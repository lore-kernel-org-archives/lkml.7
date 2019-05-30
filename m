Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C078BC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902D925650
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190665;
	bh=IxlLU21AYF8lNGgu0aEl00aZGtBAT2KobApAnq5506E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EuTt/kWVt/vBg0TY30olQh9DHdTuD21WSp5vXC8bKDbRXpC9bwze7FSWq44/dq0vF
	 QhwpMerodqlT7seLav8rTzO2YOXVam5Ntnt7croZON5d5wFEmy6xYaCmTgi6QB2SE4
	 MQuUFlin+grC4/KRtT5d/HlIU6JPMVS03HkDSmFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfE3EbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbfE3DNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:50 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39A4524556;
        Thu, 30 May 2019 03:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186030;
        bh=IxlLU21AYF8lNGgu0aEl00aZGtBAT2KobApAnq5506E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G7dlawYlPhvRp+KytxWecVd9Qkx15LAKRmma8Ap51oRjDYZvGjpRJSQUxcowT/WhZ
         pgqnaNhreoz2R4Ng7G6Znn+wryh0MhRghmwkeDkROGxcrpvfb4hCSoAMOx8HHRCv0E
         i35Jb73byRzvQsjT4AZQihmxLIP/jYIrWqpdwbuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 107/346] ASoC: fsl_sai: Update is_slave_mode with correct value
Date:   Wed, 29 May 2019 20:03:00 -0700
Message-Id: <20190530030546.531273720@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ddb351145a967ee791a0fb0156852ec2fcb746ba ]

is_slave_mode defaults to false because sai structure
that contains it is kzalloc'ed.

Anyhow, if we decide to set the following configuration
SAI slave -> SAI master, is_slave_mode will remain set on true
although SAI being master it should be set to false.

Fix this by updating is_slave_mode for each call of
fsl_sai_set_dai_fmt.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 4163f2cfc06fc..bfc5b21d0c3f9 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -268,12 +268,14 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 	case SND_SOC_DAIFMT_CBS_CFS:
 		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
 		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
+		sai->is_slave_mode = false;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		sai->is_slave_mode = true;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
 		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
+		sai->is_slave_mode = false;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
-- 
2.20.1




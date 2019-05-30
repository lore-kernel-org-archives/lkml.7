Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F3C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D90225184
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189508;
	bh=IxlLU21AYF8lNGgu0aEl00aZGtBAT2KobApAnq5506E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LR2vadsa6AiMMIMOM0GXxFIHa9x8EDmdNFoFe5FR/lUaQ5+7vftRLWafP2U9gMxAT
	 9nHTSlimixzDh03nD5CHHD1qhje4TCy2iEWFvNBxJPo+bmckzGCT9utq8U7sM5MznZ
	 I9X2JD9WvOBi8F/eFaLW1VFsIISjD4lhq0EyjcX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfE3ELr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730809AbfE3DQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:47 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA450245AB;
        Thu, 30 May 2019 03:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186207;
        bh=IxlLU21AYF8lNGgu0aEl00aZGtBAT2KobApAnq5506E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rzoDiR/KIS/j5gyHs9vsBd9C8ksfeAtLv9nQCSmbFiALSdaN5zTK5RsR/DbQW+sTw
         19slcSYVazPOcCaa+18g7O1TIfe9gXDND2c6RAlgEtzfCkrQxeLfMFGI5b9OxHecf8
         9hg7oORL3I2dm9+NWaGgggKnd4I+ewpE5G+BYwcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 095/276] ASoC: fsl_sai: Update is_slave_mode with correct value
Date:   Wed, 29 May 2019 20:04:13 -0700
Message-Id: <20190530030532.100483140@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
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




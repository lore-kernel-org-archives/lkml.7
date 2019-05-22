Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839F0C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEFE2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553514;
	bh=V6VAb/5YM6f2CZC9OozkhSdrFt6Chgf47ZaYM3V8uN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z15XwU87wtDFVcPfZU5xqLP8ZaUXnu/IxEeYDb30lXhxRZXSUzVHCsd7U1k/YQnCb
	 0kgmkoMyLecbeHzLahTSVMaPvv+FAWbjLpgEKBwLLYadp0buBFqlI46Q0/37A2GjPm
	 ljoysVc9xBHkU4AtsdBgwQ6M8ebnExBqQAvmZgPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbfEVTbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387628AbfEVTbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:31:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62835217D7;
        Wed, 22 May 2019 19:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553506;
        bh=V6VAb/5YM6f2CZC9OozkhSdrFt6Chgf47ZaYM3V8uN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etVrJ4o9IJHTEHXFeBCrrBn6CglzgfmiQTYTuG08QUzNjvVqsR7VI2v7sIQfCH2hx
         2BGOkbzSIRp3yIe6fB5gh37GQjcCoTMYg6byrgLZQBsViRs5yhpOIiSdMIyq6OX1I2
         3y4IQqu9IIsoy3kQJCwT60jiJc37qp3jSGO2rBfU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 13/92] ASoC: fsl_sai: Update is_slave_mode with correct value
Date:   Wed, 22 May 2019 15:30:08 -0400
Message-Id: <20190522193127.27079-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522193127.27079-1-sashal@kernel.org>
References: <20190522193127.27079-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

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
index 08b460ba06efc..61d2d955f26a6 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -260,12 +260,14 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
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


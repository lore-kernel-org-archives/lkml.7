Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43818C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 23:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14261208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 23:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AReiaJER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfFFXBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 19:01:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42706 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfFFXBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 19:01:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id go2so25642plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 16:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=12La436VbNM+cCSd7W2kZMhljrLWHemPkQdkpyh82vY=;
        b=AReiaJERh9zfxRcBRKv/f5ZBzgNxQuBHCtL/MVHd7MWiPpVT1CnFdhZULF9v76DzvI
         APLMydZtIIGHUOF8LV9te1yum4VCqoO+JJo8fP8KQK3tcqsZVLtZjJU3eGYyNSQ1T8Sj
         dPbD4GyBcbK8B2wpKq2m7HnmayAH2ojTkHIhzVJydEe23H3GiltSObE8Vmsh3WBHMTsL
         UCc6dTDfvgdqwHalbqqL7ixq6ZcHpMDgN7SMcCwQBeJVfHPuhsJfCgSUruUu+0Q9Eubl
         Yq1eOLubJF54PHrSBAmTqhrTv0L+bf5qtlvG89eMew8LVYpvRULeTKj6Hwc7A8tWVUFH
         9V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=12La436VbNM+cCSd7W2kZMhljrLWHemPkQdkpyh82vY=;
        b=jXmpEFlcMJdt87KidGGZshs69uANZGNAXgEaMkPOL3f0mZJBMmfw4RWpVrJeqMyZXi
         S/npF5F6m+gYokyswWM9jbViF8DWcfxlPSip1LBZbf3TtJjD6fzLmbIUxFVDlhhEA2At
         ijpaM18eJx57TjMeUtCWuWK4cGMbYSCgF2dVsjiQNukz1HRA2Thvl5uDC1CegWQmz4Sm
         YkccHfXeIXpogMAvBuDXVPKQ2AUjrbexkvlveGNC4Mm2nSowpcVdODMgimDmcaHfL8MB
         7teNb8dk1J8SpJXRPfdwQsE7LdxwIpVzagkbpKTMTUJBjuDyM/+twMA1jB4cEkkCOA0E
         e/tA==
X-Gm-Message-State: APjAAAW55DoYHqh2KkTmiZidpdlN64vfkkMwWrYn+DoIygFExCBmMI1U
        1xGMObf+WTvsUDmiSQYSyNM=
X-Google-Smtp-Source: APXvYqyJRnNHG/xd1j5UBLUN+f975Gpvky3R4SP3NlglwXTBLeJVJJ23pdeMLMfwRDTHpYXKxwk0/Q==
X-Received: by 2002:a17:902:694b:: with SMTP id k11mr38505043plt.307.1559862071919;
        Thu, 06 Jun 2019 16:01:11 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w190sm198049pgw.51.2019.06.06.16.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 16:01:11 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     shengjiu.wang@nxp.com, broonie@kernel.org
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [RFC/RFT PATCH] Revert "ASoC: fsl_esai: ETDR and TX0~5 registers are non volatile"
Date:   Thu,  6 Jun 2019 16:01:05 -0700
Message-Id: <20190606230105.4385-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8973112aa41b8ad956a5b47f2fe17bc2a5cf2645.

ETDR and TX0~5 are TX data registers. There are a couple of reasons
to revert the change:
1) Though ETDR and TX0~5 are not volatile but write-only registers,
   they should not be cached either. According to the definition of
   "volatile_reg", one should be put in the volatile list if it can
   not be cached.
2) When doing regcache_sync(), the operation may accidentally write
   some "dirty" data into these registers, in case that cached data
   happen to be different from the default ones. It may also result
   in a channel shift/swap situation since the number of write-via-
   sync operations at ETDR would unlikely match the channel number.

Note: this revert is not a complete revert as it keeps those macros
of registers remaining in the default value list while the original
commit also changed other entries in the list. And this patch isn't
very necessary to Cc stable tree since there has been always a FIFO
reset operation around the regcache_sync() call, even prior to this
reverted commit.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
---
Hi Mark,
In case there's no objection against the patch, I'd still like to
wait for a Tested-by from NXP folks before submitting it. Thanks!

 sound/soc/fsl/fsl_esai.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 10d2210c91ef..8f0a86335f73 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -652,16 +652,9 @@ static const struct snd_soc_component_driver fsl_esai_component = {
 };
 
 static const struct reg_default fsl_esai_reg_defaults[] = {
-	{REG_ESAI_ETDR,	 0x00000000},
 	{REG_ESAI_ECR,	 0x00000000},
 	{REG_ESAI_TFCR,	 0x00000000},
 	{REG_ESAI_RFCR,	 0x00000000},
-	{REG_ESAI_TX0,	 0x00000000},
-	{REG_ESAI_TX1,	 0x00000000},
-	{REG_ESAI_TX2,	 0x00000000},
-	{REG_ESAI_TX3,	 0x00000000},
-	{REG_ESAI_TX4,	 0x00000000},
-	{REG_ESAI_TX5,	 0x00000000},
 	{REG_ESAI_TSR,	 0x00000000},
 	{REG_ESAI_SAICR, 0x00000000},
 	{REG_ESAI_TCR,	 0x00000000},
@@ -711,10 +704,17 @@ static bool fsl_esai_readable_reg(struct device *dev, unsigned int reg)
 static bool fsl_esai_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case REG_ESAI_ETDR:
 	case REG_ESAI_ERDR:
 	case REG_ESAI_ESR:
 	case REG_ESAI_TFSR:
 	case REG_ESAI_RFSR:
+	case REG_ESAI_TX0:
+	case REG_ESAI_TX1:
+	case REG_ESAI_TX2:
+	case REG_ESAI_TX3:
+	case REG_ESAI_TX4:
+	case REG_ESAI_TX5:
 	case REG_ESAI_RX0:
 	case REG_ESAI_RX1:
 	case REG_ESAI_RX2:
-- 
2.17.1


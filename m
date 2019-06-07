Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F20C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FB320840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLv6Z5QL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfFGWrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:47:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36470 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfFGWrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:47:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so1882369pgb.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ICW3GL2Jj3l3TI0uaeVmL4hkLsOez9fNWXiS/c/eQfY=;
        b=ZLv6Z5QLrJ+vdWNUCHtqlqCZG0PHFSaqt+Py5Y89czZ4uyL/hKmWBXnoebJ3oaJi2z
         fNsp68F8q2R9N96Bd9A/jI8d3QiZw8dMUUbqt6I47PD341BnMyAh7g7AHqEGCO2357IC
         CNMz4FlFehqaX9xTiVgvKTM+1QSBUuGtarJE+wv+JrlMPcZulqB+f1XYstR1FktPqjMR
         /lUqqQ+RIogrZ2xOFaoX85DHtBzOfnEWeK8DbD9KKBh2VlKWSEuOVRTez+2Z7ahvASP1
         9yI02X006pLDHxGt7czFz+UL2a2a6OFZ56XtvR2B4GWpYPikdJVhqV2yYSE3I7xSwHso
         8F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ICW3GL2Jj3l3TI0uaeVmL4hkLsOez9fNWXiS/c/eQfY=;
        b=Ai8JfWaVlquTs1FcDUE1poDK9Ehf3uQB7QjD/hx1dNE3TIX/CN1RRZOBulZ0+pyEkP
         6ySLHLUZWif0ZxH9ZSnxfK+gWAGjHy2yxujRaXgathh5j2OV/ZcxW0rgAZAUmHL+tFZk
         kOereI/7VaSoHRgYJNOnhCs/oeusbm2LyopWxIKxG08zRF62sClMW6zwM4UrQVi0Q4uT
         AqcNl/VtAm7aw2JDg+Tg3kjUYWbqaaGFLjWCDBPWwNDsiqY5IWcNjG6fJTDAQft8BXqO
         PFgyWPAXzMMRbY92BtOK6vWX1vkYRb9egA7h2DsVLZ9WlXIKfozPKBGh9ZqBaaZALSvl
         +XnA==
X-Gm-Message-State: APjAAAWtfY1xJv5UnJ9dTvX96Ma2IUcvmnt6r73BR0RvhdyIp2sMJQdL
        Pfs0Fam+EGtAd7EEqloL2oc=
X-Google-Smtp-Source: APXvYqx0Kqdu7J8mgnnETb2JJBsOuRoR+vWceEaG9gGl0GEJ6BSdxg5yX5SJDiBQSiluCmXucSjmXQ==
X-Received: by 2002:a62:4d03:: with SMTP id a3mr62510491pfb.2.1559947640754;
        Fri, 07 Jun 2019 15:47:20 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id o70sm3684607pfo.33.2019.06.07.15.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 15:47:20 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     shengjiu.wang@nxp.com, broonie@kernel.org
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [RFC/RFT PATCH v2] ASoC: fsl_esai: Revert "ETDR and TX0~5 registers are non volatile"
Date:   Fri,  7 Jun 2019 15:47:14 -0700
Message-Id: <20190607224714.13933-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8973112aa41b ("ASoC: fsl_esai: ETDR and TX0~5 registers are
non volatile") removed TX data registers from the volatile_reg list
and appended default values for them. However, being data registers
of TX, they should not have been removed from the list because they
should not be cached -- see the following reason.

When doing regcache_sync(), this operation might accidentally write
some dirty data to these registers, in case that cached data happen
to be different from the default ones, which might also result in a
channel shift or swap situation, since the number of write-via-sync
operations at ETDR would very unlikely match the channel number.

So this patch reverts the original commit to keep TX data registers
in volatile_reg list in order to prevent them from being written by
regcache_sync().

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

Changelog
v1->v2
 * Fixed subject by following subsystem format.
 * Revised commit message to emphasize the real issue.

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


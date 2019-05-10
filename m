Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F70BC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153B2217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a6OnrweB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfEJWjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:39:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39263 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfEJWjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:39:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so3657970pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 15:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btsWjRP5fMorg/50XHE1AhFeDHrZVO/tdOU3AkASJ7Q=;
        b=a6OnrweBxtt7NkvEdUNplsNNvQ4sNDXgesDB2iG1R1yxR5CioQT6uI6SsDYsOlRGVJ
         nXWhQA0mEOMVNhRtNUO4Ccl1UQirg8OZlU1AdDJDvs4SyaOwguDHbTj44A0Jakwozs1B
         wwinoq6Vors0uxxc591xIBjZ624499lmP2Bdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btsWjRP5fMorg/50XHE1AhFeDHrZVO/tdOU3AkASJ7Q=;
        b=Z6uqsXSsYu0U/xSS1gOrJ0ayd76t/ZVern2YkxXgET4ro6wvPfyarsiHImYAEfURhn
         Vl0iZ2Z+vsAKS6qCR9Dp8G5bARUYXIV5orqcuvMS1IUhtNwz0QVPTOpsPC2+mSZnhzwJ
         aeKS/azjpvS33/+LOBqQptsb4qzbtMteJuPNtLid7tf+8Luq4r9v5jUXqnY2ttK9P6K9
         ces9GHsa+mmKebIQrZfLaQ938t7uQrNFeqxNnbLvaxq/v0cpNDCPo1Ua154OsgNZTd/W
         huWcyPSsLrUgFpgxWweYgn8NWWKxE+OHjzZ2uN5YSMRrCkhrs73gr2Ie4CueOejKJo+x
         Ngdg==
X-Gm-Message-State: APjAAAU1G6KauiuejHBPKjOeB81Do2/i2+Lu9qQmIiYFYqB1RY3u4zNI
        1eMdl2Mg8xff9gChn+AyeHRVJw==
X-Google-Smtp-Source: APXvYqweIgH4BFWK+Kw6cY3nsX0Zo2SGslEeQYFM8I6kmq6sGDYYG3FZxMlP8D3EIOb5rYXde/pNnw==
X-Received: by 2002:a65:4183:: with SMTP id a3mr16513747pgq.121.1557527985655;
        Fri, 10 May 2019 15:39:45 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id u66sm13300540pfa.36.2019.05.10.15.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 May 2019 15:39:44 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v3 1/2] ASoC: SOF: Add Comet Lake PCI IDs
Date:   Fri, 10 May 2019 15:39:28 -0700
Message-Id: <20190510223929.165569-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510223929.165569-1-evgreen@chromium.org>
References: <20190510223929.165569-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Intel Comet Lake platforms by adding a new Kconfig
for CometLake and the appropriate PCI IDs.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v3:
- Copy cnl_desc to new cml_desc, and avoid selecting cannonlake (Pierre-Louis)

Changes in v2:
- Add CML-H ID 0x06c8 (Pierre-Louis)

 sound/soc/sof/intel/Kconfig | 32 ++++++++++++++++++++++++++++++++
 sound/soc/sof/sof-pci-dev.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 603e0db4f012..17e10d65fc0c 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -24,6 +24,8 @@ config SND_SOC_SOF_INTEL_PCI
 	select SND_SOC_SOF_CANNONLAKE  if SND_SOC_SOF_CANNONLAKE_SUPPORT
 	select SND_SOC_SOF_COFFEELAKE  if SND_SOC_SOF_COFFEELAKE_SUPPORT
 	select SND_SOC_SOF_ICELAKE     if SND_SOC_SOF_ICELAKE_SUPPORT
+	select SND_SOC_SOF_COMETLAKE_LP if SND_SOC_SOF_COMETLAKE_LP_SUPPORT
+	select SND_SOC_SOF_COMETLAKE_H if SND_SOC_SOF_COMETLAKE_H_SUPPORT
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
@@ -179,6 +181,36 @@ config SND_SOC_SOF_ICELAKE
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
 
+config SND_SOC_SOF_COMETLAKE_LP
+	tristate
+	select SND_SOC_SOF_HDA_COMMON
+	help
+	  This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_COMETLAKE_LP_SUPPORT
+	bool "SOF support for CometLake-LP"
+	help
+	  This adds support for Sound Open Firmware for Intel(R) platforms
+	  using the Cometlake-LP processors.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
+config SND_SOC_SOF_COMETLAKE_H
+	tristate
+	select SND_SOC_SOF_HDA_COMMON
+	help
+	  This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_COMETLAKE_H_SUPPORT
+	bool "SOF support for CometLake-H"
+	help
+	  This adds support for Sound Open Firmware for Intel(R) platforms
+	  using the Cometlake-H processors.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
 config SND_SOC_SOF_HDA_COMMON
 	tristate
 	select SND_SOC_SOF_INTEL_COMMON
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index b778dffb2d25..d736806c2e0d 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -129,6 +129,26 @@ static const struct sof_dev_desc cfl_desc = {
 };
 #endif
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_LP) || \
+	IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_H)
+
+static const struct sof_dev_desc cml_desc = {
+	.machines		= snd_soc_acpi_intel_cnl_machines,
+	.resindex_lpe_base	= 0,
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= -1,
+	.irqindex_host_ipc	= -1,
+	.resindex_dma_base	= -1,
+	.chip_info = &cnl_chip_info,
+	.default_fw_path = "intel/sof",
+	.default_tplg_path = "intel/sof-tplg",
+	.nocodec_fw_filename = "sof-cnl.ri",
+	.nocodec_tplg_filename = "sof-cnl-nocodec.tplg",
+	.ops = &sof_cnl_ops,
+	.arch_ops = &sof_xtensa_arch_ops
+};
+#endif
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
 static const struct sof_dev_desc icl_desc = {
 	.machines               = snd_soc_acpi_intel_icl_machines,
@@ -353,6 +373,14 @@ static const struct pci_device_id sof_pci_ids[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
 	{ PCI_DEVICE(0x8086, 0x34C8),
 		.driver_data = (unsigned long)&icl_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_LP)
+	{ PCI_DEVICE(0x8086, 0x02c8),
+		.driver_data = (unsigned long)&cml_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_H)
+	{ PCI_DEVICE(0x8086, 0x06c8),
+		.driver_data = (unsigned long)&cml_desc},
 #endif
 	{ 0, }
 };
-- 
2.20.1


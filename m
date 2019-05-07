Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAD0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1DC206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TJHz7SXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfEGVyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:54:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33810 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfEGVyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:54:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id n19so794420pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2mZ3KmK2gCP50bBQ3mZ2/amM1EISbfPLkjJEim0ThDA=;
        b=TJHz7SXm4sQDBvLL20U3wXDmPm2umD/JEJdBHusPXQlRJXVPHuh/hNTeEl4REtZ8zl
         bzJNj25iP1+UU9YJx/X5nvdnCPA4aHELx7s60A9KfmUvaOa5gKS0gdCzfhGLlHImU3rR
         WILEyNTWWw1BiZbDnkX2kIjeuQqZxxXF1Ij/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2mZ3KmK2gCP50bBQ3mZ2/amM1EISbfPLkjJEim0ThDA=;
        b=uRnCMhg2QVkzBTpNxaMSDstDN45uF9EI/jNPtoNbvTJv1Nt/ypYufglbG/tU5dfsT6
         df7Db5+reyyr58X8sMws9tiePOhNqNXqVOBXUW5L0eL1kJJ/vs99uFuwl9Q6wy+Y7tVG
         fd40glkZ88WuWhKooBbxfZ0IIvegmF41Xs4N/4ibdwNBn7+Gf2SV1sIpirtSfxJw9spr
         F9z9hOKgRLJwMhD5dBnWx0orOGOM47HiDhH6lZWpgFvj9oKAZL/kmStTGe7fkdMIHalC
         nhn/KnkIslegpjZ8bwzdpRncCXtgWgED5pHg6YqtzV2O34hxtiPOT13uAF3iLpGXSMi+
         ST5A==
X-Gm-Message-State: APjAAAXybrrpF0XZb+28wPFkpG8XWNdFFZY2MomMeYXUXDMIfx4MZcpx
        YUSE4n6YjlbSEBOIhgox+xBYBw==
X-Google-Smtp-Source: APXvYqydcKF3Z8iHDFH4RujwANE5rKFdGwfbt6zKY8Tl+Ss3XTeF8BK+ZIiIkMZtGZR4HomzrpIF7A==
X-Received: by 2002:a63:5443:: with SMTP id e3mr42240547pgm.265.1557266070836;
        Tue, 07 May 2019 14:54:30 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id 19sm36854191pfs.104.2019.05.07.14.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 14:54:30 -0700 (PDT)
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
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, Jenny TC <jenny.tc@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
Subject: [PATCH v2 2/2] ASoC: Intel: Skylake: Add Cometlake PCI IDs
Date:   Tue,  7 May 2019 14:53:59 -0700
Message-Id: <20190507215359.113378-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507215359.113378-1-evgreen@chromium.org>
References: <20190507215359.113378-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCI IDs for Intel CometLake platforms, which from a software
point of view are extremely similar to Cannonlake platforms.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
- Add 0x06c8 for CML-H (Pierre-Louis)

 sound/soc/intel/Kconfig                | 18 ++++++++++++++++++
 sound/soc/intel/skylake/skl-messages.c | 16 ++++++++++++++++
 sound/soc/intel/skylake/skl.c          | 10 ++++++++++
 3 files changed, 44 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index fc1396adde71..1ebac54b7081 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -110,6 +110,8 @@ config SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_INTEL_GLK
 	select SND_SOC_INTEL_CNL
 	select SND_SOC_INTEL_CFL
+	select SND_SOC_INTEL_CML_H
+	select SND_SOC_INTEL_CML_LP
 	help
           This is a backwards-compatible option to select all devices
 	  supported by the Intel SST/Skylake driver. This option is no
@@ -165,6 +167,22 @@ config SND_SOC_INTEL_CFL
 	  If you have a Intel CoffeeLake platform with the DSP
 	  enabled in the BIOS then enable this option by saying Y or m.
 
+config SND_SOC_INTEL_CML_H
+	tristate "CometLake-H Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel CometLake-H platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_CML_LP
+	tristate "CometLake-LP Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel CometLake-LP platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
 config SND_SOC_INTEL_SKYLAKE_FAMILY
 	tristate
 	select SND_SOC_INTEL_SKYLAKE_COMMON
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 4bf70b4429f0..df01dc952521 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -255,6 +255,22 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.init_fw = cnl_sst_init_fw,
 		.cleanup = cnl_sst_dsp_cleanup
 	},
+	{
+		.id = 0x02c8,
+		.num_cores = 4,
+		.loader_ops = bxt_get_loader_ops,
+		.init = cnl_sst_dsp_init,
+		.init_fw = cnl_sst_init_fw,
+		.cleanup = cnl_sst_dsp_cleanup
+	},
+	{
+		.id = 0x06c8,
+		.num_cores = 4,
+		.loader_ops = bxt_get_loader_ops,
+		.init = cnl_sst_dsp_init,
+		.init_fw = cnl_sst_init_fw,
+		.cleanup = cnl_sst_dsp_cleanup
+	},
 };
 
 const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 4ed5b7e17d44..f864f7b3df3a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1166,6 +1166,16 @@ static const struct pci_device_id skl_ids[] = {
 	/* CFL */
 	{ PCI_DEVICE(0x8086, 0xa348),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML_LP)
+	/* CML-LP */
+	{ PCI_DEVICE(0x8086, 0x02c8),
+		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML_H)
+	/* CML-H */
+	{ PCI_DEVICE(0x8086, 0x06c8),
+		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
 #endif
 	{ 0, }
 };
-- 
2.20.1


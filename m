Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE9BC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862FE217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CW3FW1Qa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfEJWjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:39:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43244 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfEJWjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:39:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id c6so3923161pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 15:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SfaLLvXepQRjPBSTX7ofFVM9xFaCs9uEAd6y7Vf/jI=;
        b=CW3FW1QaMndV6cwwyiyNA8R53BhYSKmW1OSkoFcainmLy819+8sTqcbkORQZyJkm+j
         Xv2ZITvIK9F7I695Ipiy4gQ1xDUxh0NYNr8Kjztz40o19XH6MbspMyOdaQVO0Y1twGp7
         hRTBhLibmNvg9nBN/yrN6K3nY6blDcUvKTMQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SfaLLvXepQRjPBSTX7ofFVM9xFaCs9uEAd6y7Vf/jI=;
        b=A78dcjeYJ69tJSj5RT6zIPzaQP1XiBrhDI5XhrkB2pUoz1jWoRRnmuKO6B6xEl8H4C
         uQ6Ywb046GHQTzgmPDo/Xp8Ax4YQJaVyfGXHNP/XHxL4wWnkeecRDuyIMO3tRxvJsv/K
         7F6oaqgq9nmn47YzS/bZS6LsyfOYRFRO57E5AZFWUYM2r4IecrRsYfM5L49EQnBe8l0e
         wAW9BKImuBjTJvXLoeXs7gQuMXbsGU01xkPbC4RjhmVG7PoEycbWBbsJTlZpHv363NqF
         JiK+fKx0rsvRHFqDS735Agr9ftazuoJNs4GiCWA4InPdsjQFZCJg4EuP0scd/6h8tZcI
         33QQ==
X-Gm-Message-State: APjAAAUBESPKlJHFEhx63gOXyDP8rQWgBmrYVcUzzqU0h0/vUo2AFpWB
        3deYCnvnJf0RUS5Wv2PohGbUiA==
X-Google-Smtp-Source: APXvYqyRgDz+Yrd5PgXej0kYFwSP00cOYoCC+OFOn+fT0I0FzCSLjsERw1RyZahadf+YpZ58Uxujag==
X-Received: by 2002:aa7:8a53:: with SMTP id n19mr17229422pfa.11.1557527988266;
        Fri, 10 May 2019 15:39:48 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id u66sm13300540pfa.36.2019.05.10.15.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 May 2019 15:39:47 -0700 (PDT)
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
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>
Subject: [PATCH v3 2/2] ASoC: Intel: Skylake: Add Cometlake PCI IDs
Date:   Fri, 10 May 2019 15:39:29 -0700
Message-Id: <20190510223929.165569-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510223929.165569-1-evgreen@chromium.org>
References: <20190510223929.165569-1-evgreen@chromium.org>
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

Changes in v3:
- Don't select CML_* in SND_SOC_INTEL_SKYLAKE (Pierre-Louis)

Changes in v2:
- Add 0x06c8 for CML-H (Pierre-Louis)

 sound/soc/intel/Kconfig                | 16 ++++++++++++++++
 sound/soc/intel/skylake/skl-messages.c | 16 ++++++++++++++++
 sound/soc/intel/skylake/skl.c          | 10 ++++++++++
 3 files changed, 42 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index fc1396adde71..b089ed3bf77f 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -165,6 +165,22 @@ config SND_SOC_INTEL_CFL
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


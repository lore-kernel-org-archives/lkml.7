Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0077C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9DD205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l3Ojkz9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfEFWyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:54:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44425 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEFWyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:54:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so7525207pfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L5NX6UdjTtgyLhTG27pUpjzYT4XZYiXb70lYN/n1LfU=;
        b=l3Ojkz9Kx0UoD8mJ28v84u+3hN5a5hHyIRJ7s+kZXtdFq/gt3GfoAoPpnPfJtSuT/O
         FbBWXqsZ87BV7hUKd1phpYpv1DJoPQTDMn8/TB7RXoLpYhkahaXBhfam/nbRrX/ilHjE
         HxLCC6vyjtJw5WqMVmYGpH99s1FTjxGyc5iNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L5NX6UdjTtgyLhTG27pUpjzYT4XZYiXb70lYN/n1LfU=;
        b=mppR4t0RXUxjGBGVjQTVjhXMVMGXcZ1OoKi+rJb1e6a5kaKkRmezuU7jR1X/MV6Uv9
         C3fiq8RGn+dbrqxBIjZn5icKGA3z2i/IqxwFwuM5FLfzu8GxN38EqAIShUnFDbpcdkI9
         VOI9DQFXKhcys53wAUzEcnx4UdGaipoaLux22N1bdtL1shIzvqdxCftanw/cZ+ceGyoH
         WuT8hxlIJ600D/o6E9g1BN0XBidkAbhy7/bC9qGXo/rYMkq2t9zI/9A9oZAkAlo3Z+Gl
         4KazXphmWkWLOyXzR0ttxPL+qg/s1JqlnwHM55e2TXHXj7WiUOouY1HDbntajLcn2Diq
         Kt4w==
X-Gm-Message-State: APjAAAUXaTXZtIm7NuizWyjw0v4Hm5TlJXVKPPGxqcaZlaWfeRIogzgS
        E34hbfN+5jGE0QOXQ/gcxW90kw==
X-Google-Smtp-Source: APXvYqwNnGdQJp9gwELfUY9wZmF/dWP2Oo+RWeMx6qHAIWlNWMHxnD7YS6x+eRVEg2u8SQEdjkwQ6g==
X-Received: by 2002:a62:1a51:: with SMTP id a78mr27784562pfa.133.1557183244836;
        Mon, 06 May 2019 15:54:04 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id i15sm16052204pfr.8.2019.05.06.15.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 15:54:04 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, Jenny TC <jenny.tc@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
Subject: [PATCH v1 2/2] ASoC: Intel: Skylake: Add Cometlake PCI IDs
Date:   Mon,  6 May 2019 15:53:21 -0700
Message-Id: <20190506225321.74100-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506225321.74100-1-evgreen@chromium.org>
References: <20190506225321.74100-1-evgreen@chromium.org>
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

 sound/soc/intel/Kconfig                | 9 +++++++++
 sound/soc/intel/skylake/skl-messages.c | 8 ++++++++
 sound/soc/intel/skylake/skl.c          | 5 +++++
 3 files changed, 22 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index fc1396adde71..6b45082f8bd1 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -110,6 +110,7 @@ config SND_SOC_INTEL_SKYLAKE
 	select SND_SOC_INTEL_GLK
 	select SND_SOC_INTEL_CNL
 	select SND_SOC_INTEL_CFL
+	select SND_SOF_INTEL_CML
 	help
           This is a backwards-compatible option to select all devices
 	  supported by the Intel SST/Skylake driver. This option is no
@@ -165,6 +166,14 @@ config SND_SOC_INTEL_CFL
 	  If you have a Intel CoffeeLake platform with the DSP
 	  enabled in the BIOS then enable this option by saying Y or m.
 
+config SND_SOC_INTEL_CML
+	tristate "CometLake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel CometLake platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
 config SND_SOC_INTEL_SKYLAKE_FAMILY
 	tristate
 	select SND_SOC_INTEL_SKYLAKE_COMMON
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 4bf70b4429f0..e0e404b08627 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -255,6 +255,14 @@ static const struct skl_dsp_ops dsp_ops[] = {
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
 };
 
 const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 4ed5b7e17d44..a9f6f5184639 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1166,6 +1166,11 @@ static const struct pci_device_id skl_ids[] = {
 	/* CFL */
 	{ PCI_DEVICE(0x8086, 0xa348),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML)
+	/* CML */
+	{ PCI_DEVICE(0x8086, 0x02c8),
+		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
 #endif
 	{ 0, }
 };
-- 
2.20.1


Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85231C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A38422ADB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAZlNgbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfGXNRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:17:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32919 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfGXNRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:17:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so20958507pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZ7wVAol4MmwCR8qqLkSZFpDoEl3K+dOfXOvnl97TeU=;
        b=aAZlNgbGrO631uA4dTBhkeCQuO+ougCeNujCTmwIi60xQzK8W7h6fg+EoMg2ulbvoI
         j4rKf6Q4ecwOfU/XRmw8OSvIlEcUrrqWmzkLz2EyjeYlz9mWUNBY1Hyatjt9V6Ayf3Ce
         yYh7wV6rkgfWbfqcHMcoh9GERBqkY95OZEeNi44B1mZvSRfaKRRvhDc8c1+UgbaDV3iA
         6/RJ4BSutiLMhvAeygYx8Ut3BroohM4kNixAKTrHNH94qic6ExiKTzUCEtTy+78LeaWk
         FIvzzXhX8GLwAwmXVxpSUBt/b5hDx0jQZFxL4WJD1dMCYNBZR3sRF4klnP68Xgw9sfy+
         tZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZ7wVAol4MmwCR8qqLkSZFpDoEl3K+dOfXOvnl97TeU=;
        b=G9cPhBsMFi3HF6dwu64mTtypoKpgSotPe/Er44KU1gJz+WGrmjjPXTmOmaCfokVUWj
         HhBfZelP+Vi+zB3J+t7N5fn1pNgRwtc2sEFAG7yhtGyx2YaNmUeATKeVh4Ttj6gR8SAt
         VvD5B3LDWxP939j8DZoKfBCw8xLt/mayrntgw0xQx5gXBq9DopcA2drstkgQyfgjMdOe
         KCvJGU+2nJaLheB21530KS1IC0ZX+fTzeYqMb5DSblWvBY2s+C6rZuKddxCtxnTz0RVi
         MVP6SX9U6mG4Xk8dAlTucbN6nalLjz7OFkZPzGoCfpQIzIBbDCeKcb9CY+KJcfMNUWne
         v6nw==
X-Gm-Message-State: APjAAAUi0hADeDCUvQgeZEmICZaA07UOSrK7ol4IsJoqY/pfGy/8Bf8M
        FWp3n+/PIuPY8xf+4t3OBfXZ5+vxhdU=
X-Google-Smtp-Source: APXvYqwi0sRrTRaqStbjuaz+zMQjtVRZiL1SvumOsFoCHj6qqKXFFgM9byvpvn9R6xFgMTSfElL1OQ==
X-Received: by 2002:aa7:8218:: with SMTP id k24mr10886951pfi.221.1563974253258;
        Wed, 24 Jul 2019 06:17:33 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id w4sm61053835pfn.144.2019.07.24.06.17.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 06:17:32 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: Intel: Skylake: Use dev_get_drvdata where possible
Date:   Wed, 24 Jul 2019 21:17:25 +0800
Message-Id: <20190724131725.1655-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/intel/skylake/skl-nhlt.c |  3 +--
 sound/soc/intel/skylake/skl.c      | 12 ++++--------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 1132109cb992..46d9977224d1 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -241,8 +241,7 @@ int skl_nhlt_update_topology_bin(struct skl *skl)
 static ssize_t skl_nhlt_platform_id_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 	struct skl *skl = bus_to_skl(bus);
 	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
 	char platform_id[32];
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 3362e71b4563..1f625fc65307 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -141,8 +141,7 @@ static int skl_init_chip(struct hdac_bus *bus, bool full_reset)
 
 void skl_update_d0i3c(struct device *dev, bool enable)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 	u8 reg;
 	int timeout = 50;
 
@@ -274,8 +273,7 @@ static int skl_acquire_irq(struct hdac_bus *bus, int do_disconnect)
 
 static int skl_suspend_late(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 	struct skl *skl = bus_to_skl(bus);
 
 	return skl_suspend_late_dsp(skl);
@@ -400,8 +398,7 @@ static int skl_resume(struct device *dev)
 #ifdef CONFIG_PM
 static int skl_runtime_suspend(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
@@ -410,8 +407,7 @@ static int skl_runtime_suspend(struct device *dev)
 
 static int skl_runtime_resume(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
-- 
2.20.1


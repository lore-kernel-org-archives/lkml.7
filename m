Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430E6C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111AD205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xqp1nGdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEFWyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:54:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37082 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEFWyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:54:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id z8so7106703pln.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HGiQcQsNLZSu4O6fjQQo4uRzuuZ+mn8z8Ipe1hIL3NA=;
        b=Xqp1nGdvYAdr3hwiLJW8lG3kT1k7Yy9LxQ5aPzpz6Nocr+Nm86dqowKmEwscybxhPf
         EhVlR0xH5V3jZ0fHsBXC7WYcjwWDuajuIXoY0MNpwhfBrIEA3pTFW5Jjx0ry/Vok2mqC
         dQnYy491jpnktcXfymmYwDTpd5+KS3JVJuNvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HGiQcQsNLZSu4O6fjQQo4uRzuuZ+mn8z8Ipe1hIL3NA=;
        b=LySIbqYFYIKRPjhAtDMKSVa8x95fmN4q2USIw/DaWCCIZaU2JkYHHfVBNSoKdm/5pr
         +jBGeTpM024CjcOy6x3XycWAykHgAGtR5W6yPku2bTnmmWxY2wac2Gx6c/oABmZ4fc9h
         ZVNMTPBT5fm8rzm2YoDRPO5HBkFoUz/7eBn8jqmPD/xIVr6LE3IdWNo8x8yEtrXoB+6l
         5j30bM5sSC9G0RR1Th2vIrBZ7fv/AzIsShHf24LrIKry0Z7CRqoGOhz74IxDp5sRrpHM
         amVpVTHvzt8UimDOioqhs3NAg9QVHthlBARyV0tfmUluWB7h2xLDni7FlebDSoAVxs8W
         6RMQ==
X-Gm-Message-State: APjAAAUcD9q+1at9Pqck1Fbjy0ygV2vh/11xnyJMNPKyUcAQP6ZYHpwS
        llr1CFSFB8KDFA9wYtz+gif5+Q==
X-Google-Smtp-Source: APXvYqxjOUJswIaRnTQ3xdkZLysQ2doJPKtQCCGYKHAnXh29aCBCNNabnZeO15lzHDP+VUQD41L99g==
X-Received: by 2002:a17:902:5ac9:: with SMTP id g9mr738635plm.134.1557183241818;
        Mon, 06 May 2019 15:54:01 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id i15sm16052204pfr.8.2019.05.06.15.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 15:54:01 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v1 1/2] ASoC: SOF: Add Comet Lake PCI ID
Date:   Mon,  6 May 2019 15:53:20 -0700
Message-Id: <20190506225321.74100-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506225321.74100-1-evgreen@chromium.org>
References: <20190506225321.74100-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Intel Comet Lake platforms by adding a new Kconfig
for CometLake and the appropriate PCI ID.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 sound/soc/sof/intel/Kconfig | 16 ++++++++++++++++
 sound/soc/sof/sof-pci-dev.c |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 32ee0fabab92..0b616d025f05 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -24,6 +24,7 @@ config SND_SOC_SOF_INTEL_PCI
 	select SND_SOC_SOF_CANNONLAKE  if SND_SOC_SOF_CANNONLAKE_SUPPORT
 	select SND_SOC_SOF_COFFEELAKE  if SND_SOC_SOF_COFFEELAKE_SUPPORT
 	select SND_SOC_SOF_ICELAKE     if SND_SOC_SOF_ICELAKE_SUPPORT
+	select SND_SOC_SOF_COMETLAKE   if SND_SOC_SOF_COMETLAKE_SUPPORT
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
@@ -179,6 +180,21 @@ config SND_SOC_SOF_ICELAKE
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
 
+config SND_SOC_SOF_COMETLAKE
+	tristate
+	select SND_SOC_SOF_CANNONLAKE
+	help
+	  This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_COMETLAKE_SUPPORT
+	bool "SOF support for CometLake"
+	help
+	  This adds support for Sound Open Firmware for Intel(R) platforms
+	  using the Cometlake processors.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
 config SND_SOC_SOF_HDA_COMMON
 	tristate
 	select SND_SOC_SOF_INTEL_COMMON
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index b778dffb2d25..5f0128337e40 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -353,6 +353,10 @@ static const struct pci_device_id sof_pci_ids[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
 	{ PCI_DEVICE(0x8086, 0x34C8),
 		.driver_data = (unsigned long)&icl_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE)
+	{ PCI_DEVICE(0x8086, 0x02c8),
+		.driver_data = (unsigned long)&cnl_desc},
 #endif
 	{ 0, }
 };
-- 
2.20.1


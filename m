Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389B7C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDC5204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 23:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfGRXCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 19:02:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:56872 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbfGRXCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:02:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 16:02:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,279,1559545200"; 
   d="scan'208";a="367512460"
Received: from jmendes-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.24.98])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2019 16:02:36 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH] soundwire: fix regmap dependencies and align with other serial links
Date:   Thu, 18 Jul 2019 18:02:15 -0500
Message-Id: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing code has a mixed select/depend usage which makes no sense.

config SOUNDWIRE_BUS
       tristate
       select REGMAP_SOUNDWIRE

config REGMAP_SOUNDWIRE
        tristate
        depends on SOUNDWIRE_BUS

Let's remove one layer of Kconfig definitions and align with the
solutions used by all other serial links.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/regmap/Kconfig | 2 +-
 drivers/soundwire/Kconfig   | 7 +------
 drivers/soundwire/Makefile  | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 6ad5ef48b61e..8cd2ac650b50 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -44,7 +44,7 @@ config REGMAP_IRQ
 
 config REGMAP_SOUNDWIRE
 	tristate
-	depends on SOUNDWIRE_BUS
+	depends on SOUNDWIRE
 
 config REGMAP_SCCB
 	tristate
diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 3a01cfd70fdc..f518273cfbe3 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -4,7 +4,7 @@
 #
 
 menuconfig SOUNDWIRE
-	bool "SoundWire support"
+	tristate "SoundWire support"
 	help
 	  SoundWire is a 2-Pin interface with data and clock line ratified
 	  by the MIPI Alliance. SoundWire is used for transporting data
@@ -17,17 +17,12 @@ if SOUNDWIRE
 
 comment "SoundWire Devices"
 
-config SOUNDWIRE_BUS
-	tristate
-	select REGMAP_SOUNDWIRE
-
 config SOUNDWIRE_CADENCE
 	tristate
 
 config SOUNDWIRE_INTEL
 	tristate "Intel SoundWire Master driver"
 	select SOUNDWIRE_CADENCE
-	select SOUNDWIRE_BUS
 	depends on X86 && ACPI && SND_SOC
 	help
 	  SoundWire Intel Master driver.
diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index fd99a831b92a..45b7e5001653 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -5,7 +5,7 @@
 
 #Bus Objs
 soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
-obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
+obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
 
 #Cadence Objs
 soundwire-cadence-objs := cadence_master.o
-- 
2.20.1


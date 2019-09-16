Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D657C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477B9214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfIPVnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:43:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:58528 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbfIPVnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:43:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 14:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="198480039"
Received: from dgitin-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.142.45])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2019 14:43:46 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [RFC PATCH 05/12] ASoC: SOF: Intel: add build support for SoundWire
Date:   Mon, 16 Sep 2019 16:42:44 -0500
Message-Id: <20190916214251.13130-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
References: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select SoundWire capabilities on newer Intel platforms, starting with
CannonLake/CoffeeLake/CometLake.

As done for HDaudio, the SoundWire link is an opt-in capability. We
explicitly test for ACPI to avoid warnings on unmet dependencies on
the SoundWire side.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/Kconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 479ba249e219..1adff7be5b40 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -150,6 +150,7 @@ config SND_SOC_SOF_CANNONLAKE_SUPPORT
 config SND_SOC_SOF_CANNONLAKE
 	tristate
 	select SND_SOC_SOF_HDA_COMMON
+	select SND_SOC_SOF_INTEL_SOUNDWIRE
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
@@ -165,6 +166,7 @@ config SND_SOC_SOF_COFFEELAKE_SUPPORT
 config SND_SOC_SOF_COFFEELAKE
 	tristate
 	select SND_SOC_SOF_HDA_COMMON
+	select SND_SOC_SOF_INTEL_SOUNDWIRE
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
@@ -180,6 +182,7 @@ config SND_SOC_SOF_ICELAKE_SUPPORT
 config SND_SOC_SOF_ICELAKE
 	tristate
 	select SND_SOC_SOF_HDA_COMMON
+	select SND_SOC_SOF_INTEL_SOUNDWIRE
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
@@ -187,6 +190,7 @@ config SND_SOC_SOF_ICELAKE
 config SND_SOC_SOF_COMETLAKE_LP
 	tristate
 	select SND_SOC_SOF_HDA_COMMON
+	select SND_SOC_SOF_INTEL_SOUNDWIRE
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
@@ -202,6 +206,7 @@ config SND_SOC_SOF_COMETLAKE_LP_SUPPORT
 config SND_SOC_SOF_COMETLAKE_H
 	tristate
 	select SND_SOC_SOF_HDA_COMMON
+	select SND_SOC_SOF_INTEL_SOUNDWIRE
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
@@ -225,6 +230,7 @@ config SND_SOC_SOF_TIGERLAKE_SUPPORT
 config SND_SOC_SOF_TIGERLAKE
 	tristate
 	select SND_SOC_SOF_HDA_COMMON
+	select SND_SOC_SOF_INTEL_SOUNDWIRE
 	help
           This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
@@ -240,6 +246,7 @@ config SND_SOC_SOF_ELKHARTLAKE_SUPPORT
 config SND_SOC_SOF_ELKHARTLAKE
 	tristate
 	select SND_SOC_SOF_HDA_COMMON
+	select SND_SOC_SOF_INTEL_SOUNDWIRE
 	help
           This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
@@ -291,6 +298,22 @@ config SND_SOC_SOF_HDA
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
 
+config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK
+	bool "SOF support for SoundWire"
+	depends on SOUNDWIRE && ACPI
+	help
+	  This adds support for SoundWire with Sound Open Firmware
+		  for Intel(R) platforms.
+	  Say Y if you want to enable SoundWire links with SOF.
+	  If unsure select "N".
+
+config SND_SOC_SOF_INTEL_SOUNDWIRE
+	tristate
+	select SOUNDWIRE_INTEL if SND_SOC_SOF_INTEL_SOUNDWIRE_LINK
+	help
+	  This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
 endif ## SND_SOC_SOF_INTEL_PCI
 
 endif ## SND_SOC_SOF_INTEL_TOPLEVEL
-- 
2.20.1


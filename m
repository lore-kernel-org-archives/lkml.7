Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3A120862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbfEVTrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:47:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:47986 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730843AbfEVTrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:47:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:47:48 -0700
X-ExtLoop1: 1
Received: from cjpowell-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.154.39])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2019 12:47:47 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v2 01/15] soundwire: intel: filter SoundWire controller device search
Date:   Wed, 22 May 2019 14:47:17 -0500
Message-Id: <20190522194732.25704-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention is that the SoundWire controller device is a child of
the HDAudio controller. However there can be more than one child
exposed in the DSDT table, and the current namespace walk returns the
last (incorrect) device.

Intel documentation states that bits 28..31 of the _ADR field
represent the link type, with SoundWire assigned the value 4.

Add a filter and terminate early when a valid _ADR is provided,
otherwise keep iterating to find the next child.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index d3d6b54c5791..771a53a5c033 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -14,6 +14,7 @@
 #include <linux/soundwire/sdw_intel.h>
 #include "intel.h"
 
+#define SDW_LINK_TYPE		4 /* from Intel ACPI documentation */
 #define SDW_MAX_LINKS		4
 #define SDW_SHIM_LCAP		0x0
 #define SDW_SHIM_BASE		0x2C000
@@ -150,6 +151,12 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 {
 	struct sdw_intel_res *res = cdata;
 	struct acpi_device *adev;
+	acpi_status status;
+	u64 adr;
+
+	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &adr);
+	if (ACPI_FAILURE(status))
+		return AE_OK; /* keep going */
 
 	if (acpi_bus_get_device(handle, &adev)) {
 		pr_err("%s: Couldn't find ACPI handle\n", __func__);
@@ -157,7 +164,19 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 	}
 
 	res->handle = handle;
-	return AE_OK;
+
+	/*
+	 * On some Intel platforms, multiple children of the HDAS
+	 * device can be found, but only one of them is the SoundWire
+	 * controller. The SNDW device is always exposed with
+	 * Name(_ADR, 0x40000000), with bits 31..28 representing the
+	 * SoundWire link so filter accordingly
+	 */
+	if ((adr & GENMASK(31, 28)) >> 28 != SDW_LINK_TYPE)
+		return AE_OK; /* keep going */
+
+	/* device found, stop namespace walk */
+	return AE_CTRL_TERMINATE;
 }
 
 /**
-- 
2.20.1


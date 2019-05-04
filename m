Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7485C004C9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71D62075C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfEDA3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 20:29:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:11134 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfEDA3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 20:29:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 17:29:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,427,1549958400"; 
   d="scan'208";a="170430423"
Received: from jlwhitty-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.28.45])
  by fmsmga001.fm.intel.com with ESMTP; 03 May 2019 17:29:39 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 1/8] soundwire: intel: filter SoundWire controller device search
Date:   Fri,  3 May 2019 19:29:19 -0500
Message-Id: <20190504002926.28815-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention is that the SoundWire controller device is a child of
the HDAudio controller. However there can be more than one child
exposed in the DSDT table, and the current namespace walk returns the
last device.

Add a filter and terminate early when a valid _ADR is provided,
otherwise keep iterating to find the next child.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index d3d6b54c5791..f85db67d05f0 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -150,6 +150,12 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
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
@@ -157,7 +163,18 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 	}
 
 	res->handle = handle;
-	return AE_OK;
+
+	/*
+	 * On some Intel platforms, multiple children of the HDAS
+	 * device can be found, but only one of them is the SoundWire
+	 * controller. The SNDW device is always exposed with
+	 * Name(_ADR, 0x40000000) so filter accordingly
+	 */
+	if (adr != 0x40000000)
+		return AE_OK; /* keep going */
+
+	/* device found, stop namespace walk */
+	return AE_CTRL_TERMINATE;
 }
 
 /**
-- 
2.17.1


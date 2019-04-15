Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32D3C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0A120818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfDOPTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:19:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:2071 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOPTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:19:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 08:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,354,1549958400"; 
   d="scan'208";a="149586833"
Received: from pmmacken-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.139.191])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2019 08:19:28 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        devel@acpica.org (open list:ACPI COMPONENT ARCHITECTURE (ACPICA))
Subject: [PATCH] ACPI / device_sysfs: change _ADR representation to 64 bits
Date:   Mon, 15 Apr 2019 10:18:57 -0500
Message-Id: <20190415151857.25531-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standards such as the MIPI DisCo for SoundWire 1.0 specification
assume the _ADR field is 64 bits.

_ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
released in 2002. The low levels already use _ADR as 64 bits, e.g. in
struct acpi_device_info.

This patch bumps the representation used for sysfs to 64 bits.

Example with a SoundWire device, the results show the complete
vendorID and linkID which were omitted before:

Before:
$ more /sys/bus/acpi/devices/device\:38/adr
0x5d070000
After:
$ more /sys/bus/acpi/devices/device\:38/adr
0x000010025d070000

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/acpi/device_sysfs.c | 3 +--
 include/acpi/acpi_bus.h     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 8940054d6250..f8d73ae42529 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -428,8 +428,7 @@ static ssize_t acpi_device_adr_show(struct device *dev,
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
-	return sprintf(buf, "0x%08x\n",
-		       (unsigned int)(acpi_dev->pnp.bus_address));
+	return sprintf(buf, "0x%016llx\n", acpi_dev->pnp.bus_address);
 }
 static DEVICE_ATTR(adr, 0444, acpi_device_adr_show, NULL);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f7981751ac77..9075e28ea60a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -230,7 +230,7 @@ struct acpi_device_dir {
 /* Plug and Play */
 
 typedef char acpi_bus_id[8];
-typedef unsigned long acpi_bus_address;
+typedef u64 acpi_bus_address;
 typedef char acpi_device_name[40];
 typedef char acpi_device_class[20];
 
-- 
2.17.1


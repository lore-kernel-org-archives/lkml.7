Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ED8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7F12075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfCKLWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:22:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfCKLWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:22:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C064882F5;
        Mon, 11 Mar 2019 11:22:23 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-37.ams2.redhat.com [10.36.117.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B3AC5C579;
        Mon, 11 Mar 2019 11:22:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mfd: intel-lpss: Add "linux,use-dynamic-adapter-nr" device-prop to i2c-devices
Date:   Mon, 11 Mar 2019 12:22:16 +0100
Message-Id: <20190311112216.31391-3-hdegoede@redhat.com>
In-Reply-To: <20190311112216.31391-1-hdegoede@redhat.com>
References: <20190311112216.31391-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 11 Mar 2019 11:22:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-designware-platdrv assumes that if the pdev has an apci-companion
it should use a dynamic adapter-nr and otherwise it will use pdev->id as
adapter-nr.

On some devices e.g. the Apollo Lake using Acer TravelMate Spin B118,
some of the LPSS i2c-adapters are enumerated through PCI and do not have
an ACPI fwnode. These devices are handled as mfd devices so they end up
using the i2c-designware-platdrv driver.

This results in the i2c-adapter being registered with the mfd generated
pdev->id as adapter-nr, which conflicts with existing adapters, triggering
a WARN(id < 0, "couldn't get idr") in i2c-core-base.c and causing the
adapter registration to fail.

To fix this the i2c-designware-platdrv now also supports a
"linux,use-dynamic-adapter-nr" device-property, which tells it to use a
dynamic adapter nr even if there is no ACPI fwnode for the device.

This commit adds this device-property to the properties list for PCI
enumerated LPSS i2c-adapters.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1687065
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/intel-lpss-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 0e5282fc1467..c7b84a0f090e 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -69,6 +69,7 @@ static const struct intel_lpss_platform_info spt_info = {
 
 static struct property_entry spt_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
+	PROPERTY_ENTRY_BOOL("linux,use-dynamic-adapter-nr"),
 	{ },
 };
 
@@ -104,6 +105,7 @@ static struct property_entry bxt_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 42),
 	PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
 	PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
+	PROPERTY_ENTRY_BOOL("linux,use-dynamic-adapter-nr"),
 	{ },
 };
 
@@ -116,6 +118,7 @@ static struct property_entry apl_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 207),
 	PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
 	PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
+	PROPERTY_ENTRY_BOOL("linux,use-dynamic-adapter-nr"),
 	{ },
 };
 
-- 
2.20.1


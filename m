Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1C4C433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4C4206C1
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 13:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHDNk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 09:40:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfHDNk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 09:40:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3063C796EF;
        Sun,  4 Aug 2019 13:40:26 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-50.ams2.redhat.com [10.36.116.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B43D15C22D;
        Sun,  4 Aug 2019 13:40:24 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        russianneuromancer@ya.ru
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for the Irbis TW90 tablet
Date:   Sun,  4 Aug 2019 15:40:23 +0200
Message-Id: <20190804134023.3495-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 04 Aug 2019 13:40:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen info for the Irbis TW90 tablet.

Reported-by: russianneuromancer@ya.ru
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 83dd6df674e8..20a943f519dd 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -273,6 +273,24 @@ static const struct ts_dmi_data gp_electronic_t701_data = {
 	.properties	= gp_electronic_t701_props,
 };
 
+static const struct property_entry irbis_tw90_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1138),
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 8),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 14),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3680-irbis_tw90.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data irbis_tw90_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= irbis_tw90_props,
+};
+
 static const struct property_entry itworks_tw891_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 5),
@@ -780,6 +798,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "itWORKS.G.WI71C.JGBMRB"),
 		},
 	},
+	{
+		/* Irbis TW90 */
+		.driver_data = (void *)&irbis_tw90_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IRBIS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TW90"),
+		},
+	},
 	{
 		/* I.T.Works TW891 */
 		.driver_data = (void *)&itworks_tw891_data,
-- 
2.22.0


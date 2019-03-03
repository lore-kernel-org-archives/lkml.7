Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BAFC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC43920836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=myself5.de header.i=@myself5.de header.b="c6keQmCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfCCNsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:48:13 -0500
Received: from myself5.de ([5.230.26.43]:51520 "EHLO myself5.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfCCNsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 08:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=myself5.de; s=mail;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=SBrZGwE2TfsT48jTXrshvYTdg6trXRsDlaV6C/MLUuk=;
        b=c6keQmCyZZWapVZQ6nhZx42YZAy45UKglrhg9iu6HJ7tPrzypyNWHtsriMBRCvZYwTPiKZDFxB3tTO9Z0hajbwM7BhrLcfvIP5gTfvOgsvTViGqzYcuu3Y6mRLIBW+8FDQ1OQfTT9pJj0m4bzuz6qOrN76d2CnLLPjIPs+GmAbVodNDKTT7tIF2WSVPY5yqGAeR4IyTaqcDXC5bix8phpzb+dwmMpB4pM1Hx9BQ8XIddv/VGzZHOEd2EJjpA30F+JlS8lAFlvLBnjrLGxR571lkP3PKIspWUsKaJSbooGyBvw4HNMtuPNQyECru53C2k6q6hgH6/om6zwK+MBQwE7w==;
Received: from hsi-kbw-085-216-078-008.hsi.kabelbw.de ([85.216.78.8] helo=M5MacBookPro.fritz.box)
        by myself5.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.84_2)
        (envelope-from <me@myself5.de>)
        id 1h0RTI-0005Tk-Ii; Sun, 03 Mar 2019 14:48:04 +0100
From:   Christian Oder <me@myself5.de>
To:     hdegoede@redhat.com
Cc:     andy@infradead.org, dvhart@infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        me@myself5.de, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2] platform/x86: touchscreen_dmi: Add info for the CHUWI Hi10 Air tablet
Date:   Sun,  3 Mar 2019 14:47:27 +0100
Message-Id: <20190303134727.6680-1-me@myself5.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <c6b0c2ef-eed9-ffae-e974-92260d5356aa@redhat.com>
References: <c6b0c2ef-eed9-ffae-e974-92260d5356aa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add  touchscreen info for the CHUWUI Hi10 Air tablet.

Signed-off-by: Christian Oder <me@myself5.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- added review tag

 drivers/platform/x86/touchscreen_dmi.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 167a156e3cc7..2d56ff7c8230 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -72,6 +72,25 @@ static const struct ts_dmi_data chuwi_hi8_pro_data = {
 	.properties	= chuwi_hi8_pro_props,
 };
 
+static const struct property_entry chuwi_hi10_air_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1981),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1271),
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 99),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 9),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_U32("touchscreen-fuzz-x", 5),
+	PROPERTY_ENTRY_U32("touchscreen-fuzz-y", 4),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-chuwi-hi10-air.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data chuwi_hi10_air_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= chuwi_hi10_air_props,
+};
+
 static const struct property_entry chuwi_vi8_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 4),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 6),
@@ -546,6 +565,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
 		},
 	},
+	{
+		/* Chuwi Hi10 Air */
+		.driver_data = (void *)&chuwi_hi10_air_data,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "P1W6_C109D_B"),
+		},
+	},
 	{
 		/* Chuwi Vi8 (CWI506) */
 		.driver_data = (void *)&chuwi_vi8_data,
-- 
2.20.1


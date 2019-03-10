Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD7DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD4220657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfCJQZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:25:00 -0400
Received: from shell.v3.sk ([90.176.6.54]:45130 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfCJQY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:24:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 07B0A102CAD;
        Sun, 10 Mar 2019 17:24:56 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QNbaK_JPbRam; Sun, 10 Mar 2019 17:24:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4F875102CB8;
        Sun, 10 Mar 2019 17:24:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dp5g__NxlNZd; Sun, 10 Mar 2019 17:24:31 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0B69E102CA8;
        Sun, 10 Mar 2019 17:24:31 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 08/10] power: supply: olpc_battery: Avoid using platform_info
Date:   Sun, 10 Mar 2019 17:24:17 +0100
Message-Id: <20190310162419.11861-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310162419.11861-1-lkundrak@v3.sk>
References: <20190310162419.11861-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This wouldn't work on the DT-based ARM platform. Let's read the EC versio=
n
directly from the EC driver instead.

This removes x86 specific bits that would prevent this driver from being
used with the EC of ARM-based OLPC XO 1.75.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Changes since v5:
- Turn new_proto into a bool

Changes since v2:
- Move the priv data allocation hunk from this patch to a proper place

Changes since v1:
- Use uint8_t instead of unsigned char [1] for ecver

 drivers/power/supply/olpc_battery.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index d83c77c2a0ec..8be44c717d85 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -57,6 +57,7 @@ struct olpc_battery_data {
 	struct power_supply *olpc_ac;
 	struct power_supply *olpc_bat;
 	char bat_serial[17];
+	bool new_proto;
 };
=20
 /*********************************************************************
@@ -100,7 +101,7 @@ static const struct power_supply_desc olpc_ac_desc =3D=
 {
 static int olpc_bat_get_status(struct olpc_battery_data *data,
 		union power_supply_propval *val, uint8_t ec_byte)
 {
-	if (olpc_platform_info.ecver > 0x44) {
+	if (data->new_proto) {
 		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
 			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
 		else if (ec_byte & BAT_STAT_DISCHARGING)
@@ -608,6 +609,7 @@ static int olpc_battery_probe(struct platform_device =
*pdev)
 	struct power_supply_config psy_cfg =3D {};
 	struct olpc_battery_data *data;
 	uint8_t status;
+	uint8_t ecver;
 	int ret;
=20
 	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -615,13 +617,21 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, data);
=20
-	/*
-	 * We've seen a number of EC protocol changes; this driver requires
-	 * the latest EC protocol, supported by 0x44 and above.
-	 */
-	if (olpc_platform_info.ecver < 0x44) {
+	/* See if the EC is already there and get the EC revision */
+	ret =3D olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ecver, 1);
+	if (ret)
+		return ret;
+
+	if (ecver > 0x44) {
+		/* XO 1 or 1.5 with a new EC firmware. */
+		data->new_proto =3D true;
+	} else if (ecver < 0x44) {
+		/*
+		 * We've seen a number of EC protocol changes; this driver
+		 * requires the latest EC protocol, supported by 0x44 and above.
+		 */
 		printk(KERN_NOTICE "OLPC EC version 0x%02x too old for "
-			"battery driver.\n", olpc_platform_info.ecver);
+			"battery driver.\n", ecver);
 		return -ENXIO;
 	}
=20
--=20
2.20.1


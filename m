Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE441C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B964820657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCJQZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:25:24 -0400
Received: from shell.v3.sk ([90.176.6.54]:45141 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfCJQY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:24:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 37AC7102CAE;
        Sun, 10 Mar 2019 17:24:53 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OqkGrqDTHt77; Sun, 10 Mar 2019 17:24:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 51A1C102C8A;
        Sun, 10 Mar 2019 17:24:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B0ls7K63qpbv; Sun, 10 Mar 2019 17:24:30 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DA7CE102CB3;
        Sun, 10 Mar 2019 17:24:29 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 05/10] power: supply: olpc_battery: Use DT to get battery version
Date:   Sun, 10 Mar 2019 17:24:14 +0100
Message-Id: <20190310162419.11861-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310162419.11861-1-lkundrak@v3.sk>
References: <20190310162419.11861-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid using the x86 OLPC platform specific call to get the board
version. That wouldn't work on FDT-based ARM MMP2 platform.

Add the XO 1.5 compatible string too. This is actually not completely
necessary as the battery nodes on XO 1.5 claim to be compatible with
"olpc,xo1-battery", but there are, in fact, differencies.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---
Changes since v5:
- Use of_device_is_compatible() instead of
  of_property_match_string("compatible")

Changes since v2:
- Clarify the XO 1 compatibility in the commit message.

Changes since v1:
- Sort the new include a bit higher

 drivers/power/supply/olpc_battery.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
index 5a97e42a3547..3dcf5e19f329 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/jiffies.h>
@@ -622,11 +623,12 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
 	olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
 	if (IS_ERR(olpc_ac))
 		return PTR_ERR(olpc_ac);
-
-	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
+	if (of_device_is_compatible(pdev->dev.of_node, "olpc,xo1.5-battery")) {
+		/* XO-1.5 */
 		olpc_bat_desc.properties =3D olpc_xo15_bat_props;
 		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo15_bat_props);
-	} else { /* XO-1 */
+	} else {
+		/* XO-1 */
 		olpc_bat_desc.properties =3D olpc_xo1_bat_props;
 		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
 	}
@@ -672,6 +674,7 @@ static int olpc_battery_remove(struct platform_device=
 *pdev)
=20
 static const struct of_device_id olpc_battery_ids[] =3D {
 	{ .compatible =3D "olpc,xo1-battery" },
+	{ .compatible =3D "olpc,xo1.5-battery" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, olpc_battery_ids);
--=20
2.20.1


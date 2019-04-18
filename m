Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09DAC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8670F206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbfDROrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:47:35 -0400
Received: from shell.v3.sk ([90.176.6.54]:48020 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388685AbfDROrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:47:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 203761027E1;
        Thu, 18 Apr 2019 16:47:29 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3SShGV9OaCBZ; Thu, 18 Apr 2019 16:47:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E2C711027A1;
        Thu, 18 Apr 2019 16:47:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 17yGudhjh6Y2; Thu, 18 Apr 2019 16:47:02 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4F4401027AD;
        Thu, 18 Apr 2019 16:47:00 +0200 (CEST)
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
Subject: [PATCH v7 05/10] power: supply: olpc_battery: Use DT to get battery version
Date:   Thu, 18 Apr 2019 16:46:50 +0200
Message-Id: <20190418144655.18758-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418144655.18758-1-lkundrak@v3.sk>
References: <20190418144655.18758-1-lkundrak@v3.sk>
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
2.21.0


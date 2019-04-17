Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FD6C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DBA2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfDQCmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:42:33 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:5488 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbfDQCma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:42:30 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id AB8367CE6013546EB907;
        Wed, 17 Apr 2019 10:42:28 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x3H2gLOt060615;
        Wed, 17 Apr 2019 10:42:21 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019041710424126-8909753 ;
          Wed, 17 Apr 2019 10:42:41 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] power: supply: fix leaked of_node refs in power_supply_get_battery_info
Date:   Wed, 17 Apr 2019 10:43:03 +0800
Message-Id: <1555468983-34952-3-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
References: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-17 10:42:41,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-17 10:42:13,
        Serialize complete at 2019-04-17 10:42:13
X-MAIL: mse01.zte.com.cn x3H2gLOt060615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/power/supply/power_supply_core.c:601:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.
./drivers/power/supply/power_supply_core.c:604:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.
./drivers/power/supply/power_supply_core.c:632:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.
./drivers/power/supply/power_supply_core.c:635:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.
./drivers/power/supply/power_supply_core.c:653:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.
./drivers/power/supply/power_supply_core.c:664:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.
./drivers/power/supply/power_supply_core.c:673:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 595, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/power/supply/power_supply_core.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 65c619c..874495c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -598,10 +598,12 @@ int power_supply_get_battery_info(struct power_supply *psy,
 
 	err = of_property_read_string(battery_np, "compatible", &value);
 	if (err)
-		return err;
+		goto out_put_node;
 
-	if (strcmp("simple-battery", value))
-		return -ENODEV;
+	if (strcmp("simple-battery", value)) {
+		err = -ENODEV;
+		goto out_put_node;
+	}
 
 	/* The property and field names below must correspond to elements
 	 * in enum power_supply_property. For reasoning, see
@@ -629,10 +631,12 @@ int power_supply_get_battery_info(struct power_supply *psy,
 
 	len = of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
 	if (len < 0 && len != -EINVAL) {
-		return len;
+		err = len;
+		goto out_put_node;
 	} else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
 		dev_err(&psy->dev, "Too many temperature values\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto out_put_node;
 	} else if (len > 0) {
 		of_property_read_u32_array(battery_np, "ocv-capacity-celsius",
 					   info->ocv_temp, len);
@@ -650,7 +654,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			dev_err(&psy->dev, "failed to get %s\n", propname);
 			kfree(propname);
 			power_supply_put_battery_info(psy, info);
-			return -EINVAL;
+			err = -EINVAL;
+			goto out_put_node;
 		}
 
 		kfree(propname);
@@ -661,7 +666,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
 		if (!info->ocv_table[index]) {
 			power_supply_put_battery_info(psy, info);
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto out_put_node;
 		}
 
 		for (i = 0; i < tab_len; i++) {
@@ -670,7 +676,9 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		}
 	}
 
-	return 0;
+out_put_node:
+	of_node_put(battery_np);
+	return err;
 }
 EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
 
-- 
2.9.5


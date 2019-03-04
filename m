Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B77C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093F220645
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfCDMCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:02:01 -0500
Received: from skyboo.net ([94.40.87.198]:57270 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfCDMCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:02:00 -0500
X-Greylist: delayed 2276 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Mar 2019 07:01:58 EST
Received: from manio by skyboo.net with local (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1h0lhK-0005n2-6q; Mon, 04 Mar 2019 12:24:00 +0100
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <greg@kroah.com>
Cc:     Mariusz Bialonczyk <manio@skyboo.net>,
        Andrew Worsley <amworsley@gmail.com>,
        "Andrew F . Davis" <afd@ti.com>
Date:   Mon,  4 Mar 2019 12:23:36 +0100
Message-Id: <20190304112336.21397-1-manio@skyboo.net>
X-Mailer: git-send-email 2.19.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, zbr@ioremap.net, greg@kroah.com, manio@skyboo.net, amworsley@gmail.com, afd@ti.com
X-SA-Exim-Mail-From: manio@skyboo.net
Subject: [PATCH] w1: ds2482: cosmetic fixes after 54865314f5a1
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a helper function ds2482_calculate_config() which is calculating
the config value, so just use it instead of passing the same variable
in all calls to this function.

Also fixes the placement of module parameters to match with:
50fa2951bd74 (w1: Organize driver source to natural/common order)
by Andrew F. Davis

Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
Cc: Andrew Worsley <amworsley@gmail.com>
Cc: Andrew F. Davis <afd@ti.com>
---
 drivers/w1/masters/ds2482.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index 8b5e598ffdb3..8f2b25f1614c 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -37,6 +37,11 @@ module_param_named(active_pullup, ds2482_active_pullup, int, 0644);
 MODULE_PARM_DESC(active_pullup, "Active pullup (apply to all buses): " \
 				"0-disable, 1-enable (default)");
 
+/* extra configurations - e.g. 1WS */
+static int extra_config;
+module_param(extra_config, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(extra_config, "Extra Configuration settings 1=APU,2=PPM,3=SPU,8=1WS");
+
 /**
  * The DS2482 registers - there are 3 registers that are addressed by a read
  * pointer. The read pointer is set by the last command executed.
@@ -70,8 +75,6 @@ MODULE_PARM_DESC(active_pullup, "Active pullup (apply to all buses): " \
 #define DS2482_REG_CFG_PPM		0x02	/* presence pulse masking */
 #define DS2482_REG_CFG_APU		0x01	/* active pull-up */
 
-/* extra configurations - e.g. 1WS */
-static int extra_config;
 
 /**
  * Write and verify codes for the CHANNEL_SELECT command (DS2482-800 only).
@@ -130,6 +133,8 @@ struct ds2482_data {
  */
 static inline u8 ds2482_calculate_config(u8 conf)
 {
+	conf |= extra_config;
+
 	if (ds2482_active_pullup)
 		conf |= DS2482_REG_CFG_APU;
 
@@ -405,7 +410,7 @@ static u8 ds2482_w1_reset_bus(void *data)
 		/* If the chip did reset since detect, re-config it */
 		if (err & DS2482_REG_STS_RST)
 			ds2482_send_cmd_data(pdev, DS2482_CMD_WRITE_CONFIG,
-					ds2482_calculate_config(extra_config));
+					     ds2482_calculate_config(0x00));
 	}
 
 	mutex_unlock(&pdev->access_lock);
@@ -431,7 +436,8 @@ static u8 ds2482_w1_set_pullup(void *data, int delay)
 		ds2482_wait_1wire_idle(pdev);
 		/* note: it seems like both SPU and APU have to be set! */
 		retval = ds2482_send_cmd_data(pdev, DS2482_CMD_WRITE_CONFIG,
-			ds2482_calculate_config(extra_config|DS2482_REG_CFG_SPU|DS2482_REG_CFG_APU));
+			ds2482_calculate_config(DS2482_REG_CFG_SPU |
+						DS2482_REG_CFG_APU));
 		ds2482_wait_1wire_idle(pdev);
 	}
 
@@ -484,7 +490,7 @@ static int ds2482_probe(struct i2c_client *client,
 
 	/* Set all config items to 0 (off) */
 	ds2482_send_cmd_data(data, DS2482_CMD_WRITE_CONFIG,
-		ds2482_calculate_config(extra_config));
+		ds2482_calculate_config(0x00));
 
 	mutex_init(&data->access_lock);
 
@@ -559,7 +565,5 @@ module_i2c_driver(ds2482_driver);
 
 MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
 MODULE_DESCRIPTION("DS2482 driver");
-module_param(extra_config, int, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(extra_config, "Extra Configuration settings 1=APU,2=PPM,3=SPU,8=1WS");
 
 MODULE_LICENSE("GPL");
-- 
2.19.0.rc1


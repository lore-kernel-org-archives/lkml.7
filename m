Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3764C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8119D2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfLPMaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:30:00 -0500
Received: from sauhun.de ([88.99.104.3]:39798 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbfLPM3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:29:53 -0500
Received: from localhost (p54B33297.dip0.t-ipconnect.de [84.179.50.151])
        by pokefinder.org (Postfix) with ESMTPSA id 620C62C2D92;
        Mon, 16 Dec 2019 13:29:52 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] platform: chrome: convert to i2c_new_scanned_device
Date:   Mon, 16 Dec 2019 13:29:51 +0100
Message-Id: <20191216122951.3679-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216122951.3679-1-wsa+renesas@sang-engineering.com>
References: <20191216122951.3679-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/platform/chrome/chromeos_laptop.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 8723bcf10c93..4f3651fcd9fe 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -63,7 +63,7 @@ struct acpi_peripheral {
 struct chromeos_laptop {
 	/*
 	 * Note that we can't mark this pointer as const because
-	 * i2c_new_probed_device() changes passed in I2C board info, so.
+	 * i2c_new_scanned_device() changes passed in I2C board info, so.
 	 */
 	struct i2c_peripheral *i2c_peripherals;
 	unsigned int num_i2c_peripherals;
@@ -87,8 +87,8 @@ chromes_laptop_instantiate_i2c_device(struct i2c_adapter *adapter,
 	 * address we scan secondary addresses. In any case the client
 	 * structure gets assigned primary address.
 	 */
-	client = i2c_new_probed_device(adapter, info, addr_list, NULL);
-	if (!client && alt_addr) {
+	client = i2c_new_scanned_device(adapter, info, addr_list, NULL);
+	if (IS_ERR(client) && alt_addr) {
 		struct i2c_board_info dummy_info = {
 			I2C_BOARD_INFO("dummy", info->addr),
 		};
@@ -97,9 +97,9 @@ chromes_laptop_instantiate_i2c_device(struct i2c_adapter *adapter,
 		};
 		struct i2c_client *dummy;
 
-		dummy = i2c_new_probed_device(adapter, &dummy_info,
-					      alt_addr_list, NULL);
-		if (dummy) {
+		dummy = i2c_new_scanned_device(adapter, &dummy_info,
+					       alt_addr_list, NULL);
+		if (!IS_ERR(dummy)) {
 			pr_debug("%d-%02x is probed at %02x\n",
 				 adapter->nr, info->addr, dummy->addr);
 			i2c_unregister_device(dummy);
@@ -107,12 +107,14 @@ chromes_laptop_instantiate_i2c_device(struct i2c_adapter *adapter,
 		}
 	}
 
-	if (!client)
+	if (IS_ERR(client)) {
+		client = NULL;
 		pr_debug("failed to register device %d-%02x\n",
 			 adapter->nr, info->addr);
-	else
+	} else {
 		pr_debug("added i2c device %d-%02x\n",
 			 adapter->nr, info->addr);
+	}
 
 	return client;
 }
-- 
2.20.1


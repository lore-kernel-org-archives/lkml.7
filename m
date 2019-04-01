Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40787C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C2A20879
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554090202;
	bh=3vsHmTspt1AeVGkHKsrcnxUixcw9eectjzyiiOf8pus=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=W9qGfpH11FXOCE6Hm3KetsXLCWOjh1mOjoL8h29t+r9/0s7951yD5DV8qai0uFRCt
	 T2LWRX85GWfQxSj9qF1V1lM5C128EzIsZ+RxGOCp70BHXWFVi2vdE3ThU10FaTcwiZ
	 gRI4uHcCPNMLQZ3OLj8YHNj0+4Ku71enzdWuDHYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfDADnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:43:21 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:42892 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731383AbfDADnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 23:43:21 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 8EB495FD0F; Mon,  1 Apr 2019 11:43:17 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Imre Kaloz <kaloz@dune.hu>,
        stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Fix empty regulator supplies for Intel Macs
Date:   Mon,  1 Apr 2019 11:43:12 +0800
Message-Id: <20190401034312.27475-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The code path for Macs goes through bcm_apple_get_resources(), which
skips over the code that sets up the regulator supplies. As a result,
the call to regulator_bulk_enable() / regulator_bulk_disable() results
in a NULL pointer dereference.

This was reported on the kernel.org Bugzilla, bug 202963.

Unbreak Broadcom Bluetooth support on Intel Macs by checking if the
supplies were set up before enabling or disabling them.

The same does not need to be done for the clocks, as the common clock
framework API checks for NULL pointers.

Fixes: 75d11676dccb ("Bluetooth: hci_bcm: Add support for regulator supplies")
Cc: <stable@vger.kernel.org> # 5.0.x
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

I do not own a Mac, so this needs to be tested by someone else.

---
 drivers/bluetooth/hci_bcm.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbe518c3e5b..b5d31d583d60 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -228,9 +228,15 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	int err;
 
 	if (powered && !dev->res_enabled) {
-		err = regulator_bulk_enable(BCM_NUM_SUPPLIES, dev->supplies);
-		if (err)
-			return err;
+		/* Intel Macs use bcm_apple_get_resources() and don't
+		 * have regulator supplies configured.
+		 */
+		if (dev->supplies[0].supply) {
+			err = regulator_bulk_enable(BCM_NUM_SUPPLIES,
+						    dev->supplies);
+			if (err)
+				return err;
+		}
 
 		/* LPO clock needs to be 32.768 kHz */
 		err = clk_set_rate(dev->lpo_clk, 32768);
@@ -259,7 +265,13 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	if (!powered && dev->res_enabled) {
 		clk_disable_unprepare(dev->txco_clk);
 		clk_disable_unprepare(dev->lpo_clk);
-		regulator_bulk_disable(BCM_NUM_SUPPLIES, dev->supplies);
+
+		/* Intel Macs use bcm_apple_get_resources() and don't
+		 * have regulator supplies configured.
+		 */
+		if (dev->supplies[0].supply)
+			regulator_bulk_disable(BCM_NUM_SUPPLIES,
+					       dev->supplies);
 	}
 
 	/* wait for device to power on and come out of reset */
-- 
2.20.1


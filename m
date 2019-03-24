Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E917C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A4221019
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfCXX1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 19:27:01 -0400
Received: from muru.com ([72.249.23.125]:42306 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfCXX1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 19:27:00 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7B28B80E1;
        Sun, 24 Mar 2019 23:27:13 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, NeilBrown <neilb@suse.com>
Subject: [PATCH] phy: phy-twl4030-usb: Fix cable state handling
Date:   Sun, 24 Mar 2019 16:26:54 -0700
Message-Id: <20190324232654.60812-1-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent regulator changes I noticed new warnings on doing rmmod of
phy-twl4030-usb:

WARNING: CPU: 0 PID: 1080 at drivers/regulator/core.c:2046 _regulator_put
...

Turns out we can currently miss disconnect at least for cases where status
is 0 and linkstat is 0. And in that case doing rmmod phy-twl4030-usb will
produce the regulator_put() warning.

This is because the missed disconnect causes unbalanced PM runtime calls
and the regulators will be on exit.

Let's fix the issue by using an atomic flag for the cable state to make
sure that PM runtime won't get out of sync with the cable state. That
way we can also simplify the code a bit.

Note that we can also drop the old comments, those relate to issues that
the battery charger driver and musb driver is dealing with rather than
the USB PHY driver.

Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/phy/ti/phy-twl4030-usb.c | 35 ++++++++++++--------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
--- a/drivers/phy/ti/phy-twl4030-usb.c
+++ b/drivers/phy/ti/phy-twl4030-usb.c
@@ -172,6 +172,7 @@ struct twl4030_usb {
 
 	int			irq;
 	enum musb_vbus_id_status linkstat;
+	atomic_t		connected;
 	bool			vbus_supplied;
 	bool			musb_mailbox_pending;
 
@@ -575,39 +576,29 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
 	struct twl4030_usb *twl = _twl;
 	enum musb_vbus_id_status status;
-	bool status_changed = false;
 	int err;
 
 	status = twl4030_usb_linkstat(twl);
 
 	mutex_lock(&twl->lock);
-	if (status >= 0 && status != twl->linkstat) {
-		status_changed =
-			cable_present(twl->linkstat) !=
-			cable_present(status);
-		twl->linkstat = status;
-	}
+	twl->linkstat = status;
 	mutex_unlock(&twl->lock);
 
-	if (status_changed) {
-		/* FIXME add a set_power() method so that B-devices can
-		 * configure the charger appropriately.  It's not always
-		 * correct to consume VBUS power, and how much current to
-		 * consume is a function of the USB configuration chosen
-		 * by the host.
-		 *
-		 * REVISIT usb_gadget_vbus_connect(...) as needed, ditto
-		 * its disconnect() sibling, when changing to/from the
-		 * USB_LINK_VBUS state.  musb_hdrc won't care until it
-		 * starts to handle softconnect right.
-		 */
-		if (cable_present(status)) {
+	if (cable_present(status)) {
+		if (atomic_add_unless(&twl->connected, 1, 1)) {
+			dev_dbg(twl->dev, "%s: cable connected %i\n",
+				__func__, status);
 			pm_runtime_get_sync(twl->dev);
-		} else {
+			twl->musb_mailbox_pending = true;
+		}
+	} else {
+		if (atomic_add_unless(&twl->connected, -1, 0)) {
+			dev_dbg(twl->dev, "%s: cable disconnected %i\n",
+				__func__, status);
 			pm_runtime_mark_last_busy(twl->dev);
 			pm_runtime_put_autosuspend(twl->dev);
+			twl->musb_mailbox_pending = true;
 		}
-		twl->musb_mailbox_pending = true;
 	}
 	if (twl->musb_mailbox_pending) {
 		err = musb_mailbox(status);
-- 
2.21.0

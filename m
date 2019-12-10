Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F33C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF5F2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576015421;
	bh=3NJK7LSeQsv9ayLSa/zZdTL8LE1cuD1zQV8odFPXkH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B0dcCztIxUoQ4SnoWq3vILCJLtVaVj9/ojq2eqfKI8F1QiMnPPBOj30aPW2Mbsnmn
	 cGHnY1Jq00BEPItTjwJ8s7qOnB7qGxWPl2LwrJNLkvfGdnWoR9fIwO4FRZTx5xxwWM
	 BESUtgrXeozNfpnMIbH68Q/g6FBhzFBQ4Lbm4Szc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfLJWDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:03:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfLJWDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:03:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1B292077B;
        Tue, 10 Dec 2019 22:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015409;
        bh=3NJK7LSeQsv9ayLSa/zZdTL8LE1cuD1zQV8odFPXkH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t8CakMp1k8E5yKECXnERogwmRcK6pkiZlQcJlFUjzaCuVSrMiULRThMoXBiqW/PBi
         G+Sqc3B7emf4BAmTqQoxlzH8l8aNstUfMuP4JSVPeWb55IWFZ1zJVmD+xhmDnmL0jR
         AGauo2T6N71NlB0KNxHnvcXB+EBrEPm3fA/wCJXA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 023/130] usb: renesas_usbhs: add suspend event support in gadget mode
Date:   Tue, 10 Dec 2019 17:01:14 -0500
Message-Id: <20191210220301.13262-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>

[ Upstream commit 39abcc84846bbc0538f13c190b6a9c7e36890cd2 ]

When R-Car Gen3 USB 2.0 is in Gadget mode, if host is detached an interrupt
will be generated and Suspended state bit is set in interrupt status
register. Interrupt handler will call driver->suspend(composite_suspend)
if suspended state bit is set. composite_suspend will call
ffs_func_suspend which will post FUNCTIONFS_SUSPEND and will be consumed
by user space application via /dev/ep0.

To be able to detect host detach, extend the DVSQ_MASK to cover the
Suspended bit of the DVSQ[2:0] bitfield from the Interrupt Status
Register 0 (INTSTS0) register and perform appropriate action in the
DVST interrupt handler (usbhsg_irq_dev_state).

Without this commit, disconnection of the phone from R-Car-H3 ES2.0
Salvator-X CN9 port is not recognized and reverse role switch does
not happen. If phone is connected again it does not enumerate.

With this commit, disconnection will be recognized and reverse role
switch will happen by a user space application. If phone is connected
again it will enumerate properly and will become visible in the output
of 'lsusb'.

Signed-off-by: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/1568207756-22325-3-git-send-email-external.veeraiyan.c@de.adit-jv.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/renesas_usbhs/common.h     |  3 ++-
 drivers/usb/renesas_usbhs/mod_gadget.c | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
index b8620aa6b72e6..8424c165f732a 100644
--- a/drivers/usb/renesas_usbhs/common.h
+++ b/drivers/usb/renesas_usbhs/common.h
@@ -163,11 +163,12 @@ struct usbhs_priv;
 #define VBSTS	(1 << 7)	/* VBUS_0 and VBUSIN_0 Input Status */
 #define VALID	(1 << 3)	/* USB Request Receive */
 
-#define DVSQ_MASK		(0x3 << 4)	/* Device State */
+#define DVSQ_MASK		(0x7 << 4)	/* Device State */
 #define  POWER_STATE		(0 << 4)
 #define  DEFAULT_STATE		(1 << 4)
 #define  ADDRESS_STATE		(2 << 4)
 #define  CONFIGURATION_STATE	(3 << 4)
+#define  SUSPENDED_STATE	(4 << 4)
 
 #define CTSQ_MASK		(0x7)	/* Control Transfer Stage */
 #define  IDLE_SETUP_STAGE	0	/* Idle stage or setup stage */
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 0dedb0d91dccb..b27f2135b66d7 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -465,12 +465,18 @@ static int usbhsg_irq_dev_state(struct usbhs_priv *priv,
 {
 	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
 	struct device *dev = usbhsg_gpriv_to_dev(gpriv);
+	int state = usbhs_status_get_device_state(irq_state);
 
 	gpriv->gadget.speed = usbhs_bus_get_speed(priv);
 
-	dev_dbg(dev, "state = %x : speed : %d\n",
-		usbhs_status_get_device_state(irq_state),
-		gpriv->gadget.speed);
+	dev_dbg(dev, "state = %x : speed : %d\n", state, gpriv->gadget.speed);
+
+	if (gpriv->gadget.speed != USB_SPEED_UNKNOWN &&
+	    (state & SUSPENDED_STATE)) {
+		if (gpriv->driver && gpriv->driver->suspend)
+			gpriv->driver->suspend(&gpriv->gadget);
+		usb_gadget_set_state(&gpriv->gadget, USB_STATE_SUSPENDED);
+	}
 
 	return 0;
 }
-- 
2.20.1


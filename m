Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0D2C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976962075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfFEJGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:06:19 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:49387 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEJGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:06:19 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 44CD33C014D;
        Wed,  5 Jun 2019 11:06:16 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qlywOd2IU4e6; Wed,  5 Jun 2019 11:06:09 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id B23853C00D1;
        Wed,  5 Jun 2019 11:06:09 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 5 Jun 2019
 11:06:09 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Kento Kobayashi <Kento.A.Kobayashi@sony.com>,
        Hui Peng <benquike@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jan-Marek Glogowski <glogow@fbihome.de>,
        Bin Liu <b-liu@ti.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jon Flatley <jflat@chromium.org>,
        Mathieu Malaterre <malat@debian.org>
CC:     Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        "George G . Davis" <george_davis@mentor.com>,
        <yuichi.kusakabe@denso-ten.com>, <yohhei.fukui@denso-ten.com>,
        <natsumi.kamei@denso-ten.com>, <yasano@jp.adit-jv.com>
Subject: [PATCH] usb: hub: report failure to enumerate uevent to userspace
Date:   Wed, 5 Jun 2019 11:05:56 +0200
Message-ID: <20190605090556.17792-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>

When a USB device fails to enumerate, only a kernel message is printed.
With this patch, a uevent is also generated to notify userspace.
Services can monitor for the event through udev and handle failures
accordingly.

The "port_enumerate_fail_notify()" function name follows the syntax of
"port_over_current_notify()" used in v4.20-rc1
commit 201af55da8a398 ("usb: core: added uevent for over-current").

Signed-off-by: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 Documentation/ABI/testing/usb-uevent | 36 ++++++++++++++++++++++++++++
 drivers/usb/core/hub.c               | 15 +++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/usb-uevent b/Documentation/ABI/testing/usb-uevent
index d35c3cad892c..23e618227d31 100644
--- a/Documentation/ABI/testing/usb-uevent
+++ b/Documentation/ABI/testing/usb-uevent
@@ -25,3 +25,39 @@ Description:	When the USB Host Controller has entered a state where it is no
 		TYPE=9/0/1
 
 Users:		chromium-os-dev@chromium.org
+
+What:		Raise a uevent when USB device enumeration has failed
+Date:		2019-06-05
+KernelVersion:	5.2
+Contact:	linux-usb@vger.kernel.org
+Description:	When a USB device has failed to enumerate, a uevent will be generated.
+		The uevent will contain ACTION=change, ENUMERATION_FAILURE=1 and
+		ENUMERATION_FAIL_PORT=<port_id>. Services can monitor for the event
+		through udev and handle failures accordingly.
+
+		Here is an example taken using udevadm monitor -p (R-Car H3ULCB):
+
+		UDEV  [47.298493] change   /devices/platform/soc/ee0a0000.usb/usb4/4-0:1.0 (usb)
+		ACTION=change
+		DEVPATH=/devices/platform/soc/ee0a0000.usb/usb4/4-0:1.0
+		DEVTYPE=usb_interface
+		DRIVER=hub
+		ENUMERATION_FAILURE=1
+		ENUMERATION_FAIL_PORT=1
+		ID_MODEL_FROM_DATABASE=1.1 root hub
+		ID_USB_CLASS_FROM_DATABASE=Hub
+		ID_USB_PROTOCOL_FROM_DATABASE=Full speed (or root) hub
+		ID_VENDOR_FROM_DATABASE=Linux Foundation
+		INTERFACE=9/0/0
+		MODALIAS=usb:v1D6Bp0001d0502dc09dsc00dp00ic09isc00ip00in00
+		OF_COMPATIBLE_0=generic-ohci
+		OF_COMPATIBLE_N=1
+		OF_FULLNAME=/soc/usb@ee0a0000
+		OF_NAME=usb
+		PRODUCT=1d6b/1/502
+		SEQNUM=1762
+		SUBSYSTEM=usb
+		TYPE=9/0/0
+		USEC_INITIALIZED=24344435
+
+Users:		ADIT, DENSO TEN
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 2f94568ba385..da1a3d47a071 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4921,6 +4921,17 @@ hub_power_remaining(struct usb_hub *hub)
 	return remaining;
 }
 
+static void port_enumerate_fail_notify(struct usb_port *port)
+{
+	char env_port[32];
+	char *envp[3] = { "ENUMERATION_FAILURE=1", env_port, NULL };
+
+	snprintf(env_port, sizeof(env_port), "ENUMERATION_FAIL_PORT=%d",
+		 port->portnum);
+
+	kobject_uevent_env(&port->dev.parent->kobj, KOBJ_CHANGE, envp);
+}
+
 static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		u16 portchange)
 {
@@ -5131,9 +5142,11 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 	if (hub->hdev->parent ||
 			!hcd->driver->port_handed_over ||
 			!(hcd->driver->port_handed_over)(hcd, port1)) {
-		if (status != -ENOTCONN && status != -ENODEV)
+		if (status != -ENOTCONN && status != -ENODEV) {
+			port_enumerate_fail_notify(port_dev);
 			dev_err(&port_dev->dev,
 					"unable to enumerate USB device\n");
+		}
 	}
 
 done:
-- 
2.21.0


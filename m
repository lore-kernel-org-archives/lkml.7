Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB3CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866DF20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCSHw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:52:56 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25225 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725988AbfCSHw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 03:52:56 -0400
X-UUID: 3adc52ba73264bf2905c80e92a58f64e-20190319
X-UUID: 3adc52ba73264bf2905c80e92a58f64e-20190319
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 725628735; Tue, 19 Mar 2019 15:52:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Mar 2019 15:52:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Mar 2019 15:52:33 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Johan Hovold <johan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colin Ian King <colin.king@canonical.com>,
        Matteo Croce <mcroce@redhat.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] usb: introduce usb_ep_type_string() function
Date:   Tue, 19 Mar 2019 15:44:24 +0800
Message-ID: <28a8e9f1518e47c35e4563706cbe592b972a7f9d.1552977710.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some places, the code prints a human-readable USB endpoint
transfer type (e.g. "Bulk"). This involves a switch statement
sometimes wrapped around in ({ ... }) block leading to code
repetition.
To make this scenario easier, here introduces usb_ep_type_string()
function, which returns a human-readable name of provided
endpoint type.
It also changes a few places switch was used to use this
new function.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2 changes:
    1. keep type string consistent with type_show() used in endpoint.c
---
 drivers/usb/common/common.c              | 16 ++++++++++++++++
 drivers/usb/core/endpoint.c              | 18 ++----------------
 drivers/usb/core/hcd.c                   | 17 ++---------------
 drivers/usb/dwc3/debugfs.c               | 23 ++++-------------------
 drivers/usb/gadget/udc/aspeed-vhub/epn.c |  6 +-----
 drivers/usb/gadget/udc/dummy_hcd.c       | 16 +---------------
 drivers/usb/host/xhci-trace.h            | 19 ++-----------------
 include/linux/usb/ch9.h                  |  8 ++++++++
 8 files changed, 36 insertions(+), 87 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 48277bbc15e4..529b01e786fd 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -16,6 +16,22 @@
 #include <linux/usb/otg.h>
 #include <linux/of_platform.h>
 
+static const char *const ep_type_names[] = {
+	[USB_ENDPOINT_XFER_CONTROL] = "Control",
+	[USB_ENDPOINT_XFER_ISOC] = "Isoc",
+	[USB_ENDPOINT_XFER_BULK] = "Bulk",
+	[USB_ENDPOINT_XFER_INT] = "Interrupt",
+};
+
+const char *usb_ep_type_string(int ep_type)
+{
+	if (ep_type < 0 || ep_type >= ARRAY_SIZE(ep_type_names))
+		return "unknown";
+
+	return ep_type_names[ep_type];
+}
+EXPORT_SYMBOL_GPL(usb_ep_type_string);
+
 const char *usb_otg_state_string(enum usb_otg_state state)
 {
 	static const char *const names[] = {
diff --git a/drivers/usb/core/endpoint.c b/drivers/usb/core/endpoint.c
index 1c2c04079676..afa43f9a47b2 100644
--- a/drivers/usb/core/endpoint.c
+++ b/drivers/usb/core/endpoint.c
@@ -60,23 +60,9 @@ static ssize_t type_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct ep_device *ep = to_ep_device(dev);
-	char *type = "unknown";
+	int ep_type = usb_endpoint_type(ep->desc);
 
-	switch (usb_endpoint_type(ep->desc)) {
-	case USB_ENDPOINT_XFER_CONTROL:
-		type = "Control";
-		break;
-	case USB_ENDPOINT_XFER_ISOC:
-		type = "Isoc";
-		break;
-	case USB_ENDPOINT_XFER_BULK:
-		type = "Bulk";
-		break;
-	case USB_ENDPOINT_XFER_INT:
-		type = "Interrupt";
-		break;
-	}
-	return sprintf(buf, "%s\n", type);
+	return sprintf(buf, "%s\n", usb_ep_type_string(ep_type));
 }
 static DEVICE_ATTR_RO(type);
 
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 3189181bb628..0ccf2efeb40b 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1878,23 +1878,10 @@ void usb_hcd_flush_endpoint(struct usb_device *udev,
 		/* kick hcd */
 		unlink1(hcd, urb, -ESHUTDOWN);
 		dev_dbg (hcd->self.controller,
-			"shutdown urb %pK ep%d%s%s\n",
+			"shutdown urb %pK ep%d%s-%s\n",
 			urb, usb_endpoint_num(&ep->desc),
 			is_in ? "in" : "out",
-			({	char *s;
-
-				 switch (usb_endpoint_type(&ep->desc)) {
-				 case USB_ENDPOINT_XFER_CONTROL:
-					s = ""; break;
-				 case USB_ENDPOINT_XFER_BULK:
-					s = "-bulk"; break;
-				 case USB_ENDPOINT_XFER_INT:
-					s = "-intr"; break;
-				 default:
-					s = "-iso"; break;
-				};
-				s;
-			}));
+			usb_ep_type_string(usb_endpoint_type(&ep->desc)));
 		usb_put_urb (urb);
 
 		/* list contents may have changed */
diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index 1c792710348f..d9e2a63835fe 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -750,28 +750,13 @@ static int dwc3_transfer_type_show(struct seq_file *s, void *unused)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (!(dep->flags & DWC3_EP_ENABLED) ||
-			!dep->endpoint.desc) {
-		seq_printf(s, "--\n");
+	if (!(dep->flags & DWC3_EP_ENABLED) || !dep->endpoint.desc) {
+		seq_puts(s, "unknown\n");
 		goto out;
 	}
 
-	switch (usb_endpoint_type(dep->endpoint.desc)) {
-	case USB_ENDPOINT_XFER_CONTROL:
-		seq_printf(s, "control\n");
-		break;
-	case USB_ENDPOINT_XFER_ISOC:
-		seq_printf(s, "isochronous\n");
-		break;
-	case USB_ENDPOINT_XFER_BULK:
-		seq_printf(s, "bulk\n");
-		break;
-	case USB_ENDPOINT_XFER_INT:
-		seq_printf(s, "interrupt\n");
-		break;
-	default:
-		seq_printf(s, "--\n");
-	}
+	seq_printf(s, "%s\n",
+		   usb_ep_type_string(usb_endpoint_type(dep->endpoint.desc)));
 
 out:
 	spin_unlock_irqrestore(&dwc->lock, flags);
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 83340f4fdc6e..35941dc125f9 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -593,10 +593,6 @@ static int ast_vhub_epn_disable(struct usb_ep* u_ep)
 static int ast_vhub_epn_enable(struct usb_ep* u_ep,
 			       const struct usb_endpoint_descriptor *desc)
 {
-	static const char *ep_type_string[] __maybe_unused = { "ctrl",
-							       "isoc",
-							       "bulk",
-							       "intr" };
 	struct ast_vhub_ep *ep = to_ast_ep(u_ep);
 	struct ast_vhub_dev *dev;
 	struct ast_vhub *vhub;
@@ -646,7 +642,7 @@ static int ast_vhub_epn_enable(struct usb_ep* u_ep,
 	ep->epn.wedged = false;
 
 	EPDBG(ep, "Enabling [%s] %s num %d maxpacket=%d\n",
-	      ep->epn.is_in ? "in" : "out", ep_type_string[type],
+	      ep->epn.is_in ? "in" : "out", usb_ep_type_string(type),
 	      usb_endpoint_num(desc), maxpacket);
 
 	/* Can we use DMA descriptor mode ? */
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index baf72f95f0f1..40c6a484e232 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -617,21 +617,7 @@ static int dummy_enable(struct usb_ep *_ep,
 		_ep->name,
 		desc->bEndpointAddress & 0x0f,
 		(desc->bEndpointAddress & USB_DIR_IN) ? "in" : "out",
-		({ char *val;
-		 switch (usb_endpoint_type(desc)) {
-		 case USB_ENDPOINT_XFER_BULK:
-			 val = "bulk";
-			 break;
-		 case USB_ENDPOINT_XFER_ISOC:
-			 val = "iso";
-			 break;
-		 case USB_ENDPOINT_XFER_INT:
-			 val = "intr";
-			 break;
-		 default:
-			 val = "ctrl";
-			 break;
-		 } val; }),
+		usb_ep_type_string(usb_endpoint_type(desc)),
 		max, ep->stream_en ? "enabled" : "disabled");
 
 	/* at this point real hardware should be NAKing transfers
diff --git a/drivers/usb/host/xhci-trace.h b/drivers/usb/host/xhci-trace.h
index 88b427434bd8..bac73d688f11 100644
--- a/drivers/usb/host/xhci-trace.h
+++ b/drivers/usb/host/xhci-trace.h
@@ -289,23 +289,8 @@ DECLARE_EVENT_CLASS(xhci_log_urb,
 	),
 	TP_printk("ep%d%s-%s: urb %p pipe %u slot %d length %d/%d sgs %d/%d stream %d flags %08x",
 			__entry->epnum, __entry->dir_in ? "in" : "out",
-			({ char *s;
-			switch (__entry->type) {
-			case USB_ENDPOINT_XFER_INT:
-				s = "intr";
-				break;
-			case USB_ENDPOINT_XFER_CONTROL:
-				s = "control";
-				break;
-			case USB_ENDPOINT_XFER_BULK:
-				s = "bulk";
-				break;
-			case USB_ENDPOINT_XFER_ISOC:
-				s = "isoc";
-				break;
-			default:
-				s = "UNKNOWN";
-			} s; }), __entry->urb, __entry->pipe, __entry->slot_id,
+			usb_ep_type_string(__entry->type),
+			__entry->urb, __entry->pipe, __entry->slot_id,
 			__entry->actual, __entry->length, __entry->num_mapped_sgs,
 			__entry->num_sgs, __entry->stream, __entry->flags
 		)
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index 523aa088f6ab..da82606be605 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -36,6 +36,14 @@
 #include <linux/device.h>
 #include <uapi/linux/usb/ch9.h>
 
+/**
+ * usb_ep_type_string() - Returns human readable-name of the endpoint type.
+ * @ep_type: The endpoint type to return human-readable name for.  If it's not
+ *   any of the types: USB_ENDPOINT_XFER_{CONTROL, ISOC, BULK, INT},
+ *   usually got by usb_endpoint_type(), the string 'unknown' will be returned.
+ */
+extern const char *usb_ep_type_string(int ep_type);
+
 /**
  * usb_speed_string() - Returns human readable-name of the speed.
  * @speed: The speed to return human-readable name for.  If it's not
-- 
2.20.1


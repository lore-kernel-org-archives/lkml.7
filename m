Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8018C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C13821744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 08:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IeJbQg0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEIIsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 04:48:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34277 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfEIIsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:48:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190509084828euoutp017c533f2430b2e0149a919da8ad3ec556~c94Hn7bq03062930629euoutp019;
        Thu,  9 May 2019 08:48:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190509084828euoutp017c533f2430b2e0149a919da8ad3ec556~c94Hn7bq03062930629euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557391708;
        bh=8Iob6mvtL1S8ewGxreFizsraS0/+JCLQ9ltwPWqTkio=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=IeJbQg0dIMCBRixV1f5rIcJeBP0Jx+ollJvo1wf/qI9gcMm8hTU6Kz81BjGV3p628
         DOgkGviWdKe/d42s0kTkgb+qxaq0rRaQwPhIimw++JwtXn0WLUWMSs14I0z3AW08Ts
         tPhxeVzAsBLw6YT7ratKMB38ga3jHCZdwQ/Mnf14=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190509084828eucas1p1dcdce5a1e42908a116f6c830f9292f62~c94HQpen11689816898eucas1p1x;
        Thu,  9 May 2019 08:48:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0F.2C.04298.B59E3DC5; Thu,  9
        May 2019 09:48:27 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190509084827eucas1p294962744fe70745c50b69a5349b5de68~c94GcpBMs0394203942eucas1p2X;
        Thu,  9 May 2019 08:48:27 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-d7-5cd3e95b2e7d
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6E.12.04140.B59E3DC5; Thu,  9
        May 2019 09:48:27 +0100 (BST)
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PR800GPLB4IMG00@eusync3.samsung.com>;
        Thu, 09 May 2019 09:48:27 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mans Rullgard <mans@mansr.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v3] usb: core: verify devicetree nodes for USB devices
Date:   Thu, 09 May 2019 10:47:26 +0200
Message-id: <20190509084726.5405-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <yw1xpnotufti.fsf@mansr.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWy7djPc7rRLy/HGPQv07fYOGM9q0Xz4vVs
        FufPb2C3uLxrDpvFjPP7mCwWLWtltnh55Aejxdojd9ktfjyczmTx594dVgcuj1t36j02repk
        89g/dw27x5vTp9g9Nr7bweTRt2UVo8fnTXIB7FFcNimpOZllqUX6dglcGXPXzWQuOKNaseHo
        F5YGxn3yXYycHBICJhLzelazdTFycQgJrGCUOPZqJROE85lRYtOuLiaYqtX3PrNCJJYxSpx9
        0gPV8p9R4v+MC+wgVWwChhJdb7vYQGwRgQSJI5vfM4MUMQusY5J4d6AJqIiDQ1jATWLfHSWQ
        GhYBVYmezRPBNvAK2EgsWfmYHWKbvMTqDQeYQWxOAU2J70e3g22WENjAJnGwt4kVoshF4vCj
        mSwQtozE5cndLBBFzYwSD8+tZYdwehglLjfNYISospY4fPwiWDezAJ/EpG3TmUEukhDgleho
        E4Io8ZB48qMHbLOQQI3EhqU7GScwSixgZFjFKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kR
        GJun/x3/tIPx66WkQ4wCHIxKPLwZhy7FCLEmlhVX5h5ilOBgVhLhvT4RKMSbklhZlVqUH19U
        mpNafIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoFxqoGNgqj3ro/yfmdfzp7Aa/Zb
        K+gE33RGk9YV/n9Up88+c/nZtcK1/pu+161eULfYS2i30+IVzx/MW3jBQN3oe4z41PpXK9R2
        SB04v3dOUZlN4BV3tp/rvh9rD1Dljn76puH0krnqC8SWefrZe837IJDD1RxZvfDLirXXP/jH
        bX9p2xj54YXmBiWW4oxEQy3mouJEACA0lNXJAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsVy+t/xq7rRLy/HGGx6ym6xccZ6VovmxevZ
        LM6f38BucXnXHDaLGef3MVksWtbKbPHyyA9Gi7VH7rJb/Hg4ncniz707rA5cHrfu1HtsWtXJ
        5rF/7hp2jzenT7F7bHy3g8mjb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Muaum8lccEa1YsPR
        LywNjPvkuxg5OSQETCRW3/vM2sXIxSEksIRRouHZFBYIp5FJYsb2WewgVWwChhJdb7vYQGwR
        gQSJJW83s4MUMQusY5KYdXk/YxcjB4ewgJvEvjtKIDUsAqoSPZsnMoHYvAI2EktWPmaH2CYv
        sXrDAWYQm1NAU+L70e2sILaQgIbEz5a9TBMYeRYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P
        3cQIDLZtx35u2cHY9S74EKMAB6MSD2/GoUsxQqyJZcWVuYcYJTiYlUR4r08ECvGmJFZWpRbl
        xxeV5qQWH2KU5mBREuftEDgYIySQnliSmp2aWpBaBJNl4uCUamDkj1s9Y9vdimiPy5P+an9v
        lDpx3vZEa6nbe64w2UUn7ztExwXvZfPXe/Rx89tv1/8qv7I9xyh4OfZOjfDZsA19krMWrOjZ
        uVTgRL7Ol59Lbt3NY1xd2qp5fPXKKfv9om/Z3Sn7c0M0vHX+3WlXLf+Ws9p/CA4svS92apJY
        oEjceiPFFndJhdDtSizFGYmGWsxFxYkArqiYUzICAAA=
X-CMS-MailID: 20190509084827eucas1p294962744fe70745c50b69a5349b5de68
CMS-TYPE: 201P
X-CMS-RootMailID: 20190509084827eucas1p294962744fe70745c50b69a5349b5de68
References: <yw1xpnotufti.fsf@mansr.com>
        <CGME20190509084827eucas1p294962744fe70745c50b69a5349b5de68@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 69bec7259853 ("USB: core: let USB device know device node")
added support for attaching devicetree node for USB devices. The mentioned
commit however identifies the given USB device node only by the 'reg'
property in the host controller children nodes. The USB device node
however also has to have a 'compatible' property as described in
Documentation/devicetree/bindings/usb/usb-device.txt. Lack for the
'compatible' property check might result in assigning a devicetree node,
which is not intended to be the proper node for the given USB device.

This is important especially when USB host controller has child-nodes for
other purposes. For example, Exynos EHCI and OHCI drivers already define
child-nodes for each physical root hub port and assigns respective PHY
controller and parameters for them. Those binding predates support for
USB devicetree nodes.

Checking for the proper compatibility string allows to mitigate the
conflict between USB device devicetree nodes and the bindings for USB
controllers with child nodes. It also fixes the side-effect of the other
commits, like 01fdf179f4b0 ("usb: core: skip interfaces disabled in
devicetree"), which incorrectly disables some devices on Exynos based
boards.

Reported-by: Markus Reichl <m.reichl@fivetechno.de>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v3:
- replaced ad hoc checks by proper test for proper value of the
  compatible string in drivers/usb/core/of.c
v2: https://lkml.org/lkml/2019/5/8/321
v1: https://lkml.org/lkml/2019/5/7/715
---
 drivers/usb/core/hub.c |  3 +++
 drivers/usb/core/of.c  | 31 +++++++++++++++++++++++++++++++
 include/linux/usb/of.h |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 2f94568ba385..6f2438522d09 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -22,6 +22,7 @@
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/of.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/quirks.h>
 #include <linux/workqueue.h>
@@ -5023,6 +5024,8 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if (status < 0)
 			goto loop;
 
+		usb_of_validate_device_node(udev);
+
 		if (udev->quirks & USB_QUIRK_DELAY_INIT)
 			msleep(2000);
 
diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
index 651708d8c908..2b6f16753edc 100644
--- a/drivers/usb/core/of.c
+++ b/drivers/usb/core/of.c
@@ -30,6 +30,12 @@ struct device_node *usb_of_get_device_node(struct usb_device *hub, int port1)
 	for_each_child_of_node(hub->dev.of_node, node) {
 		if (of_property_read_u32(node, "reg", &reg))
 			continue;
+		/*
+		 * idVendor and idProduct are not yet known, so check only
+		 * a presence of the compatible property.
+		 */
+		if (!of_find_property(node, "compatible", NULL))
+			continue;
 
 		if (reg == port1)
 			return node;
@@ -39,6 +45,31 @@ struct device_node *usb_of_get_device_node(struct usb_device *hub, int port1)
 }
 EXPORT_SYMBOL_GPL(usb_of_get_device_node);
 
+/**
+ * usb_of_validate_device_node() - validate dt node of the probed USB device
+ * @udev: USB device
+ *
+ * Validate devicetree node for the USB device. Compatible string must match
+ * device's idVendor and idProduct, otherwise the of_node will be put and set
+ * to NULL.
+ */
+void usb_of_validate_device_node(struct usb_device *udev)
+{
+	char compatible[13];
+
+	if (!udev->dev.of_node)
+		return;
+
+	snprintf(compatible, sizeof(compatible), "usb%x,%x",
+		 le16_to_cpu(udev->descriptor.idVendor),
+		 le16_to_cpu(udev->descriptor.idProduct));
+
+	if (of_device_is_compatible(udev->dev.of_node, compatible) == 0) {
+		of_node_put(udev->dev.of_node);
+		udev->dev.of_node = NULL;
+	}
+}
+
 /**
  * usb_of_has_combined_node() - determine whether a device has a combined node
  * @udev: USB device
diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
index dba55ccb9b53..9969efda03ad 100644
--- a/include/linux/usb/of.h
+++ b/include/linux/usb/of.h
@@ -24,6 +24,7 @@ bool usb_of_has_combined_node(struct usb_device *udev);
 struct device_node *usb_of_get_interface_node(struct usb_device *udev,
 		u8 config, u8 ifnum);
 struct device *usb_of_get_companion_dev(struct device *dev);
+void usb_of_validate_device_node(struct usb_device *udev);
 #else
 static inline enum usb_dr_mode
 of_usb_get_dr_mode_by_phy(struct device_node *np, int arg0)
@@ -57,6 +58,7 @@ static inline struct device *usb_of_get_companion_dev(struct device *dev)
 {
 	return NULL;
 }
+static inline void usb_of_validate_device_node(struct usb_device *udev) { }
 #endif
 
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB_SUPPORT)
-- 
2.17.1


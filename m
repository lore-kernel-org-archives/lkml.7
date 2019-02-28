Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B553CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855F7214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbfB1Od6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:33:58 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:47880 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbfB1Od6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:33:58 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 3232015632; Thu, 28 Feb 2019 14:33:56 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] dt-bindings: usb: add non-removable device property
Date:   Thu, 28 Feb 2019 14:33:44 +0000
Message-Id: <20190228143344.16312-1-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a boolean property indicating that a device is hardwired to the
upstream port.  Although hubs can provide this information, they are not
always configured correctly.  An alternate means of indicating this for
built-in USB devices is thus useful.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
I have a situation where userspace would like to know which USB devices
are built-in, but the on-board hub doesn't have the right setting.
Also, the hub itself can't be indicated as fixed in any other way that
I'm aware of.

In a way, adding this property seems a bit silly since dt can only
sensibly be used for hardwired devices in the first place.  Thus the
mere presence of a dt node could be taken to indicate the same thing.
On the other hand, it's conceivable that someone might dynamically
generate a devicetree based on what happens to be connected on boot or
something.  For that reason, and explicit property seems safer.
---
 Documentation/devicetree/bindings/usb/usb-device.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
index 036be172b1ae..903d39b7e415 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.txt
+++ b/Documentation/devicetree/bindings/usb/usb-device.txt
@@ -26,6 +26,10 @@ Required properties for device nodes:
 - reg: the number of the USB hub port or the USB host-controller port to which
   this device is attached. The range is 1-255.
 
+Optional properties for device nodes:
+- non-removable: boolean, if present the device is hardwired to the
+  upstream port.
+
 
 Required properties for device nodes with interface nodes:
 - #address-cells: shall be 2
@@ -55,6 +59,10 @@ Required properties for combined nodes:
 - reg: the number of the USB hub port or the USB host-controller port to which
   this device is attached. The range is 1-255.
 
+Optional properties for combined nodes:
+- non-removable: boolean, if present the device is hardwired to the
+  upstream port.
+
 
 Required properties for hub nodes with device nodes:
 - #address-cells: shall be 1
-- 
2.20.1


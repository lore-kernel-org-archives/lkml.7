Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC7BC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3329C2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfB1Sps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:45:48 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:49124 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfB1Spr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:45:47 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 6030C15637; Thu, 28 Feb 2019 18:45:45 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: hub: use non-removable-ports DT property
Date:   Thu, 28 Feb 2019 18:45:40 +0000
Message-Id: <20190228184540.24570-2-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228184540.24570-1-mans@mansr.com>
References: <20190228184540.24570-1-mans@mansr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark any ports listed in the non-removable-ports DT property as
hardwired. This is useful for boards with built-in USB devices
that cannot be (or have not been) marked as fixed in hardware.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/usb/core/hub.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 3adff4da2ee1..44ac49a30be1 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1328,6 +1328,9 @@ static int hub_configure(struct usb_hub *hub,
 	unsigned unit_load;
 	unsigned full_load;
 	unsigned maxchild;
+	struct property *prop;
+	const __be32 *cur;
+	u32 val;
 
 	hub->buffer = kmalloc(sizeof(*hub->buffer), GFP_KERNEL);
 	if (!hub->buffer) {
@@ -1629,6 +1632,17 @@ static int hub_configure(struct usb_hub *hub,
 		}
 	}
 
+	of_property_for_each_u32(hub_dev->of_node, "non-removable-ports",
+				 prop, cur, val) {
+		if (val < 1 || val > hdev->maxchild) {
+			dev_warn(hub_dev, "port number %u out of range\n", val);
+			continue;
+		}
+
+		hub->ports[val - 1]->connect_type =
+			USB_PORT_CONNECT_TYPE_HARD_WIRED;
+	}
+
 	usb_hub_adjust_deviceremovable(hdev, hub->descriptor);
 
 	hub_activate(hub, HUB_INIT);
-- 
2.20.1


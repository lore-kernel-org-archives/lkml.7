Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D93C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE90321743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390157AbfHHPsL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:48:11 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:37049 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbfHHPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:48:11 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Aug 2019 11:48:11 EDT
IronPort-SDR: T1QHL6pa1qRd+ViMRHR+IxA7umAwd5ol9ie/wBL88UUWBlRiv6KVRgG0p9g9EGwXLwR3id6i6k
 O43qrhpQi03OGQ/DAUrZWr+bgJdej+2pizPyCtQS5jZlj870VufGAE52+0QDk2z5X8a1rWqpOv
 tMaCikK10f0E8b4+32G0z3IbJXiBB06kavbzqioa6HwwlLhTPLGDZDYyIl2ILJuZFVsLewbjj4
 K1N2Z58QnV5r2czi6rI9RmLBjBqaU2hmXOXizNdlTZw4MAbFiCG6/N3QAk63IUN4AvWmZYSWIN
 0lc=
X-IronPort-AV: E=Sophos;i="5.64,362,1559548800"; 
   d="scan'208";a="42094792"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 08 Aug 2019 07:41:04 -0800
IronPort-SDR: 4gd+k2LPXxqLSZ9JsdYDieMxAb36A2pTn0/o0OZlrH6sphtV7sxNzR8nwhKNTB/rnsmj2dAP7Q
 1vw117nOXAjyYW92g2c+lVKWPV+xRl9lS4zG7ld8NruFsfT/omPZc4RG4+WkEXGeZK0aoJmAvc
 LBdFXOLgupFClBAfKhHt8E4de1R2352dWDmKmXEtpdFFuzn512DhFBcYEt7xFSoYNCDWRfLSkg
 mwQ7S3GQrQGVieaR3o1s+A0pqinKhU9EOVyM4Gdy/nZtr0gYisAKBFJiqaYvgwGRkvo8iN+LY5
 KRU=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/resource.c: invalidate parent when freed resource has
 childs
Thread-Topic: [PATCH] kernel/resource.c: invalidate parent when freed resource
 has childs
Thread-Index: AQHVTf27k2ql41s2a0y+HEWXJQe+tQ==
Date:   Thu, 8 Aug 2019 15:40:59 +0000
Message-ID: <1565278859475.1962@mentor.com>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a resource is freed and has children, the childrens are
left without any hint that their parent is no more valid.
This caused at least one use-after-free in the xhci-hcd using
ext-caps driver when platform code released platform devices.

Fix this by setting child's parent to zero and warn.

Signed-off-by: Carsten Schmid <carsten_schmid@mentor.com>
---
Rationale:
When hunting for the root cause of a crash on a 4.14.86 kernel, i
have found the root cause and checked it being still present
upstream. Our case:
Having xhci-hcd and intel_xhci_usb_sw active we can see in
/proc/meminfo: (exceirpt)
  b3c00000-b3c0ffff : 0000:00:15.0
    b3c00000-b3c0ffff : xhci-hcd
      b3c08070-b3c0846f : intel_xhci_usb_sw
intel_xhci_usb_sw being a child of xhci-hcd.

Doing an unbind command
echo 0000:00:15.0 > /sys/bus/pci/drivers/xhci_hcd/unbind
leads to xhci-hcd being freed in __release_region.
The intel_xhci_usb_sw resource is accessed in platform code
in platform_device_del with
		for (i = 0; i < pdev->num_resources; i++) {
			struct resource *r = &pdev->resource[i];
			if (r->parent)
				release_resource(r);
		}
as the resource's parent has not been updated, the release_resource
uses the parent:
	p = &old->parent->child;
which is now invalid.
Fix this by marking the parent invalid in the child and give a warning
in dmesg.
---
 kernel/resource.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/resource.c b/kernel/resource.c
index 158f04ec1d4f..95340cb0b1c2 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1200,6 +1200,15 @@ void __release_region(struct resource *parent, resource_size_t start,
 			write_unlock(&resource_lock);
 			if (res->flags & IORESOURCE_MUXED)
 				wake_up(&muxed_resource_wait);
+
+			write_lock(&resource_lock);
+			if (res->child) {
+				printk(KERN_WARNING "__release_region: %s has child %s,"
+						"invalidating childs parent\n",
+						res->name, res->child->name);
+				res->child->parent = NULL;
+			}
+			write_unlock(&resource_lock);
 			free_resource(res);
 			return;
 		}
-- 
2.17.1

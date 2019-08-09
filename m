Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0B5C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A6F2086D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436528AbfHINun convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:50:43 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:33310 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406503AbfHINun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:50:43 -0400
IronPort-SDR: c7XBxt0w41laaEA18M61aI1hwu2HMMisTHs2woexRiDSJ0iPn8M294kN0RfZp9AZ5hoh1iwHvG
 79Vt8rxj5PidvY4ICsQizKJLBz32t8/lpenNz4ZoXoVm2PlhamSIWhfIkeyVYxSrs9GdNn8HA6
 aCJfdfDnAwQ8x5Y2NxEr1stKrbRxKzVBL/LhE/fAMMgylrYhckjkt0/DnPYh/0VJOubHTYnv8a
 Zr9AGW8t6rauyfoFZNO7GFro8ZEv6BwhL5U9e8ouvD4hgJgtN2UKDEciqQJDn9Cw9UlBAxgWRj
 8io=
X-IronPort-AV: E=Sophos;i="5.64,364,1559548800"; 
   d="scan'208";a="42128753"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 09 Aug 2019 05:50:30 -0800
IronPort-SDR: +/kcSjdizrCDDTWTsoaJ8omvSmgV5tCBzXiYGZ8iOfCyXZ+nMExm1sz9B7ZEb+tbYkPlcXUNSC
 KlO8rsrEtNRR1sTmI7OTozxL7BR0bFazNPYBjHzpWRbqaJtddCmlE8+A8XP3tLppA2XC2J1dQL
 aMwtlVc+CWpuOZ81lB3H2v4YUBmH0m1f0l/V/guBXQgqWoKHY+pIhYcjRqJn9cRE76icjv4Mm7
 vZXtoyxG4FbSFpslO4LFT/sorcynZp/rSZWNfI/YK83Mje1o3i9A1f78IjLZ1F7vXGY+DWO2bb
 84E=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Resend [PATCH] kernel/resource.c: invalidate parent when freed
 resource has childs
Thread-Topic: Resend [PATCH] kernel/resource.c: invalidate parent when freed
 resource has childs
Thread-Index: AQHVTrktoAw70LsxJE6oaOICoAXoow==
Date:   Fri, 9 Aug 2019 13:50:24 +0000
Message-ID: <1565358624103.3694@mentor.com>
References: <1565278859475.1962@mentor.com>
In-Reply-To: <1565278859475.1962@mentor.com>
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
Advised by Greg (thanks):
Try resending it with at least the people who get_maintainer.pl says has
touched that file last in it. [CS:done]

Also, Linus is the unofficial resource.c maintainer.  I think he has a
set of userspace testing scripts for changes somewhere, so you should
 cc: him too.  And might as well add me :) [CS:done]

 thanks,

 greg k-h
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
+                       write_lock(&resource_lock);
+                       if (res->child) {
+                               printk(KERN_WARNING "__release_region: %s has child %s,"
+                                               "invalidating childs parent\n",
+                                               res->name, res->child->name);
+                               res->child->parent = NULL;
+                       }
+                       write_unlock(&resource_lock);
                        free_resource(res);
                        return;
                }
--
2.17.1

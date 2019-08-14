Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E05C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B1D2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfHNOsn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:48:43 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:3215 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfHNOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:48:42 -0400
IronPort-SDR: Ob59t+9w4lRE1kWR5UzVGEd85CtqqVHAWPphIDI/ltJpNgfsJnthWDUYxbHvaEInT7gojXXZ/Q
 NtsvuNwrDdEMEhXw1fL1woklX3IZoeGyBiybeEZzIIHJV2AHzviw7E2Tt8ScGK2uYnB/oa7D4Y
 8RHZwi2795dn/YfQvbKS5mAzODZ6qF0tuzLf+PLkPPiLcs5UxhObzkv6s0e+wFgFBhqU3SSbeS
 XQIQKKv947myM5uD7lbp4jQZS8V9nabtZfRRSNBkHxuEc+hhQbJMKDw4+qcEt8nAg9hiG/Dw3B
 QVY=
X-IronPort-AV: E=Sophos;i="5.64,385,1559548800"; 
   d="scan'208";a="40450613"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 14 Aug 2019 06:48:30 -0800
IronPort-SDR: jMbxt+ASILuBqBmL8+IglLxg6Ajyl0a0rhfMqOHnnYTPuLghprJPi/pPceLenN6Mh+luI9XYdv
 6fEFabw8YQNR6aEarhIaQdpByZWBVtFK8SlSQ8E+LImhDGyOT3+BUKWr4QpS7B0uTl5Iv7+S8q
 /tH4J3QKulCM14bsFdlTLDU03WVD2By40ht0m414djYBrmeuQDOXaX2sWODcza0eneex4Py9Qd
 fahKV16LiZGJCkS+aCiPmFsYmHGAICGCGE6nhHkYCCJxRqe9ZOXOoEXgaxY2iN6HzdiXp7pZtI
 z0s=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>
CC:     "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: [PATCH v2] kernel/resource.c: invalidate parent when freed resource
 has childs
Thread-Topic: [PATCH v2] kernel/resource.c: invalidate parent when freed
 resource has childs
Thread-Index: AQHVUq5kcb5Ex7JpNUSktSjVjdFuew==
Date:   Wed, 14 Aug 2019 14:48:24 +0000
Message-ID: <1565794104204.54092@mentor.com>
References: <1565278859475.1962@mentor.com> <1565358624103.3694@mentor.com>
 <20190809223831.fk4uyrzscr366syr@master>,<CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
In-Reply-To: <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
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

In such case, warn and release all resources beyond.

Signed-off-by: Carsten Schmid <carsten_schmid@mentor.com>
---
v2:
- release everything below the released resource, not only
  one child; re-using __release_child_resources
  (Inspired by Linus Torvalds outline)
- warn only once
  (According to Linus Torvalds outline)
- Keep parent and child name in warning message
  (eases hunting for the involved parties)
---
 kernel/resource.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index c3cc6d85ec52..eb48d793aa74 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -239,7 +239,7 @@ static int __release_resource(struct resource *old, bool release_child)
 	return -EINVAL;
 }
 
-static void __release_child_resources(struct resource *r)
+static void __release_child_resources(struct resource *r, bool warn)
 {
 	struct resource *tmp, *p;
 	resource_size_t size;
@@ -252,9 +252,10 @@ static void __release_child_resources(struct resource *r)
 
 		tmp->parent = NULL;
 		tmp->sibling = NULL;
-		__release_child_resources(tmp);
+		__release_child_resources(tmp, warn);
 
-		printk(KERN_DEBUG "release child resource %pR\n", tmp);
+		if (warn)
+			printk(KERN_DEBUG "release child resource %pR\n", tmp);
 		/* need to restore size, and keep flags */
 		size = resource_size(tmp);
 		tmp->start = 0;
@@ -265,7 +266,7 @@ static void __release_child_resources(struct resource *r)
 void release_child_resources(struct resource *r)
 {
 	write_lock(&resource_lock);
-	__release_child_resources(r);
+	__release_child_resources(r, true);
 	write_unlock(&resource_lock);
 }
 
@@ -1172,7 +1173,20 @@ EXPORT_SYMBOL(__request_region);
  * @n: resource region size
  *
  * The described resource region must match a currently busy region.
+ * If the region has children they are released too.
  */
+static void check_children(struct resource *parent)
+{
+	if (parent->child) {
+		/* warn and release all children */
+		WARN_ONCE(1, "%s: %s has child %s, release all children\n",
+				__func__, parent->name, parent->child->name);
+		write_lock(&resource_lock);
+		__release_child_resources(parent, false);
+		write_unlock(&resource_lock);
+	}
+}
+
 void __release_region(struct resource *parent, resource_size_t start,
 		      resource_size_t n)
 {
@@ -1200,6 +1214,10 @@ void __release_region(struct resource *parent, resource_size_t start,
 			write_unlock(&resource_lock);
 			if (res->flags & IORESOURCE_MUXED)
 				wake_up(&muxed_resource_wait);
+
+			/* You should'nt release a resource that has children */
+			check_children(res);
+
 			free_resource(res);
 			return;
 		}
-- 
2.17.1


Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B47C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA4821D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407331AbfIYOIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:08:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:30650 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730549AbfIYOIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:08:17 -0400
X-UUID: 19718c1b18de4097918ef4cbc03071f4-20190925
X-UUID: 19718c1b18de4097918ef4cbc03071f4-20190925
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1720719353; Wed, 25 Sep 2019 22:08:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Sep 2019 22:08:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Sep 2019 22:08:08 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] mm: slub: print the offset of fault addresses
Date:   Wed, 25 Sep 2019 22:08:07 +0800
Message-ID: <20190925140807.20490-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the commit ad67b74d2469d9b8 ("printk: hash addresses printed with
%p"), it is a little bit harder to match the fault addresses printed by
check_bytes_and_report() or slab_pad_check() in the dump because the
fault addresses may not show up in the dump.

Print the offset of the fault addresses to make it easier to match the
incorrect poison or padding values in the dump.

Before:
We have to search the "63" in the dump. If we want to get the offset of
63, we have to count it from the start of Object dump.

=============================================================
BUG kmalloc-128 (Not tainted): Poison overwritten
-------------------------------------------------------------

Disabling lock debugging due to kernel taint
INFO: 0x00000000570da294-0x00000000570da294.
First byte 0x63 instead of 0x6b
...
INFO: Object 0x000000006ebb3b9e @offset=14208 fp=0x0000000065862488
Redzone 00000000a6abccff: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 00000000741c16f0: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 0000000061ad278f: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 000000000467c1bd: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 000000008812766b: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 000000003d9b8f25: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 0000000000d80c33: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 00000000867b0d90: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Object 000000006ebb3b9e: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 000000005ea59a9f: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 000000003ef8bddc: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 000000008190375d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 000000006df7fb32: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 0000000069474eae: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 0000000008073b7d: 6b 6b 6b 6b 63 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 00000000b45ae74d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5

After:
We know the fault address is at @offset=1508, and the Object is at
@offset=1408, so we know the fault address is at offset=100 within the
object.

=========================================================
BUG kmalloc-128 (Not tainted): Poison overwritten
---------------------------------------------------------

Disabling lock debugging due to kernel taint
INFO: 0x00000000638ec1d1-0x00000000638ec1d1 @offset=1508.
First byte 0x63 instead of 0x6b
...
INFO: Object 0x000000008171818d @offset=1408 fp=0x0000000066dae230
Redzone 00000000e2697ab6: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 0000000064b6a381: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 00000000e413a234: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 0000000004c1dfeb: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 000000009ad24d42: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 000000002a196a23: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 00000000a7b8468a: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Redzone 0000000088db6da3: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
Object 000000008171818d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 000000007c4035d4: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 000000004dd281a4: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 0000000079121dff: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 00000000756682a9: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 0000000053b7e541: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 0000000091f8d530: 6b 6b 6b 6b 63 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Object 000000009c76035c: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5

Change since v1:
1. do not replace DUMP_PREFIX_ADDRESS with DUMP_PREFIX_OFFSET because
the hash addresses are useful
2. print the offset of the fault address

Cc: Christoph Lameter <cl@linux.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 mm/slub.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 42c1b3af3c98..21d26cd3e3bc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -736,6 +736,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
 {
 	u8 *fault;
 	u8 *end;
+	u8 *addr = page_address(page);
 
 	metadata_access_enable();
 	fault = memchr_inv(start, value, bytes);
@@ -748,8 +749,9 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
 		end--;
 
 	slab_bug(s, "%s overwritten", what);
-	pr_err("INFO: 0x%p-0x%p. First byte 0x%x instead of 0x%x\n",
-					fault, end - 1, fault[0], value);
+	pr_err("INFO: 0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
+					fault, end - 1, fault - addr,
+					fault[0], value);
 	print_trailer(s, page, object);
 
 	restore_bytes(s, what, value, fault, end);
@@ -844,7 +846,8 @@ static int slab_pad_check(struct kmem_cache *s, struct page *page)
 	while (end > fault && end[-1] == POISON_INUSE)
 		end--;
 
-	slab_err(s, page, "Padding overwritten. 0x%p-0x%p", fault, end - 1);
+	slab_err(s, page, "Padding overwritten. 0x%p-0x%p @offset=%tu",
+			fault, end - 1, fault - start);
 	print_section(KERN_ERR, "Padding ", pad, remainder);
 
 	restore_bytes(s, "slab padding", POISON_INUSE, fault, end);
-- 
2.18.0


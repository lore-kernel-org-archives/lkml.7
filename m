Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77197C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDDE20896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfDNQCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:02:16 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43188 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDNQCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:02:15 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFha9-0002Y6-0B; Sun, 14 Apr 2019 18:02:13 +0200
Message-Id: <20190414160143.591255977@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 14 Apr 2019 17:59:37 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org
Subject: [patch V3 01/32] mm/slab: Fix broken stack trace storage
References: <20190414155936.679808307@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstack_end() is broken on interrupt stacks as they are not guaranteed to be
sized THREAD_SIZE and THREAD_SIZE aligned.

Use the stack tracer instead. Remove the pointless pointer increment at the
end of the function while at it.

Fixes: 98eb235b7feb ("[PATCH] page unmapping debug") - History tree
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
---
 mm/slab.c |   28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1470,33 +1470,29 @@ static bool is_debug_pagealloc_cache(str
 static void store_stackinfo(struct kmem_cache *cachep, unsigned long *addr,
 			    unsigned long caller)
 {
-	int size = cachep->object_size;
+	int size = cachep->object_size / sizeof(unsigned long);
 
 	addr = (unsigned long *)&((char *)addr)[obj_offset(cachep)];
 
-	if (size < 5 * sizeof(unsigned long))
+	if (size < 5)
 		return;
 
 	*addr++ = 0x12345678;
 	*addr++ = caller;
 	*addr++ = smp_processor_id();
-	size -= 3 * sizeof(unsigned long);
+#ifdef CONFIG_STACKTRACE
 	{
-		unsigned long *sptr = &caller;
-		unsigned long svalue;
-
-		while (!kstack_end(sptr)) {
-			svalue = *sptr++;
-			if (kernel_text_address(svalue)) {
-				*addr++ = svalue;
-				size -= sizeof(unsigned long);
-				if (size <= sizeof(unsigned long))
-					break;
-			}
-		}
+		struct stack_trace trace = {
+			.max_entries	= size - 4;
+			.entries	= addr;
+			.skip		= 3;
+		};
 
+		save_stack_trace(&trace);
+		addr += trace.nr_entries;
 	}
-	*addr++ = 0x87654321;
+#endif
+	*addr = 0x87654321;
 }
 
 static void slab_kernel_map(struct kmem_cache *cachep, void *objp,



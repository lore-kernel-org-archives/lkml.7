Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AADFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1562220833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfDOJDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:03:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44951 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOJDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:03:02 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFxVy-0002zp-IB; Mon, 15 Apr 2019 11:02:58 +0200
Date:   Mon, 15 Apr 2019 11:02:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: [patch V4 01/32] mm/slab: Fix broken stack trace storage
In-Reply-To: <alpine.DEB.2.21.1904141832400.4917@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1904151101100.1729@nanos.tec.linutronix.de>
References: <20190414155936.679808307@linutronix.de> <20190414160143.591255977@linutronix.de> <CALCETrUhVc_u3HL-x7wMnk9ukEbwQPvc9N5Na-Q55se0VwcCpw@mail.gmail.com> <alpine.DEB.2.21.1904141832400.4917@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
V4: Made the code simpler to understand (Andy) and make it actually compile
---
 mm/slab.c |   30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1470,33 +1470,31 @@ static bool is_debug_pagealloc_cache(str
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
+	size -= 3;
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
+			/* Leave one for the end marker below */
+			.max_entries	= size - 1,
+			.entries	= addr,
+			.skip		= 3,
+		};
 
+		save_stack_trace(&trace);
+		addr += trace.nr_entries;
 	}
-	*addr++ = 0x87654321;
+#endif
+	*addr = 0x87654321;
 }
 
 static void slab_kernel_map(struct kmem_cache *cachep, void *objp,

Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC546C28CBF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 17:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9235320815
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 17:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfEZRdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 13:33:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46270 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfEZRdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 13:33:38 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hUx1S-00024Z-LB; Sun, 26 May 2019 19:33:26 +0200
Date:   Sun, 26 May 2019 19:33:25 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hugh Dickins <hughd@google.com>, x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86/fpu: Use fault_in_pages_writeable() for pre-faulting
Message-ID: <20190526173325.lpt5qtg7c6rnbql5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hughd@google.com>

Since commit

   d9c9ce34ed5c8 ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")

we use get_user_pages_unlocked() to pre-faulting user's memory if a
write generates a page fault while the handler is disabled.
This works in general and uncovered a bug as reported by Mike Rapoport.

It has been pointed out that this function may be fragile and a
simple pre-fault as in fault_in_pages_writeable() would be a better
solution. Better as in taste and simplicity: That write (as performed by
the alternative function) performs exactly the same faulting of memory
that we had before. This was suggested by Hugh Dickins and Andrew
Morton.

Use fault_in_pages_writeable() for pre-faulting of user's stack.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Hugh Dickins <hughd@google.com>
Link: https://lkml.kernel.org/r/alpine.LSU.2.11.1905251033230.1112@eggly.anvils
[bigeasy: patch description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 5a8d118bc423e..060d6188b4533 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -5,6 +5,7 @@
 
 #include <linux/compat.h>
 #include <linux/cpu.h>
+#include <linux/pagemap.h>
 
 #include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
@@ -189,15 +190,7 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 	fpregs_unlock();
 
 	if (ret) {
-		int aligned_size;
-		int nr_pages;
-
-		aligned_size = offset_in_page(buf_fx) + fpu_user_xstate_size;
-		nr_pages = DIV_ROUND_UP(aligned_size, PAGE_SIZE);
-
-		ret = get_user_pages_unlocked((unsigned long)buf_fx, nr_pages,
-					      NULL, FOLL_WRITE);
-		if (ret == nr_pages)
+		if (!fault_in_pages_writeable(buf_fx, fpu_user_xstate_size))
 			goto retry;
 		return -EFAULT;
 	}
-- 
2.20.1


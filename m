Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33A9C432C3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 20:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D112082E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 20:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfLAUEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 15:04:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51313 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfLAUEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 15:04:36 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ibVRv-00024M-RZ; Sun, 01 Dec 2019 21:04:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 04A071C1FFA;
        Sun,  1 Dec 2019 21:04:04 +0100 (CET)
Date:   Sun, 01 Dec 2019 20:04:03 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/pat: Fix off-by-one bugs in interval tree search
Cc:     kernel test robot <rong.a.chen@intel.com>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Mariusz Ceier <mceier+kernel@gmail.com>,
        Mariusz Ceier <mceier@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191201144947.GA4167@gmail.com>
References: <20191201144947.GA4167@gmail.com>
MIME-Version: 1.0
Message-ID: <157523064382.21853.5318954116634654015.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     91298f1a302dad0f0f630413c812818636faa8a0
Gitweb:        https://git.kernel.org/tip/91298f1a302dad0f0f630413c812818636faa8a0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 01 Dec 2019 15:49:47 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 01 Dec 2019 20:57:25 +01:00

x86/mm/pat: Fix off-by-one bugs in interval tree search

There's a bug in the new PAT code, the conversion of memtype_check_conflict()
is buggy:

   8d04a5f97a5f: ("x86/mm/pat: Convert the PAT tree to a generic interval tree")

        dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
        found_type = match->type;

-       node = rb_next(&match->rb);
-       while (node) {
-               match = rb_entry(node, struct memtype, rb);
-
-               if (match->start >= end) /* Checked all possible matches */
-                       goto success;
-
-               if (is_node_overlap(match, start, end) &&
-                   match->type != found_type) {
+       match = memtype_interval_iter_next(match, start, end);
+       while (match) {
+               if (match->type != found_type)
                        goto failure;
-               }

-               node = rb_next(&match->rb);
+               match = memtype_interval_iter_next(match, start, end);
        }

Note how the '>= end' condition to end the interval check, got converted
into:

+       match = memtype_interval_iter_next(match, start, end);

This is subtly off by one, because the interval trees interfaces require
closed interval parameters:

  include/linux/interval_tree_generic.h

 /*                                                                            \
  * Iterate over intervals intersecting [start;last]                           \
  *                                                                            \
  * Note that a node's interval intersects [start;last] iff:                   \
  *   Cond1: ITSTART(node) <= last                                             \
  * and                                                                        \
  *   Cond2: start <= ITLAST(node)                                             \
  */                                                                           \

  ...

                if (ITSTART(node) <= last) {            /* Cond1 */           \
                        if (start <= ITLAST(node))      /* Cond2 */           \
                                return node;    /* node is leftmost match */  \

[start;last] is a closed interval (note that '<= last' check) - while the
PAT 'end' parameter is 1 byte beyond the end of the range, because
ioremap() and the other mapping APIs usually use the [start,end)
half-open interval, derived from 'size'.

This is what ioremap() does for example:

        /*
         * Mappings have to be page-aligned
         */
        offset = phys_addr & ~PAGE_MASK;
        phys_addr &= PHYSICAL_PAGE_MASK;
        size = PAGE_ALIGN(last_addr+1) - phys_addr;

        retval = reserve_memtype(phys_addr, (u64)phys_addr + size,
                                                pcm, &new_pcm);

phys_addr+size will be on a page boundary, after the last byte of the
mapped interval.

So the correct parameter to use in the interval tree searches is not
'end' but 'end-1'.

This could have relevance if conflicting PAT ranges are exactly adjacent,
for example a future WC region is followed immediately by an already
mapped UC- region - in this case memtype_check_conflict() would
incorrectly deny the WC memtype region and downgrade the memtype to UC-.

BTW., rather annoyingly this downgrading is done silently in
memtype_check_insert():

int memtype_check_insert(struct memtype *new,
                         enum page_cache_mode *ret_type)
{
        int err = 0;

        err = memtype_check_conflict(new->start, new->end, new->type, ret_type);
        if (err)
                return err;

        if (ret_type)
                new->type = *ret_type;

        memtype_interval_insert(new, &memtype_rbroot);
        return 0;
}

So on such a conflict we'd just silently get UC- in *ret_type, and write
it into the new region, never the wiser ...

So assuming that the patch below fixes the primary bug the diagnostics
side of ioremap() cache attribute downgrades would be another thing to
fix.

Anyway, I checked all the interval-tree iterations, and most of them are
off by one - but I think the one related to memtype_check_conflict() is
the one causing this particular performance regression.

The only correct interval-tree searches were these two:

  arch/x86/mm/pat_interval.c:     match = memtype_interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
  arch/x86/mm/pat_interval.c:             match = memtype_interval_iter_next(match, 0, ULONG_MAX);

The ULONG_MAX was hiding the off-by-one in plain sight. :-)

Note that the bug was probably benign in the sense of implementing a too
strict cache attribute conflict policy and downgrading cache attributes,
so AFAICS the worst outcome of this bug would be a performance regression,
not any instabilities.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Reported-by: Kenneth R. Crudup <kenny@panix.com>
Reported-by: Mariusz Ceier <mceier+kernel@gmail.com>
Tested-by: Mariusz Ceier <mceier@gmail.com>
Tested-by: Kenneth R. Crudup <kenny@panix.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191201144947.GA4167@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat_interval.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat_interval.c b/arch/x86/mm/pat_interval.c
index 47a1bf3..6855362 100644
--- a/arch/x86/mm/pat_interval.c
+++ b/arch/x86/mm/pat_interval.c
@@ -56,7 +56,7 @@ static struct memtype *memtype_match(u64 start, u64 end, int match_type)
 {
 	struct memtype *match;
 
-	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
+	match = memtype_interval_iter_first(&memtype_rbroot, start, end-1);
 	while (match != NULL && match->start < end) {
 		if ((match_type == MEMTYPE_EXACT_MATCH) &&
 		    (match->start == start) && (match->end == end))
@@ -66,7 +66,7 @@ static struct memtype *memtype_match(u64 start, u64 end, int match_type)
 		    (match->start < start) && (match->end == end))
 			return match;
 
-		match = memtype_interval_iter_next(match, start, end);
+		match = memtype_interval_iter_next(match, start, end-1);
 	}
 
 	return NULL; /* Returns NULL if there is no match */
@@ -79,7 +79,7 @@ static int memtype_check_conflict(u64 start, u64 end,
 	struct memtype *match;
 	enum page_cache_mode found_type = reqtype;
 
-	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
+	match = memtype_interval_iter_first(&memtype_rbroot, start, end-1);
 	if (match == NULL)
 		goto success;
 
@@ -89,12 +89,12 @@ static int memtype_check_conflict(u64 start, u64 end,
 	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
 	found_type = match->type;
 
-	match = memtype_interval_iter_next(match, start, end);
+	match = memtype_interval_iter_next(match, start, end-1);
 	while (match) {
 		if (match->type != found_type)
 			goto failure;
 
-		match = memtype_interval_iter_next(match, start, end);
+		match = memtype_interval_iter_next(match, start, end-1);
 	}
 success:
 	if (newtype)
@@ -160,7 +160,7 @@ struct memtype *memtype_erase(u64 start, u64 end)
 struct memtype *memtype_lookup(u64 addr)
 {
 	return memtype_interval_iter_first(&memtype_rbroot, addr,
-					   addr + PAGE_SIZE);
+					   addr + PAGE_SIZE-1);
 }
 
 #if defined(CONFIG_DEBUG_FS)

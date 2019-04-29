Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8351AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAD0215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="V7qOcJZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfD2Ssv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:48:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47189 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfD2Sst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:48:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIl7l71031309
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:47:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIl7l71031309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563629;
        bh=NqQZCZDmZyz46kfVTYaSbxf42G2RgnTuY765DSfM7Ao=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=V7qOcJZpHhqS7GynwnDxeVYW95jzG0FkPAHZrjVU/KgdyvmtX+9r/m/3E+Trm+RGU
         p2KU+nMypRKM8DqvLxTPkpuvvb9hgbgI/J/oGHIxxh5Tj1n7lZW7MkbueIefENOFJT
         DOrKK+5h67EGwjJ0UJIPo3Enqopp2FMq/hNbBr/nyTydW+K6e0cFCIknyV3ipE7NKN
         BPEm54oPFkwi+pSSPzQ0KZUzURwu8wwb+UfzZmHIbzs8olCNGyUeZTntyI49rh2fSH
         MZCjTPbJGVcxbd7B+p1gzBn2ZROSfBgVz9lWFEMervQ5+s9hGI+jT04zziiPmn8MIR
         eXCERzJzwVhRw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIl66D1031295;
        Mon, 29 Apr 2019 11:47:06 -0700
Date:   Mon, 29 Apr 2019 11:47:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-9f50c91b1195dfffd183d5d8505e45af86623532@git.kernel.org>
Cc:     rostedt@goodmis.org, mingo@kernel.org, penberg@kernel.org,
        hpa@zytor.com, snitzer@redhat.com, airlied@linux.ie, clm@fb.com,
        adobriyan@gmail.com, luto@kernel.org, josef@toxicpanda.com,
        tglx@linutronix.de, rppt@linux.vnet.ibm.com,
        maarten.lankhorst@linux.intel.com, jpoimboe@redhat.com,
        tom.zanussi@linux.intel.com, joonas.lahtinen@linux.intel.com,
        hch@lst.de, aryabinin@virtuozzo.com, akinobu.mita@gmail.com,
        catalin.marinas@arm.com, dsterba@suse.com, daniel@ffwll.ch,
        rientjes@google.com, m.szyprowski@samsung.com, cl@linux.com,
        glider@google.com, jani.nikula@linux.intel.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        rodrigo.vivi@intel.com, dvyukov@google.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jthumshirn@suse.de, agk@redhat.com
Reply-To: jthumshirn@suse.de, agk@redhat.com, rodrigo.vivi@intel.com,
          dvyukov@google.com, mbenes@suse.cz, akpm@linux-foundation.org,
          cl@linux.com, glider@google.com, linux-kernel@vger.kernel.org,
          jani.nikula@linux.intel.com, robin.murphy@arm.com,
          joonas.lahtinen@linux.intel.com, hch@lst.de,
          aryabinin@virtuozzo.com, akinobu.mita@gmail.com,
          catalin.marinas@arm.com, dsterba@suse.com, rientjes@google.com,
          daniel@ffwll.ch, m.szyprowski@samsung.com, tglx@linutronix.de,
          jpoimboe@redhat.com, rppt@linux.vnet.ibm.com,
          maarten.lankhorst@linux.intel.com, tom.zanussi@linux.intel.com,
          luto@kernel.org, josef@toxicpanda.com, clm@fb.com,
          airlied@linux.ie, adobriyan@gmail.com, rostedt@goodmis.org,
          mingo@kernel.org, penberg@kernel.org, hpa@zytor.com,
          snitzer@redhat.com
In-Reply-To: <20190425094803.340000461@linutronix.de>
References: <20190425094803.340000461@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] tracing: Remove the last struct stack_trace
 usage
Git-Commit-ID: 9f50c91b1195dfffd183d5d8505e45af86623532
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9f50c91b1195dfffd183d5d8505e45af86623532
Gitweb:     https://git.kernel.org/tip/9f50c91b1195dfffd183d5d8505e45af86623532
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:17 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:56 +0200

tracing: Remove the last struct stack_trace usage

Simplify the stack retrieval code by using the storage array based
interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: kasan-dev@googlegroups.com
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: linux-arch@vger.kernel.org
Link: https://lkml.kernel.org/r/20190425094803.340000461@linutronix.de

---
 kernel/trace/trace_stack.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 4efda5f75a0f..5d16f73898db 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -23,11 +23,7 @@
 static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES];
 static unsigned stack_trace_index[STACK_TRACE_ENTRIES];
 
-struct stack_trace stack_trace_max = {
-	.max_entries		= STACK_TRACE_ENTRIES,
-	.entries		= &stack_dump_trace[0],
-};
-
+static unsigned int stack_trace_nr_entries;
 static unsigned long stack_trace_max_size;
 static arch_spinlock_t stack_trace_max_lock =
 	(arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
@@ -44,10 +40,10 @@ static void print_max_stack(void)
 
 	pr_emerg("        Depth    Size   Location    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   stack_trace_max.nr_entries);
+			   stack_trace_nr_entries);
 
-	for (i = 0; i < stack_trace_max.nr_entries; i++) {
-		if (i + 1 == stack_trace_max.nr_entries)
+	for (i = 0; i < stack_trace_nr_entries; i++) {
+		if (i + 1 == stack_trace_nr_entries)
 			size = stack_trace_index[i];
 		else
 			size = stack_trace_index[i] - stack_trace_index[i+1];
@@ -93,13 +89,12 @@ static void check_stack(unsigned long ip, unsigned long *stack)
 
 	stack_trace_max_size = this_size;
 
-	stack_trace_max.nr_entries = 0;
-	stack_trace_max.skip = 0;
-
-	save_stack_trace(&stack_trace_max);
+	stack_trace_nr_entries = stack_trace_save(stack_dump_trace,
+					       ARRAY_SIZE(stack_dump_trace) - 1,
+					       0);
 
 	/* Skip over the overhead of the stack tracer itself */
-	for (i = 0; i < stack_trace_max.nr_entries; i++) {
+	for (i = 0; i < stack_trace_nr_entries; i++) {
 		if (stack_dump_trace[i] == ip)
 			break;
 	}
@@ -108,7 +103,7 @@ static void check_stack(unsigned long ip, unsigned long *stack)
 	 * Some archs may not have the passed in ip in the dump.
 	 * If that happens, we need to show everything.
 	 */
-	if (i == stack_trace_max.nr_entries)
+	if (i == stack_trace_nr_entries)
 		i = 0;
 
 	/*
@@ -126,13 +121,13 @@ static void check_stack(unsigned long ip, unsigned long *stack)
 	 * loop will only happen once. This code only takes place
 	 * on a new max, so it is far from a fast path.
 	 */
-	while (i < stack_trace_max.nr_entries) {
+	while (i < stack_trace_nr_entries) {
 		int found = 0;
 
 		stack_trace_index[x] = this_size;
 		p = start;
 
-		for (; p < top && i < stack_trace_max.nr_entries; p++) {
+		for (; p < top && i < stack_trace_nr_entries; p++) {
 			/*
 			 * The READ_ONCE_NOCHECK is used to let KASAN know that
 			 * this is not a stack-out-of-bounds error.
@@ -163,7 +158,7 @@ static void check_stack(unsigned long ip, unsigned long *stack)
 			i++;
 	}
 
-	stack_trace_max.nr_entries = x;
+	stack_trace_nr_entries = x;
 
 	if (task_stack_end_corrupted(current)) {
 		print_max_stack();
@@ -265,7 +260,7 @@ __next(struct seq_file *m, loff_t *pos)
 {
 	long n = *pos - 1;
 
-	if (n >= stack_trace_max.nr_entries)
+	if (n >= stack_trace_nr_entries)
 		return NULL;
 
 	m->private = (void *)n;
@@ -329,7 +324,7 @@ static int t_show(struct seq_file *m, void *v)
 		seq_printf(m, "        Depth    Size   Location"
 			   "    (%d entries)\n"
 			   "        -----    ----   --------\n",
-			   stack_trace_max.nr_entries);
+			   stack_trace_nr_entries);
 
 		if (!stack_tracer_enabled && !stack_trace_max_size)
 			print_disabled(m);
@@ -339,10 +334,10 @@ static int t_show(struct seq_file *m, void *v)
 
 	i = *(long *)v;
 
-	if (i >= stack_trace_max.nr_entries)
+	if (i >= stack_trace_nr_entries)
 		return 0;
 
-	if (i + 1 == stack_trace_max.nr_entries)
+	if (i + 1 == stack_trace_nr_entries)
 		size = stack_trace_index[i];
 	else
 		size = stack_trace_index[i] - stack_trace_index[i+1];

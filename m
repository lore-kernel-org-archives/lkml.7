Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6B4C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267E22146E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfEZTPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfEZTPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:15:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FBDF2075E;
        Sun, 26 May 2019 19:15:50 +0000 (UTC)
Date:   Sun, 26 May 2019 15:15:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [GIT PULL] tracing: Silence GCC 9 array bounds warning
Message-ID: <20190526151548.2d7bc6bc@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Make the GCC 9 warning for sub struct memset go away.

GCC 9 now warns about calling memset() on partial structures when it
goes across multiple fields. This adds a helper for the place in
tracing that does this type of clearing of a structure.


Please pull the latest trace-v5.2-rc1-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.2-rc1-2

Tag SHA1: 5fa176f243ceb9deaec360cc3f88062e466498b8
Head SHA1: 0c97bf863efce63d6ab7971dad811601e6171d2f


Miguel Ojeda (1):
      tracing: Silence GCC 9 array bounds warning

----
 kernel/trace/trace.c     |  6 +-----
 kernel/trace/trace.h     | 18 ++++++++++++++++++
 kernel/trace/trace_kdb.c |  6 +-----
 3 files changed, 20 insertions(+), 10 deletions(-)
---------------------------
commit 0c97bf863efce63d6ab7971dad811601e6171d2f
Author: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu May 23 14:45:35 2019 +0200

    tracing: Silence GCC 9 array bounds warning
    
    Starting with GCC 9, -Warray-bounds detects cases when memset is called
    starting on a member of a struct but the size to be cleared ends up
    writing over further members.
    
    Such a call happens in the trace code to clear, at once, all members
    after and including `seq` on struct trace_iterator:
    
        In function 'memset',
            inlined from 'ftrace_dump' at kernel/trace/trace.c:8914:3:
        ./include/linux/string.h:344:9: warning: '__builtin_memset' offset
        [8505, 8560] from the object at 'iter' is out of the bounds of
        referenced subobject 'seq' with type 'struct trace_seq' at offset
        4368 [-Warray-bounds]
          344 |  return __builtin_memset(p, c, size);
              |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    In order to avoid GCC complaining about it, we compute the address
    ourselves by adding the offsetof distance instead of referring
    directly to the member.
    
    Since there are two places doing this clear (trace.c and trace_kdb.c),
    take the chance to move the workaround into a single place in
    the internal header.
    
    Link: http://lkml.kernel.org/r/20190523124535.GA12931@gmail.com
    
    Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
    [ Removed unnecessary parenthesis around "iter" ]
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2c92b3d9ea30..1c80521fd436 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8910,12 +8910,8 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 
 		cnt++;
 
-		/* reset all but tr, trace, and overruns */
-		memset(&iter.seq, 0,
-		       sizeof(struct trace_iterator) -
-		       offsetof(struct trace_iterator, seq));
+		trace_iterator_reset(&iter);
 		iter.iter_flags |= TRACE_FILE_LAT_FMT;
-		iter.pos = -1;
 
 		if (trace_find_next_entry_inc(&iter) != NULL) {
 			int ret;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 82c70b63d375..005f08629b8b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1966,4 +1966,22 @@ static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
 
 extern struct trace_iterator *tracepoint_print_iter;
 
+/*
+ * Reset the state of the trace_iterator so that it can read consumed data.
+ * Normally, the trace_iterator is used for reading the data when it is not
+ * consumed, and must retain state.
+ */
+static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
+{
+	const size_t offset = offsetof(struct trace_iterator, seq);
+
+	/*
+	 * Keep gcc from complaining about overwriting more than just one
+	 * member in the structure.
+	 */
+	memset((char *)iter + offset, 0, sizeof(struct trace_iterator) - offset);
+
+	iter->pos = -1;
+}
+
 #endif /* _LINUX_KERNEL_TRACE_H */
diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 6c1ae6b752d1..cca65044c14c 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -37,12 +37,8 @@ static void ftrace_dump_buf(int skip_entries, long cpu_file)
 	if (skip_entries)
 		kdb_printf("(skipping %d entries)\n", skip_entries);
 
-	/* reset all but tr, trace, and overruns */
-	memset(&iter.seq, 0,
-		   sizeof(struct trace_iterator) -
-		   offsetof(struct trace_iterator, seq));
+	trace_iterator_reset(&iter);
 	iter.iter_flags |= TRACE_FILE_LAT_FMT;
-	iter.pos = -1;
 
 	if (cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {

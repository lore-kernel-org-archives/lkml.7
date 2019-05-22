Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBF6C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF3E20821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eepgEolk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfEVJ61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:58:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38354 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfEVJ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:58:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so1559691wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3kfhe+C5MUHt6X5mCM+Dlz0/pZVO77tnwk01LDkUJwI=;
        b=eepgEolkpBAsdhuDCiFIXdUlqhCg4rRJ19or5wxnHr181zC0h3kfWE4MDlCk4igOk8
         ogY4TIEByedt10k+bIx+/Sq0ziV+OCBxwVC+pU7n22x65upqN7ot8H2e0732+uy8osY/
         rsse1NIQ2GMdf39YotIm+b2D7x4pOHLRKDdyEz0St2H3UaXFJyisPPYm0L3rGWUab9OR
         egCbW5FtAp7nvuvNQHxL1fWLon85eOxNH3rK5gfiETt2E55G/czHN3uLH20d4WMktVO6
         XCHoavNoOAsh6w0vpg2jAuXbtnR3amKBkJJYokAvfxlpS8HNTYqfu0q+7XsX/eb9Kmy8
         TClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3kfhe+C5MUHt6X5mCM+Dlz0/pZVO77tnwk01LDkUJwI=;
        b=TK2VFecu57+eiL9XzjCSf0F5WVuLpndTV/70IbBORSqDAgalM7K4SG6jvffSXdGLIE
         RtqaGQWKni1btwVauWrce/C2xeo5qXUHx/KvaNcU0taeZG48HeWah7LZnxpwegKbKGd2
         DA/B3m+k+rquR3OT7x1nxOAv6mJ88LGvRuzx7P3AJFOqeEbxfVUISbW78jpd7zN8nRsF
         iauHSyPFgFaAw5JQpFCT2o48S9DV94zyjdM6hnZBJONyX9EyG8rzv6PZko/tC6t/nSMy
         dKnmm8ogQS+tM5WZQp47ahYWkH/i/Sk1WyJjqSsrVojhAMNUI/pnuWb3oQnu9CZxVVLd
         t2Nw==
X-Gm-Message-State: APjAAAUM9Es/ydpTvdKkYRLwBpuSx+UQdR74ie5sIJJZM7NXtcFpApSF
        fX6IOMAZcIhQEbkiWbGw29Q4GF/W
X-Google-Smtp-Source: APXvYqxJnFa/97VgErvjnVhLSPSEdqaXOinYYwWOp5xfTqerKU/79CGHZMCzLjEsX9aXIl8a9bcBXw==
X-Received: by 2002:a5d:4ec6:: with SMTP id s6mr46648586wrv.184.1558519105239;
        Wed, 22 May 2019 02:58:25 -0700 (PDT)
Received: from gmail.com (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id n2sm2327078wro.13.2019.05.22.02.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 02:58:24 -0700 (PDT)
Date:   Wed, 22 May 2019 11:58:10 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: silence GCC 9 array bounds warning
Message-ID: <20190522095810.GA16110@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
Steven, let me know if you still prefer (char *) or anything else
(or just change it in your side if you want :-)

 kernel/trace/trace.c     |  6 +-----
 kernel/trace/trace.h     | 14 ++++++++++++++
 kernel/trace/trace_kdb.c |  6 +-----
 3 files changed, 16 insertions(+), 10 deletions(-)

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
index 1974ce818ddb..f9a12003f137 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1967,4 +1967,18 @@ static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
 
 extern struct trace_iterator *tracepoint_print_iter;
 
+/* reset all but tr, trace, and overruns */
+static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
+{
+	/*
+	 * We do not simplify the start address to &iter->seq in order to let
+	 * GCC 9 know that we really want to overwrite more members than
+	 * just iter->seq (-Warray-bounds).
+	 */
+	const size_t offset = offsetof(struct trace_iterator, seq);
+	memset((char *)(iter) + offset, 0, sizeof(struct trace_iterator) - offset);
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
-- 
2.17.1


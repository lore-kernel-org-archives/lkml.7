Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07EEC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8125D2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbfFYTPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731085AbfFYTPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:15:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29833208CA;
        Tue, 25 Jun 2019 19:15:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hfquv-0002IA-1m; Tue, 25 Jun 2019 15:15:45 -0400
Message-Id: <20190625191544.944310129@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 15:15:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 01/12] ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS
References: <20190625191510.599310671@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Commit c19fa94a8fed ("Add HAVE_64BIT_ALIGNED_ACCESS") added the config for
architectures that required 64bit aligned access for all 64bit words. As
the ftrace ring buffer stores data on 4 byte alignment, this config option
was used to force it to store data on 8 byte alignment to make sure the data
being stored and written directly into the ring buffer was 8 byte aligned as
it would cause issues trying to write an 8 byte word on a 4 not 8 byte
aligned memory location.

But with the removal of the metag architecture, which was the only
architecture to use this, there is no architecture supported by Linux that
requires 8 byte aligne access for all 8 byte words (4 byte alignment is good
enough). Removing this config can simplify the code a bit.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/Kconfig               | 16 ----------------
 kernel/trace/ring_buffer.c | 17 ++++-------------
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c47b328eada0..665a7557b15c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -128,22 +128,6 @@ config UPROBES
 	    managed by the kernel and kept transparent to the probed
 	    application. )
 
-config HAVE_64BIT_ALIGNED_ACCESS
-	def_bool 64BIT && !HAVE_EFFICIENT_UNALIGNED_ACCESS
-	help
-	  Some architectures require 64 bit accesses to be 64 bit
-	  aligned, which also requires structs containing 64 bit values
-	  to be 64 bit aligned too. This includes some 32 bit
-	  architectures which can do 64 bit accesses, as well as 64 bit
-	  architectures without unaligned access.
-
-	  This symbol should be selected by an architecture if 64 bit
-	  accesses are required to be 64 bit aligned in this way even
-	  though it is not a 64 bit architecture.
-
-	  See Documentation/unaligned-memory-access.txt for more
-	  information on the topic of unaligned memory accesses.
-
 config HAVE_EFFICIENT_UNALIGNED_ACCESS
 	bool
 	help
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 05b0b3139ebc..66358d66c933 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -128,16 +128,7 @@ int ring_buffer_print_entry_header(struct trace_seq *s)
 #define RB_ALIGNMENT		4U
 #define RB_MAX_SMALL_DATA	(RB_ALIGNMENT * RINGBUF_TYPE_DATA_TYPE_LEN_MAX)
 #define RB_EVNT_MIN_SIZE	8U	/* two 32bit words */
-
-#ifndef CONFIG_HAVE_64BIT_ALIGNED_ACCESS
-# define RB_FORCE_8BYTE_ALIGNMENT	0
-# define RB_ARCH_ALIGNMENT		RB_ALIGNMENT
-#else
-# define RB_FORCE_8BYTE_ALIGNMENT	1
-# define RB_ARCH_ALIGNMENT		8U
-#endif
-
-#define RB_ALIGN_DATA		__aligned(RB_ARCH_ALIGNMENT)
+#define RB_ALIGN_DATA		__aligned(RB_ALIGNMENT)
 
 /* define RINGBUF_TYPE_DATA for 'case RINGBUF_TYPE_DATA:' */
 #define RINGBUF_TYPE_DATA 0 ... RINGBUF_TYPE_DATA_TYPE_LEN_MAX
@@ -2373,7 +2364,7 @@ rb_update_event(struct ring_buffer_per_cpu *cpu_buffer,
 
 	event->time_delta = delta;
 	length -= RB_EVNT_HDR_SIZE;
-	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT) {
+	if (length > RB_MAX_SMALL_DATA) {
 		event->type_len = 0;
 		event->array[0] = length;
 	} else
@@ -2388,11 +2379,11 @@ static unsigned rb_calculate_event_length(unsigned length)
 	if (!length)
 		length++;
 
-	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT)
+	if (length > RB_MAX_SMALL_DATA)
 		length += sizeof(event.array[0]);
 
 	length += RB_EVNT_HDR_SIZE;
-	length = ALIGN(length, RB_ARCH_ALIGNMENT);
+	length = ALIGN(length, RB_ALIGNMENT);
 
 	/*
 	 * In case the time delta is larger than the 27 bits for it
-- 
2.20.1



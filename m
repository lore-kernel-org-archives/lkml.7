Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A677C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48F9216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389563AbfHGW1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:27:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51831 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfHGW1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:27:37 -0400
Received: from [5.158.153.52] (helo=g2noscherz.tec.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hvUOs-0007mg-0e; Thu, 08 Aug 2019 00:27:20 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [RFC PATCH v4 7/9] printk-rb: increase size of seq and size variables
Date:   Thu,  8 Aug 2019 00:32:32 +0206
Message-Id: <20190807222634.1723-8-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807222634.1723-1-john.ogness@linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk implementation will rely on sequence numbers never
wrapping. For 32-bit systems, an unsigned long for sequence
numbers is not acceptable. Change the sequence number to u64.

Size variables are currently unsigned int, which may not be
acceptable for 64-bit systems. Change size variables to
unsigned long. (32-bit sizes on 32-bit systems should be fine.)

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/dataring.c   |  8 ++++----
 kernel/printk/dataring.h   |  4 ++--
 kernel/printk/numlist.c    |  6 +++---
 kernel/printk/numlist.h    |  6 +++---
 kernel/printk/ringbuffer.c |  6 +++---
 kernel/printk/ringbuffer.h | 10 +++++-----
 kernel/printk/test_prb.c   | 14 +++++++-------
 7 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/printk/dataring.c b/kernel/printk/dataring.c
index 345c46dba5bb..712842f2dc04 100644
--- a/kernel/printk/dataring.c
+++ b/kernel/printk/dataring.c
@@ -152,7 +152,7 @@ static struct dr_datablock *to_datablock(struct dataring *dr,
  * than or equal to the size of @dr_datablock.id. This ensures that there is
  * always space in the data array for the @id of a "wrapping" data block.
  */
-static void to_db_size(unsigned int *size)
+static void to_db_size(unsigned long *size)
 {
 	*size += sizeof(struct dr_datablock);
 	/* Alignment padding must be >= sizeof(dr_datablock.id). */
@@ -238,7 +238,7 @@ bool dataring_datablock_isvalid(struct dataring *dr, struct dr_desc *desc)
  *
  * Return: true if the size is legal for the data ringbuffer, otherwise false.
  */
-bool dataring_checksize(struct dataring *dr, unsigned int size)
+bool dataring_checksize(struct dataring *dr, unsigned long size)
 {
 	if (size == 0)
 		return false;
@@ -445,7 +445,7 @@ static unsigned long _dataring_pop(struct dataring *dr,
  * This will only fail if it was not possible to invalidate the tail data
  * block (i.e. the @id of the tail data block was not yet set by its writer).
  */
-static bool get_new_lpos(struct dataring *dr, unsigned int size,
+static bool get_new_lpos(struct dataring *dr, unsigned long size,
 			 unsigned long *begin_lpos_out,
 			 unsigned long *next_lpos_out)
 {
@@ -537,7 +537,7 @@ void dataring_desc_init(struct dr_desc *desc)
  * This will only fail if it was not possible to invalidate the tail data
  * block.
  */
-char *dataring_push(struct dataring *dr, unsigned int size,
+char *dataring_push(struct dataring *dr, unsigned long size,
 		    struct dr_desc *desc, unsigned long id)
 {
 	unsigned long begin_lpos;
diff --git a/kernel/printk/dataring.h b/kernel/printk/dataring.h
index 413ee95f4dd6..c566ce228abe 100644
--- a/kernel/printk/dataring.h
+++ b/kernel/printk/dataring.h
@@ -90,10 +90,10 @@ struct dataring {
 	void		*getdesc_arg;
 };
 
-bool dataring_checksize(struct dataring *dr, unsigned int size);
+bool dataring_checksize(struct dataring *dr, unsigned long size);
 
 bool dataring_pop(struct dataring *dr);
-char *dataring_push(struct dataring *dr, unsigned int size,
+char *dataring_push(struct dataring *dr, unsigned long size,
 		    struct dr_desc *desc, unsigned long id);
 
 void dataring_datablock_setid(struct dataring *dr, struct dr_desc *desc,
diff --git a/kernel/printk/numlist.c b/kernel/printk/numlist.c
index d5e224dafc0c..16c6ffa74b01 100644
--- a/kernel/printk/numlist.c
+++ b/kernel/printk/numlist.c
@@ -108,7 +108,7 @@
  *
  * This function will fail if @id is not valid anytime during this function.
  */
-bool numlist_read(struct numlist *nl, unsigned long id, unsigned long *seq,
+bool numlist_read(struct numlist *nl, unsigned long id, u64 *seq,
 		  unsigned long *next_id)
 {
 	struct nl_node *n;
@@ -165,7 +165,7 @@ bool numlist_read(struct numlist *nl, unsigned long id, unsigned long *seq,
  *
  * Return: The ID of the tail node.
  */
-unsigned long numlist_read_tail(struct numlist *nl, unsigned long *seq,
+unsigned long numlist_read_tail(struct numlist *nl, u64 *seq,
 				unsigned long *next_id)
 {
 	unsigned long tail_id;
@@ -201,8 +201,8 @@ unsigned long numlist_read_tail(struct numlist *nl, unsigned long *seq,
 void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id)
 {
 	unsigned long head_id;
-	unsigned long seq;
 	unsigned long r;
+	u64 seq;
 
 	/*
 	 * bA:
diff --git a/kernel/printk/numlist.h b/kernel/printk/numlist.h
index cdc3b21e6597..d4595fb9a3e9 100644
--- a/kernel/printk/numlist.h
+++ b/kernel/printk/numlist.h
@@ -20,7 +20,7 @@
  */
 struct nl_node {
 	/* private */
-	unsigned long	seq;
+	u64		seq;
 	unsigned long	next_id;
 };
 
@@ -64,9 +64,9 @@ struct numlist {
 void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id);
 struct nl_node *numlist_pop(struct numlist *nl);
 
-unsigned long numlist_read_tail(struct numlist *nl, unsigned long *seq,
+unsigned long numlist_read_tail(struct numlist *nl, u64 *seq,
 				unsigned long *next_id);
-bool numlist_read(struct numlist *nl, unsigned long id, unsigned long *seq,
+bool numlist_read(struct numlist *nl, unsigned long id, u64 *seq,
 		  unsigned long *next_id);
 
 #endif /* _KERNEL_PRINTK_NUMLIST_H */
diff --git a/kernel/printk/ringbuffer.c b/kernel/printk/ringbuffer.c
index 9be841761ea2..053622151447 100644
--- a/kernel/printk/ringbuffer.c
+++ b/kernel/printk/ringbuffer.c
@@ -416,7 +416,7 @@ static bool assign_desc(struct prb_reserved_entry *e)
  * * -ENOMEM: failed to reserve data (invalid descriptor committed)
  */
 char *prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
-		  unsigned int size)
+		  unsigned long size)
 {
 	struct prb_desc *d;
 	unsigned long id;
@@ -567,7 +567,7 @@ EXPORT_SYMBOL(prb_iter_init);
  */
 static void reset_iter(struct prb_iterator *iter)
 {
-	unsigned long last_seq;
+	u64 last_seq;
 
 	iter->next_id = numlist_read_tail(&iter->rb->nl, &last_seq, NULL);
 
@@ -650,9 +650,9 @@ int prb_iter_next_valid_entry(struct prb_iterator *iter)
 	struct dr_desc desc;
 	struct prb_desc *d;
 	struct nl_node *n;
-	unsigned long seq;
 	unsigned long id;
 	int size;
+	u64 seq;
 
 	if (!setup_next(nl, iter))
 		return 0;
diff --git a/kernel/printk/ringbuffer.h b/kernel/printk/ringbuffer.h
index 698d2328ea9e..ec7bb21abac2 100644
--- a/kernel/printk/ringbuffer.h
+++ b/kernel/printk/ringbuffer.h
@@ -97,9 +97,9 @@ struct prb_reserved_entry {
  */
 struct prb_entry {
 	/* public */
-	unsigned long	seq;
-	char		*buffer;
-	int		buffer_size;
+	u64	seq;
+	char	*buffer;
+	int	buffer_size;
 };
 
 /**
@@ -125,13 +125,13 @@ struct prb_iterator {
 	struct prb_entry		*e;
 
 	unsigned long			last_id;
-	unsigned long			last_seq;
+	u64				last_seq;
 	unsigned long			next_id;
 };
 
 /* writer interface */
 char *prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
-		  unsigned int size);
+		  unsigned long size);
 void prb_commit(struct prb_reserved_entry *e);
 
 /* reader interface */
diff --git a/kernel/printk/test_prb.c b/kernel/printk/test_prb.c
index 77d298b6990a..0157bbdf051f 100644
--- a/kernel/printk/test_prb.c
+++ b/kernel/printk/test_prb.c
@@ -38,8 +38,8 @@ static void dump_rb(struct printk_ringbuffer *rb)
 {
 	DECLARE_PRINTKRB_ENTRY(entry, 160);
 	DECLARE_PRINTKRB_ITER(iter, rb, &entry);
-	unsigned long last_seq = 0;
 	struct rbdata *dat;
+	u64 last_seq = 0;
 	char buf[160];
 	int len;
 
@@ -47,7 +47,7 @@ static void dump_rb(struct printk_ringbuffer *rb)
 
 	prb_for_each_entry_continue(&iter, len) {
 		if (entry.seq - last_seq != 1) {
-			trace_printk("LOST %lu\n",
+			trace_printk("LOST %llu\n",
 				     entry.seq - (last_seq + 1));
 		}
 		last_seq = entry.seq;
@@ -56,7 +56,7 @@ static void dump_rb(struct printk_ringbuffer *rb)
 
 		snprintf(buf, sizeof(buf), "%s", dat->text);
 		buf[sizeof(buf) - 1] = 0;
-		trace_printk("seq=%lu len=%d textlen=%d dataval=%s\n",
+		trace_printk("seq=%llu len=%d textlen=%d dataval=%s\n",
 			     entry.seq, len, dat->len, buf);
 	}
 
@@ -112,11 +112,11 @@ static int prbtest_reader(void *data)
 	DECLARE_PRINTKRB_ENTRY(entry, 160);
 	DECLARE_PRINTKRB_ITER(iter, &test_rb, &entry);
 	unsigned long total_lost = 0;
-	unsigned long last_seq = 0;
 	unsigned long max_lost = 0;
 	unsigned long count = 0;
 	struct rbdata *dat;
 	int did_sched = 1;
+	u64 last_seq = 0;
 	int len;
 
 	pr_err("prbtest: start thread %lu (reader)\n", num);
@@ -126,7 +126,7 @@ static int prbtest_reader(void *data)
 			if (entry.seq < last_seq) {
 				WRITE_ONCE(halt_test, 1);
 				trace_printk(
-					"reader%lu invalid seq %lu -> %lu\n",
+					"reader%lu invalid seq %llu -> %llu\n",
 					num, last_seq, entry.seq);
 				goto out;
 			}
@@ -145,7 +145,7 @@ static int prbtest_reader(void *data)
 			if (len != dat->len || len >= 160) {
 				WRITE_ONCE(halt_test, 1);
 				trace_printk(
-				 "reader%lu invalid len for %lu (%d<->%d)\n",
+				 "reader%lu invalid len for %llu (%d<->%d)\n",
 				 num, entry.seq, len, dat->len);
 				goto out;
 			}
@@ -172,7 +172,7 @@ static int prbtest_reader(void *data)
 	}
 out:
 	pr_err(
-	 "reader%lu: total_lost=%lu max_lost=%lu total_read=%lu seq=%lu\n",
+	 "reader%lu: total_lost=%lu max_lost=%lu total_read=%lu seq=%llu\n",
 	 num, total_lost, max_lost, count, entry.seq);
 	pr_err("prbtest: end thread %lu (reader)\n", num);
 
-- 
2.20.1


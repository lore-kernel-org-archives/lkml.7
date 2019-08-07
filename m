Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C219C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB20214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389582AbfHGW1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:27:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51847 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfHGW1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:27:43 -0400
Received: from [5.158.153.52] (helo=g2noscherz.tec.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hvUOx-0007mg-JO; Thu, 08 Aug 2019 00:27:24 +0200
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
Subject: [RFC PATCH v4 8/9] printk-rb: new functionality to support printk
Date:   Thu,  8 Aug 2019 00:32:33 +0206
Message-Id: <20190807222634.1723-9-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807222634.1723-1-john.ogness@linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following functions needed to support printk features.

dataring:
dataring_unused() - return free bytes

ringbuffer:
prb_init() - dynamically initialize a ringbuffer
prb_iter_seek() - seek to an entry in the committed list
prb_iter_wait_next_valid_entry() - blocking reader function
prb_iter_copy() - duplicate an iterator
prb_iter_entry() - get the entry of an iterator
prb_unused() - wrapper for dataring_unused()
prb_wait_queue() - get the ringbuffer wait queue
DECLARE_PRINTKRB_SEQENTRY() - declare entry for only seq reading

Also modify prb_iter_peek_next_entry() to optionally return the
sequence number previous to the next entry.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/dataring.c   |  29 ++++
 kernel/printk/dataring.h   |   3 +-
 kernel/printk/ringbuffer.c | 292 +++++++++++++++++++++++++++++++++++--
 kernel/printk/ringbuffer.h |  46 +++++-
 4 files changed, 354 insertions(+), 16 deletions(-)

diff --git a/kernel/printk/dataring.c b/kernel/printk/dataring.c
index 712842f2dc04..e48069dc27bc 100644
--- a/kernel/printk/dataring.c
+++ b/kernel/printk/dataring.c
@@ -489,6 +489,35 @@ static bool get_new_lpos(struct dataring *dr, unsigned long size,
 	}
 }
 
+/**
+ * dataring_unused() - Determine the unused bytes available for pushing.
+ *
+ * @dr: The data ringbuffer to check.
+ *
+ * Determine the largest possible push size that can be performed without
+ * invalidating existing data.
+ *
+ * Return: The number of unused bytes available for pushing.
+ */
+unsigned long dataring_unused(struct dataring *dr)
+{
+	unsigned long head_lpos;
+	unsigned long tail_lpos;
+	unsigned long size = 0;
+	unsigned long diff;
+
+	to_db_size(&size);
+
+	tail_lpos = atomic_long_read(&dr->tail_lpos);
+	head_lpos = atomic_long_read(&dr->head_lpos);
+
+	diff = DATA_SIZE(dr) + tail_lpos - head_lpos;
+	if (diff <= size)
+		return 0;
+
+	return (diff - size);
+}
+
 /**
  * dataring_desc_init() - Initialize a descriptor to be permanently invalid.
  *
diff --git a/kernel/printk/dataring.h b/kernel/printk/dataring.h
index c566ce228abe..896a7f855d9f 100644
--- a/kernel/printk/dataring.h
+++ b/kernel/printk/dataring.h
@@ -91,13 +91,14 @@ struct dataring {
 };
 
 bool dataring_checksize(struct dataring *dr, unsigned long size);
+unsigned long dataring_unused(struct dataring *dr);
 
 bool dataring_pop(struct dataring *dr);
 char *dataring_push(struct dataring *dr, unsigned long size,
 		    struct dr_desc *desc, unsigned long id);
-
 void dataring_datablock_setid(struct dataring *dr, struct dr_desc *desc,
 			      unsigned long id);
+
 struct dr_datablock *dataring_getdatablock(struct dataring *dr,
 					   struct dr_desc *desc, int *size);
 bool dataring_datablock_isvalid(struct dataring *dr, struct dr_desc *desc);
diff --git a/kernel/printk/ringbuffer.c b/kernel/printk/ringbuffer.c
index 053622151447..e727d9d72f65 100644
--- a/kernel/printk/ringbuffer.c
+++ b/kernel/printk/ringbuffer.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/irqflags.h>
 #include <linux/string.h>
+#include <linux/sched.h>
 #include <linux/err.h>
 #include "ringbuffer.h"
 
@@ -530,6 +531,24 @@ void prb_commit(struct prb_reserved_entry *e)
 }
 EXPORT_SYMBOL(prb_commit);
 
+/**
+ * prb_unused() - Determine the unused bytes available for reserving.
+ *
+ * @rb: The ringbuffer to check.
+ *
+ * This is the public function available to writer to determine the largest
+ * possible reserve size that can be performed without invalidating old
+ * entries.
+ *
+ * Context: Any context.
+ * Return: The number of unused bytes available for reserving.
+ */
+unsigned long prb_unused(struct printk_ringbuffer *rb)
+{
+	return dataring_unused(&rb->dr);
+}
+EXPORT_SYMBOL(prb_unused);
+
 /**
  * prb_iter_init() - Initialize an iterator.
  *
@@ -543,7 +562,7 @@ EXPORT_SYMBOL(prb_commit);
  *
  * As an alternative, DECLARE_PRINTKRB_ITER() can be used.
  *
- * The interator is initialized to the beginning of the committed list (the
+ * The iterator is initialized to the beginning of the committed list (the
  * oldest committed entry).
  *
  * Context: Any context.
@@ -575,10 +594,10 @@ static void reset_iter(struct prb_iterator *iter)
 	iter->last_seq = last_seq - 1;
 
 	/*
-	 * @last_id is only significant in EOL situations, when it is equal to
-	 * @next_id and the iterator wants to read the entry after @last_id as
-	 * the next entry. Set @last_id to something other than @next_id. So
-	 * that the iterator will read @next_id as the next entry.
+	 * @last_id is only significant in EOL situations, when it is equal
+	 * to @next_id, in which case it reads the entry after @last_id. Set
+	 * @last_id to something other than @next_id so that the iterator
+	 * will read @next_id as the next entry.
 	 */
 	iter->last_id = iter->next_id - 1;
 }
@@ -696,8 +715,12 @@ int prb_iter_next_valid_entry(struct prb_iterator *iter)
 			e->seq = seq;
 
 			db = dataring_getdatablock(dr, &desc, &size);
-			memcpy(&e->buffer[0], &db->data[0],
-			       size > e->buffer_size ? e->buffer_size : size);
+
+			if (e->buffer && e->buffer_size) {
+				memcpy(&e->buffer[0], &db->data[0],
+				       size > e->buffer_size ?
+				       e->buffer_size : size);
+			}
 
 			/*
 			 * mD:
@@ -726,6 +749,39 @@ int prb_iter_next_valid_entry(struct prb_iterator *iter)
 }
 EXPORT_SYMBOL(prb_iter_next_valid_entry);
 
+
+/**
+ * prb_iter_wait_next_valid_entry() - Blocking traverse and read.
+ *
+ * @iter: The iterator used for list traversal.
+ *
+ * This is the public function available to readers to traverse the committed
+ * entry list. It is the same as prb_iter_next_valid_entry() except that it
+ * blocks (interruptible) if the end of the commit list is reached. See
+ * prb_iter_next_valid_entry() for traversal/read/size details.
+ *
+ * Context: Process context. Sleeps if the end of the commit list reached.
+ * Return: The size of the entry data or -ERESTARTSYS if interrupted.
+ */
+int prb_iter_wait_next_valid_entry(struct prb_iterator *iter)
+{
+	int ret;
+
+	for (;;) {
+		ret = wait_event_interruptible(*(iter->rb->wq),
+					prb_iter_peek_next_entry(iter, NULL));
+		if (ret < 0)
+			break;
+
+		ret = prb_iter_next_valid_entry(iter);
+		if (ret > 0)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(prb_iter_wait_next_valid_entry);
+
 /**
  * prb_iter_sync() - Position an iterator to that of another iterator.
  *
@@ -764,10 +820,41 @@ void prb_iter_sync(struct prb_iterator *dst, struct prb_iterator *src)
 }
 EXPORT_SYMBOL(prb_iter_sync);
 
+/**
+ * prb_iter_copy() - Copy all iterator information to another iterator.
+ *
+ * @dst: The iterator to modify.
+ *
+ * @src: The iterator to copy from.
+ *
+ * This is the public function available to readers to copy all iterator
+ * information of another iterator. After calling this function, @dst will
+ * be using the same entry and traverse the same ringbuffer, from the
+ * same committed entry as @src.
+ *
+ * It is not necessary for @dst to be previously initialized.
+ *
+ * Context: Any context.
+ *
+ * It is safe to call this function from any context and state. But note
+ * that this function is not atomic. Callers must not sync iterators that
+ * can be accessed by other tasks/contexts unless proper synchronization is
+ * used.
+ */
+void prb_iter_copy(struct prb_iterator *dst, struct prb_iterator *src)
+{
+	dst->e = src->e;
+	prb_iter_sync(dst, src);
+}
+EXPORT_SYMBOL(prb_iter_copy);
+
 /**
  * prb_iter_peek_next_entry() - Check if there is a next (newer) entry.
  *
- * @iter: The iterator used for list traversal.
+ * @iter:     The iterator used for list traversal.
+ *
+ * @last_seq: A pointer to a variable to store the last seen sequence number.
+ *            This may be NULL if the caller is not interested in this value.
  *
  * This is the public function available to readers to check if a newer
  * entry is available.
@@ -775,14 +862,23 @@ EXPORT_SYMBOL(prb_iter_sync);
  * Context: Any context.
  * Return: true if there is a next entry, otherwise false.
  */
-bool prb_iter_peek_next_entry(struct prb_iterator *iter)
+bool prb_iter_peek_next_entry(struct prb_iterator *iter, u64 *last_seq)
 {
-	DECLARE_PRINTKRB_ENTRY(e, 1);
+	DECLARE_PRINTKRB_SEQENTRY(e);
 	DECLARE_PRINTKRB_ITER(iter_copy, iter->rb, &e);
 
 	prb_iter_sync(&iter_copy, iter);
 
-	return (prb_iter_next_valid_entry(&iter_copy) != 0);
+	if (prb_iter_next_valid_entry(&iter_copy) == 0) {
+		if (last_seq)
+			*last_seq = iter_copy.last_seq;
+		return false;
+	}
+
+	/* Pretend to have seen the previous entry. */
+	if (last_seq)
+		*last_seq = iter_copy.last_seq - 1;
+	return true;
 }
 EXPORT_SYMBOL(prb_iter_peek_next_entry);
 
@@ -807,3 +903,177 @@ unsigned long prb_getfail(struct printk_ringbuffer *rb)
 	return atomic_long_read(&rb->fail);
 }
 EXPORT_SYMBOL(prb_getfail);
+
+/**
+ * prb_iter_seek() - Reposition an iterator based on the sequence number.
+ *
+ * @iter:     The iterator used for list traversal.
+ *
+ * @last_seq: The sequence number that the iterator will have seen last.
+ *            Use 0 to position for reading the oldest commit list entry and
+ *            -1 to position beyond the newest commit list entry.
+ *
+ * This is the public function available to readers to reposition an iterator
+ * based on the commit list entry sequence number.
+ *
+ * If @last_seq exists, the iterator is positioned such that a following read
+ * will read the entry with the next higher sequence number.
+ *
+ * If @last_seq does not exist but a higher (newer) sequence number exists,
+ * the iterator is positioned such that a following read will read that
+ * higher entry.
+ *
+ * If @last_seq does not exist and no higher (newer) sequence number exists,
+ * the iterator is positioned at the end of the commit list such that a
+ * following read will read the next (not yet existent) entry.
+ *
+ * Context: Any context.
+ * Return: The last seen sequence number.
+ *
+ * From the return value (and the value of @last_seq) the caller can identify
+ * which of the above described scenarios occurred.
+ */
+u64 prb_iter_seek(struct prb_iterator *iter, u64 last_seq)
+{
+	DECLARE_PRINTKRB_SEQENTRY(e);
+	DECLARE_PRINTKRB_ITER(i, iter->rb, &e);
+	int l;
+
+	/* Seek to the beginning? */
+	if (last_seq == 0) {
+		reset_iter(iter);
+		goto out;
+	}
+
+	/* Iterator already where it should be? */
+	if (iter->last_seq == last_seq)
+		goto out;
+
+	/*
+	 * Backward seeking is not possible. Reset the iterator to the
+	 * beginning and seek forwards.
+	 */
+	if (last_seq < iter->last_seq)
+		reset_iter(iter);
+
+	/*
+	 * Seek using a local copy and only sync with the iterator when it
+	 * is known that the seek has not gone too far, for example when
+	 * the desired last_seq was an invalid entry or does not exist.
+	 */
+	prb_iter_sync(&i, iter);
+
+	prb_for_each_entry_continue(&i, l) {
+		if (e.seq > last_seq)
+			break;
+
+		prb_iter_sync(iter, &i);
+		if (e.seq == last_seq)
+			break;
+	}
+out:
+	return iter->last_seq;
+}
+EXPORT_SYMBOL(prb_iter_seek);
+
+/**
+ * prb_init() - Initialize a ringbuffer.
+ *
+ * @rb:               The ringbuffer to initialize.
+ *
+ * @data:             A pointer to a byte array for raw entry storage.
+ *
+ * @data_size_bits:   The power-of-2 size fo @data.
+ *
+ * @descs:            A pointer to a prb_desc array for descriptor storage.
+ *
+ * @desc_count_bits:  The power-of-2 count of descriptors in @descs.
+ *
+ * @waitq:            A wait queue to use for blocking readers.
+ *
+ * This is the public function available to initialize a ringbuffer. It
+ * allows the caller to provide the internal buffers, thus allowing the
+ * buffers to be allocated dynamically.
+ *
+ * As per numlist requirement of always having at least one node in the list,
+ * the ringbuffer structures are initialized such that:
+ *
+ * * the numlist head and tail point to descriptor 0
+ * * descriptor 0 has an invalid data block and is the terminating node
+ * * descriptor 1 will be the next descriptor
+ *
+ * As an alternative, DECLARE_PRINTKRB() can be used.
+ *
+ * Context: Any context.
+ */
+void prb_init(struct printk_ringbuffer *rb, char *data, int data_size_bits,
+	      struct prb_desc *descs, int desc_count_bits,
+	      struct wait_queue_head *waitq)
+{
+	struct dataring *dr = &rb->dr;
+	struct numlist *nl = &rb->nl;
+
+	rb->desc_count_bits = desc_count_bits;
+	rb->descs = descs;
+	atomic_long_set(&descs[0].id, 0);
+	descs[0].desc.begin_lpos = 1;
+	descs[0].desc.next_lpos = 1;
+	atomic_set(&rb->desc_next_unused, 1);
+
+	atomic_long_set(&nl->head_id, 0);
+	atomic_long_set(&nl->tail_id, 0);
+	nl->node = prb_desc_node;
+	nl->node_arg = rb;
+	nl->busy = prb_desc_busy;
+	nl->busy_arg = rb;
+
+	dr->size_bits = data_size_bits;
+	dr->data = data;
+	atomic_long_set(&dr->head_lpos, -111 * sizeof(long));
+	atomic_long_set(&dr->tail_lpos, -111 * sizeof(long));
+	dr->getdesc = prb_getdesc;
+	dr->getdesc_arg = rb;
+
+	atomic_long_set(&rb->fail, 0);
+
+	rb->wq = waitq;
+}
+EXPORT_SYMBOL(prb_init);
+
+/**
+ * prb_wait_queue() - Get the wait queue of blocking readers.
+ *
+ * @rb: The ringbuffer containing the wait queue.
+ *
+ * This is the public function available to readers to get the wait queue
+ * associated with a ringbuffer. All waiters on this wait queue are woken
+ * each time a new entry is committed. This allows a reader to implement
+ * their own blocking read/poll function.
+ *
+ * Context: Any context.
+ * Return: The ringbuffer wait queue.
+ */
+struct wait_queue_head *prb_wait_queue(struct printk_ringbuffer *rb)
+{
+	return rb->wq;
+}
+EXPORT_SYMBOL(prb_wait_queue);
+
+/**
+ * prb_iter_entry() - Get the prb_entry associated with an iterator.
+ *
+ * @iter: The iterator to get the entry from.
+ *
+ * This is the public function to allow readers to get the prb_entry
+ * structure associated with an iterator. Readers need an iterator's
+ * prb_entry in order to process the read data. This function is useful in
+ * case a caller only has an iterator, but not the associated prb_entry.
+ *
+ * Context: Any context.
+ * Return: The prb_entry used by @iter.
+ */
+struct prb_entry *prb_iter_entry(struct prb_iterator *iter)
+{
+	return iter->e;
+}
+EXPORT_SYMBOL(prb_iter_entry);
diff --git a/kernel/printk/ringbuffer.h b/kernel/printk/ringbuffer.h
index ec7bb21abac2..70cb9ad284d4 100644
--- a/kernel/printk/ringbuffer.h
+++ b/kernel/printk/ringbuffer.h
@@ -4,6 +4,7 @@
 #define _LINUX_PRINTK_RINGBUFFER_H
 
 #include <linux/atomic.h>
+#include <linux/wait.h>
 #include "numlist.h"
 #include "dataring.h"
 
@@ -48,6 +49,8 @@ struct prb_desc {
  *                    descriptor. Failure due to not being able to reserve
  *                    space in the dataring is not counted because readers
  *                    will notice a lost sequence number in that case.
+ *
+ * @wq:               The wait queue used by blocking readers.
  */
 struct printk_ringbuffer {
 	/* private */
@@ -60,6 +63,8 @@ struct printk_ringbuffer {
 	struct dataring		dr;
 
 	atomic_long_t		fail;
+
+	struct wait_queue_head	*wq;
 };
 
 /**
@@ -138,13 +143,22 @@ void prb_commit(struct prb_reserved_entry *e);
 void prb_iter_init(struct prb_iterator *iter, struct printk_ringbuffer *rb,
 		   struct prb_entry *e);
 int prb_iter_next_valid_entry(struct prb_iterator *iter);
-void prb_iter_sync(struct prb_iterator *dest, struct prb_iterator *src);
-bool prb_iter_peek_next_entry(struct prb_iterator *iter);
+int prb_iter_wait_next_valid_entry(struct prb_iterator *iter);
+void prb_iter_sync(struct prb_iterator *dst, struct prb_iterator *src);
+void prb_iter_copy(struct prb_iterator *dst, struct prb_iterator *src);
+bool prb_iter_peek_next_entry(struct prb_iterator *iter, u64 *last_seq);
+u64 prb_iter_seek(struct prb_iterator *iter, u64 last_seq);
+struct wait_queue_head *prb_wait_queue(struct printk_ringbuffer *rb);
+struct prb_entry *prb_iter_entry(struct prb_iterator *iter);
 
 /* utility functions */
 unsigned long prb_getfail(struct printk_ringbuffer *rb);
+void prb_init(struct printk_ringbuffer *rb, char *data, int data_size_bits,
+	      struct prb_desc *descs, int desc_count_bits,
+	      struct wait_queue_head *waitq);
+unsigned long prb_unused(struct printk_ringbuffer *rb);
 
-/* prototypes for callbacks used by numlist and dataring, respectively */
+/* callbacks used by numlist and dataring, respectively */
 struct nl_node *prb_desc_node(unsigned long id, void *arg);
 bool prb_desc_busy(unsigned long id, void *arg);
 struct dr_desc *prb_getdesc(unsigned long id, void *arg);
@@ -164,6 +178,8 @@ struct dr_desc *prb_getdesc(unsigned long id, void *arg);
  *
  * @descbits:    The power-of-2 maximum amount of descriptors allowed.
  *
+ * @waitq:       A wait queue to use for blocking readers.
+ *
  * The size of the data array will be the average data size multiplied by the
  * maximum amount of descriptors.
  *
@@ -173,8 +189,12 @@ struct dr_desc *prb_getdesc(unsigned long id, void *arg);
  * * the numlist head and tail point to descriptor 0
  * * descriptor 0 has an invalid data block and is the terminating node
  * * descriptor 1 will be the next descriptor
+ *
+ * This macro is particularly useful for static ringbuffers that should be
+ * immediately available and initialized. It is an alternative to
+ * manually initializing a ringbuffer with prb_init().
  */
-#define DECLARE_PRINTKRB(name, avgdatabits, descbits)			\
+#define DECLARE_PRINTKRB(name, avgdatabits, descbits, waitq)		\
 char _##name##_data[1 << ((avgdatabits) + (descbits))]			\
 	__aligned(__alignof__(long));					\
 struct prb_desc _##name##_descs[1 << (descbits)] = {			\
@@ -206,6 +226,7 @@ struct printk_ringbuffer name = {					\
 		.getdesc_arg	= &name,				\
 	},								\
 	.fail			= ATOMIC_LONG_INIT(0),			\
+	.wq			= waitq,				\
 }
 
 /**
@@ -231,6 +252,23 @@ struct prb_entry name = {						\
 	.buffer_size	= size,						\
 }
 
+/**
+ * DECLARE_PRINTKRB_SEQENTRY() - Declare an entry structure for sequences.
+ *
+ * @name: The name for the entry structure variable.
+ *
+ * This macro is declares and initializes an entry structure without any
+ * buffer. This is useful if an iterator is only interested in sequence
+ * numbers and so does not need to read the entry data. Also, because of
+ * its small size, it is safe to put on the stack.
+ */
+#define DECLARE_PRINTKRB_SEQENTRY(name)					\
+struct prb_entry name = {						\
+	.seq		= 0,						\
+	.buffer		= NULL,						\
+	.buffer_size	= 0,						\
+}
+
 /**
  * DECLARE_PRINTKRB_ITER() - Declare an iterator for readers.
  *
-- 
2.20.1


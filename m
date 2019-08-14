Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58402C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 03:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2006A2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 03:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfHNDrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 23:47:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36611 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfHNDrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 23:47:12 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hxkFX-0005cN-WD; Wed, 14 Aug 2019 05:47:00 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH POC] printk_ringbuffer: Alternative implementation of lockless printk ringbuffer
References: <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
        <20190704103321.10022-1-pmladek@suse.com>
        <20190704103321.10022-1-pmladek@suse.com>
        <87r275j15h.fsf@linutronix.de>
        <20190708152311.7u6hs453phhjif3q@pathway.suse.cz>
        <20190708152311.7u6hs453phhjif3q@pathway.suse.cz>
        <874l3wng7g.fsf@linutronix.de>
        <20190709090609.shx7j2mst7wlkbqm@pathway.suse.cz>
        <20190709090609.shx7j2mst7wlkbqm@pathway.suse.cz>
        <87tvbv33w2.fsf@linutronix.de>
        <20190709115814.5nykd6yroae7wmxw@pathway.suse.cz>
Date:   Wed, 14 Aug 2019 05:46:57 +0200
Message-ID: <87lfvwcssu.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

FWIW, I hacked a patch against my RFCv4[0] series to implement your
POC. Some parts of the patch are not particularly pretty, as I had to
"mold" it to fit numlist usage. And I was extreme with heavy memory
barrier usage to save time. But it boots, runs, and passes all my printk
interface tests. It is all behind a PETRM_POC macro, so toggling between
the two implementations is quite simple.

I varied from your POC by having the sequence number be separate from
the id. We need 64-bit sequence numbers for all architectures, but since
there are cmpxchg() calls on the id, the id probably should remain an
unsigned long. That wasn't a problem to implement because my ringbuffer
implementation has them separate as well. It also has the benefit that
no sequence bits are sacrified for the state bits.

I would like to say that I am glad to see that this works. I was not
convinced that an array-based approach would work. And although I still
think it is too complex, it is not as bad as I expected.

Particularly interesting to note by the implementation is the use of
states. numlist.c:expire_oldest_node() provides the main piece of state
logic to handle the critical point of descriptor recycling. But also
note that readers (numlist.c:numlist_read()) need to watch for two
states (committed and reusable) as well as validating the data itself.

As for performance, my test_prb test module does not provide very good
results. On a 16-core ARM64 I usually only see about 10,000 to 1,000,000
records before a writer fails to reserve. The problem seems to be that a
writer has reserved but not yet committed a record and the descriptor
array has wrapped. With the array implementation this means no further
descriptors can be assigned until that writer has committed. So a new
writer has no choice but to fail.

With the linked list approach this problem is avoided because writers
simply remove a descriptor from the committed list. With it removed, it
is less critical how long that writer takes to commit because it is not
preventing other writers from removing descriptors from the committed
list.

To compare, with the linked list implementation, the test_prb test
module ran 14 days on a 16-core ARM64 machine before I manually stopped
the test. In that time the 15 writers wrote a total of 936,341,256,222
records (average of 735,408 per second). The single reader never lost
more than 29 consecutive records (having lost a total of 0.02% of the
records). Keep in mind all of this is using a 4KB ringbuffer.

It could be argued that the test_prb module (with its massive writing
and small ringbuffer) is unrealistic. However, I would still argue that
using a linked list to manage the committed records is a simpler, more
straight forward, more robust approach that is easier to understand and
maintain. I hope with the splitting of the linked list (numlist) into
separate source files, you will also see that it is not so complicated.

John Ogness

[0] https://lkml.kernel.org/r/20190807222634.1723-1-john.ogness@linutronix.de

------ BEGIN PATCH -----
diff --git a/kernel/printk/numlist.h b/kernel/printk/numlist.h
index d4595fb9a3e9..09535e3fb055 100644
--- a/kernel/printk/numlist.h
+++ b/kernel/printk/numlist.h
@@ -2,6 +2,7 @@
 
 #ifndef _KERNEL_PRINTK_NUMLIST_H
 #define _KERNEL_PRINTK_NUMLIST_H
+#define PETRM_POC
 
 #include <linux/atomic.h>
 
@@ -69,4 +70,25 @@ unsigned long numlist_read_tail(struct numlist *nl, u64 *seq,
 bool numlist_read(struct numlist *nl, unsigned long id, u64 *seq,
 		  unsigned long *next_id);
 
+#ifdef PETRM_POC
+unsigned long prb_descs_count(struct numlist *nl);
+
+enum desc_state {
+	desc_miss,
+	desc_reserved,
+	desc_committed,
+	desc_reusable,
+};
+
+#define DESC_DST_BITS		(sizeof(long) * 8)
+#define DESC_COMMITTED_MASK	(1UL << (DESC_DST_BITS - 1))
+#define DESC_REUSE_MASK		(1UL << (DESC_DST_BITS - 2))
+#define DESC_FLAGS_MASK		(DESC_COMMITTED_MASK | DESC_REUSE_MASK)
+#define DESC_ID_MASK		(~DESC_FLAGS_MASK)
+
+#define DESC_ID(id)		((id) & DESC_ID_MASK)
+#define DESC_ID_PREV_WRAP(nl, id) \
+				DESC_ID(DESC_ID(id) - prb_descs_count(nl))
+#endif
+
 #endif /* _KERNEL_PRINTK_NUMLIST_H */
diff --git a/kernel/printk/numlist.c b/kernel/printk/numlist.c
index 16c6ffa74b01..de3dbdfdb0a8 100644
--- a/kernel/printk/numlist.c
+++ b/kernel/printk/numlist.c
@@ -79,6 +79,27 @@
  * Nodes can become invalid while being read by non-consuming readers.
  */
 
+#ifdef PETRM_POC
+unsigned long prb_desc_get_id(unsigned long id, void *arg);
+void prb_desc_set_id(unsigned long id, unsigned long new_id, void *arg);
+unsigned long prb_desc_cmpxchg_id(unsigned long id, unsigned long old_id,
+				  unsigned long new_id, void *arg);
+
+enum desc_state get_desc_state(unsigned long id, unsigned long entry_state)
+{
+	if (id != (entry_state & DESC_ID_MASK))
+		return desc_miss;
+
+	if (!(entry_state & DESC_COMMITTED_MASK))
+		return desc_reserved;
+
+	if (!(entry_state & DESC_REUSE_MASK))
+		return desc_committed;
+
+	return desc_reusable;
+}
+#endif
+
 /**
  * numlist_read() - Read the information stored within a node.
  *
@@ -111,6 +132,10 @@
 bool numlist_read(struct numlist *nl, unsigned long id, u64 *seq,
 		  unsigned long *next_id)
 {
+#ifdef PETRM_POC
+	enum desc_state desc_state;
+	unsigned long entry_state;
+#endif
 	struct nl_node *n;
 
 	n = nl->node(id, nl->node_arg);
@@ -146,6 +171,28 @@ bool numlist_read(struct numlist *nl, unsigned long id, u64 *seq,
 	 */
 	smp_rmb();
 
+#ifdef PETRM_POC
+	entry_state = prb_desc_get_id(id, nl->node_arg);
+	desc_state = get_desc_state(id, entry_state);
+	if (desc_state != desc_committed && desc_state != desc_reusable)
+		return false;
+
+	if (next_id) {
+		/* mark as EOL if next is not ready */
+
+		if (*next_id != DESC_ID(id + 1)) {
+			*next_id = id;
+		} else {
+			entry_state = prb_desc_get_id(*next_id, nl->node_arg);
+			desc_state = get_desc_state(*next_id, entry_state);
+			if (desc_state != desc_committed &&
+			    desc_state != desc_reusable) {
+				*next_id = id;
+			}
+		}
+	}
+#endif
+
 	return (nl->node(id, nl->node_arg) != NULL);
 }
 
@@ -198,6 +245,12 @@ unsigned long numlist_read_tail(struct numlist *nl, u64 *seq,
  * to update @next_id of the former head node to point to this one, which
  * makes this node visible to any task that sees the former head node.
  */
+#ifdef PETRM_POC
+void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id)
+{
+	prb_desc_set_id(DESC_ID(id), id | DESC_COMMITTED_MASK, nl->node_arg);
+}
+#else
 void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id)
 {
 	unsigned long head_id;
@@ -312,6 +365,7 @@ void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id)
 	 */
 	smp_store_release(&n->next_id, id);
 }
+#endif
 
 /**
  * numlist_pop() - Remove the oldest node from the list.
@@ -328,6 +382,76 @@ void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id)
  *
  * Return: The removed node or NULL if the tail node cannot be removed.
  */
+#ifdef PETRM_POC
+bool expire_oldest_node(struct numlist *nl, unsigned long tail_id)
+{
+	enum desc_state desc_state;
+	unsigned long entry_state;
+
+	entry_state = prb_desc_get_id(tail_id, nl->node_arg);
+	desc_state = get_desc_state(tail_id, entry_state);
+
+	switch (desc_state) {
+	case desc_miss:
+		if (DESC_ID(entry_state) == DESC_ID_PREV_WRAP(nl, tail_id))
+			return false;
+		return true;
+	case desc_reserved:
+		return false;
+	case desc_committed:
+		if (nl->busy(tail_id, nl->busy_arg))
+			return false;
+		prb_desc_cmpxchg_id(tail_id, entry_state,
+				    entry_state | DESC_REUSE_MASK, nl->node_arg);
+		/* fall through */
+	case desc_reusable:
+		break;
+	}
+
+	atomic_long_cmpxchg(&nl->tail_id, tail_id, DESC_ID(tail_id + 1));
+	return true;
+}
+
+struct nl_node *numlist_pop(struct numlist *nl)
+{
+	unsigned long id_prev_wrap;
+	unsigned long head_id;
+	struct nl_node *n;
+	unsigned long id;
+	unsigned long r;
+
+	head_id = atomic_long_read(&nl->head_id);
+
+	for (;;) {
+		id = DESC_ID(head_id + 1);
+		id_prev_wrap = DESC_ID_PREV_WRAP(nl, id);
+
+		if (id_prev_wrap == atomic_long_read(&nl->tail_id)) {
+			if (!expire_oldest_node(nl, id_prev_wrap))
+				return NULL;
+		}
+
+		r = atomic_long_cmpxchg(&nl->head_id, head_id, id);
+		if (r == head_id)
+			break;
+
+		head_id = r;
+	}
+
+	n = nl->node(id, nl->node_arg);
+
+	/* set to reserved */
+	prb_desc_set_id(id, id, nl->node_arg);
+
+	if (!n->seq)
+		WRITE_ONCE(n->seq, id);
+	else
+		WRITE_ONCE(n->seq, READ_ONCE(n->seq) + prb_descs_count(nl));
+	WRITE_ONCE(n->next_id, DESC_ID(id + 1));
+
+	return n;
+}
+#else
 struct nl_node *numlist_pop(struct numlist *nl)
 {
 	unsigned long tail_id;
@@ -374,3 +498,4 @@ struct nl_node *numlist_pop(struct numlist *nl)
 
 	return nl->node(tail_id, nl->node_arg);
 }
+#endif
diff --git a/kernel/printk/ringbuffer.h b/kernel/printk/ringbuffer.h
index 02b4c53e287e..3e28fbad5359 100644
--- a/kernel/printk/ringbuffer.h
+++ b/kernel/printk/ringbuffer.h
@@ -218,13 +218,23 @@ struct dr_desc *prb_getdesc(unsigned long id, void *arg);
  * immediately available and initialized. It is an alternative to
  * manually initializing a ringbuffer with prb_init().
  */
+#ifdef PETRM_POC
+#define ID0_INITIALIZER \
+	ATOMIC_LONG_INIT(DESC_COMMITTED_MASK|DESC_REUSE_MASK)
+#define NODE0_INITIALIZER { .seq = 0, .next_id = 1, }
+#else
+#define ID0_INITIALIZER ATOMIC_LONG_INIT(0)
+#define NODE0_INITIALIZER { .seq = 0, .next_id = 0 }
+#endif
+
 #define DECLARE_PRINTKRB(name, avgdatabits, descbits, waitq)		\
 char _##name##_data[1 << ((avgdatabits) + (descbits))]			\
 	__aligned(__alignof__(long));					\
 struct prb_desc _##name##_descs[1 << (descbits)] = {			\
 		{							\
-			.id	= ATOMIC_LONG_INIT(0),			\
+			.id	= ID0_INITIALIZER,			\
 			.desc	= __DR_DESC_INITIALIZER,		\
+			.list	= NODE0_INITIALIZER,			\
 		},							\
 	};								\
 struct printk_ringbuffer name = {					\
@@ -281,7 +291,7 @@ struct prb_entry name = {						\
  *
  * @name: The name for the entry structure variable.
  *
- * This macro is declares and initializes an entry structure without any
+ * This macro declares and initializes an entry structure without any
  * buffer. This is useful if an iterator is only interested in sequence
  * numbers and so does not need to read the entry data. Also, because of
  * its small size, it is safe to put on the stack.
diff --git a/kernel/printk/ringbuffer.c b/kernel/printk/ringbuffer.c
index e727d9d72f65..165b2128b34e 100644
--- a/kernel/printk/ringbuffer.c
+++ b/kernel/printk/ringbuffer.c
@@ -219,8 +219,10 @@ struct nl_node *prb_desc_node(unsigned long id, void *arg)
 {
 	struct prb_desc *d = to_desc(arg, id);
 
+#ifndef PETRM_POC
 	if (id != atomic_long_read(&d->id))
 		return NULL;
+#endif
 
 	return &d->list;
 }
@@ -263,7 +265,11 @@ bool prb_desc_busy(unsigned long id, void *arg)
 	smp_rmb();
 
 	/* hC: */
+#ifdef PETRM_POC
+	return (id == DESC_ID(atomic_long_read(&d->id)));
+#else
 	return (id == atomic_long_read(&d->id));
+#endif
 }
 EXPORT_SYMBOL(prb_desc_busy);
 
@@ -294,7 +300,11 @@ struct dr_desc *prb_getdesc(unsigned long id, void *arg)
 	 * assign_desc(). The smp_rmb() issued by the caller after calling
 	 * this function pairs with that _release(). See jB for details.
 	 */
+#ifdef PETRM_POC
+	if (id != DESC_ID(atomic_long_read(&d->id)))
+#else
 	if (id != atomic_long_read(&d->id))
+#endif
 		return NULL;
 
 	/* iB: */
@@ -302,6 +312,44 @@ struct dr_desc *prb_getdesc(unsigned long id, void *arg)
 }
 EXPORT_SYMBOL(prb_getdesc);
 
+#ifdef PETRM_POC
+unsigned long prb_descs_count(struct numlist *nl)
+{
+	struct printk_ringbuffer *rb =
+				container_of(nl, struct printk_ringbuffer, nl);
+	return DESCS_COUNT(rb);
+}
+
+unsigned long prb_desc_get_id(unsigned long id, void *arg)
+{
+	struct prb_desc *d = to_desc(arg, DESC_ID(id));
+	unsigned long ret;
+	smp_mb();
+	ret = atomic_long_read(&d->id);
+	smp_mb();
+	return ret;
+}
+
+void prb_desc_set_id(unsigned long id, unsigned long new_id, void *arg)
+{
+	struct prb_desc *d = to_desc(arg, DESC_ID(id));
+	smp_mb();
+	atomic_long_set_release(&d->id, new_id);
+	smp_mb();
+}
+
+unsigned long prb_desc_cmpxchg_id(unsigned long id, unsigned long old_id,
+				  unsigned long new_id, void *arg)
+{
+	struct prb_desc *d = to_desc(arg, DESC_ID(id));
+	unsigned long ret;
+	smp_mb();
+	ret = atomic_long_cmpxchg(&d->id, old_id, new_id);
+	smp_mb();
+	return ret;
+}
+#endif
+
 /**
  * assign_desc() - Assign a descriptor to the caller.
  *
@@ -326,7 +374,6 @@ static bool assign_desc(struct prb_reserved_entry *e)
 	struct printk_ringbuffer *rb = e->rb;
 	struct prb_desc *d;
 	struct nl_node *n;
-	unsigned long i;
 
 	for (;;) {
 		/*
@@ -340,8 +387,11 @@ static bool assign_desc(struct prb_reserved_entry *e)
 			break;
 		}
 
+#ifndef PETRM_POC
 		/* Fallback to static never-used descriptors. */
 		if (atomic_read(&rb->desc_next_unused) < DESCS_COUNT(rb)) {
+			unsigned long i;
+
 			i = atomic_fetch_inc(&rb->desc_next_unused);
 			if (i < DESCS_COUNT(rb)) {
 				d = &rb->descs[i];
@@ -354,6 +404,7 @@ static bool assign_desc(struct prb_reserved_entry *e)
 				break;
 			}
 		}
+#endif
 
 		/*
 		 * No descriptor available. Make one available for recycling
@@ -383,8 +434,10 @@ static bool assign_desc(struct prb_reserved_entry *e)
 	 *    matching
 	 * RMB between dB->iA and dI
 	 */
+#ifndef PETRM_POC
 	atomic_long_set_release(&d->id, atomic_long_read(&d->id) +
 				DESCS_COUNT(rb));
+#endif
 
 	e->desc = d;
 	return true;
@@ -507,7 +560,11 @@ void prb_commit(struct prb_reserved_entry *e)
 	struct prb_desc *d = e->desc;
 	unsigned long id;
 
+#ifdef PETRM_POC
+	id = DESC_ID(atomic_long_read(&d->id));
+#else
 	id = atomic_long_read(&d->id);
+#endif
 
 	/*
 	 * lA:
@@ -1015,7 +1072,12 @@ void prb_init(struct printk_ringbuffer *rb, char *data, int data_size_bits,
 
 	rb->desc_count_bits = desc_count_bits;
 	rb->descs = descs;
+#ifdef PETRM_POC
+	atomic_long_set(&descs[0].id, DESC_COMMITTED_MASK|DESC_REUSE_MASK);
+	descs[0].list.next_id = 1;
+#else
 	atomic_long_set(&descs[0].id, 0);
+#endif
 	descs[0].desc.begin_lpos = 1;
 	descs[0].desc.next_lpos = 1;
 	atomic_set(&rb->desc_next_unused, 1);

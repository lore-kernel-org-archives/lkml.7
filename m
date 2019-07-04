Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD07C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2742189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfGDKdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:33:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:57822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727552AbfGDKdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:33:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4567AEF1;
        Thu,  4 Jul 2019 10:33:49 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH POC] printk_ringbuffer: Alternative implementation of lockless printk ringbuffer
Date:   Thu,  4 Jul 2019 12:33:21 +0200
Message-Id: <20190704103321.10022-1-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
References: <20190621140516.h36g4in26pe3rmly@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is POC that implements the lockless printk ringbuffer slightly
different way. I believe that it is worth considering because it looks
much easier to deal with. The reasons are:

	+ The state of each entry is always clear.

	+ The write access rights and validity of the data
	  are clear from the state of the entry.

	+ It seems that three barriers are enough to synchronize
	  readers vs. writers. The rest is done implicitely
	  using atomic operations.

Of course, I might have missed some critical race that can't get
solved by the new design easily. But I do not see it at the moment.

The code compiles but it is not really tested. I wanted to send it
ASAP in a good enough state before we spend more time on cleaning
up either of the proposals.

How it works:

It uses two buffers (data, descriptors) like in John's variant.
The main difference is how the state is handled.

The trick is in the descriptor state "dst" variable included
in struct prb_desc. It consists of 3 values that are manipulated
atomically:

   + sequence number
   + committed flag
   + reuse flag

All the operations rely on the fact that we know what sequence
number we are looking for. From this point of view the descriptor
can be in the following states, see also enum prb_desc_state
and prb_desc_state() function:

   + miss: sequence number is not the expected one
   + reserved: sequence matches, both flags cleared
   + committed: sequence matches, committed flag set
   + reusable: sequence matches, both flags set

Next, the descriptor and data array are crosslinked:

   + descriptor contains: lpos, lpos_next
   + data array contains: seq

The main trickery is in prb_read_desc(). It reads descriptor
for the given sequence number into a buffer. It returns
enum prb_desc_state that says how much the values are valid.
The meaning is the following, by descriptor state:

   + miss: nothing is valid
   + reserved: nothing is valid
   + committed: everything is valid (descriptor, data)
   + reusable: descriptor has valid lpos, lpos_next but
	data are not longer valid

The validity is guaranteed by double checking the descriptor
state before and after reading the other values. It might
be less efficient than Jonh's approach. But I find it much
easier to make sure that the consistency more is correct.

Consistency:

1. Writer become owner of the descriptor by pushing rb->seq_newest
   forward. From this point, it has exclusive write access to
   the descriptor until the committed flag is set.

   The descriptor that is being replaced has to be in reusable
   state and the related data are not longer in valid lpos_oldest,
   lpos_latest range. By other words, nobody need the data from
   the old descriptor any longer.

   The descriptor can be moved into reusable state only
   when it was in the committed state before (atomic operation).

2. Writer reserve data by pushing rb->lpos_newest. From this
   point, it has exclusive access to the data until committed
   flag is set.

   Writers have to make enough space for the data before they
   change lpos_newest by pushing rb->lpos_oldest. They use
   the crosslinked "seq" to find the right descriptors and
   set them reusable.

   Again, only committed descriptors can be marked reusable.

3. Writers set committed flag when everything is set correctly.
   It means that crosslink and data are set correctly.

   From this point, they must not modify the descriptor or
   the data any longer. They might get moved into the reusable
   state at any time.

4. Readers have a simple life. They just try to access descriptors
   in the seq_oldest, seq_newest range. They try to read data
   only when the descriptor is in the committed state. They
   double check the state after the data read (copied).

5. Finally, I believe that we do not need to be concerned about
   overflows of seq or lpos numbers. All operations are done
   with interrupts disabled. Therefore they can be interrupted
   only by NMI. And NMI could not reserve and already
   reserved descriptor before it gets committed.

   By other words, I do not see a way how any CPU could
   rotate lpos or seq numbers over the entire range while
   while another CPU is still looking for a reusable
   descriptor/data.

TODO when there is interest in this variant:

     + add printk_ringbuffer.h and Makefile
     + solve bootstrap (first added message)
     + add iterators
     + fix bugs (one-off and other ungly mistakes)

Heavily-based-on: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/Makefile            |   1 +
 lib/printk_ringbuffer.c | 715 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 716 insertions(+)
 create mode 100644 lib/printk_ringbuffer.c

diff --git a/lib/Makefile b/lib/Makefile
index fb7697031a79..150680b02605 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -37,6 +37,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o
 
+lib-$(CONFIG_PRINTK) += printk_ringbuffer.o
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
new file mode 100644
index 000000000000..27594806c8ab
--- /dev/null
+++ b/lib/printk_ringbuffer.c
@@ -0,0 +1,715 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+
+/**
+ * struct prb_desc - A descriptor representing an entry in the ringbuffer.
+ * @dst:        The state of the descriptor and associated data. It includes:
+ *			- sequence number
+ *			- flag set when the data are committed
+ *			- flag set when the data are freed (buffer
+ *				could get reused)
+ * @lpos:      The logical position of the data for this entry.
+ *             The location of the beginning of the data within the data array
+ *             an be determined from this value.
+ * @lpos_next: The logical position of the data next to this entry.
+ *             This is used to determine the length of the data as well as
+ *             identify where the next data begins.
+ *
+ * Descriptors are used to identify where the data for each entry is and
+ * also provide an ordering for readers. Entry ordering is based on the
+ * descriptor linked list (not the ordering of data in the data array).
+ */
+struct prb_desc {
+	/* private */
+	unsigned long dst;
+	unsigned long lpos;
+	unsigned long lpos_next;
+};
+
+/**
+ * struct printk_ringbuffer - The ringbuffer structure.
+ * @desc:	    Descriptors array;
+ * @data:	    Data array;
+ * @desc_size_bits: Size of the descriptors array as a power-of-2
+ * @data_size_bits: Size of the data array as a power-of-2
+ * @seq_oldest:     Sequence number of the oldest valid descriptor
+ * @seq_newest:     Sequence number of the newest valid descriptor
+ * @lpos_oldest:    Logical position of the oldest valid data
+ * @lpos_newest:    Logical position right behind the newest data
+ * @lost:           Counter tracking how often writers failed to reserve data.
+ */
+struct printk_ringbuffer {
+	/* private */
+	struct prb_desc *desc;
+	char *data;
+
+	unsigned int desc_size_bits;
+	unsigned int data_size_bits;
+
+	unsigned long seq_oldest;
+	unsigned long seq_newest;
+
+	unsigned long lpos_oldest;
+	unsigned long lpos_newest;
+
+	atomic_t lost;
+};
+
+/**
+ * struct prb_reserved_entry - Used by writers to reserve/commit data.
+ * @rb: The printk ringbuffer used for reserve/commit.
+ * @seq: The sequence number of the reserved data.
+ * @irqflags: Local IRQs are disabled during the reserve/commit window.
+ *
+ * A writer provides this structure when reserving and committing data. The
+ * values of all the members are set on reserve and are only valid until
+ * commit.
+ */
+struct prb_reserved_entry {
+	/* private */
+	struct printk_ringbuffer *rb;
+	unsigned long seq;
+	unsigned long irqflags;
+};
+
+/**
+ * struct prb_data_block - A data block.
+ * @seq: Sequence number pointing to the related descriptor.
+ * @data: The data committed by the writer.
+ */
+struct prb_data_block {
+	unsigned long seq;
+	char data[0];
+};
+
+#define PRB_DST_BITS (sizeof(unsigned long) * 8)
+#define PRB_COMMITTED_MASK	(1UL << (PRB_DST_BITS - 1))
+#define PRB_REUSE_MASK		(1UL << (PRB_DST_BITS - 2))
+#define PRB_FLAGS_MASK		(PRB_COMMITTED_MASK | PRB_REUSE_MASK)
+#define PRB_SEQ_MASK		(~PRB_FLAGS_MASK)
+
+#define PRB_DESC_SIZE(rb) (1 << rb->desc_size_bits)
+#define PRB_DATA_SIZE(rb) (1 << rb->data_size_bits)
+
+#define PRB_DESC_MASK(rb) (PRB_DESC_SIZE(rb) - 1)
+#define PRB_DATA_MASK(rb) (PRB_DATA_SIZE(rb) - 1)
+
+#define PRB_LPOS_WRAP_CNT(rb, lpos) (lpos & ~PRB_DATA_MASK(rb))
+
+#define SEQ_TO_DESC(rb, seq) \
+	(&rb->desc[seq & PRB_DESC_MASK(rb)])
+#define LPOS_TO_DATAB(rb, lpos) \
+	((struct prb_data_block *)&rb->data[lpos & PRB_DATA_MASK(rb)])
+
+static bool prb_lpos_in_use(struct printk_ringbuffer *rb,
+			       unsigned long lpos)
+{
+	unsigned long lpos_oldest = READ_ONCE(rb->lpos_oldest);
+	unsigned long lpos_newest = READ_ONCE(rb->lpos_newest);
+
+	/*
+	 * lpos_newest will be lpos for the next reserved data.
+	 * It is right behind the in-use range.
+	 */
+	return lpos - lpos_oldest < lpos_newest - lpos_oldest;
+}
+
+/*
+ * Return values from prv_desc_state(). They make it easier
+ * to handle the given state using switch() or if contitions.
+ *
+ * It describes what information is valid in the given
+ * descriptor:
+ *
+ *   - miss: nothing is valid
+ *   - reserved: nothing is valid
+ *   - committed: everything is valid (descriptor, data)
+ *   - reusable: descriptor have valid lpos, lpos_next but
+ *	data are not longer valid
+ */
+enum prb_desc_state {
+	desc_miss,
+	desc_reserved,
+	desc_committed,
+	desc_reusable,
+};
+
+/* Return the state of the descriptor according to its life cycle. */
+static enum prb_desc_state
+prb_desc_state(unsigned long dst, unsigned long seq)
+{
+	if (seq != (dst & PRB_SEQ_MASK))
+		return desc_miss;
+
+	if (!(dst & PRB_COMMITTED_MASK))
+		return desc_reserved;
+
+	if (!(dst & PRB_REUSE_MASK))
+		return desc_committed;
+
+	return desc_reusable;
+}
+
+/*
+ * Read descriptor for the given sequence number into the given
+ * struct prb_desc buffer. Read lpos, lpos_next when it makes
+ * sense. Return enum desc_state so that the caller know what
+ * information is valid.
+ */
+static enum prb_desc_state
+prb_read_desc(struct printk_ringbuffer *rb,
+	      unsigned long seq,
+	      struct prb_desc *desc_out)
+{
+	struct prb_desc *desc = SEQ_TO_DESC(rb, seq);
+	enum prb_desc_state desc_state;
+
+	desc_out->dst = READ_ONCE(desc->dst);
+	desc_state = prb_desc_state(desc_out->dst, seq);
+
+	if (desc_state == desc_miss || desc_state == desc_reserved)
+		return desc_state;
+
+	/*
+	 * Synchronize lpos, lpos_next vs. desc read. The values
+	 * are set before PRB_COMMITTED_MASK is committed in prb_commit().
+	 */
+	smp_rmb();
+	desc_out->lpos = READ_ONCE(desc->lpos_next);
+	desc_out->lpos_next = READ_ONCE(desc->lpos_next);
+
+	/*
+	 * Make sure the lpos_next still belongs to the seq number.
+	 * It might be modified once cmpxchg() a new sequence
+	 * number is written in prb_reserve_desc().
+	 *
+	 * Also make sure that data read before this function is called
+	 * are still valid for the sequence number. They are invalidated
+	 * by setting reuse flag in prb_make_desc_reusable().
+	 */
+	smp_rmb();
+	desc_out->dst = READ_ONCE(desc->dst);
+
+	return prb_desc_state(desc_out->dst, seq);
+}
+
+/* Only committed descriptor can be made reusable. */
+static int prb_make_desc_reusable(struct printk_ringbuffer *rb,
+				  unsigned long seq)
+{
+	struct prb_desc *desc = SEQ_TO_DESC(rb, seq);
+	unsigned long dst_committed = seq | PRB_COMMITTED_MASK;
+	unsigned long dst_reusable = dst_committed | PRB_REUSE_MASK;
+
+	/*
+	 * Successful exchange works also as a write barrier that
+	 * tell readers that the date are not longer valid.
+	 * The related read barrier is in prb_read_desc().
+	 */
+	if (cmpxchg(&desc->dst, dst_committed, dst_reusable) == dst_committed)
+		return 0;
+	return -EINVAL;
+}
+
+/*
+ * Mark all conflicting data entries as reuasable.
+ *
+ * Fill desc_last with information from the descriptor
+ * related to the last data section.
+ *
+ * This function does not shuffle rb->lpos_oldest. It just
+ * marks the data reusable in the respective descriptors.
+ * Note that lpos_oldest is passed as parameter.
+ *
+ * Return 0 when all descriptors can be marked for reuse.
+ * Return -EBUSY when failed to find the right descriptor
+ * or when it was not yet committed.
+ */
+static int prb_make_data_reusable(struct printk_ringbuffer *rb,
+				  unsigned long lpos_oldest,
+				  unsigned long lpos_min_new,
+				  struct prb_desc *desc_last)
+{
+	unsigned long lpos = lpos_oldest;
+
+	/* Overflow means that lpos reached the required limit. */
+	while (lpos_min_new - lpos - 1 <= PRB_DATA_SIZE(rb)) {
+		struct prb_data_block *datab = LPOS_TO_DATAB(rb, lpos);
+		unsigned long seq;
+		enum prb_desc_state desc_state;
+
+		seq = READ_ONCE(datab->seq);
+		desc_state = prb_read_desc(rb, seq, desc_last);
+
+		switch (desc_state) {
+		case desc_miss:
+			/*
+			 * Mismatching sequence number means that the data
+			 * are freshly reserved but the prb_data_block have not
+			 * been updated with the new seq yet. We might even
+			 * be in the middle only newly written data.
+			 */
+			return -EBUSY;
+		case desc_reserved:
+			return -EBUSY;
+		case desc_committed:
+			/*
+			 * Make sure that this descriptor really points to this
+			 * lpos. Otherwise, this data block is already rewritten
+			 * by a parallel writer and we got a valid sequence
+			 * number only by chance.
+			 */
+			if (desc_last->lpos != lpos)
+				return -EBUSY;
+
+			/*
+			 * Descriptor is committed and can be freed. It is
+			 * perfectly fine when a parallel writer is faster.
+			 */
+			prb_make_desc_reusable(rb, seq);
+			break;
+		case desc_reusable:
+			/* nope */
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Move lpos_oldest to lpos_min_oldest or behind. Where lpos_min_oldest
+ * might be an existing lpos or minimal lpos to get enough free space.
+ *
+ * Return 0 when succeeded. Return -ENOMEM when some data were
+ * not committed yet and might still be accessed by parallel
+ * writers.
+ */
+static int prb_remove_data_oldest(struct printk_ringbuffer *rb,
+				  unsigned long lpos_min_oldest)
+{
+	struct prb_desc desc_last;
+	unsigned long lpos_oldest;
+	int err;
+
+	/*
+	 * Try until lpos_oldest is behind lpos_min_oldest.
+	 * There might be several entries in between. Parallel
+	 * writers might shift lpos_oldest for their needs.
+	 */
+	do {
+		lpos_oldest = READ_ONCE(rb->lpos_oldest);
+
+		/* Is the new position actually still used? */
+		if (!prb_lpos_in_use(rb, lpos_min_oldest))
+			return 0;
+
+		/* OK, mark all conflicting data entries as freed. */
+		err = prb_make_data_reusable(rb, lpos_oldest, lpos_min_oldest,
+					     &desc_last);
+		if (err) {
+			/*
+			 * Data array might point to wrong descriptors
+			 * when reused in the meantime. Try again in
+			 * this case.
+			 */
+			if (lpos_oldest != READ_ONCE(rb->lpos_oldest))
+				continue;
+
+			/*
+			 * Bad luck. Some conflicting data have not been
+			 * committed yet.
+			 */
+			return -ENOMEM;
+		}
+		/*
+		 * We are here only when prb_make_data_reusable() had to proceed
+		 * at least one desriptor and desc_last.lpos_next includes
+		 * some valid lpos_next.
+		 */
+	} while  (cmpxchg(&rb->lpos_oldest, lpos_oldest, desc_last.lpos_next) != lpos_oldest);
+
+	return 0;
+}
+
+/*
+ * Must be called with seq number that must be oldest one.
+ * It is safe when it has already been removed in parallel.
+ *
+ * Return 0 when the descriptor and its associated data have
+ * been freed.
+ *
+ * Returns -ENOMEM when the data were not committed yet or
+ * when lpos_oldest could not get moved because there are
+ * not-yet-committed data from another descriptor on the way.
+ */
+static int prb_remove_desc_oldest(struct printk_ringbuffer *rb,
+				  unsigned long seq_oldest)
+{
+	struct prb_desc desc;
+	enum prb_desc_state desc_state;
+	int err;
+
+	desc_state = prb_read_desc(rb, seq_oldest, &desc);
+	switch (desc_state) {
+	/*
+	 * Another seq means that the oldest desciptor has already been
+	 * removed and reused. Return success in this case.
+	 */
+	case desc_miss:
+		return 0;
+	/* Bad luck when still reserved but not yet committed. */
+	case desc_reserved:
+		return -ENOMEM;
+	case desc_committed:
+		/*
+		 * It was committed => either we or another parallel
+		 * writer marks it reusable. Anything is fine.
+		 */
+		prb_make_desc_reusable(rb, seq_oldest);
+		/* fall through */
+	case desc_reusable:
+		/*
+		 * Might fail when there are another uncommitted data
+		 * between lpos_oldest and desc.lpos_next.
+		 */
+		err = prb_remove_data_oldest(rb, desc.lpos_next);
+		if (err)
+			return err;
+		break;
+	}
+
+	/* It does not matter who removed the oldest desc */
+	cmpxchg(&rb->seq_oldest, seq_oldest, seq_oldest + 1);
+	return 0;
+}
+
+/*
+ * Get exclusive write access to a descriptor together with
+ * a new sequence number.
+ *
+ * First, remove the conflicting descriptor and related data
+ * from the active ranges by pushing seq_oldest and lpos_oldest
+ * forward.
+ */
+static int prb_reserve_desc(struct prb_reserved_entry *entry)
+{
+	unsigned long seq, seq_newest, seq_prev_wrap;
+	struct printk_ringbuffer *rb = entry->rb;
+	struct prb_desc *desc;
+	int err;
+
+	/* Get descriptor for the next sequence number. */
+	do {
+		seq_newest = READ_ONCE(rb->seq_newest);
+		seq = (seq_newest + 1) & PRB_SEQ_MASK;
+		seq_prev_wrap = (seq - PRB_DESC_SIZE(rb)) & PRB_SEQ_MASK;
+
+		/*
+		 * Remove conflicting descriptor from the previous wrap
+		 * if ever used. It might fail when the related data
+		 * have not been committed yet.
+		 */
+		if (seq_prev_wrap == READ_ONCE(rb->seq_oldest)) {
+			err = prb_remove_desc_oldest(rb, seq_prev_wrap);
+			if (err)
+				return err;
+		}
+	} while (cmpxchg(&rb->seq_newest, seq_newest, seq) != seq_newest);
+
+	/*
+	 * The descriptor is ours until the COMMITTED bit is set.
+	 * Set its sequence number with all flags cleared.
+	 */
+	desc = SEQ_TO_DESC(rb, seq);
+	WRITE_ONCE(desc->dst, seq);
+
+	/*
+	 * Make sure that anyone sees the new dst/seq before
+	 * lpos values and data are manipulated. It is related
+	 * to the read berrier in prb_read_desc().
+	 */
+	smp_wmb();
+
+	entry->seq = seq;
+	return 0;
+}
+
+/*
+ * Return lpos_next for the given lpos and size of data.
+ * Never wrap the data.
+ */
+static unsigned long
+prb_get_lpos_next(struct printk_ringbuffer *rb,
+		  unsigned long lpos,
+		  unsigned int size)
+{
+	unsigned long lpos_idx = lpos & PRB_DATA_MASK(rb);
+
+	/*
+	 * Wrap lpos when there is not enough space at the end of the buffer.
+	 * Reserve space for extra prb_data_block when the next data block
+	 * gets wrapped.
+	 */
+	if (lpos_idx + size + sizeof(struct prb_data_block) >= PRB_DATA_SIZE(rb)) {
+		lpos = PRB_LPOS_WRAP_CNT(rb, lpos) + PRB_DATA_SIZE(rb);
+	}
+
+	return lpos + size;
+}
+
+/*
+ * Try to make the needed space but do not reserve it. The function can
+ * be used to check whether there is a chance to reserve the space.
+ */
+static int prb_make_space(struct printk_ringbuffer *rb,
+			  unsigned int size)
+{
+	unsigned long lpos, lpos_next;
+
+	lpos = READ_ONCE(rb->lpos_newest);
+	lpos_next = prb_get_lpos_next(rb, lpos, size);
+
+	/*
+	 * Move lpos_oldest behind the conflicting lpos. Bad luck
+	 * when the some conflicting data have not been committed yet.
+	 */
+	return prb_remove_data_oldest(rb, lpos_next - PRB_DATA_SIZE(rb));
+}
+
+/*
+ * Reserve a range of logical positions in the data array.
+ *
+ * First, mark all conflicting data entries and related
+ * desciptors reusable. Then move lpos_oldest and
+ * lpos_newest as needed.
+ */
+static int prb_reserve_data(struct prb_reserved_entry *entry,
+			    unsigned int size)
+{
+	struct printk_ringbuffer *rb = entry->rb;
+	struct prb_desc *desc = SEQ_TO_DESC(rb, entry->seq);
+	unsigned long lpos, lpos_next;
+	struct prb_data_block *datab;
+	int err;
+
+	do {
+		lpos = READ_ONCE(rb->lpos_newest);
+		lpos_next = prb_get_lpos_next(rb, lpos, size);
+
+		/*
+		 * Move lpos_oldest behind the conflicting lpos. Bad luck
+		 * when the some conflicting data have not been committed yet.
+		 */
+		err = prb_remove_data_oldest(rb, lpos_next - PRB_DATA_SIZE(rb));
+		if (err)
+			return err;
+	} while (cmpxchg(&rb->lpos_newest, lpos, lpos_next) != lpos);
+
+	/*
+	 * Data range is reserved. Cross link the data block and descriptor.
+	 *
+	 * Use the original lpos_newest. The data might be stored into
+	 * a wrapped lpos but it can be detected and computed anytime
+	 * later, see prb_lpos_wrapped().
+	 */
+	datab = LPOS_TO_DATAB(rb, lpos);
+	WRITE_ONCE(datab->seq, entry->seq);
+	desc->lpos = lpos;
+	desc->lpos_next = lpos_next;
+	/*
+	 * No barrier is necessary here. Nobody will believe the reserved data
+	 * and meta information until they are committed. Nobody could
+	 * manipulate the descriptor until the data are committed and freed.
+	 *
+	 * Any mistake will get detected because the number of active
+	 * descriptors is limited by the array. The committed and freed
+	 * flags are always manipulated atomically with the sequence
+	 * number. An overflow of sequence numbers is not realistic.
+	 */
+	return 0;
+}
+
+/*
+ * This function is used when it was not possible to reserve
+ * data for the given descriptor. Allow to reuse this descritor
+ * in the next possible occasion.
+ *
+ * The function is called when the caller has exclusive write
+ * access to the descriptor.
+ */
+static void prb_make_desc_unused(struct printk_ringbuffer *rb,
+				 unsigned long seq)
+{
+	/* Use some currently used lpos that will be freed early. */
+	unsigned long lpos_oldest = READ_ONCE(rb->lpos_oldest);
+	struct prb_desc *desc = SEQ_TO_DESC(rb, seq);
+
+	desc->lpos = lpos_oldest;
+	desc->lpos_next = lpos_oldest;
+
+	/*
+	 * Make sure that prb_desc_read() see valid lpos, lpos_next
+	 * when the committed flag is set.
+	 */
+	smp_wmb();
+	desc->dst |= PRB_COMMITTED_MASK;
+}
+
+/*
+ * Return lpos of struct datap where the data are written.
+ * 
+ * It is lpos of the beginning of data array from the next
+ * when wrap when desc->lpos and desc->lpos_next are
+ * from different wraps.
+ *
+ * Note that struct datap with the crosslinked seq is
+ * written in the original desc->lpos.
+ */
+static unsigned long prb_lpos_data(struct printk_ringbuffer *rb,
+				   struct prb_desc *desc)
+{
+	if (PRB_LPOS_WRAP_CNT(rb, desc->lpos) !=
+	    PRB_LPOS_WRAP_CNT(rb, desc->lpos_next))
+		return PRB_LPOS_WRAP_CNT(rb, desc->lpos_next);
+
+	return desc->lpos;
+}
+
+/*
+ * Return pointer to the data for the given descriptor.
+ *
+ * The caller is reposnsible for passing struct prb_desc
+ * that can't be modified in the meantime.
+ */
+static char *prb_data(struct printk_ringbuffer *rb,
+		      struct prb_desc *desc)
+{
+	struct prb_data_block *datab;
+	unsigned long lpos_data;
+
+	lpos_data = prb_lpos_data(rb, desc);
+	datab = LPOS_TO_DATAB(rb, lpos_data);
+
+	return datab->data;
+}
+
+/*
+ * Return size of the reserved data buffer.
+ *
+ * The called is reposnsible for passing struct prb_desc
+ * that can't be modified in the meantime.
+ */
+static unsigned int prb_data_size(struct printk_ringbuffer *rb,
+				  struct prb_desc *desc)
+{
+	char *data, *data_next;
+
+	/* Need to compare pointer to the data inside prb_data_block. */
+	data = prb_data(rb, desc);
+	data_next = rb->data + (desc->lpos_next & PRB_DATA_MASK(rb));
+
+	return data_next - data;
+}
+
+char *prb_reserve(struct prb_reserved_entry *entry,
+		  struct printk_ringbuffer *rb,
+		  unsigned int size)
+{
+	int err;
+
+	entry->rb = rb;
+
+	size += sizeof(struct prb_data_block);
+	size = ALIGN(size, sizeof(unsigned long));
+	/*
+	 * We need one more prb_data_block when wrapping. Require small
+	 * enough entries so that we do not need to mind about such
+	 * datails and other corner cases.
+	 */
+	if (size > (PRB_DATA_SIZE(rb) / 4)) {
+		atomic_inc(&rb->lost);
+		return NULL;
+	}
+
+	local_irq_save(entry->irqflags);
+
+	/*
+	 * Reserve descriptor only when there is a chance
+	 * to reserve enough space in the data array.
+	 */
+	err = prb_make_space(rb, size);
+	if (err)
+		goto err;
+
+	err = prb_reserve_desc(entry);
+	if (err)
+		goto err;
+
+	err = prb_reserve_data(entry, size);
+	if (err) {
+		prb_make_desc_unused(rb, entry->seq);
+		goto err;
+	}
+
+	/*
+	 * Nobody could manipulate the reserved descriptor
+	 * until the committed flag is set.
+	 */
+	return prb_data(rb, SEQ_TO_DESC(rb, entry->seq));
+
+err:
+	atomic_inc(&rb->lost);
+	local_irq_restore(entry->irqflags);
+	return NULL;
+}
+
+void prb_commit(struct prb_reserved_entry *entry)
+{
+	struct prb_desc *desc = SEQ_TO_DESC(entry->rb, entry->seq);
+
+	/*
+	 * Make sure that the data, including crosslink between
+	 * the descriptor and the data_block, are written before
+	 * the committed flag is set.
+	 *
+	 * The respective read barrier in prb_read_desc().
+	 */
+	smp_wmb();
+
+	desc->dst |= PRB_COMMITTED_MASK;
+
+	local_irq_restore(entry->irqflags);
+}
+
+int prb_read(struct printk_ringbuffer *rb,
+	     unsigned long seq,
+	     char *buf,
+	     unsigned int size)
+{
+	struct prb_desc desc;
+	enum prb_desc_state desc_state;
+	char *data;
+	unsigned int data_size;
+
+	desc_state = prb_read_desc(rb, seq, &desc);
+	if (desc_state != desc_committed)
+		return -EFAULT;
+
+	data = prb_data(rb, &desc);
+	data_size = prb_data_size(rb, &desc);
+
+	if (size > data_size)
+		size = data_size;
+
+	memcpy(data, buf, size);
+
+	desc_state = prb_read_desc(rb, seq, &desc);
+	if (desc_state != desc_committed)
+		return -EFAULT;
+
+	return size;
+}
-- 
2.16.4


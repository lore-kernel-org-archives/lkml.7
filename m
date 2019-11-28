Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9C7C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860D321569
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfK1BxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:53:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45758 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbfK1BxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:53:06 -0500
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ia8zJ-00083b-LS; Thu, 28 Nov 2019 02:52:57 +0100
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
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer implementation (writer)
Date:   Thu, 28 Nov 2019 02:58:33 +0106
Message-Id: <20191128015235.12940-2-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128015235.12940-1-john.ogness@linutronix.de>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new lockless ringbuffer implementation to be used for printk.
First only add support for writers. Reader support will be added in
a follow-up commit.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 676 ++++++++++++++++++++++++++++++
 kernel/printk/printk_ringbuffer.h | 239 +++++++++++
 2 files changed, 915 insertions(+)
 create mode 100644 kernel/printk/printk_ringbuffer.c
 create mode 100644 kernel/printk/printk_ringbuffer.h

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
new file mode 100644
index 000000000000..09c32e52fd40
--- /dev/null
+++ b/kernel/printk/printk_ringbuffer.c
@@ -0,0 +1,676 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/irqflags.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/bug.h>
+#include "printk_ringbuffer.h"
+
+/**
+ * DOC: printk_ringbuffer overview
+ *
+ * Data Structure
+ * --------------
+ * The printk_ringbuffer is made up of 3 internal ringbuffers::
+ *
+ * * desc_ring:      A ring of descriptors. A descriptor contains all record
+ *                   meta-data (sequence number, timestamp, loglevel, etc.) as
+ *                   well as internal state information about the record and
+ *                   logical positions specifying where in the other
+ *                   ringbuffers the text and dictionary strings are located.
+ *
+ * * text_data_ring: A ring of data blocks. A data block consists of a 32-bit
+ *                   integer (ID) that maps to a desc_ring index followed by
+ *                   the text string of the record.
+ *
+ * * dict_data_ring: A ring of data blocks. A data block consists of a 32-bit
+ *                   integer (ID) that maps to a desc_ring index followed by
+ *                   the dictionary string of the record.
+ *
+ * Usage
+ * -----
+ * Here are some simple examples demonstrating writers and readers. For the
+ * examples it is assumed that a global ringbuffer is available::
+ *
+ *	DECLARE_PRINTKRB(rb, 15, 5, 4);
+ *
+ * This ringbuffer has a size of 1 MiB for text data (2 ^ 20), 512 KiB for
+ * dictionary data (2 ^ 19), and allows up to 32768 records (2 ^ 15).
+ *
+ * Sample writer code::
+ *
+ *	struct prb_reserved_entry e;
+ *	struct printk_record r;
+ *
+ *	// specify how much to allocate
+ *	r.text_buf_size = strlen(textstr) + 1;
+ *	r.dict_buf_size = strlen(dictstr) + 1;
+ *
+ *	if (prb_reserve(&e, &rb, &r)) {
+ *		snprintf(r.text_buf, r.text_buf_size, "%s", textstr);
+ *
+ *		// dictionary allocation may have failed
+ *		if (r.dict_buf)
+ *			snprintf(r.dict_buf, r.dict_buf_size, "%s", dictstr);
+ *
+ *		r.info->ts_nsec = local_clock();
+ *
+ *		prb_commit(&e);
+ *	}
+ *
+ * Sample reader code::
+ *
+ *	struct printk_info info;
+ *	char text_buf[32];
+ *	char dict_buf[32];
+ *	u64 next_seq = 0;
+ *	struct printk_record r = {
+ *		.info		= &info,
+ *		.text_buf	= &text_buf[0],
+ *		.dict_buf	= &dict_buf[0],
+ *		.text_buf_size	= sizeof(text_buf),
+ *		.dict_buf_size	= sizeof(dict_buf),
+ *	};
+ *
+ *	while (prb_read_valid(&rb, next_seq, &r)) {
+ *		if (info.seq != next_seq)
+ *			pr_warn("lost %llu records\n", info.seq - next_seq);
+ *
+ *		if (info.text_len > r.text_buf_size) {
+ *			pr_warn("record %llu text truncated\n", info.seq);
+ *			text_buf[sizeof(text_buf) - 1] = 0;
+ *		}
+ *
+ *		if (info.dict_len > r.dict_buf_size) {
+ *			pr_warn("record %llu dict truncated\n", info.seq);
+ *			dict_buf[sizeof(dict_buf) - 1] = 0;
+ *		}
+ *
+ *		pr_info("%llu: %llu: %s;%s\n", info.seq, info.ts_nsec,
+ *			&text_buf[0], info.dict_len ? &dict_buf[0] : "");
+ *
+ *		next_seq = info.seq + 1;
+ *	}
+ */
+
+#define DATA_SIZE(data_ring)		_DATA_SIZE((data_ring)->size_bits)
+#define DATA_SIZE_MASK(data_ring)	(DATA_SIZE(data_ring) - 1)
+
+#define DESCS_COUNT(desc_ring)		_DESCS_COUNT((desc_ring)->count_bits)
+#define DESCS_COUNT_MASK(desc_ring)	(DESCS_COUNT(desc_ring) - 1)
+
+/* Determine the data array index from a logical position. */
+#define DATA_INDEX(data_ring, lpos)	((lpos) & DATA_SIZE_MASK(data_ring))
+
+/* Determine the desc array index from an ID or sequence number. */
+#define DESC_INDEX(desc_ring, n)	((n) & DESCS_COUNT_MASK(desc_ring))
+
+/* Determine how many times the data array has wrapped. */
+#define DATA_WRAPS(data_ring, lpos)	((lpos) >> (data_ring)->size_bits)
+
+/* Get the logical position at index 0 of the current wrap. */
+#define DATA_THIS_WRAP_START_LPOS(data_ring, lpos) \
+	((lpos) & ~DATA_SIZE_MASK(data_ring))
+
+/* Get the ID for the same index of the previous wrap as the given ID. */
+#define DESC_ID_PREV_WRAP(desc_ring, id) \
+	DESC_ID((id) - DESCS_COUNT(desc_ring))
+
+/* A data block: maps to the raw data within the data ring. */
+struct prb_data_block {
+	u32	id;
+	u8	data[0];
+};
+
+static struct prb_desc *to_desc(struct prb_desc_ring *desc_ring, u64 n)
+{
+	return &desc_ring->descs[DESC_INDEX(desc_ring, n)];
+}
+
+static struct prb_data_block *to_block(struct prb_data_ring *data_ring,
+				       unsigned long begin_lpos)
+{
+	char *data = &data_ring->data[DATA_INDEX(data_ring, begin_lpos)];
+
+	return (struct prb_data_block *)data;
+}
+
+/* Increase the data size to account for data block meta data. */
+static unsigned long to_blk_size(unsigned long size)
+{
+	struct prb_data_block *db = NULL;
+
+	size += sizeof(*db);
+	size = ALIGN(size, sizeof(db->id));
+	return size;
+}
+
+/*
+ * Sanity checker for reserve size. The ringbuffer code assumes that a data
+ * block does not exceed the maximum possible size that could fit within the
+ * ringbuffer. This function provides that basic size check so that the
+ * assumption is safe.
+ */
+static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
+{
+	struct prb_data_block *db = NULL;
+
+	/* Writers are not allowed to write data-less records. */
+	if (size == 0)
+		return false;
+
+	/*
+	 * Ensure the alignment padded size could possibly fit in the data
+	 * array. The largest possible data block must still leave room for
+	 * at least the ID of the next block.
+	 */
+	size = to_blk_size(size);
+	if (size > DATA_SIZE(data_ring) - sizeof(db->id))
+		return false;
+
+	return true;
+}
+
+/* The possible responses of a descriptor state-query. */
+enum desc_state {
+	desc_miss,	/* ID mismatch */
+	desc_reserved,	/* reserved, but still in use by writer */
+	desc_committed, /* committed, writer is done */
+	desc_reusable,	/* free, not used by any writer */
+};
+
+/* Query the state of a descriptor. */
+static enum desc_state get_desc_state(u32 id, u32 state_val)
+{
+	if (id != DESC_ID(state_val))
+		return desc_miss;
+
+	if (state_val & DESC_REUSE_MASK)
+		return desc_reusable;
+
+	if (state_val & DESC_COMMITTED_MASK)
+		return desc_committed;
+
+	return desc_reserved;
+}
+
+/* Get a copy of a specified descriptor and its state. */
+static enum desc_state desc_read(struct prb_desc_ring *desc_ring, u32 id,
+				 struct prb_desc *desc_out)
+{
+	struct prb_desc *desc = to_desc(desc_ring, id);
+	atomic_t *state_var = &desc->state_var;
+	enum desc_state d_state;
+	u32 state_val;
+
+	state_val = atomic_read(state_var);
+	d_state = get_desc_state(id, state_val);
+	if (d_state == desc_miss || d_state == desc_reserved)
+		return d_state;
+
+	/* Check state before loading data. */
+	smp_rmb(); /* matches LMM_REF(prb_commit:A) */
+
+	*desc_out = READ_ONCE(*desc);
+
+	/* Load data before re-checking state. */
+	smp_rmb(); /* matches LMM_REF(desc_reserve:A) */
+
+	state_val = atomic_read(state_var);
+	return get_desc_state(id, state_val);
+}
+
+/*
+ * Take a given descriptor out of the committed state by attempting
+ * the transition: committed->reusable. Either this task or some
+ * other task will have been successful.
+ */
+static void desc_make_reusable(struct prb_desc_ring *desc_ring, u32 id)
+{
+	struct prb_desc *desc = to_desc(desc_ring, id);
+	atomic_t *state_var = &desc->state_var;
+	u32 val_committed = id | DESC_COMMITTED_MASK;
+	u32 val_reusable = val_committed | DESC_REUSE_MASK;
+
+	atomic_cmpxchg(state_var, val_committed, val_reusable);
+}
+
+/*
+ * For a given data ring (text or dict) and its current tail lpos:
+ * for each data block up until @lpos, make the associated descriptor
+ * reusable.
+ *
+ * If there is any problem making the associated descriptor reusable,
+ * either the descriptor has not yet been committed or another writer
+ * task has already pushed the tail lpos past the problematic data
+ * block. Regardless, on error the caller can re-load the tail lpos
+ * to determine the situation.
+ */
+static bool data_make_reusable(struct printk_ringbuffer *rb,
+			       struct prb_data_ring *data_ring,
+			       unsigned long tail_lpos, unsigned long lpos,
+			       unsigned long *lpos_out)
+{
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	struct prb_data_blk_lpos *blk_lpos;
+	struct prb_data_block *blk;
+	enum desc_state d_state;
+	struct prb_desc desc;
+	u32 id;
+
+	/*
+	 * Point @blk_lpos to the correct blk_lpos with the local copy
+	 * of the descriptor based on the provided @data_ring.
+	 */
+	if (data_ring == &rb->text_data_ring)
+		blk_lpos = &desc.text_blk_lpos;
+	else
+		blk_lpos = &desc.dict_blk_lpos;
+
+	/* Loop until @tail_lpos has advanced to or beyond @lpos. */
+	while ((lpos - tail_lpos) - 1 < DATA_SIZE(data_ring)) {
+		blk = to_block(data_ring, tail_lpos);
+		id = READ_ONCE(blk->id);
+
+		d_state = desc_read(desc_ring, id, &desc);
+
+		switch (d_state) {
+		case desc_miss:
+			return false;
+		case desc_reserved:
+			return false;
+		case desc_committed:
+			/* Does the descriptor link to this data block? */
+			if (blk_lpos->begin != tail_lpos)
+				return false;
+			desc_make_reusable(desc_ring, id);
+			break;
+		case desc_reusable:
+			/* Does the descriptor link to this data block? */
+			if (blk_lpos->begin != tail_lpos)
+				return false;
+			break;
+		}
+
+		/* Advance @tail_lpos to the next data block. */
+		tail_lpos = blk_lpos->next;
+	}
+
+	*lpos_out = tail_lpos;
+
+	return true;
+}
+
+/*
+ * Advance the data ring tail to at least @lpos. This function puts all
+ * descriptors into the reusable state if the tail will be pushed beyond their
+ * associated data block.
+ */
+static bool data_push_tail(struct printk_ringbuffer *rb,
+			   struct prb_data_ring *data_ring, unsigned long lpos)
+{
+	unsigned long tail_lpos;
+	unsigned long next_lpos;
+
+	/* If @lpos is not valid, there is nothing to do. */
+	if (lpos == INVALID_LPOS)
+		return true;
+
+	tail_lpos = atomic_long_read(&data_ring->tail_lpos);
+
+	do {
+		/* If @lpos is no longer valid, there is nothing to do. */
+		if (lpos - tail_lpos >= DATA_SIZE(data_ring))
+			break;
+
+		/*
+		 * Make all descriptors reusable that are associated with
+		 * data blocks before @lpos.
+		 */
+		if (!data_make_reusable(rb, data_ring, tail_lpos, lpos,
+					&next_lpos)) {
+			/*
+			 * data_make_reusable() performed state loads. Make
+			 * sure they are done before reloading the tail lpos.
+			 */
+			smp_rmb(); /* matches LMM_REF(data_push_tail:A) */
+
+			/*
+			 * Failure may be due to another task pushing the
+			 * tail. Reload the tail and check.
+			 */
+			next_lpos = atomic_long_read(&data_ring->tail_lpos);
+			if (next_lpos == tail_lpos)
+				return false;
+
+			/* Another task pushed the tail. Try again. */
+			tail_lpos = next_lpos;
+			continue;
+		}
+	/*
+	 * Advance the tail lpos (invalidating the data block) before
+	 * allowing future changes (such as the recycling of the
+	 * associated descriptor).
+	 */
+	} while (!atomic_long_try_cmpxchg(&data_ring->tail_lpos, &tail_lpos,
+				next_lpos)); /* LMM_TAG(data_push_tail:A) */
+
+	return true;
+}
+
+/*
+ * Advance the desc ring tail. This function advances the tail by one
+ * descriptor, thus invalidating the oldest descriptor. Before advancing
+ * the tail, the tail descriptor is made reusable and all data blocks up to
+ * and including the descriptor's data block are invalidated (i.e. the data
+ * ring tail is pushed past the data block of the descriptor being made
+ * reusable).
+ */
+static bool desc_push_tail(struct printk_ringbuffer *rb, u32 tail_id)
+{
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	enum desc_state d_state;
+	struct prb_desc desc;
+
+	d_state = desc_read(desc_ring, tail_id, &desc);
+
+	switch (d_state) {
+	case desc_miss:
+		/*
+		 * If the ID is exactly 1 wrap behind the expected, it is
+		 * being reserved by another writer and cannot be invalidated.
+		 */
+		if (DESC_ID(atomic_read(&desc.state_var)) ==
+		    DESC_ID_PREV_WRAP(desc_ring, tail_id)) {
+			return false;
+		}
+		return true;
+	case desc_reserved:
+		return false;
+	case desc_committed:
+		desc_make_reusable(desc_ring, tail_id);
+		break;
+	case desc_reusable:
+		break;
+	}
+
+	/*
+	 * Data blocks must be invalidated before their associated
+	 * descriptor can be made available for recycling. Invalidating
+	 * them later is not possible because there is no way to trust
+	 * data blocks once their associated descriptor is gone.
+	 */
+
+	if (!data_push_tail(rb, &rb->text_data_ring, desc.text_blk_lpos.next))
+		return false;
+	if (!data_push_tail(rb, &rb->dict_data_ring, desc.dict_blk_lpos.next))
+		return false;
+
+	/*
+	 * Check the next descriptor after @tail_id before pushing the tail to
+	 * it because the tail must always be in a committed or reusable
+	 * state. The implementation of get_desc_tail_seq() relies on this.
+	 *
+	 * A successful read also implies that the next descriptor <= @head_id
+	 * so there is no risk of pushing the tail past the head.
+	 */
+	d_state = desc_read(desc_ring, DESC_ID(tail_id + 1), &desc);
+	if (d_state == desc_committed || d_state == desc_reusable) {
+		atomic_cmpxchg(&desc_ring->tail_id, tail_id,
+			       DESC_ID(tail_id + 1));
+	} else {
+		/*
+		 * The descriptor following @tail_id is not in an allowed
+		 * tail state. But if the tail has since been moved by
+		 * another task already, then it does not matter.
+		 */
+		if (atomic_read(&desc_ring->tail_id) == tail_id)
+			return false;
+	}
+
+	return true;
+}
+
+/* Reserve a new descriptor, invalidating the oldest if necessary. */
+static bool desc_reserve(struct printk_ringbuffer *rb, u32 *id_out)
+{
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	struct prb_desc *desc;
+	u32 id_prev_wrap;
+	u32 head_id;
+	u32 id;
+
+	head_id = atomic_read(&desc_ring->head_id);
+
+	do {
+		desc = to_desc(desc_ring, head_id);
+
+		id = DESC_ID(head_id + 1);
+		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
+
+		if (id_prev_wrap == atomic_read(&desc_ring->tail_id)) {
+			if (!desc_push_tail(rb, id_prev_wrap))
+				return false;
+		}
+	} while (!atomic_try_cmpxchg(&desc_ring->head_id, &head_id, id));
+
+	desc = to_desc(desc_ring, id);
+
+	/* Set the descriptor's ID and also set its state to reserved. */
+	atomic_set(&desc->state_var, id | 0);
+
+	/* Store new ID/state before making any other changes. */
+	smp_wmb(); /* LMM_TAG(desc_reserve:A) */
+
+	*id_out = id;
+	return true;
+}
+
+/* Determine the end of a data block. */
+static unsigned long get_next_lpos(struct prb_data_ring *data_ring,
+				   unsigned long lpos, unsigned int size)
+{
+	unsigned long begin_lpos;
+	unsigned long next_lpos;
+
+	begin_lpos = lpos;
+	next_lpos = lpos + size;
+
+	if (DATA_WRAPS(data_ring, begin_lpos) ==
+	    DATA_WRAPS(data_ring, next_lpos)) {
+		/* The data block does not wrap. */
+		return next_lpos;
+	}
+
+	/* Wrapping data blocks store their data at the beginning. */
+	return (DATA_THIS_WRAP_START_LPOS(data_ring, next_lpos) + size);
+}
+
+/*
+ * Allocate a new data block, invalidating the oldest data block(s)
+ * if necessary. This function also associates the data block with
+ * a specified descriptor.
+ */
+static char *data_alloc(struct printk_ringbuffer *rb,
+			struct prb_data_ring *data_ring, unsigned long size,
+			struct prb_data_blk_lpos *blk_lpos, u32 id)
+{
+	struct prb_data_block *blk;
+	unsigned long begin_lpos;
+	unsigned long next_lpos;
+
+	if (size == 0) {
+		/* Specify a data-less block. */
+		blk_lpos->begin = INVALID_LPOS;
+		blk_lpos->next = INVALID_LPOS;
+		return NULL;
+	}
+
+	size = to_blk_size(size);
+
+	begin_lpos = atomic_long_read(&data_ring->head_lpos);
+
+	do {
+		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
+
+		if (!data_push_tail(rb, data_ring,
+				    next_lpos - DATA_SIZE(data_ring))) {
+			/* Failed to allocate, specify a data-less block. */
+			blk_lpos->begin = INVALID_LPOS;
+			blk_lpos->next = INVALID_LPOS;
+			return NULL;
+		}
+	} while (!atomic_long_try_cmpxchg(&data_ring->head_lpos, &begin_lpos,
+					  next_lpos));
+
+	/*
+	 * No barrier is needed here. The data validity is defined by
+	 * the state of the associated descriptor. They are marked as
+	 * invalid at the moment. And only the winner of the above
+	 * cmpxchg() could write here.
+	 */
+
+	blk = to_block(data_ring, begin_lpos);
+	blk->id = id;
+
+	if (DATA_WRAPS(data_ring, begin_lpos) !=
+	    DATA_WRAPS(data_ring, next_lpos)) {
+		/* Wrapping data blocks store their data at the beginning. */
+		blk = to_block(data_ring, 0);
+		blk->id = id;
+	}
+
+	blk_lpos->begin = begin_lpos;
+	blk_lpos->next = next_lpos;
+
+	return &blk->data[0];
+}
+
+/**
+ * prb_reserve() - Reserve space in the ringbuffer.
+ *
+ * @e:  The entry structure to setup.
+ * @rb: The ringbuffer to reserve data in.
+ * @r:  The record structure to allocate buffers for.
+ *
+ * This is the public function available to writers to reserve data.
+ *
+ * The writer specifies the text and dict sizes to reserve by setting the
+ * @text_buf_size and @dict_buf_size fields of @r, respectively. Dictionaries
+ * are optional, so @dict_buf_size is allowed to be 0.
+ *
+ * Context: Any context. Disables local interrupts on success.
+ * Return: true if at least text data could be allocated, otherwise false.
+ *
+ * On success, the fields @info, @text_buf, @dict_buf of @r will be set by
+ * this function and should be filled in by the writer before committing.
+ *
+ * If the function fails to reserve dictionary space (but all else succeeded),
+ * it will still report success. In that case @dict_buf is set to NULL and
+ * @dict_buf_size is set to 0. Writers must check this before writing to
+ * dictionary space.
+ */
+bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
+		 struct printk_record *r)
+{
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	struct prb_desc *d;
+	u32 id;
+
+	if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
+		return false;
+
+	/* Records without dictionaries are allowed. */
+	if (r->dict_buf_size) {
+		if (!data_check_size(&rb->dict_data_ring, r->dict_buf_size))
+			return false;
+	}
+
+	/* Disable interrupts during the reserve/commit window. */
+	local_irq_save(e->irqflags);
+
+	if (!desc_reserve(rb, &id)) {
+		/* Descriptor reservation failures are tracked. */
+		atomic_long_inc(&rb->fail);
+		local_irq_restore(e->irqflags);
+		return false;
+	}
+
+	d = to_desc(desc_ring, id);
+
+	/*
+	 * Set the @e fields here so that prb_commit() can be used if
+	 * text data allocation fails.
+	 */
+	e->rb = rb;
+	e->id = id;
+
+	/*
+	 * Initialize the sequence number if it has never been set.
+	 * Otherwise just increment it by a full wrap.
+	 *
+	 * @seq is considered "never been set" if it has a value of 0,
+	 * _except_ for descs[0], which was set by the ringbuffer initializer
+	 * and therefore is always considered as set.
+	 *
+	 * See the "Bootstrap" comment block in printk_ringbuffer.h for
+	 * details about how the initializer bootstraps the descriptors.
+	 */
+	if (d->info.seq == 0 && DESC_INDEX(desc_ring, id) != 0)
+		d->info.seq = DESC_INDEX(desc_ring, id);
+	else
+		d->info.seq += DESCS_COUNT(desc_ring);
+
+	r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
+				 &d->text_blk_lpos, id);
+	/* If text data allocation fails, a data-less record is committed. */
+	if (r->text_buf_size && !r->text_buf) {
+		d->info.text_len = 0;
+		d->info.dict_len = 0;
+		prb_commit(e);
+		return false;
+	}
+
+	r->dict_buf = data_alloc(rb, &rb->dict_data_ring, r->dict_buf_size,
+				 &d->dict_blk_lpos, id);
+	/*
+	 * If dict data allocation fails, the caller can still commit
+	 * text. But dictionary information will not be available.
+	 */
+	if (r->dict_buf_size && !r->dict_buf)
+		r->dict_buf_size = 0;
+
+	r->info = &d->info;
+
+	/* Set default values for the lengths. */
+	d->info.text_len = r->text_buf_size;
+	d->info.dict_len = r->dict_buf_size;
+
+	return true;
+}
+EXPORT_SYMBOL(prb_reserve);
+
+/**
+ * prb_commit() - Commit (previously reserved) data to the ringbuffer.
+ *
+ * @e: The entry containing the reserved data information.
+ *
+ * This is the public function available to writers to commit data.
+ *
+ * Context: Any context. Enables local interrupts.
+ */
+void prb_commit(struct prb_reserved_entry *e)
+{
+	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
+	struct prb_desc *d = to_desc(desc_ring, e->id);
+
+	/* Store all record data before updating the state. */
+	smp_wmb(); /* LMM_TAG(prb_commit:A) */
+
+	atomic_set(&d->state_var, e->id | DESC_COMMITTED_MASK);
+
+	/* Restore interrupts, the reserve/commit window is finished. */
+	local_irq_restore(e->irqflags);
+}
+EXPORT_SYMBOL(prb_commit);
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
new file mode 100644
index 000000000000..b6f06e5edc1b
--- /dev/null
+++ b/kernel/printk/printk_ringbuffer.h
@@ -0,0 +1,239 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KERNEL_PRINTK_RINGBUFFER_H
+#define _KERNEL_PRINTK_RINGBUFFER_H
+
+#include <linux/atomic.h>
+
+struct printk_info {
+	u64	seq;		/* sequence number */
+	u64	ts_nsec;	/* timestamp in nanoseconds */
+	u16	text_len;	/* length of entire record */
+	u16	dict_len;	/* length of dictionary buffer */
+	u8	facility;	/* syslog facility */
+	u8	flags:5;	/* internal record flags */
+	u8	level:3;	/* syslog level */
+	u32	caller_id;	/* thread id or processor id */
+};
+
+/*
+ * A structure providing the buffers, used by writers.
+ *
+ * Writers:
+ * The writer sets @text_buf_size and @dict_buf_size before calling
+ * prb_reserve(). On success, prb_reserve() sets @info, @text_buf, @dict_buf.
+ */
+struct printk_record {
+	struct printk_info	*info;
+	char			*text_buf;
+	char			*dict_buf;
+	unsigned int		text_buf_size;
+	unsigned int		dict_buf_size;
+};
+
+/* Specifies the position/span of a data block. */
+struct prb_data_blk_lpos {
+	unsigned long	begin;
+	unsigned long	next;
+};
+
+/* A descriptor: the complete meta-data for a record. */
+struct prb_desc {
+	struct printk_info		info;
+	atomic_t			state_var;
+	struct prb_data_blk_lpos	text_blk_lpos;
+	struct prb_data_blk_lpos	dict_blk_lpos;
+};
+
+/* A ringbuffer of "struct prb_data_block + data" elements. */
+struct prb_data_ring {
+	unsigned int	size_bits;
+	char		*data;
+	atomic_long_t	head_lpos;
+	atomic_long_t	tail_lpos;
+};
+
+/* A ringbuffer of "struct prb_desc" elements. */
+struct prb_desc_ring {
+	unsigned int		count_bits;
+	struct prb_desc		*descs;
+	atomic_t		head_id;
+	atomic_t		tail_id;
+};
+
+/* The high level structure representing the printk ringbuffer. */
+struct printk_ringbuffer {
+	struct prb_desc_ring	desc_ring;
+	struct prb_data_ring	text_data_ring;
+	struct prb_data_ring	dict_data_ring;
+	atomic_long_t		fail;
+};
+
+/* Used by writers as a reserve/commit handle. */
+struct prb_reserved_entry {
+	struct printk_ringbuffer	*rb;
+	unsigned long			irqflags;
+	u32				id;
+};
+
+#define _DATA_SIZE(sz_bits)		(1UL << (sz_bits))
+#define _DESCS_COUNT(ct_bits)		(1U << (ct_bits))
+#define DESC_SV_BITS			(sizeof(int) * 8)
+#define DESC_COMMITTED_MASK		(1U << (DESC_SV_BITS - 1))
+#define DESC_REUSE_MASK			(1U << (DESC_SV_BITS - 2))
+#define DESC_FLAGS_MASK			(DESC_COMMITTED_MASK | DESC_REUSE_MASK)
+#define DESC_ID_MASK			(~DESC_FLAGS_MASK)
+#define DESC_ID(sv)			((sv) & DESC_ID_MASK)
+#define INVALID_LPOS			1
+
+#define INVALID_BLK_LPOS	\
+	{			\
+		.begin	= INVALID_LPOS,	\
+		.next	= INVALID_LPOS,	\
+	}
+
+/*
+ * Descriptor Bootstrap
+ *
+ * The descriptor array is minimally initialized to allow immediate usage
+ * by readers and writers. The requirements that the descriptor array
+ * initialization must satisfy:
+ *
+ * R1: The tail must point to an existing (committed or reusable) descriptor.
+ *     This is required by the implementation of get_desc_tail_seq().
+ *
+ * R2: Readers must see that the ringbuffer is initially empty.
+ *
+ * R3: The first record reserved by a writer is assigned sequence number 0.
+ *
+ * To satisfy R1, the tail points to a descriptor that is minimally
+ * initialized (having no data block, i.e. data block's lpos @begin and @next
+ * values are set to INVALID_LPOS).
+ *
+ * To satisfy R2, the tail descriptor is initialized to the reusable state.
+ * Readers recognize reusable descriptors as existing records, but skip over
+ * them.
+ *
+ * To satisfy R3, the last descriptor in the array is used as the initial head
+ * (and tail) descriptor. This allows the first record reserved by a writer
+ * (head + 1) to be the first descriptor in the array. (Only the first
+ * descriptor in the array could have a valid sequence number of 0.)
+ *
+ * The first time a descriptor is reserved, it is assigned a sequence number
+ * with the value of the array index. A "first time reserved" descriptor can
+ * be recognized because it has a sequence number of 0 even though it does not
+ * have an index of 0. (Only the first descriptor in the array could have a
+ * valid sequence number of 0.) After the first reservation, all future
+ * reservations simply involve incrementing the sequence number by the array
+ * count.
+ *
+ * Hack #1:
+ * The first descriptor in the array is allowed to have a sequence number 0.
+ * In this case it is not possible to recognize if it is being reserved the
+ * first time (set to index value) or has been reserved previously (increment
+ * by the the array count)? This is handled by _always_ incrementing the
+ * sequence number when reserving the first descriptor in the array. So in
+ * order to satisfy R3, the sequence number of the first descriptor in the
+ * array is initialized to minus the array count. Then, upon the first
+ * reservation, it is incremented to 0.
+ *
+ * Hack #2:
+ * get_desc_tail_seq() can be called at any time by readers to retrieve the
+ * sequence number of the tail descriptor. However, due to R2 and R3,
+ * initially there are no records to report the sequence number of (sequence
+ * numbers are u64 and there is nothing less than 0). To handle this, the
+ * sequence number of the tail descriptor is initialized to 0. Technically
+ * this is incorrect, because there is no record with sequence number 0 (yet)
+ * and the tail descriptor is not the first descriptor in the array. But it
+ * allows prb_read_valid() to correctly report that the record is
+ * non-existent for any given sequence number. Bootstrapping is complete when
+ * the tail is pushed the first time, thus finally pointing to the first
+ * descriptor reserved by a writer, which has the assigned sequence number 0.
+ */
+
+/*
+ * Initiating Logical Value Overflows
+ *
+ * Both logical position (lpos) and ID values can be mapped to array indexes
+ * but may experience overflows during the lifetime of the system. To ensure
+ * that printk_ringbuffer can handle the overflows for these types, initial
+ * values are chosen that map to the correct initial array indexes, but will
+ * result in overflows soon.
+ *
+ * BLK0_LPOS: The initial @head_lpos and @tail_lpos for data rings.
+ *            It is at index 0 and the lpos value is such that it
+ *            will overflow on the first wrap.
+ *
+ * DESC0_ID: The initial @head_id and @tail_id for the desc ring. It is
+ *           at the last index of the descriptor array and the ID value
+ *           is such that it will overflow on the second wrap.
+ */
+#define BLK0_LPOS(sz_bits)	(-(_DATA_SIZE(sz_bits)))
+#define DESC0_ID(ct_bits)	DESC_ID(-(_DESCS_COUNT(ct_bits) + 1))
+#define DESC0_SV(ct_bits)	(DESC_COMMITTED_MASK | DESC_REUSE_MASK | \
+					DESC0_ID(ct_bits))
+
+#define DECLARE_PRINTKRB(name, descbits, avgtextbits, avgdictbits)	\
+char _##name##_text[1U << ((avgtextbits) + (descbits))]			\
+	__aligned(__alignof__(int));					\
+char _##name##_dict[1U << ((avgdictbits) + (descbits))]			\
+	__aligned(__alignof__(int));					\
+struct prb_desc _##name##_descs[_DESCS_COUNT(descbits)] = {		\
+	/* this will be the first record reserved by a writer */	\
+	[0] = {								\
+			.info = {					\
+				/*
+				 * will be incremented to 0 on
+				 * the first reservation
+				 */					\
+				.seq = -(u64)_DESCS_COUNT(descbits),	\
+				},					\
+		},							\
+	/* the initial head and tail */					\
+	[_DESCS_COUNT(descbits) - 1] = {				\
+			.info = {					\
+				/*
+				 * reports the minimal seq value
+				 * during the bootstrap phase
+				 */					\
+				.seq = 0,				\
+				},					\
+			/* reusable */					\
+			.state_var	= ATOMIC_INIT(DESC0_SV(descbits)), \
+			/* no associated data block */			\
+			.text_blk_lpos	= INVALID_BLK_LPOS,		\
+			.dict_blk_lpos	= INVALID_BLK_LPOS,		\
+		},							\
+	};								\
+struct printk_ringbuffer name = {					\
+	.desc_ring = {							\
+		.count_bits	= descbits,				\
+		.descs		= &_##name##_descs[0],			\
+		.head_id	= ATOMIC_INIT(DESC0_ID(descbits)),	\
+		.tail_id	= ATOMIC_INIT(DESC0_ID(descbits)),	\
+	},								\
+	.text_data_ring = {						\
+		.size_bits	= (avgtextbits) + (descbits),		\
+		.data		= &_##name##_text[0],			\
+		.head_lpos	= ATOMIC_LONG_INIT(BLK0_LPOS(		\
+					(avgtextbits) + (descbits))),	\
+		.tail_lpos	= ATOMIC_LONG_INIT(BLK0_LPOS(		\
+					(avgtextbits) + (descbits))),	\
+	},								\
+	.dict_data_ring = {						\
+		.size_bits	= (avgtextbits) + (descbits),		\
+		.data		= &_##name##_dict[0],			\
+		.head_lpos	= ATOMIC_LONG_INIT(BLK0_LPOS(		\
+					(avgtextbits) + (descbits))),	\
+		.tail_lpos	= ATOMIC_LONG_INIT(BLK0_LPOS(		\
+					(avgtextbits) + (descbits))),	\
+	},								\
+	.fail			= ATOMIC_LONG_INIT(0),			\
+}
+
+/* Writer Interface */
+bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
+		 struct printk_record *r);
+void prb_commit(struct prb_reserved_entry *e);
+
+#endif /* _KERNEL_PRINTK_RINGBUFFER_H */
-- 
2.20.1


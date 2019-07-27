Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF7BC76190
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 01:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6605522BF5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 01:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfG0BeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 21:34:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50700 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfG0BeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 21:34:09 -0400
Received: from [5.158.153.52] (helo=lx-training.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hrBal-0005il-Q2; Sat, 27 Jul 2019 03:33:48 +0200
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
Subject: [RFC PATCH v3 1/2] printk-rb: add a new printk ringbuffer implementation
Date:   Sat, 27 Jul 2019 03:33:32 +0200
Message-Id: <20190727013333.11260-2-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190727013333.11260-1-john.ogness@linutronix.de>
References: <20190727013333.11260-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See documentation for details.

For the real patch the "prb overview" documentation section in
kernel/printk/ringbuffer.c will be included in the commit message.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/Makefile     |   3 +
 kernel/printk/dataring.c   | 761 ++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/dataring.h   |  95 ++++++
 kernel/printk/numlist.c    | 375 +++++++++++++++++++++
 kernel/printk/numlist.h    |  72 ++++
 kernel/printk/ringbuffer.c | 800 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/ringbuffer.h | 288 ++++++++++++++++
 7 files changed, 2394 insertions(+)
 create mode 100644 kernel/printk/dataring.c
 create mode 100644 kernel/printk/dataring.h
 create mode 100644 kernel/printk/numlist.c
 create mode 100644 kernel/printk/numlist.h
 create mode 100644 kernel/printk/ringbuffer.c
 create mode 100644 kernel/printk/ringbuffer.h

diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index 4d052fc6bcde..567999aa93af 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y	= printk.o
 obj-$(CONFIG_PRINTK)	+= printk_safe.o
+obj-$(CONFIG_PRINTK)	+= ringbuffer.o
+obj-$(CONFIG_PRINTK)	+= numlist.o
+obj-$(CONFIG_PRINTK)	+= dataring.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
diff --git a/kernel/printk/dataring.c b/kernel/printk/dataring.c
new file mode 100644
index 000000000000..911bac593ec1
--- /dev/null
+++ b/kernel/printk/dataring.c
@@ -0,0 +1,761 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "dataring.h"
+
+/**
+ * DOC: dataring overview
+ *
+ * A dataring is a lockless ringbuffer consisting of variable length data
+ * blocks, each of which are assigned an ID. The IDs map to descriptors, which
+ * contain metadata about the data block. The lookup function mapping IDs to
+ * descriptors is implemented by the user.
+ *
+ * Data Blocks
+ * -----------
+ * All ringbuffer data is stored within a single static byte array. This is
+ * to ensure that any pointers to the data (past and present) will always
+ * point to valid memory. This is important because the lockless readers
+ * and writers may preempt for long periods of time and when they resume may
+ * be working with expired pointers.
+ *
+ * Data blocks are specified by begin and end logical positions (lpos) that
+ * map directly to byte array offsets. Using logical positions indirectly
+ * provides tagged state references for the data blocks to avoid ABA issues
+ * when the ringbuffer wraps. The number of tagged states per index is::
+ *
+ *	sizeof(long) / size of byte array
+ *
+ * If a data block starts near the end of the byte array but would extend
+ * beyond it, that data block is handled differently: a special "wrapping data
+ * block" is inserted in the space available at the end of the byte array and
+ * a "content data block" is placed at the beginning of the byte array. This
+ * can waste space at the end of the byte array, but simplifies the
+ * implementation by allowing writers to always work with contiguous buffers.
+ * For example, for a 1000 byte array, a descriptor may show a start lpos of
+ * 1950 and an end lpos of 2100. The data block associated with this
+ * descriptor is 100 bytes in size. Its ID is located in the "wrapping" data
+ * block (located at offset 950 of the byte array) and its data is found in
+ * the "content" data block (located at offset 0 of the byte array).
+ *
+ * Descriptors
+ * -----------
+ * A descriptor is a handle to a data block. How descriptors are structured
+ * and mapped to IDs is implemented by the user.
+ *
+ * Descriptors contain the begin (begin_lpos) and end (next_lpos) logical
+ * positions of the data block they represent. The end logical position
+ * matches the begin logical position of the adjacent data block.
+ *
+ * Why Descriptors?
+ * ----------------
+ * The data ringbuffer supports variable length entities, which means that
+ * data blocks will not always begin at a predictable offset of the byte
+ * array. This is a major problem for lockless writers that, for example, will
+ * compete to expire and reuse old data blocks when the ringbuffer is full.
+ * Without a predictable begin for the data blocks, a writer has no reliable
+ * information about the status of the "free" area. Are any flags or state
+ * variables already set or is it just garbage left over from previous usage?
+ *
+ * Descriptors allow safe and controlled access to data block metadata by
+ * providing predictable offsets for such metadata. This is key to supporting
+ * multiple concurrent lockless writers.
+ *
+ * Behavior
+ * --------
+ * The data ringbuffer allows writers to commit data without regard for
+ * readers. Readers must pre- and post-validate the data blocks they are
+ * processing to be sure the processed data is consistent. A function
+ * dataring_datablock_isvalid() is available for that. Readers can only
+ * iterate data blocks by utilizing an external implementation using
+ * descriptor lookups based on IDs.
+ *
+ * Writers commit data in two steps:
+ *
+ * (1) Reserve a new data block (dataring_push()).
+ * (2) Commit the data block (dataring_datablock_setid()).
+ *
+ * Once a data block is committed, it is available for recycling by another
+ * writer. Therefore, once committed, a writer must no longer access the data
+ * block.
+ *
+ * If data block reservation fails, it means the oldest reserved data block
+ * has not yet been committed by its writer. This acts as a blocker for any
+ * future data block reservation.
+ */
+
+#define DATA_SIZE(dr) (1 << (dr)->size_bits)
+#define DATA_SIZE_MASK(dr) (DATA_SIZE(dr) - 1)
+
+/**
+ * DATA_INDEX() - Determine the data array index from a logical position.
+ *
+ * @dr:   The associated data ringbuffer.
+ *
+ * @lpos: A logical position used (or to be used) for a data block.
+ */
+#define DATA_INDEX(dr, lpos) ((lpos) & DATA_SIZE_MASK(dr))
+
+/**
+ * DATA_WRAPS() - Determine how many times the data array has wrapped.
+ *
+ * @dr:   The associated data ringbuffer.
+ *
+ * @lpos: A logical position used (or to be used) for a data block.
+ *
+ * The number of wraps is useful when determining if one logical position
+ * is overtaking the data array index of another logical position.
+ */
+#define DATA_WRAPS(dr, lpos) ((lpos) >> (dr)->size_bits)
+
+/**
+ * DATA_THIS_WRAP_START_LPOS() - Get the position at the start of the wrap.
+ *
+ * @dr:   The associated data ringbuffer.
+ *
+ * @lpos: A logical position used (or to be used) for a data block.
+ *
+ * Given a logical position, return the logical position if backed up to the
+ * beginning of the current wrap (data array index 0). This is useful when a
+ * data block extends beyond the end of the data array (i.e. wraps) and
+ * therefore needs to store its data at the beginning of the data array.
+ */
+#define DATA_THIS_WRAP_START_LPOS(dr, lpos) ((lpos) & ~DATA_SIZE_MASK(dr))
+
+/**
+ * to_datablock() - Get a data block pointer from a logical position.
+ *
+ * @dr:         The associated data ringbuffer.
+ *
+ * @begin_lpos: The logical position of the beginning of the data block.
+ *
+ * Return: A pointer to a data block.
+ *
+ * Since multiple logical positions can map to the same array index, the
+ * returned data block may not be the data the caller wants. The caller is
+ * responsible for validating the data.
+ *
+ * The returned pointer has an address dependency to @begin_lpos.
+ */
+static struct dr_datablock *to_datablock(struct dataring *dr,
+					 unsigned long begin_lpos)
+{
+	return (struct dr_datablock *)&dr->data[DATA_INDEX(dr, begin_lpos)];
+}
+
+/**
+ * to_db_size() - Increase a data size to account for ID and padding.
+ *
+ * @size: A pointer to a size value to modify.
+ *
+ * IMPORTANT: The alignment padding specified within ALIGN() must be greater
+ * than or equal to the size of @dr_datablock.id. This ensures that there is
+ * always space in the data array for the @id of a "wrapping" data block.
+ */
+static void to_db_size(unsigned int *size)
+{
+	*size += sizeof(struct dr_datablock);
+	/* Alignment padding must be >= sizeof(dr_datablock.id). */
+	*size = ALIGN(*size, sizeof(long));
+}
+
+/**
+ * _datablock_valid() - Check if given positions yield a valid data block.
+ *
+ * @dr:         The associated data ringbuffer.
+ *
+ * @head_lpos:  The newest data logical position.
+ *
+ * @tail_lpos:  The oldest data logical position.
+ *
+ * @begin_lpos: The beginning logical position of the data block to check.
+ *
+ * @next_lpos:  The logical position of the next adjacent data block.
+ *              This value is used to identify the end of the data block.
+ *
+ * A data block is considered valid if it satisfies the two conditions:
+ *
+ * * tail_lpos <= begin_lpos < next_lpos <= head_lpos
+ * * tail_lpos is at most exactly 1 wrap behind head_lpos
+ *
+ * Return: true if the specified data block is valid.
+ */
+static bool _datablock_valid(struct dataring *dr,
+			     unsigned long head_lpos, unsigned long tail_lpos,
+			     unsigned long begin_lpos, unsigned long next_lpos)
+
+{
+	unsigned long size = DATA_SIZE(dr);
+
+	/* tail_lpos <= begin_lpos */
+	if (begin_lpos - tail_lpos >= size)
+		return false;
+
+	/* begin_lpos < next_lpos */
+	if (begin_lpos == next_lpos)
+		return false;
+	if (next_lpos - begin_lpos >= size)
+		return false;
+
+	/* next_lpos <= head_lpos */
+	if (head_lpos - next_lpos >= size)
+		return false;
+
+	/* at most exactly 1 wrap */
+	if (head_lpos - tail_lpos > size)
+		return false;
+
+	return true;
+}
+
+/**
+ * dataring_datablock_isvalid() - Check if a specified data block is valid.
+ *
+ * @dr:   The associated data ringbuffer.
+ *
+ * @desc: A descriptor describing a data block to check.
+ *
+ * Return: true if the data block is valid, otherwise false.
+ */
+bool dataring_datablock_isvalid(struct dataring *dr, struct dr_desc *desc)
+{
+	return _datablock_valid(dr,
+				atomic_long_read(&dr->head_lpos),
+				atomic_long_read(&dr->tail_lpos),
+				READ_ONCE(desc->begin_lpos),
+				READ_ONCE(desc->next_lpos));
+}
+
+/**
+ * dataring_checksize() - Check if a data size is legal.
+ *
+ * @dr:   The data ringbuffer to check against.
+ *
+ * @size: The size value requested by a writer.
+ *
+ * The size value is increased to include the data block structure size and
+ * any needed alignment padding.
+ *
+ * Return: true if the size is legal for the data ringbuffer, otherwise false.
+ */
+bool dataring_checksize(struct dataring *dr, unsigned int size)
+{
+	if (size == 0)
+		return false;
+
+	/* Ensure the alignment padded size fits in the data array. */
+	to_db_size(&size);
+	if (size >= DATA_SIZE(dr))
+		return false;
+
+	return true;
+}
+
+/**
+ * _dataring_pop() - Move tail forward, invalidating the oldest data block.
+ *
+ * @dr:        The data ringbuffer containing the data block.
+ *
+ * @tail_lpos: The logical position of the oldest data block.
+ *
+ * This function expects to move the pointer to the oldest data block forward,
+ * thus invalidating the oldest data block. Before attempting to move the
+ * tail, it is verified that the data block is valid. An invalid data block
+ * means that another task has already moved the tail pointer forward.
+ *
+ * Return: The new/current value (logical position) of the tail.
+ *
+ * From the return value the caller can identify if the tail was moved
+ * forward. However, the caller does not know if it was the task that
+ * performed the move.
+ *
+ * If, after seeing a moved tail, the caller will be modifying @begin_lpos or
+ * @next_lpos of a descriptor or will be modifying the head, a full memory
+ * barrier is required before doing so. This ensures that if any update to a
+ * descriptor's @begin_lpos or @next_lpos or the data ringbuffer's head is
+ * visible, that the previous update to the tail is also visible. This avoids
+ * the possibility of failure to notice when another task has moved the tail.
+ *
+ * If the tail has not moved forward it means the @id for the data block was
+ * not set yet. In this case the tail cannot move forward.
+ */
+static unsigned long _dataring_pop(struct dataring *dr,
+				   unsigned long tail_lpos)
+{
+	unsigned long new_tail_lpos;
+	unsigned long begin_lpos;
+	unsigned long next_lpos;
+	struct dr_datablock *db;
+	struct dr_desc *desc;
+
+	/*
+	 * dA:
+	 *
+	 * @db has an address dependency on @tail_pos. Therefore @tail_lpos
+	 * must be loaded before dB, which accesses @db.
+	 */
+	db = to_datablock(dr, tail_lpos);
+
+	/*
+	 * dB:
+	 *
+	 * When a writer has completed accessing its data block, it sets the
+	 * @id thus making the data block available for invalidation. This
+	 * _acquire() ensures that this task sees all data ringbuffer and
+	 * descriptor values seen by the writer as @id was set. This is
+	 * necessary to ensure that the data block can be correctly identified
+	 * as valid (i.e. @begin_lpos, @next_lpos, @head_lpos are at least the
+	 * values seen by that writer, which yielded a valid data block at
+	 * that time). It is not enough to rely on the address dependency of
+	 * @desc to @id because @head_lpos is not depedent on @id. This pairs
+	 * with the _release() in dataring_datablock_setid().
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If dB reads from gA, then dC reads from fG.
+	 * If dB reads from gA, then dD reads from fH.
+	 * If dB reads from gA, then dE reads from fE.
+	 *
+	 * Note that if dB reads from gA, then dC cannot read from fC.
+	 * Note that if dB reads from gA, then dD cannot read from fD.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from fG to gA
+	 *    matching
+	 * ADDRESS DEP. from dB to dC
+	 *
+	 * RELEASE from fH to gA
+	 *    matching
+	 * ADDRESS DEP. from dB to dD
+	 *
+	 * RELEASE from fE to gA
+	 *    matching
+	 * ACQUIRE from dB to dE
+	 */
+	desc = dr->getdesc(smp_load_acquire(&db->id), dr->getdesc_arg);
+	if (!desc) {
+		/*
+		 * The data block @id is invalid. The data block is either in
+		 * use by the writer (@id not yet set) or has already been
+		 * invalidated by another task and the data array area or
+		 * descriptor have already been recycled. The latter case
+		 * (descriptor already recycled) relies on the implementation
+		 * of getdesc(), which, when using an smp_rmb(), must allow
+		 * this task to see @tail_lpos as it was visible to the task
+		 * that changed the ID-to-descriptor mapping. See the
+		 * implementation of getdesc() for details.
+		 */
+		goto out;
+	}
+
+	/*
+	 * dC:
+	 *
+	 * Even though the data block @id was determined to be valid, it is
+	 * possible that it is a data block recently made available and @id
+	 * has not yet been initialized. The @id needs to be re-validated (dF)
+	 * after checking if the descriptor points to the data block. Use
+	 * _acquire() to ensure that the re-loading of @id occurs after
+	 * loading @begin_lpos. This pairs with the _release() in
+	 * dataring_push(). See fG for details.
+	 */
+	begin_lpos = smp_load_acquire(&desc->begin_lpos);
+
+	if (begin_lpos != tail_lpos) {
+		/*
+		 * @desc is not describing the data block at @tail_lpos. Since
+		 * a data block and its descriptor always become valid before
+		 * @id is set (see dB for details) the data block at
+		 * @tail_lpos has already been invalidated.
+		 */
+		goto out;
+	}
+
+	/* dD: */
+	next_lpos = READ_ONCE(desc->next_lpos);
+
+	if (!_datablock_valid(dr,
+			      /* dE: */
+			      atomic_long_read(&dr->head_lpos),
+			      tail_lpos, begin_lpos, next_lpos)) {
+		/* Another task has already invalidated the data block. */
+		goto out;
+	}
+
+	/* dF: */
+	if (dr->getdesc(READ_ONCE(db->id), dr->getdesc_arg) != desc) {
+		/*
+		 * The data block ID has changed. The rare case of an
+		 * uninitialized @db->id matching the descriptor ID was hit.
+		 * This is a special case and it applies to the failure of the
+		 * previous @id check (dB).
+		 */
+		goto out;
+	}
+
+	/* dG: */
+	new_tail_lpos = atomic_long_cmpxchg_relaxed(&dr->tail_lpos,
+						    begin_lpos, next_lpos);
+	if (new_tail_lpos == begin_lpos)
+		return next_lpos;
+	return new_tail_lpos;
+out:
+	/*
+	 * dH:
+	 *
+	 * Ensure that the updated @tail_lpos is visible if the data block has
+	 * been invalidated. This pairs with the smp_mb() in dataring_push()
+	 * (see fB for details) as well as with the ID synchronization used in
+	 * the getdesc() implementation, which must guarantee that an
+	 * smp_rmb() is sufficient for seeing an updated @tail_lpos (see the
+	 * implementation of getdesc() for details).
+	 */
+	smp_rmb();
+
+	/* dI: */
+	return atomic_long_read(&dr->tail_lpos);
+}
+
+/**
+ * get_new_lpos() - Determine the logical positions of a new data block.
+ *
+ * @dr:             The data ringbuffer to contain the data.
+ *
+ * @size:           The (alignment padded) size of the new data block.
+ *
+ * @begin_lpos_out: A pointer where to set the begin logical position value.
+ *                  This will be the beginning of the data block.
+ *
+ * @next_lpos_out:  A pointer where to set the next logical position value.
+ *                  This value is used to identify the end of the data block.
+ *
+ * Based on the logical position @head_lpos, determine @begin_lpos and
+ * @next_lpos values for a new data block. If the data block would overwrite
+ * the tail data block, this function will invalidate the tail data block,
+ * thus providing itself space for the new data block.
+ *
+ * IMPORTANT: This function can push or see a pushed data ringbuffer tail.
+ * If the caller will be modifying @begin_lpos or @next_lpos of a descriptor
+ * or will be modifying the head, a full memory barrier is required before
+ * doing so.
+ *
+ * Return: true if logical positions were determined, otherwise false.
+ *
+ * This will only fail if it was not possible to invalidate the tail data
+ * block (i.e. the @id of the tail data block was not yet set by its writer).
+ */
+static bool get_new_lpos(struct dataring *dr, unsigned int size,
+			 unsigned long *begin_lpos_out,
+			 unsigned long *next_lpos_out)
+{
+	unsigned long data_begin_lpos;
+	unsigned long new_tail_lpos;
+	unsigned long begin_lpos;
+	unsigned long next_lpos;
+	unsigned long tail_lpos;
+
+	/* eA: #1 */
+	tail_lpos = atomic_long_read(&dr->tail_lpos);
+
+	for (;;) {
+		begin_lpos = atomic_long_read(&dr->head_lpos);
+		data_begin_lpos = begin_lpos;
+
+		for (;;) {
+			next_lpos = data_begin_lpos + size;
+
+			if (next_lpos - tail_lpos > DATA_SIZE(dr)) {
+				/* would overwrite oldest */
+
+				new_tail_lpos = _dataring_pop(dr, tail_lpos);
+				if (new_tail_lpos == tail_lpos)
+					return false;
+				/* eA: #2 */
+				tail_lpos = new_tail_lpos;
+				break;
+			}
+
+			if (DATA_WRAPS(dr, data_begin_lpos) ==
+			    DATA_WRAPS(dr, next_lpos)) {
+				*begin_lpos_out = begin_lpos;
+				*next_lpos_out = next_lpos;
+				return true;
+			}
+
+			data_begin_lpos =
+				DATA_THIS_WRAP_START_LPOS(dr, next_lpos);
+		}
+	}
+}
+
+/**
+ * dataring_push() - Reserve a data block in the data array.
+ *
+ * @dr:   The data ringbuffer to reserve data in.
+ *
+ * @size: The size to reserve.
+ *
+ * @desc: A pointer to a descriptor to store the data block information.
+ *
+ * @id:   The ID of the descriptor to be associated.
+ *        The data block will not be set with @id, but rather initialized with
+ *        a value that is explicitly different than @id. This is to handle the
+ *        case when newly available garbage by chance matches the descriptor
+ *        ID.
+ *
+ * This function expects to move the head pointer forward. If this would
+ * result in overtaking the data array index of the tail, the tail data block
+ * will be invalidated.
+ *
+ * Return: A pointer to the reserved writer data, otherwise NULL.
+ *
+ * This will only fail if it was not possible to invalidate the tail data
+ * block.
+ */
+char *dataring_push(struct dataring *dr, unsigned int size,
+		    struct dr_desc *desc, unsigned long id)
+{
+	unsigned long begin_lpos;
+	unsigned long next_lpos;
+	struct dr_datablock *db;
+	bool ret;
+
+	to_db_size(&size);
+
+	do {
+		/* fA: */
+		ret = get_new_lpos(dr, size, &begin_lpos, &next_lpos);
+
+		/*
+		 * fB:
+		 *
+		 * The data ringbuffer tail may have been pushed (by this or
+		 * any other task). The updated @tail_lpos must be visible to
+		 * all observers before changes to @begin_lpos, @next_lpos, or
+		 * @head_lpos by this task are visible in order to allow other
+		 * tasks to recognize the invalidation of the data blocks.
+		 * This pairs with the smp_rmb() in _dataring_pop() as well as
+		 * any reader task using smp_rmb() to post-validate data that
+		 * has been read from a data block.
+		 *
+		 * Memory barrier involvement:
+		 *
+		 * If dE reads from fE, then dI reads from fA->eA.
+		 * If dC reads from fG, then dI reads from fA->eA.
+		 * If dD reads from fH, then dI reads from fA->eA.
+		 * If mC reads from fH, then mF reads from fA->eA.
+		 *
+		 * Relies on:
+		 *
+		 * FULL MB between fA->eA and fE
+		 *    matching
+		 * RMB between dE and dI
+		 *
+		 * FULL MB between fA->eA and fG
+		 *    matching
+		 * RMB between dC and dI
+		 *
+		 * FULL MB between fA->eA and fH
+		 *    matching
+		 * RMB between dD and dI
+		 *
+		 * FULL MB between fA->eA and fH
+		 *    matching
+		 * RMB between mC and mF
+		 */
+		smp_mb();
+
+		if (!ret) {
+			/*
+			 * Force @desc permanently invalid to minimize risk
+			 * of the descriptor later unexpectedly being
+			 * determined as valid due to overflowing/wrapping of
+			 * @head_lpos. An unaligned @begin_lpos can never
+			 * point to a data block and having the same value
+			 * for @begin_lpos and @next_lpos is also invalid.
+			 */
+
+			/* fC: */
+			WRITE_ONCE(desc->begin_lpos, 1);
+
+			/* fD: */
+			WRITE_ONCE(desc->next_lpos, 1);
+
+			return NULL;
+		}
+	/* fE: */
+	} while (atomic_long_cmpxchg_relaxed(&dr->head_lpos, begin_lpos,
+					     next_lpos) != begin_lpos);
+
+	db = to_datablock(dr, begin_lpos);
+
+	/*
+	 * fF:
+	 *
+	 * @db->id is a garbage value and could possibly match the @id. This
+	 * would be a problem because the data block would be considered
+	 * valid before the writer has finished with it (i.e. before the
+	 * writer has set @id). Force some other ID value.
+	 */
+	WRITE_ONCE(db->id, id - 1);
+
+	/*
+	 * fG:
+	 *
+	 * Ensure that @db->id is initialized to a wrong ID value before
+	 * setting @begin_lpos so that there is no risk of accidentally
+	 * matching a data block to a descriptor before the writer is finished
+	 * with it (i.e. before the writer has set the correct @id). This
+	 * pairs with the _acquire() in _dataring_pop().
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If dC reads from fG, then dF reads from fF.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from fF to fG
+	 *    matching
+	 * ACQUIRE from dC to dF
+	 */
+	smp_store_release(&desc->begin_lpos, begin_lpos);
+
+	/* fH: */
+	WRITE_ONCE(desc->next_lpos, next_lpos);
+
+	/* If this data block wraps, use @data from the content data block. */
+	if (DATA_WRAPS(dr, begin_lpos) != DATA_WRAPS(dr, next_lpos))
+		db = to_datablock(dr, 0);
+
+	return &db->data[0];
+}
+
+/**
+ * dataring_datablock_setid() - Set the @id for a data block.
+ *
+ * @dr:   The data ringbuffer containing the data block.
+ *
+ * @desc: A descriptor of the data block to set the iD of.
+ *
+ * @id:   The ID value to set.
+ *
+ * The data block ID is not a field within @desc, but rather is part of the
+ * data block within the data array (struct dr_datablock). Once this value is
+ * set (and only when it is set), it is possible for the data block to be
+ * invalidated. Upon calling this function, the writer data will be fully
+ * stored in the data ringbuffer. The writer must not perform any operations
+ * on the data block after calling this function.
+ */
+void dataring_datablock_setid(struct dataring *dr, struct dr_desc *desc,
+			      unsigned long id)
+{
+	struct dr_datablock *db;
+
+	db = to_datablock(dr, READ_ONCE(desc->begin_lpos));
+
+	/*
+	 * gA:
+	 *
+	 * Ensure that all information (within the data ringbuffer and the
+	 * descriptor) for the valid data block are visible before allowing
+	 * the data block to be invalidated. This includes all storage of
+	 * writer data for this data block. After this _release() the writer
+	 * is no longer allowed to write to the data block. It pairs with the
+	 * load_acquire() in _dataring_pop(). See dB for details.
+	 */
+	smp_store_release(&db->id, id);
+}
+
+/**
+ * dataring_pop() - Invalidate the tail data block.
+ *
+ * @dr: The data ringbuffer to invalidatd the tail data block in.
+ *
+ * This is a public wrapper for _dataring_pop(). See _dataring_pop() for
+ * more details about this function.
+ *
+ * Return: true if the tail was invalidated, otherwise false.
+ *
+ * This function returns true if it notices the tail was invalidated even if
+ * it was not the task the did the invalidation.
+ */
+bool dataring_pop(struct dataring *dr)
+{
+	unsigned long tail_lpos;
+
+	tail_lpos = atomic_long_read(&dr->tail_lpos);
+
+	return (_dataring_pop(dr, tail_lpos) != tail_lpos);
+}
+
+/**
+ * dataring_getdatablock() - Return the data block of a descriptor.
+ *
+ * @dr:   The data ringbuffer containing the data block.
+ *
+ * @desc: The descriptor to retrieve the data block of.
+ *
+ * @size: A pointer to a variable to set the size of the data block.
+ *        @size will include any alignment padding that may have been added.
+ *
+ * Since datablocks always contain contiguous data, the situation can occur
+ * where there is not enough space at the end of the array for a new data
+ * block. In this situation, two data blocks are created:
+ *
+ * * A "wrapping" data block at the end of the data array.
+ * * A "content" data block at the beginning of the data array.
+ *
+ * In this situation, @desc will contain the beginning logical position of the
+ * wrapping data block and the end logical position of the content data block
+ * Note that the ID is stored in the wrapping data block.
+ *
+ * This function transparently handles wrapping/content data blocks to return
+ * the data block with the data content. Note that @desc->id is a private
+ * field and thus must not be directly accessed by callers. For
+ * wrapping/content data blocks, @desc->id of the content data block is
+ * garbage.
+ *
+ * Return: A pointer to the data block. Also, the variable pointed to by @size
+ *         is set to the size of the data block.
+ */
+struct dr_datablock *dataring_getdatablock(struct dataring *dr,
+					   struct dr_desc *desc, int *size)
+{
+	unsigned long begin_lpos;
+	unsigned long next_lpos;
+
+	begin_lpos = READ_ONCE(desc->begin_lpos);
+	next_lpos = READ_ONCE(desc->next_lpos);
+
+	if (DATA_WRAPS(dr, begin_lpos) == DATA_WRAPS(dr, next_lpos)) {
+		*size = next_lpos - begin_lpos;
+	} else {
+		/* Use the content data block. */
+		*size = DATA_INDEX(dr, next_lpos);
+		begin_lpos = 0;
+	}
+	*size -= sizeof(struct dr_datablock);
+
+	return to_datablock(dr, begin_lpos);
+}
+
+/**
+ * dataring_block_copy() - Copy information referring to a data block.
+ *
+ * @dst: The data block to copy the information to.
+ *
+ * @src: The data block to copy the information from.
+ *
+ * This function only copies the data block information (i.e. begin and
+ * end logical positions for a data block). After calling this function
+ * both descriptors are referring to the same data block.
+ *
+ * This can be useful for tasks that want a local copy of a descriptor
+ * so that validation can be performed without concern of the descriptor
+ * values changing during validation.
+ */
+void dataring_desc_copy(struct dr_desc *dst, struct dr_desc *src)
+{
+	dst->begin_lpos = READ_ONCE(src->begin_lpos);
+	dst->next_lpos = READ_ONCE(src->next_lpos);
+}
diff --git a/kernel/printk/dataring.h b/kernel/printk/dataring.h
new file mode 100644
index 000000000000..346a455a335a
--- /dev/null
+++ b/kernel/printk/dataring.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KERNEL_PRINTK_DATARING_H
+#define _KERNEL_PRINTK_DATARING_H
+
+#include <linux/atomic.h>
+
+/**
+ * struct dr_datablock - A contiguous block of data reserved for a writer.
+ *
+ * @id:   An ID assigned by the writer.
+ *        This has no pre-initialized value. IMPORTANT: The size of this
+ *        field MUST be less than or equal to the alignment padding used by
+ *	  ALIGN() in to_db_size() and @id must be located at the beginning of
+ *        the structure.
+ *
+ * @data: The writer data.
+ *
+ * A pointer to the beginning of a data block can be directly typecasted to
+ * this structure to access the data block fields and their content.
+ */
+struct dr_datablock {
+	/* private */
+	unsigned long	id;
+
+	/* public */
+	char		data[0];
+};
+
+/**
+ * struct dr_desc - Meta data describing a data block.
+ *
+ * @begin_lpos: The logical position of the beginning of the data block.
+ *              The array index can be derived from the logical position.
+ *
+ * @next_lpos:  The logical position of the next data block.
+ *              This is the @begin_lpos of the adjacent data block and is used
+ *              to determine the size of the data block being described.
+ */
+struct dr_desc {
+	/* private */
+	unsigned long	begin_lpos;
+	unsigned long	next_lpos;
+};
+
+/**
+ * struct dataring - A data ringbuffer with support for entry IDs.
+ *
+ * @size_bits:   The power-of-2 size of the ringbuffer's data array.
+ *
+ * @data:        A pointer to the ringbuffer's data array.
+ *
+ * @head_lpos:   The @next_lpos value of the most recently pushed data block.
+ *               The array index can be derived from the logical position.
+ *
+ * @tail_lpos:   The @begin_lpos value of the oldest data block.
+ *               The array index can be derived from the logical position.
+ *
+ * @getdesc:     A callback function to get a descriptor for a data block.
+ *               IMPORTANT: The lookup must be implemented in such a way to
+ *               ensure that if the ID of a descriptor has been updated, any
+ *               changed data ringbuffer and descriptor fields can be
+ *               synchronized using a pairing smp_rmb().
+ *
+ * @getdesc_arg: An argument that will be passed to the getdesc() callback.
+ *
+ * IDs are used in order to get a descriptor given an ID. It is the
+ * responsibility of the user to implement this functionality via
+ * dataring_datablock_setid() and dataring.getdesc().
+ */
+struct dataring {
+	/* private */
+	unsigned int	size_bits;
+	char		*data;
+	atomic_long_t	head_lpos;
+	atomic_long_t	tail_lpos;
+
+	struct dr_desc *(*getdesc)(unsigned long id, void *arg);
+	void		*getdesc_arg;
+};
+
+bool dataring_checksize(struct dataring *dr, unsigned int size);
+
+bool dataring_pop(struct dataring *dr);
+char *dataring_push(struct dataring *dr, unsigned int size,
+		    struct dr_desc *desc, unsigned long id);
+
+void dataring_datablock_setid(struct dataring *dr, struct dr_desc *desc,
+			      unsigned long id);
+struct dr_datablock *dataring_getdatablock(struct dataring *dr,
+					   struct dr_desc *desc, int *size);
+bool dataring_datablock_isvalid(struct dataring *dr, struct dr_desc *desc);
+void dataring_desc_copy(struct dr_desc *dst, struct dr_desc *src);
+
+#endif /* _KERNEL_PRINTK_DATARING_H */
diff --git a/kernel/printk/numlist.c b/kernel/printk/numlist.c
new file mode 100644
index 000000000000..df3f89e7f7fd
--- /dev/null
+++ b/kernel/printk/numlist.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/sched.h>
+#include "numlist.h"
+
+/**
+ * DOC: numlist overview
+ *
+ * A numlist is a lockless FIFO queue list, where the nodes of the list are
+ * sequentially numbered. A numlist can be iterated over by non-consuming
+ * readers. The purpose of the sequence numbers is so that a non-consuming
+ * reader can identify if it has missed nodes (for example, if they were
+ * popped off the list before the non-consuming reader could finish reading
+ * them).
+ *
+ * IDs vs. Pointers
+ * ----------------
+ * Rather than nodes being linked by pointers, each node is given an ID and
+ * has the ID of the next node in the list. IDs are used in order to avoid an
+ * ABA problem between writers when assigning sequence numbers.
+ *
+ * The ABA problem using pointers can be seen if the list has one node and
+ * while CPU0 is adding a second node another CPU adds and removes nodes
+ * (recycling the node that CPU0 saw as the head)::
+ *
+ *	CPU0                          CPU1
+ *	----                          ----
+ *	(enter numlist_push())
+ *	head = READ_ONCE(h->head);
+ *	seq = READ_ONCE(head->seq);
+ *	WRITE_ONCE(n->seq, seq + 1);
+ *	WRITE_ONCE(n->next, NULL);
+ *	                              numlist_push(); // add some node
+ *	                              numlist_pop();  // remove "head"
+ *	                              numlist_push(); // re-add "head"
+ *	cmpxchg(&h->head, head, n);
+ *	WRITE_ONCE(head->next, n);
+ *	(exit numlist_push())
+ *
+ * Let the original head have a sequence number of 1. Then after the above
+ * scenario the list nodes could have the following sequence numbers::
+ *
+ *	1 -> 2 -> 3 -> 2
+ *
+ * The problem is that the cmpxchg() is succeeding even though the head that
+ * CPU0 wants to replace is not the head it expects. This problem is avoided
+ * by using IDs, which indirectly provide tagged state references for the
+ * nodes. The number of tagged states per node is::
+ *
+ *	sizeof(long) / max number of nodes in the list
+ *
+ * Using IDs instead of pointers, the cmpxchg() will fail as it should.
+ *
+ * Numlist users are required to implement a function to map ID values to
+ * numlist nodes and are responsible for issuing IDs to numlist nodes.
+ *
+ * Behavior
+ * --------
+ * A numbered list has two conditions in order to pop the tail node from the
+ * list:
+ *
+ * * The tail node is not the only node on the list.
+ * * The tail node is not busy.
+ *
+ * The first condition is necessary to support writers adding new nodes to the
+ * list. Such writers must modify the "next pointer" of the previous head,
+ * which becomes complex/racey if that previous head could be removed from the
+ * list and recycled during the update. One consequence of this condition is
+ * that numbered lists must be initialized such that the tail and head are
+ * already pointing to a node.
+ *
+ * For the second condition, the term "busy" is defined by the user, who must
+ * implement a function to report if a node is busy. This gives the user
+ * control to decide if a node can be removed from the list.
+ *
+ * For non-consuming readers, the function numlist_read() needs to be called a
+ * second time after reading node data to ensure the node is still valid.
+ * Nodes can become invalid while being read by non-consuming readers.
+ */
+
+/**
+ * numlist_read() - Read the information stored within a node.
+ *
+ * @nl:      The numbered list to use.
+ *
+ * @id:      The ID of the node to read from.
+ *
+ * @seq:     A pointer to a variable to store the sequence number of the node.
+ *           This may be NULL if the caller is not interested in this value.
+ *
+ * @next_id: A pointer to a variable to store the next node ID in the list.
+ *           This may be NULL if the caller is not interested in this value.
+ *           If this function stores the node's own ID to @next_id, this is
+ *           the last node on the list. Note that a node does not know its own
+ *           ID. It is up to the caller to track the node IDs during
+ *           traversal.
+ *
+ * This function can be used to read node contents for both a node that is
+ * part of a list or a node that is off-list. (Although, from this function it
+ * is not possible to identify if the node is part of a list.)
+ *
+ * Readers should call this function a second time after reading node data to
+ * ensure the node is still valid because it may have become invalid while the
+ * reader was reading the data.
+ *
+ * Return: true if the node was read, otherwise false.
+ *
+ * This function will fail if @id is not valid anytime during this function.
+ */
+bool numlist_read(struct numlist *nl, unsigned long id, unsigned long *seq,
+		  unsigned long *next_id)
+{
+	struct nl_node *n;
+
+	n = nl->node(id, nl->node_arg);
+	if (!n)
+		return false;
+
+	if (seq) {
+		/*
+		 * aA:
+		 *
+		 * Adresss dependency on @id.
+		 */
+		*seq = READ_ONCE(n->seq);
+	}
+
+	if (next_id) {
+		/*
+		 * aB:
+		 *
+		 * Adresss dependency on @id.
+		 */
+		*next_id = READ_ONCE(n->next_id);
+	}
+
+	/*
+	 * aC:
+	 *
+	 * Validate @seq and @next_id by making sure the node has not been
+	 * recycled. This pairs with the smp_wmb() of the function that
+	 * updates the ID, which is required to issue an smp_wmb() after
+	 * updating the ID and before modifying fields of the node. See the
+	 * smp_wmb() in prb_reserve() for details.
+	 */
+	smp_rmb();
+
+	return (nl->node(id, nl->node_arg) != NULL);
+}
+
+/**
+ * numlist_read_tail() - Read the oldest node.
+ *
+ * @nl:      The numbered list to use.
+ *
+ * @seq:     A pointer to a variable to store the sequence number of the node.
+ *           This may be NULL if the caller is not interested in this value.
+ *
+ * @next_id: A pointer to a variable to store the next node ID in the list.
+ *           This may be NULL if the caller is not interested in this value.
+ *
+ * This function will not return until it has successfully read the tail
+ * node.
+ *
+ * Return: The ID of the tail node.
+ */
+unsigned long numlist_read_tail(struct numlist *nl, unsigned long *seq,
+				unsigned long *next_id)
+{
+	unsigned long tail_id;
+
+	tail_id = atomic_long_read(&nl->tail_id);
+
+	while (!numlist_read(nl, tail_id, seq, next_id)) {
+		/* @tail_id is invalid. Try again with an updated value. */
+
+		cpu_relax();
+
+		tail_id = atomic_long_read(&nl->tail_id);
+	}
+
+	return tail_id;
+}
+
+/**
+ * numlist_push() - Add a node to the list and assign it a sequence number.
+ *
+ * @nl: The numbered list to push to.
+ *
+ * @n:  A node to push to the numbered list.
+ *      The node must not already be part of a list.
+ *
+ * @id: The ID of the node.
+ *
+ * A node is added in two steps: The first step is to make this node the
+ * head, which causes a following push to add to this node. The second step is
+ * to update @next_id of the former head node to point to this one, which
+ * makes this node visible to any task that sees the former head node.
+ */
+void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id)
+{
+	unsigned long head_id;
+	unsigned long seq;
+	unsigned long r;
+
+	/*
+	 * bA:
+	 *
+	 * Setup the node to be a list terminator: next_id == id.
+	 */
+	WRITE_ONCE(n->next_id, id);
+
+	/* bB: #1 */
+	head_id = atomic_long_read(&nl->head_id);
+
+	for (;;) {
+		/* bC: */
+		while (!numlist_read(nl, head_id, &seq, NULL)) {
+			/*
+			 * @head_id is invalid. Try again with an
+			 * updated value.
+			 */
+
+			cpu_relax();
+
+			/* bB: #2 */
+			head_id = atomic_long_read(&nl->head_id);
+		}
+
+		/*
+		 * bD:
+		 *
+		 * Set @seq to +1 of @seq from the previous head.
+		 *
+		 * Memory barrier involvement:
+		 *
+		 * If bB reads from bE, then bC->aA reads from bD.
+		 *
+		 * Relies on:
+		 *
+		 * RELEASE from bD to bE
+		 *    matching
+		 * ADDRESS DEP. from bB to bC->aA
+		 */
+		WRITE_ONCE(n->seq, seq + 1);
+
+		/*
+		 * bE:
+		 *
+		 * This store_release() guarantees that @seq and @next are
+		 * stored before the node with @id is visible to any popping
+		 * writers. It pairs with the address dependency between @id
+		 * and @seq/@next provided by numlist_read(). See bD and bF
+		 * for details.
+		 */
+		r = atomic_long_cmpxchg_release(&nl->head_id, head_id, id);
+		if (r == head_id)
+			break;
+
+		/* bB: #3 */
+		head_id = r;
+	}
+
+	n = nl->node(head_id, nl->node_arg);
+
+	/*
+	 * The old head (which is still the list terminator), cannot be
+	 * removed because the list will always have at least one node.
+	 * Therefore @n must be non-NULL.
+	 */
+
+	/*
+	 * bF: the STORE part for @next_id
+	 *
+	 * Set @next_id of the previous head to @id.
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If bB reads from bE, then bF overwrites bA.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from bA to bE
+	 *    matching
+	 * ADDRESS DEP. from bB to bF
+	 */
+	/*
+	 * bG: the RELEASE part for @next_id
+	 *
+	 * This _release() guarantees that a reader will see the updates to
+	 * this node's @seq/@next_id if the reader saw the @next_id of the
+	 * previous node in the list. It pairs with the address dependency
+	 * between @id and @seq/@next provided by numlist_read().
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If aB reads from bG, then aA' reads from bD, where aA' is in
+	 * numlist_read() to read the node ID from bG.
+	 * If aB reads from bG, then aB' reads from bA, where aB' is in
+	 * numlist_read() to read the node ID from bG.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from bG to bD
+	 *    matching
+	 * ADDRESS DEP. from aB to aA'
+	 *
+	 * RELEASE from bG to bA
+	 *    matching
+	 * ADDRESS DEP. from aB to aB'
+	 */
+	smp_store_release(&n->next_id, id);
+}
+
+/**
+ * numlist_pop() - Remove the oldest node from the list.
+ *
+ * @nl: The numbered list from which to remove the tail node.
+ *
+ * The tail node can only be removed if two conditions are satisfied:
+ *
+ * * The node is not the only node on the list.
+ * * The node is not busy.
+ *
+ * If, during this function, another task removes the tail, this function
+ * will try again with the new tail.
+ *
+ * Return: The removed node or NULL if the tail node cannot be removed.
+ */
+struct nl_node *numlist_pop(struct numlist *nl)
+{
+	unsigned long tail_id;
+	unsigned long next_id;
+	unsigned long r;
+
+	/* cA: #1 */
+	tail_id = atomic_long_read(&nl->tail_id);
+
+	for (;;) {
+		/* cB */
+		while (!numlist_read(nl, tail_id, NULL, &next_id)) {
+			/*
+			 * @tail_id is invalid. Try again with an
+			 * updated value.
+			 */
+
+			cpu_relax();
+
+			/* cA: #2 */
+			tail_id = atomic_long_read(&nl->tail_id);
+		}
+
+		/* Make sure the node is not the only node on the list. */
+		if (next_id == tail_id)
+			return NULL;
+
+		/*
+		 * cC:
+		 *
+		 * Make sure the node is not busy.
+		 */
+		if (nl->busy(tail_id, nl->busy_arg))
+			return NULL;
+
+		r = atomic_long_cmpxchg_relaxed(&nl->tail_id,
+						tail_id, next_id);
+		if (r == tail_id)
+			break;
+
+		/* cA: #3 */
+		tail_id = r;
+	}
+
+	return nl->node(tail_id, nl->node_arg);
+}
diff --git a/kernel/printk/numlist.h b/kernel/printk/numlist.h
new file mode 100644
index 000000000000..cdc3b21e6597
--- /dev/null
+++ b/kernel/printk/numlist.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KERNEL_PRINTK_NUMLIST_H
+#define _KERNEL_PRINTK_NUMLIST_H
+
+#include <linux/atomic.h>
+
+/**
+ * struct nl_node - A node of a numbered list.
+ *
+ * @seq:     The sequence number assigned to this node.
+ *
+ * @next_id: The ID of the next node of the numbered list.
+ *           If this is the node's own ID, this is the last node on the list.
+ *           Note that a node does not know its own ID. It is up to the caller
+ *           to track the node IDs during traversal.
+ *
+ * The fields are private and must not be directly accessed by users.
+ * numlist_read() is available for users to access these fields.
+ */
+struct nl_node {
+	/* private */
+	unsigned long	seq;
+	unsigned long	next_id;
+};
+
+/**
+ * struct numlist - A numbered list of nodes.
+ *
+ * @head_id:  The ID of the most recently pushed node.
+ *            Disregarding overflow, this node will have the highest sequence
+ *            number.
+ *
+ * @tail_id:  The ID of the oldest node.
+ *            Disregarding overflow, this node will have the lowest sequence
+ *            number.
+ *
+ * @node:     A callback function to get a node for an ID.
+ *            IDs must be implemented such that an smp_wmb() is issued after
+ *            the ID of a node has been modified and before any further
+ *            changes to the node are performed.
+ *
+ * @node_arg: An argument that will be passed to the node() callback.
+ *
+ * @busy:     A callback function to determine if a node can be removed.
+ *            Nodes that are "busy" will not be removed.
+ *
+ * @busy_arg: An argument that will be passed to the busy() callback.
+ *
+ * List nodes are sorted by their sequence numbers.
+ */
+struct numlist {
+	/* private */
+	atomic_long_t	head_id;
+	atomic_long_t	tail_id;
+
+	struct nl_node *(*node)(unsigned long id, void *arg);
+	void		*node_arg;
+
+	bool (*busy)(unsigned long id, void *arg);
+	void		*busy_arg;
+};
+
+void numlist_push(struct numlist *nl, struct nl_node *n, unsigned long id);
+struct nl_node *numlist_pop(struct numlist *nl);
+
+unsigned long numlist_read_tail(struct numlist *nl, unsigned long *seq,
+				unsigned long *next_id);
+bool numlist_read(struct numlist *nl, unsigned long id, unsigned long *seq,
+		  unsigned long *next_id);
+
+#endif /* _KERNEL_PRINTK_NUMLIST_H */
diff --git a/kernel/printk/ringbuffer.c b/kernel/printk/ringbuffer.c
new file mode 100644
index 000000000000..59bf59aba3de
--- /dev/null
+++ b/kernel/printk/ringbuffer.c
@@ -0,0 +1,800 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/irqflags.h>
+#include <linux/string.h>
+#include <linux/err.h>
+#include "ringbuffer.h"
+
+/**
+ * DOC: prb overview
+ *
+ * As the name suggests, this ringbuffer was implemented specifically to
+ * serve the needs of the printk() infrastructure. The ringbuffer itself is
+ * not specific to printk and could be used for other purposes. However, the
+ * requirements and semantics of printk are rather unique. If you intend to
+ * use this ringbuffer for anything other than printk, you need to be very
+ * clear on its features, behavior, and limitations.
+ *
+ * Features
+ * --------
+ * * single global buffer
+ * * resides in initialized data section (available at early boot)
+ * * supports multiple concurrent lockless readers and writers
+ * * safe from any context (including NMI)
+ * * groups bytes into variable length data blocks (referenced by entries)
+ * * entries tagged with sequence numbers
+ *
+ * Terminology
+ * -----------
+ * * data block: A contiguous block of data containing an ID of an associated
+ *               descriptor and the raw data from the writer.
+ *
+ * * descriptor: Meta data for a data block containing an ID, the logical
+ *               positions of the associated data block, a unique sequence
+ *               number, and a pointer to the next (newer) descriptor.
+ *
+ * * entry:      A high level object used by the readers/writers that contains
+ *               a descriptor as well as state information during the
+ *               reserve/commit window.
+ *
+ * Data Structure
+ * --------------
+ * The ringbuffer implementation makes use of two internal data structures:
+ *
+ * * a data ringbuffer (dataring) to manage the raw data storage of entries
+ *
+ * * a numbered list (numlist) to sort and sequentially label committed
+ *   entries
+ *
+ * Both dataring and numlist implementations make use of ID numbers to
+ * identify their entities. The ringbuffer implementation creates and manages
+ * those IDs using the same value for all data structures (i.e. ID=22 for a
+ * dataring data block and descriptor corresponds to ID=22 for the numlist
+ * node.)
+ *
+ * The ringbuffer implementation provides a high-level descriptor (prb_desc).
+ * This descriptor contains the ID, a dataring descriptor, and a numlist node,
+ * thus acting as the unifying entity for the various data structures.
+ *
+ * The descriptors are stored within a static array and IDs map directly to
+ * array offsets. The full range of IDs (unsigned long) is used in order to
+ * provide tagged state references for the descriptors to avoid ABA issues
+ * when the descriptors are recycled. The number of tagged states per
+ * descriptor is::
+ *
+ *	sizeof(long) / number of descriptors in the array
+ *
+ * Behavior
+ * --------
+ * Since the printk ringbuffer is lockless, there exists no synchronization
+ * between readers and writers. Basically writers are the tasks in control and
+ * may overwrite any and all committed data at any time and from any context.
+ * For this reason readers can miss entries if they are overwritten before the
+ * reader was able to access the data. The reader API implementation is such
+ * that reader access to data is atomic, so there is no risk of readers having
+ * to deal with partial or corrupt data blocks. Also, entries include the
+ * sequence number of the associated descriptor so that readers can recognize
+ * if entries were missed.
+ *
+ * Writing to the ringbuffer consists of two steps:
+ *
+ * (1) Reserve data (prb_reserve()).
+ * (2) Commit the reserved data (prb_commit()).
+ *
+ * The sequence number is assigned on commit.
+ *
+ * Once committed, a writer must no longer access the data directly. This is
+ * because the data may have been overwritten and no longer exists. If a
+ * writer must access the data, it should either keep a private copy before
+ * committing or use the reader API to gain access to the data.
+ *
+ * Because of how the data backend (dataring) is implemented, data blocks that
+ * have been reserved but not yet committed act as blockers, preventing future
+ * writers from filling the ringbuffer beyond the location of the reserved but
+ * not yet committed data block region. For this reason it is important that
+ * writers perform both reserve and commit as quickly as possible. To assist
+ * with this, local interrupts are disabled during the reserve/commit window.
+ * Writers in NMI contexts can still preempt any other writers, but as long
+ * as these writers do not write a large amount of data with respect to the
+ * ringbuffer size, this should not become an issue.
+ *
+ * The reader API provides an iterator to traverse the list of committed
+ * entries. The iterator utilizes a user-provided entry buffer to copy into
+ * and validate the entry data upon traversal.
+ *
+ * Entry Lifecycle
+ * ---------------
+ * This is an overview of the lifecycle for an entry. It is meant to assist in
+ * understanding how the various data structures and their procedures are
+ * coordinated. Following is what happens within the reserve/commit window of
+ * a writer:
+ *
+ * (1) Reserve a descriptor (part 1 of 3): Invalidate the oldest data block by
+ *     moving the dataring tail forward. (See the next step for why this was
+ *     necessary.)
+ *
+ * (2) Reserve a descriptor (part 2 of 3): Remove the oldest descriptor from
+ *     the committed list by removing the numlist tail. (Note that
+ *     descriptors can only be removed if their associated data block is
+ *     invalid. That invalidation was performed in the previous step.)
+ *
+ * (3) Reserve a descriptor (part 3 of 3): Invalidate the removed descriptor
+ *     by modifying its ID.
+ *
+ * (4) Reserve data: Reserve a new data block by moving the dataring head
+ *     forward.
+ *
+ * (5) Write data: Write the user data into the reserved data block.
+ *
+ * (6) Commit the data: Set the descriptor ID in the reserved data block.
+ *
+ * (7) Commit the descriptor (part 1 of 2): Add the descriptor to the
+ *     committed list by setting it as the numlist head.
+ *
+ * (8) Commit the descriptor (part 2 of 2): Link the descriptor to the older
+ *     committed entries by setting it as the "next pointer" of the former
+ *     numlist head.
+ *
+ * Usage
+ * -----
+ * Here are some simple examples demonstrating writers and readers. For the
+ * examples it is assumed that a global ringbuffer is available::
+ *
+ *	DECLARE_PRINTKRB(rb, 5, 7);
+ *
+ * This ringbuffer has a size of 4096 bytes, expects an average data size of
+ * 32 bytes, and allows up to 128 descriptors.
+ *
+ * Sample writer code::
+ *
+ *	struct prb_reserved_entry e;
+ *	char *s;
+ *
+ *	s = prb_reserve(&e, &rb, 16);
+ *	if (s) {
+ *		snprintf(s, 16, "Hello, world!");
+ *		prb_commit(&e);
+ *	}
+ *
+ * Sample reader code::
+ *
+ *	DECLARE_PRINTKRB_ENTRY(e, 64);
+ *	struct prb_iterator iter;
+ *	u64 last_seq = 0;
+ *	int len;
+ *	char *s;
+ *
+ *	prb_for_each_entry(&iter, &rb, &e, len) {
+ *		if (e.seq - last_seq != 1) {
+ *			pr_warn("LOST %llu ENTRIES\n",
+ *				e.seq - (last_seq + 1));
+ *		}
+ *		last_seq = e.seq;
+ *
+ *		s = (char *)&e.buffer[0];
+ *		if (len >= 64) {
+ *			pr_warn("ENTRY %llu TRUNCATED\n", e.seq);
+ *			s[64 - 1] = 0;
+ *		}
+ *		pr_info("%llu: %s\n", e.seq, s);
+ *	}
+ */
+
+#define DESCS_COUNT(rb) (1 << (rb)->desc_count_bits)
+#define DESCS_COUNT_MASK(rb) (DESCS_COUNT(rb) - 1)
+
+/**
+ * to_desc() - Translate an ID to a descriptor.
+ *
+ * @rb: The ringbuffer containing the descriptor.
+ *
+ * @id: An ID value to translate.
+ *
+ * This is a low-level function to provide a safe mapping that always maps
+ * to a descriptor. Callers are responsible for checking the ID of the
+ * returned descriptor to see if the mapping was correct.
+ *
+ * Return: A pointer to a descriptor.
+ */
+static struct prb_desc *to_desc(struct printk_ringbuffer *rb,
+				unsigned long id)
+{
+	return &rb->descs[id & DESCS_COUNT_MASK(rb)];
+}
+
+/**
+ * prb_desc_node() - Numbered list callback to lookup a node from an ID.
+ *
+ * @id:  The ID to lookup.
+ *
+ * @arg: The ringbuffer containing the numlist the node belongs to.
+ *
+ * Return: A pointer to the node or NULL if the ID is unknown.
+ *
+ * The returned pointer has an address dependency to @id.
+ */
+struct nl_node *prb_desc_node(unsigned long id, void *arg)
+{
+	struct prb_desc *d = to_desc(arg, id);
+
+	if (id != atomic_long_read(&d->id))
+		return NULL;
+
+	return &d->list;
+}
+
+/**
+ * prb_desc_busy() - Numbered list callback to report if a node is busy.
+ *
+ * @id:  The ID of the node to check.
+ *
+ * @arg: The ringbuffer containing the numlist the node belongs to.
+ *
+ * This callback is used by numbered lists to determine if a node can be
+ * removed from the committed list. A descriptor is considered busy if the
+ * data block it references is valid. Data blocks must be invalidated before
+ * descriptors can be recycled.
+ *
+ * Return: true if the descriptor's data block is valid, otherwise false.
+ *
+ * If the specified ID is unknown, the (unknown) descriptor is reported as
+ * not busy.
+ */
+bool prb_desc_busy(unsigned long id, void *arg)
+{
+	struct printk_ringbuffer *rb = arg;
+	struct prb_desc *d = to_desc(rb, id);
+
+	/* hA: */
+	if (!dataring_datablock_isvalid(&rb->dr, &d->desc))
+		return false;
+
+	/*
+	 * hB:
+	 *
+	 * Ensure that the data block that was just checked belongs to the
+	 * expected descriptor. Writers modify the descriptor ID before making
+	 * any other changes to the data block or descriptor. This pairs with
+	 * smp_wmb() in prb_reserve(). See kB for details.
+	 */
+	smp_rmb();
+
+	/* hC: */
+	return (id == atomic_long_read(&d->id));
+}
+
+/**
+ * prb_getdesc() - Data ringbuffer callback to lookup a descriptor from an ID.
+ *
+ * @id:  The ID to lookup.
+ *
+ * @arg: The ringbuffer containing the dataring the descriptor belongs to.
+ *
+ * The data ringbuffer requires that the caller, by issuing an smp_rmb()
+ * after this function, will see data ringbuffer updates that were visible to
+ * the task that last updated the ID.
+ *
+ * Return: A pointer to the dataring descriptor or NULL if the ID is unknown.
+ *
+ * The returned pointer has an address dependency to @id.
+ */
+struct dr_desc *prb_getdesc(unsigned long id, void *arg)
+{
+	struct prb_desc *d = to_desc(arg, id);
+
+	/*
+	 * iA:
+	 *
+	 * Since the values of @id correspond to the values of @d->id, it is
+	 * enough that the ID updating task performs a _release() in
+	 * assign_desc(). The smp_rmb() issued by the caller after calling
+	 * this function pairs with that _release(). See jB for details.
+	 */
+	if (id != atomic_long_read(&d->id))
+		return NULL;
+
+	/* iB: */
+	return &d->desc;
+}
+
+/**
+ * assign_desc() - Assign a descriptor to the caller.
+ *
+ * @e: The entry structure to store the assigned descriptor to.
+ *
+ * Find an available descriptor to assign to the caller. First it is checked
+ * if the tail descriptor from the committed list can be recycled. If not,
+ * perhaps a never-used descriptor is available. Otherwise, data blocks will
+ * be invalidated until the tail descriptor from the committed list can be
+ * recycled.
+ *
+ * Assigned descriptors are invalid until data has been reserved for them.
+ *
+ * Return: true if a descriptor was assigned, otherwise false.
+ *
+ * This will only fail if it was not possible to invalidate data blocks in
+ * order to recycle a descriptor. This can happen if a writer has reserved but
+ * not yet committed data and that reserved data is currently the oldest data.
+ */
+static bool assign_desc(struct prb_reserved_entry *e)
+{
+	struct printk_ringbuffer *rb = e->rb;
+	struct prb_desc *d;
+	struct nl_node *n;
+	unsigned long i;
+
+	for (;;) {
+		/*
+		 * jA:
+		 *
+		 * Try to recycle a descriptor on the committed list.
+		 */
+		n = numlist_pop(&rb->nl);
+		if (n) {
+			d = container_of(n, struct prb_desc, list);
+			break;
+		}
+
+		/* Fallback to static never-used descriptors. */
+		if (atomic_read(&rb->desc_next_unused) < DESCS_COUNT(rb)) {
+			i = atomic_fetch_inc(&rb->desc_next_unused);
+			if (i < DESCS_COUNT(rb)) {
+				d = &rb->descs[i];
+				atomic_long_set(&d->id, i);
+				break;
+			}
+		}
+
+		/*
+		 * No descriptor available. Make one available for recycling
+		 * by invalidating data (which some descriptor will be
+		 * referencing).
+		 */
+		if (!dataring_pop(&rb->dr))
+			return false;
+	}
+
+	/*
+	 * jB:
+	 *
+	 * Modify the descriptor ID so that users of the descriptor see that
+	 * it has been recycled. A _release() is used so that prb_getdesc()
+	 * callers can see all data ringbuffer updates after issuing a
+	 * pairing smb_rmb(). See iA for details.
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If dB->iA reads from jB, then dI reads the same value as
+	 * jA->cD->hA.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from jA->cD->hA to jB
+	 *    matching
+	 * RMB between dB->iA and dI
+	 */
+	atomic_long_set_release(&d->id, atomic_long_read(&d->id) +
+				DESCS_COUNT(rb));
+
+	e->desc = d;
+	return true;
+}
+
+/**
+ * prb_reserve() - Reserve data in the ringbuffer.
+ *
+ * @e:    The entry structure to setup.
+ *
+ * @rb:   The ringbuffer to reserve data in.
+ *
+ * @size: The size of the data to reserve.
+ *
+ * This is the public function available to writers to reserve data.
+ *
+ * Context: Any context. Disables local interrupts on success.
+ * Return: A pointer to the reserved data or an ERR_PTR if data could not be
+ *         reserved.
+ *
+ * If the provided size is legal, this will only fail if it was not possible
+ * to invalidate the oldest data block. This can happen if a writer has
+ * reserved but not yet committed data and that reserved data is currently
+ * the oldest data.
+ *
+ * The ERR_PTR values and their meaning:
+ *
+ * * -EINVAL: illegal @size value
+ * * -EBUSY:  failed to reserve a descriptor (@fail count incremented)
+ * * -ENOMEM: failed to reserve data (invalid descriptor committed)
+ */
+char *prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
+		  unsigned int size)
+{
+	struct prb_desc *d;
+	unsigned long id;
+	char *buf;
+
+	if (!dataring_checksize(&rb->dr, size))
+		return ERR_PTR(-EINVAL);
+
+	e->rb = rb;
+
+	/*
+	 * Disable interrupts during the reserve/commit window in order to
+	 * minimize the number of reserved but not yet committed data blocks
+	 * in the data ringbuffer. Although such data blocks are not bad per
+	 * se, they act as blockers for writers once the data ringbuffer has
+	 * wrapped back to them.
+	 */
+	local_irq_save(e->irqflags);
+
+	/* kA: */
+	if (!assign_desc(e)) {
+		/* Failures to reserve descriptors are counted. */
+		atomic_long_inc(&rb->fail);
+		buf = ERR_PTR(-EBUSY);
+		goto err_out;
+	}
+
+	d = e->desc;
+
+	/*
+	 * kB:
+	 *
+	 * The descriptor ID has been updated so that its users can see that
+	 * it is now invalid. Issue an smp_wmb() so that upcoming changes to
+	 * the descriptor will not be associated with the old descriptor ID.
+	 * This pairs with the smp_rmb() of prb_desc_busy() (see hB for
+	 * details) and the smp_rmb() within numlist_read() and the smp_rmb()
+	 * of prb_iter_next_valid_entry() (see mD for details).
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If hA reads from kC, then hC reads from jB.
+	 * If mC reads from kC, then mE reads from jB.
+	 *
+	 * Relies on:
+	 *
+	 * WMB between jB and kC
+	 *    matching
+	 * RMB between hA and hC
+	 *
+	 * WMB between jB and kC
+	 *    matching
+	 * RMB between mC and mE
+	 */
+	smp_wmb();
+
+	id = atomic_long_read(&d->id);
+
+	/* kC: */
+	buf = dataring_push(&rb->dr, size, &d->desc, id);
+	if (!buf) {
+		/* Put the invalid descriptor on the committed list. */
+		numlist_push(&rb->nl, &d->list, id);
+		buf = ERR_PTR(-ENOMEM);
+		goto err_out;
+	}
+
+	return buf;
+err_out:
+	local_irq_restore(e->irqflags);
+	return buf;
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
+	struct printk_ringbuffer *rb = e->rb;
+	struct prb_desc *d = e->desc;
+	unsigned long id;
+
+	id = atomic_long_read(&d->id);
+
+	/*
+	 * lA:
+	 *
+	 * Commit all writer data to the data ringbuffer. By setting the ID,
+	 * the data will be available for invalidation.
+	 */
+	dataring_datablock_setid(&rb->dr, &d->desc, id);
+
+	/*
+	 * lB:
+	 *
+	 * Add the descriptor to the committed list. Then it will be visible
+	 * to readers and popping writers (as long as all preceding
+	 * descriptors have also completed the numlist_push() call).
+	 */
+	numlist_push(&rb->nl, &d->list, id);
+
+	/* The reserve/commit window is closed. Re-enable interrupts. */
+	local_irq_restore(e->irqflags);
+}
+EXPORT_SYMBOL(prb_commit);
+
+/**
+ * prb_iter_init() - Initialize an iterator.
+ *
+ * @iter: The iterator to initialize.
+ *
+ * @rb:   The ringbuffer to associate with the iterator.
+ *
+ * @e:    An entry structure to use during iteration.
+ *
+ * This is the public function available to readers to initialize an iterator.
+ *
+ * As an alternative, DECLARE_PRINTKRB_ITER() can be used.
+ *
+ * The interator is initialized to the beginning of the committed list (the
+ * oldest committed entry).
+ *
+ * Context: Any context.
+ */
+void prb_iter_init(struct prb_iterator *iter, struct printk_ringbuffer *rb,
+		   struct prb_entry *e)
+{
+	iter->rb = rb;
+	iter->e = e;
+
+	iter->last_id = 0;
+	iter->last_seq = 0;
+	iter->next_id = 0;
+}
+EXPORT_SYMBOL(prb_iter_init);
+
+/**
+ * reset_iter() - Reset an iterator to the beginning of the committed list.
+ *
+ * @iter: The iterator to reset.
+ */
+static void reset_iter(struct prb_iterator *iter)
+{
+	unsigned long last_seq;
+
+	iter->next_id = numlist_read_tail(&iter->rb->nl, &last_seq, NULL);
+
+	/* Pretend the entry preceding the oldest entry was last seen. */
+	iter->last_seq = last_seq - 1;
+
+	/*
+	 * @last_id is only significant in EOL situations, when it is equal to
+	 * @next_id and the iterator wants to read the entry after @last_id as
+	 * the next entry. Set @last_id to something other than @next_id. So
+	 * that the iterator will read @next_id as the next entry.
+	 */
+	iter->last_id = iter->next_id - 1;
+}
+
+/**
+ * setup_next() - Prepare an iterator to read the next entry.
+ *
+ * @nl:   The numbered list used for the committed list.
+ *
+ * @iter: The iterator to prepare.
+ *
+ * Evaluate the current state of the iterator and committed list and determine
+ * if and how the iterator can proceed. For example, if the iterator
+ * previously hit the end of the list, there may now be new entries available
+ * for traversing.
+ *
+ * If the last seen entry no longer exists, the iterator is reset to the
+ * beginning of the committed list. The oldest available entry will be newer
+ * than the last seen entry.
+ *
+ * Return: true if a next entry is available for reading, otherwise false.
+ */
+static bool setup_next(struct numlist *nl, struct prb_iterator *iter)
+{
+	unsigned long next;
+
+	if (iter->last_id == iter->next_id) {
+		/* previously hit EOL, check for updated next */
+
+		if (!numlist_read(nl, iter->last_id, NULL, &next))
+			reset_iter(iter);
+		else if (next != iter->next_id)
+			iter->next_id = next;
+		else
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * prb_iter_next_valid_entry() - Traverse to and read the next (newer) entry.
+ *
+ * @iter: The iterator used for list traversal.
+ *
+ * This is the public function available to readers to traverse the committed
+ * entry list.
+ *
+ * If the iterator has not yet been used or has fallen behind and no longer
+ * has a reference to a valid entry, the next read entry will be the oldest
+ * in the committed list (which will be newer than the previously read entry).
+ *
+ * Context: Any context.
+ * Return: The size of the entry data or 0 if there is no next entry.
+ *
+ * The entry data is padded (if necessary) to allow alignment for following
+ * data blocks. Therefore the returned size value can be larger than the size
+ * reserved. If users want the exact size to be tracked, they should include
+ * this information within their data.
+ */
+int prb_iter_next_valid_entry(struct prb_iterator *iter)
+{
+	struct printk_ringbuffer *rb = iter->rb;
+	struct prb_entry *e = iter->e;
+	struct dataring *dr = &rb->dr;
+	struct numlist *nl = &rb->nl;
+	struct dr_datablock *db;
+	unsigned long next_id;
+	struct dr_desc desc;
+	struct prb_desc *d;
+	struct nl_node *n;
+	unsigned long seq;
+	unsigned long id;
+	int size;
+
+	if (!setup_next(nl, iter))
+		return 0;
+
+	for (;;) {
+		id = iter->next_id;
+
+		/* mA: */
+		if (!numlist_read(nl, id, &seq, &next_id)) {
+			/* @id not available */
+			reset_iter(iter);
+			continue;
+		}
+
+		if (seq != iter->last_seq + 1) {
+			/* @seq has an unexpected value */
+			reset_iter(iter);
+			continue;
+		}
+
+		/* mB: */
+		n = prb_desc_node(id, rb);
+		if (!n) {
+			/* @id has become invalid */
+			reset_iter(iter);
+			continue;
+		}
+
+		/* advance iter */
+		iter->last_id = id;
+		iter->last_seq = seq;
+		iter->next_id = next_id;
+
+		d = container_of(n, struct prb_desc, list);
+
+		/* get a local copy to allow non-racey validation */
+		dataring_desc_copy(&desc, &d->desc);
+
+		/* mC: */
+		if (dataring_datablock_isvalid(dr, &desc)) {
+			e->seq = seq;
+
+			db = dataring_getdatablock(dr, &desc, &size);
+			memcpy(&e->buffer[0], &db->data[0],
+			       size > e->buffer_size ? e->buffer_size : size);
+
+			/*
+			 * mD:
+			 *
+			 * Now that the data is copied, re-validate that @id
+			 * and @desc are still valid. For @id validation, this
+			 * pairs with the smp_wmb() in prb_reserve() (see kB
+			 * for details). For @desc validation, this pairs with
+			 * the smp_mb() in dataring_push() (see fB for
+			 * details).
+			 */
+			smp_rmb();
+
+			/* mE: */
+			if (prb_desc_node(id, rb) &&
+			    /* mF: */
+			    dataring_datablock_isvalid(dr, &desc)) {
+				return size;
+			}
+		}
+
+		/* hit EOL? */
+		if (next_id == id)
+			return 0;
+	}
+}
+EXPORT_SYMBOL(prb_iter_next_valid_entry);
+
+/**
+ * prb_iter_sync() - Position an iterator to that of another iterator.
+ *
+ * @dst: The iterator to modify.
+ *
+ * @src: The iterator to sync from.
+ *
+ * This is the public function available to readers to set an iterator to
+ * the position of another iterator. This is particularly useful for making
+ * backup copies of an iterator in case a form of rewinding is needed or if
+ * one iterator should continue where another left off.
+ *
+ * Note that the destination iterator must be previously initialized. The
+ * prb_entry provided during initialization will continue to be used. The
+ * iterator being sync'd from is allowed to be using a different prb_entry.
+ *
+ * Also note that if the iterator being sync'd from is traversing a
+ * different ringbuffer, the modified iterator will now also traverse that
+ * ringbuffer.
+ *
+ * Context: Any context.
+ *
+ * It is safe to call this function from any context and state. But note
+ * that this function is not atomic. Callers must not sync iterators that
+ * can be accessed by other tasks/contexts unless proper synchronization is
+ * used.
+ */
+void prb_iter_sync(struct prb_iterator *dst, struct prb_iterator *src)
+{
+	/* copy everything except the entry buffer */
+
+	dst->rb = src->rb;
+	dst->last_id = src->last_id;
+	dst->last_seq = src->last_seq;
+	dst->next_id = src->next_id;
+}
+EXPORT_SYMBOL(prb_iter_sync);
+
+/**
+ * prb_iter_peek_next_entry() - Check if there is a next (newer) entry.
+ *
+ * @iter: The iterator used for list traversal.
+ *
+ * This is the public function available to readers to check if a newer
+ * entry is available.
+ *
+ * Context: Any context.
+ * Return: true if there is a next entry, otherwise false.
+ */
+bool prb_iter_peek_next_entry(struct prb_iterator *iter)
+{
+	DECLARE_PRINTKRB_ENTRY(e, 1);
+	DECLARE_PRINTKRB_ITER(iter_copy, iter->rb, &e);
+
+	prb_iter_sync(&iter_copy, iter);
+
+	return (prb_iter_next_valid_entry(&iter_copy) != 0);
+}
+EXPORT_SYMBOL(prb_iter_peek_next_entry);
+
+/**
+ * prb_getfail() - Read the descriptor reservation failure counter.
+ *
+ * @rb: The ringbuffer whose counter to read.
+ *
+ * This is the public function available to readers to see how many descriptor
+ * reservation failures exist.
+ *
+ * The counter only counts failures to assign a descriptor. Failures due to
+ * failing to reserve data are not counted because the associated (invalid)
+ * descriptor with its sequence number will exist and readers will be able to
+ * identify that as a lost entry by seeing a jump in the sequence number.
+ *
+ * Context: Any context.
+ * Return: The number of descriptor reservation failures for this ringbuffer.
+ */
+unsigned long prb_getfail(struct printk_ringbuffer *rb)
+{
+	return atomic_long_read(&rb->fail);
+}
+EXPORT_SYMBOL(prb_getfail);
diff --git a/kernel/printk/ringbuffer.h b/kernel/printk/ringbuffer.h
new file mode 100644
index 000000000000..9fe54a09fbc2
--- /dev/null
+++ b/kernel/printk/ringbuffer.h
@@ -0,0 +1,288 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_PRINTK_RINGBUFFER_H
+#define _LINUX_PRINTK_RINGBUFFER_H
+
+#include <linux/atomic.h>
+#include "numlist.h"
+#include "dataring.h"
+
+/**
+ * struct prb_desc - A descriptor representing an entry in the ringbuffer.
+ *
+ * @id:   The ID of the descriptor.
+ *        The descriptor array index can be derived from the ID.
+ *
+ * @desc: The dataring descriptor where the entry data is stored.
+ *
+ * @list: The numbered list node within the committed list.
+ *
+ * Descriptors include information about where (and if) data for this entry is
+ * stored within the ringbuffer's dataring. A descriptor may or may not be
+ * within a numbered list of committed descriptors.
+ */
+struct prb_desc {
+	/* private */
+	atomic_long_t		id;
+	struct dr_desc		desc;
+	struct nl_node		list;
+};
+
+/**
+ * struct printk_ringbuffer - The ringbuffer structure.
+ *
+ * @desc_count_bits:  The power-of-2 maximum amount of descriptors allowed.
+ *
+ * @descs:            An array of all descriptors to use.
+ *
+ * @desc_next_unused: An index of the next available (never before used)
+ *                    descriptor. This value only increases until the
+ *                    maximum is reached.
+ *
+ * @nl:               A numbered list of committed entries.
+ *
+ * @dr:               The dataring used to manage the entry data.
+ *
+ * @fail:             A counter tracking how often writers fail to reserve.
+ *                    This only tracks failure due to not being able to get a
+ *                    descriptor. Failure due to not being able to reserve
+ *                    space in the dataring is not counted because readers
+ *                    will notice a lost sequence number in that case.
+ */
+struct printk_ringbuffer {
+	/* private */
+	unsigned int		desc_count_bits;
+	struct prb_desc		*descs;
+	atomic_t		desc_next_unused;
+
+	struct numlist		nl;
+
+	struct dataring		dr;
+
+	atomic_long_t		fail;
+};
+
+/**
+ * struct prb_reserved_entry - Used by writers to reserve/commit an entry.
+ *
+ * @rb:        The printk ringbuffer used for reserve/commit.
+ *
+ * @desc:      A pointer to the descriptor of the reserved entry.
+ *
+ * @irqflags:  Local IRQs are disabled during the reserve/commit window.
+ *
+ * A writer provides this structure when reserving and committing data. The
+ * values of all the members are set on reserve and are only valid until
+ * commit has been called.
+ */
+struct prb_reserved_entry {
+	/* private */
+	struct printk_ringbuffer	*rb;
+	struct prb_desc			*desc;
+	unsigned long			irqflags;
+};
+
+/**
+ * struct prb_entry - Used by readers to read a ringbuffer entry.
+ *
+ * @seq:         The sequence number of the entry.
+ *
+ * @buffer:      A pointer to a reader-provided buffer.
+ *               When reading an entry, the data is copied to this buffer.
+ *
+ * @buffer_size: The size of the reader-provided buffer.
+ *
+ * A reader initializes and provides this structure when traversing/reading
+ * the entries of the ringbuffer.
+ */
+struct prb_entry {
+	/* public */
+	unsigned long	seq;
+	char		*buffer;
+	int		buffer_size;
+};
+
+/**
+ * struct prb_iterator - Used by readers to traverse the committed list.
+ *
+ * @rb:       The printk ringbuffer being traversed.
+ *
+ * @e:        A pointer to a reader-provided entry structure.
+ *
+ * @last_id:  The ID of the last read entry.
+ *
+ * @last_seq: The sequence number of the last read entry.
+ *
+ * @next_id:  The ID of the next (unread) entry.
+ *
+ * An iterator tracks the current position of a reader within the ringbuffer.
+ * Readers can notice if they have missed an entry by a jump in the sequence
+ * number.
+ */
+struct prb_iterator {
+	/* private */
+	struct printk_ringbuffer	*rb;
+	struct prb_entry		*e;
+
+	unsigned long			last_id;
+	unsigned long			last_seq;
+	unsigned long			next_id;
+};
+
+/* writer interface */
+char *prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
+		  unsigned int size);
+void prb_commit(struct prb_reserved_entry *e);
+
+/* reader interface */
+void prb_iter_init(struct prb_iterator *iter, struct printk_ringbuffer *rb,
+		   struct prb_entry *e);
+int prb_iter_next_valid_entry(struct prb_iterator *iter);
+void prb_iter_sync(struct prb_iterator *dest, struct prb_iterator *src);
+bool prb_iter_peek_next_entry(struct prb_iterator *iter);
+
+/* utility functions */
+unsigned long prb_getfail(struct printk_ringbuffer *rb);
+
+/* prototypes for callbacks used by numlist and dataring, respectively */
+struct nl_node *prb_desc_node(unsigned long id, void *arg);
+bool prb_desc_busy(unsigned long id, void *arg);
+struct dr_desc *prb_getdesc(unsigned long id, void *arg);
+
+/**
+ * DECLARE_PRINTKRB() - Declare a printk ringbuffer.
+ *
+ * @name:        The name for the ringbuffer structure variable.
+ *
+ * @avgdatabits: The average size of data as a power-of-2.
+ *               If this value is greater than the actual average data size,
+ *               there will not be enough descriptors available. This will
+ *               lead to situations where data is invalidated in order to free
+ *               up descriptors, rather than because the data ringbuffer is
+ *               full. Generally, values that are less than the actual average
+ *               data size are preferred.
+ *
+ * @descbits:    The power-of-2 maximum amount of descriptors allowed.
+ *
+ * The size of the data array will be the average data size multiplied by the
+ * maximum amount of descriptors.
+ *
+ * As per numlist requirement of always having at least one node in the list,
+ * the ringbuffer structures are initialized such that:
+ *
+ * * the numlist head and tail point to descriptor 0
+ * * descriptor 0 has an invalid data block and is the terminating node
+ * * descriptor 1 will be the next descriptor
+ */
+#define DECLARE_PRINTKRB(name, avgdatabits, descbits)			\
+char _##name##_data[(1 << ((avgdatabits) + (descbits))) +		\
+				 sizeof(long)]				\
+	__aligned(__alignof__(long));					\
+struct prb_desc _##name##_descs[1 << (descbits)];			\
+struct printk_ringbuffer name = {					\
+	.desc_count_bits	= descbits,				\
+	.descs			= &_##name##_descs[0],			\
+	.desc_next_unused	= ATOMIC_INIT(1),			\
+	.nl = {								\
+		.head_id	= ATOMIC_LONG_INIT(0),			\
+		.tail_id	= ATOMIC_LONG_INIT(0),			\
+		.node		= prb_desc_node,			\
+		.node_arg	= &name,				\
+		.busy		= prb_desc_busy,			\
+		.busy_arg	= &name,				\
+	},								\
+	.dr = {								\
+		.size_bits	= (avgdatabits) + (descbits),		\
+		.data		= &_##name##_data[0],			\
+		.head_lpos	= ATOMIC_LONG_INIT(-111 *		\
+						   sizeof(long)),	\
+		.tail_lpos	= ATOMIC_LONG_INIT(-111 *		\
+						   sizeof(long)),	\
+		.getdesc	= prb_getdesc,				\
+		.getdesc_arg	= &name,				\
+	},								\
+	.fail			= ATOMIC_LONG_INIT(0),			\
+}
+
+/**
+ * DECLARE_PRINTKRB_ENTRY() - Declare an entry structure.
+ *
+ * @name: The name for the entry structure variable.
+ *
+ * @size: The size of the associated reader buffer (also declared).
+ *
+ * This macro is particularly useful for static entry structures that should
+ * be immediately available and initialized. It is an alternative to the
+ * reader manually creating a buffer and setting the buffer and
+ * buffer_size fields of the structure.
+ *
+ * Note that this macro will declare the buffer as well. This could be a
+ * problem if this is used with a large buffer size within a stack frame.
+ */
+#define DECLARE_PRINTKRB_ENTRY(name, size)				\
+char _##name##_entry_buf[size];						\
+struct prb_entry name = {						\
+	.seq		= 0,						\
+	.buffer		= &_##name##_entry_buf[0],			\
+	.buffer_size	= size,						\
+}
+
+/**
+ * DECLARE_PRINTKRB_ITER() - Declare an iterator for readers.
+ *
+ * @name:      The name for the iterator structure variable.
+ *
+ * @rbaddr:    A pointer to a printk ringbuffer.
+ *
+ * @entryaddr: A pointer to an entry structure.
+ *
+ * This macro is particularly useful for static iterators that should be
+ * immediately available and initialized. It is an alternative to
+ * manually initializing an iterator with prb_iter_init().
+ */
+#define DECLARE_PRINTKRB_ITER(name, rbaddr, entryaddr)			\
+struct prb_iterator name = {						\
+	.rb		= rbaddr,					\
+	.e		= entryaddr,					\
+	.last_id	= 0,						\
+	.last_seq	= 0,						\
+	.next_id	= 0,						\
+}
+
+/**
+ * prb_for_each_entry() - Iterate all entries of a ringbuffer.
+ *
+ * @i: A pointer to an iterator.
+ *
+ * @r: The printk ringbuffer to iterate.
+ *
+ * @e: An entry structure to use during iteration.
+ *
+ * @l: An integer used to identify when the final entry is traversed.
+ *
+ * This macro initializes the iterator and traverses through all available
+ * ringbuffer entries.
+ *
+ * See prb_for_each_entry_continue() if you want to continue traversing using
+ * an iterator that has already begun traversal.
+ */
+#define prb_for_each_entry(i, r, e, l) \
+	for (prb_iter_init(i, r, e); (l = prb_iter_next_valid_entry(i)) != 0;)
+
+/**
+ * prb_for_each_entry_continue() - Continue iterating entries of a ringbuffer.
+ *
+ * @i: A pointer to an iterator.
+ *
+ * @l: An integer used to identify when the final entry is traversed.
+ *
+ * This macro expects the iterator to be initialized. It does not reset the
+ * iterator. If the iterator has already been used for some traversal, this
+ * macro will continue where the iterator left off.
+ *
+ * See prb_for_each_entry() if you want to iterate from the beginning.
+ */
+#define prb_for_each_entry_continue(i, l) \
+	for (; (l = prb_iter_next_valid_entry(i)) != 0;)
+
+#endif /*_LINUX_PRINTK_RINGBUFFER_H */
-- 
2.11.0


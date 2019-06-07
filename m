Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D105C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC4820840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfFGQYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:24:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50567 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730066AbfFGQYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:24:11 -0400
Received: from [5.158.153.52] (helo=noscherz.tec.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hZHer-0000ei-3P; Fri, 07 Jun 2019 18:24:01 +0200
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
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer implementation
Date:   Fri,  7 Jun 2019 18:29:48 +0206
Message-Id: <20190607162349.18199-2-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190607162349.18199-1-john.ogness@linutronix.de>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See documentation for details.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 Documentation/core-api/index.rst             |   1 +
 Documentation/core-api/printk-ringbuffer.rst | 104 +++
 include/linux/printk_ringbuffer.h            | 238 +++++++
 lib/printk_ringbuffer.c                      | 924 +++++++++++++++++++++++++++
 4 files changed, 1267 insertions(+)
 create mode 100644 Documentation/core-api/printk-ringbuffer.rst
 create mode 100644 include/linux/printk_ringbuffer.h
 create mode 100644 lib/printk_ringbuffer.c

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index ee1bb8983a88..0ab649134577 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -27,6 +27,7 @@ Core utilities
    errseq
    printk-formats
    circular-buffers
+   printk-ringbuffer
    generic-radix-tree
    memory-allocation
    mm-api
diff --git a/Documentation/core-api/printk-ringbuffer.rst b/Documentation/core-api/printk-ringbuffer.rst
new file mode 100644
index 000000000000..5634c2010ed8
--- /dev/null
+++ b/Documentation/core-api/printk-ringbuffer.rst
@@ -0,0 +1,104 @@
+=====================
+The printk Ringbuffer
+=====================
+
+:Author: John Ogness <john.ogness@linutronix.de>
+
+
+.. Contents:
+
+ (*) Overview
+     - Features
+     - Terminology
+     - Behavior
+     - Data Blocks
+     - Descriptors
+     - Why Descriptors?
+
+ (*) Memory Barriers
+     - Writers
+     - Readers
+
+ (*) Structures, Macros, Functions
+
+ (*) Examples
+     - Writer
+     - Reader
+
+
+Overview
+========
+
+.. kernel-doc:: lib/printk_ringbuffer.c
+   :doc: prb overview
+
+
+Memory Barriers
+===============
+
+.. kernel-doc:: lib/printk_ringbuffer.c
+   :doc: memory barriers
+
+
+Examples
+========
+
+Here are some simple examples demonstrating writers and readers. For the
+examples it is assumed that a global ringbuffer is available::
+
+	DECLARE_PRINTKRB(rb, 7, 5);
+
+This expects an average data size of 128 bytes and allows up to 32
+descriptors.
+
+
+Writer
+------
+
+Sample writer code::
+
+	struct prb_reserved_entry e;
+	char *s;
+
+	s = prb_reserve(&e, &rb, 32);
+	if (s) {
+		sprintf(s, "Hello, world!");
+		prb_commit(&e);
+	}
+
+
+Reader
+------
+
+Sample reader code::
+
+	DECLARE_PRINTKRB_ENTRY(entry, 128);
+	DECLARE_PRINTKRB_ITER(iter, &test_rb, &entry);
+	u64 last_seq = 0;
+	int len;
+	char *s;
+
+	prb_for_each_entry(&iter, len) {
+		if (entry.seq - last_seq != 1) {
+			printf("LOST %llu ENTRIES\n",
+				entry.seq - (last_seq + 1));
+		}
+		last_seq = entry.seq;
+
+		s = (char *)&entry.buffer[0];
+		if (len >= 128)
+			s[128 - 1] = 0;
+		printf("data: %s\n", s);
+	}
+
+
+Structures, Macros, Functions
+=============================
+
+Follwing is a description of all the printk ringbuffer data structures,
+macros, and functions, most of which are private. Public interfaces are
+explicitly mentioned/marked as so.
+
+.. kernel-doc:: include/linux/printk_ringbuffer.h
+.. kernel-doc:: lib/printk_ringbuffer.c
+   :functions:
diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
new file mode 100644
index 000000000000..569980a61c0a
--- /dev/null
+++ b/include/linux/printk_ringbuffer.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PRINTK_RINGBUFFER_H
+#define _LINUX_PRINTK_RINGBUFFER_H
+
+#include <linux/atomic.h>
+
+/**
+ * struct prb_list - An abstract linked list of items.
+ * @oldest: The oldest item on the list.
+ * @newest: The newest item on the list.
+ *
+ * Items are represented as integers (logical array indexes) into an external
+ * array. For the data array they represent the beginning of the data for that
+ * item. For the descriptor array they represent the array element of the
+ * descriptor.
+ *
+ * Traversing the list requires that the items also include integers to the
+ * next item in the list. Note that only the descriptor list is ever
+ * traversed.
+ */
+struct prb_list {
+	/* private */
+	unsigned long oldest;
+	unsigned long newest;
+};
+
+/**
+ * struct prb_descr - A descriptor representing an entry in the ringbuffer.
+ * @seq: The sequence number of the entry.
+ * @id: The descriptor id.
+ *      The location of the descriptor within the descriptor array can be 
+ *      determined from this value.
+ * @data: The logical position of the data for this entry.
+ *        The location of the beginning of the data within the data array
+ *        can be determined from this value.
+ * @data_next: The logical position of the data next to this entry.
+ *             This is used to determine the length of the data as well as
+ *             identify where the next data begins.
+ * @next: The id of the next (newer) descriptor in the linked list.
+ *        A value of EOL means it is the last descriptor in the list.
+ *
+ * Descriptors are used to identify where the data for each entry is and
+ * also provide an ordering for readers. Entry ordering is based on the
+ * descriptor linked list (not the ordering of data in the data array).
+ */
+struct prb_descr {
+	/* private */
+	u64 seq;
+	unsigned long id;
+	unsigned long data;
+	unsigned long data_next;
+	unsigned long next;
+};
+
+/**
+ * struct printk_ringbuffer - The ringbuffer structure.
+ * @data_array_size_bits: The size of the data array as a power-of-2.
+ * @data_array: A pointer to the data array.
+ * @data_list: A list of entry data.
+ *             Since the data list is not traversed, this list is only used to
+ *             mark the contiguous section of the data array that is in use.
+ * @descr_max_count: The maximum amount of descriptors allowed.
+ * @descr_array: A pointer to the descriptor array.
+ * @descr_list: A list of entry descriptors.
+ *              The list can be traversed from oldest to newest.
+ * @descr_next: An index of the next available (never before used) descriptor.
+ *              This value only increases until the maximum is reached.
+ * @lost: A counter tracking how often writers failed to write.
+ *        This is only provided as convenience. It does not increment
+ *        automatically. Writers must increment it after they have deteremined
+ *        that a write failed.
+ */
+struct printk_ringbuffer {
+	/* private */
+	unsigned int data_array_size_bits;
+	char *data_array;
+	struct prb_list data_list;
+
+	unsigned int descr_max_count;
+	struct prb_descr *descr_array;
+	struct prb_list descr_list;
+
+	atomic_t descr_next;
+
+	atomic_long_t lost;
+};
+
+/**
+ * struct prb_reserved_entry - Used by writers to reserve/commit data.
+ * @rb: The printk ringbuffer used for reserve/commit.
+ * @descr: A pointer to the descriptor assigned to the reserved data.
+ * @id: The descriptor's id value, set on reserve.
+ * @data: The descriptor's data value, set on reserve.
+ * @data_next: The descriptor's future data_next value, set on commit.
+ * @irqflags: Local IRQs are disabled during the reserve/commit window.
+ *
+ * A writer provides this structure when reserving and committing data. The
+ * values of all the members are set on reserve and are only valid until
+ * commit.
+ */
+struct prb_reserved_entry {
+	/* private */
+	struct printk_ringbuffer *rb;
+	struct prb_descr *descr;
+	unsigned long id;
+	unsigned long data;
+	unsigned long data_next;
+	unsigned long irqflags;
+};
+
+/**
+ * struct prb_entry - Used by readers to read a ringbuffer entry.
+ * @seq: The sequence number of the entry descriptor.
+ * @buffer: A pointer to a reader-provided buffer.
+ *          When reading an entry, the data is copied to this buffer.
+ * @buffer_size: The size of the reader-provided buffer.
+ *
+ * A reader initializes and provides this structure when traversing/reading
+ * the entries of the ringbuffer.
+ */
+struct prb_entry {
+	/* public */
+	u64 seq;
+	char *buffer;
+	int buffer_size;
+};
+
+/**
+ * struct prb_iterator - Used by readers to traverse a descriptor list.
+ * @rb: The printk ringbuffer being traversed.
+ * @e: A pointer to a reader-provided entry structure.
+ * @id: The id of the descriptor last accessed.
+ * @id_next: The id of the next (newer) descriptor to access.
+ */
+struct prb_iterator {
+	/* private */
+	struct printk_ringbuffer *rb;
+	struct prb_entry *e;
+	unsigned long id;
+	unsigned long id_next;
+};
+
+/**
+ * DECLARE_PRINTKRB() - Declare a printk ringbuffer.
+ * @name: The name for the ringbuffer structure variable.
+ * @avgdatabits: The average size of data as a power-of-2.
+ *               If this value is too small, it will not be possible to store
+ *               as many entries as desired. If this value is too large, there
+ *               will be some wasted space in the data array because there are
+ *               not enough descriptors. Generatlly values that are too large
+ *               are preferred over thost that are too small.
+ * @descrbits: The number of descriptors (desired entries) as a power-of-2.
+ *
+ * The size of the data array will be the average data size multiplied by the
+ * number of descriptors.
+ */
+#define DECLARE_PRINTKRB(name, avgdatabits, descrbits)			\
+char _##name##_data_array[(1 << ((avgdatabits) + (descrbits))) +	\
+				 sizeof(long)]				\
+	__aligned(__alignof__(long));					\
+struct prb_descr _##name##_descr_array[1 << (descrbits)];		\
+struct printk_ringbuffer name = {					\
+	.data_array_size_bits = (avgdatabits) + (descrbits),		\
+	.data_array = &_##name##_data_array[0],				\
+	.data_list.oldest = -111 * sizeof(long),			\
+	.data_list.newest = -111 * sizeof(long),			\
+	.descr_max_count = 1 << (descrbits),				\
+	.descr_array = &_##name##_descr_array[0],			\
+	.descr_next = ATOMIC_INIT(0),					\
+	.descr_list.oldest = 0,						\
+	.descr_list.newest = 0,						\
+	.lost = ATOMIC_LONG_INIT(0),					\
+}
+
+/**
+ * DECLARE_PRINTKRB_ENTRY() - Declare an entry structure.
+ * @name: The name for the entry structure variable.
+ * @size: The size of the associated reader buffer (also declared).
+ *
+ * This macro is particularly useful for static entry structures that should be
+ * immediately available and initialized. It is an alternative to the reader
+ * manually setting the buffer and buffer_size members of the structure.
+ *
+ * Note that this macro will declare the buffer as well. This could be a
+ * problem if this is used with a large buffer size within a stack frame.
+ */
+#define DECLARE_PRINTKRB_ENTRY(name, size)				\
+char _##name##_entry_buf[size];						\
+struct prb_entry name = {						\
+	.buffer_size = size,						\
+	.buffer = &_##name##_entry_buf[0],				\
+}
+
+/**
+ * DECLARE_PRINTKRB_ITER() - Declare an iterator for readers.
+ * @name: The name for the iterator structure variable.
+ * @rbaddr: A pointer to a printk ringbuffer.
+ * @entryaddr: A pointer to an entry structure.
+ *
+ * This macro is particularly useful for static iterators that should be
+ * immediately available and initialized. It is an alternative to
+ * manually initializing an iterator with prb_iter_init().
+ */
+#define DECLARE_PRINTKRB_ITER(name, rbaddr, entryaddr)			\
+struct prb_iterator name = {						\
+	.rb = rbaddr,							\
+        .e = entryaddr,							\
+        .id = 0,							\
+        .id_next = 0,							\
+}
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
+bool prb_iter_peek_next_entry(struct prb_iterator *iter);
+
+/**
+ * prb_for_each_entry() - Iterate through all the entries of a ringbuffer.
+ * @i: A pointer to an iterator.
+ * @l: An integer used to identify when the last entry is traversed.
+ *
+ * This macro expects the iterator to be initialized. It also does not reset
+ * the iterator. So if the iterator has already been used for some traversal,
+ * this macro will continue where the iterator left off.
+ */
+#define prb_for_each_entry(i, l) \
+	for (; (l = prb_iter_next_valid_entry(i)) != 0;)
+
+/* utility functions */
+void prb_inc_lost(struct printk_ringbuffer *rb);
+
+#endif /*_LINUX_PRINTK_RINGBUFFER_H */
diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
new file mode 100644
index 000000000000..d0b2b6a549b0
--- /dev/null
+++ b/lib/printk_ringbuffer.c
@@ -0,0 +1,924 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/printk_ringbuffer.h>
+
+/**
+ * DOC: prb overview
+ *
+ * As the name suggests, this ringbuffer was implemented specifically to
+ * serve the needs of the printk() infrastructure. The ringbuffer itself is
+ * not specific to printk and could be used for other purposes. However, the
+ * requirements and semantics of printk are rather unique. If you intend to use
+ * this ringbuffer for anything other than printk, you need to be very clear on
+ * its features, behavior, and pitfalls.
+ *
+ * Features
+ * --------
+ * * single global buffer
+ * * resides in initialized data section (available at early boot)
+ * * supports multiple concurrent lockless writers
+ * * supports multiple concurrent lockless readers
+ * * safe from any context (including NMI)
+ * * groups bytes into variable length data blocks (referenced by entries)
+ * * entries tagged with sequence numbers
+ *
+ * Terminology
+ * -----------
+ * data block - A contiguous block of data containing an id to an associated
+ *              descriptor and the raw data from the writer.
+ * descriptor - Meta data for a data block containing an id, the logical
+ *              positions of the associated data block, a unique sequence
+ *              number, and a pointer to the next (newer) descriptor.
+ * entry - A high level object used by the readers/writers that contains a
+ *         descriptor as well as state information during the reserve/commit
+ *         window.
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
+ * Writing to the ringbuffer consists of 2 steps. First a writer must reserve
+ * a data block of desired size. After this step the writer has exclusive
+ * access to the memory region. Once the writer's data has been written to
+ * memory, the entry needs to be committed to the ringbuffer. After this step
+ * the data has been inserted into the ringbuffer and assigned an appropriate
+ * sequence number.
+ *
+ * Once committed, a writer must no longer access the data directly. This is
+ * because the data may have been overwritten and no longer exists. If a
+ * writer must access the data, it should either keep a private copy before
+ * committing or use the reader API to gain access to the data.
+ *
+ * Because of how the data backend is implemented, data blocks that have been
+ * reserved but not yet committed act as barriers, preventing future writers
+ * from filling the ringbuffer beyond the location of the reserved but not
+ * yet committed data block region. For this reason it is important that
+ * writers perform both reserve and commit as quickly as possible. Also, be
+ * aware that local interrupts are disabled during the reserve/commit window.
+ * Writers in NMI contexts can still preempt any other writers, but as long
+ * as these writers do not write a large amount of data with respect to the
+ * ringbuffer size, this should not become an issue.
+ *
+ * Data Blocks
+ * -----------
+ * All ring buffer data is stored within a single static byte array. The reason
+ * for this is to ensure that any pointers to the data (past and present) will
+ * always point to valid memory. This is important because the lockless readers
+ * and writers may preempt for long periods of time and when they resume may be
+ * working with expired pointers.
+ *
+ * Data blocks are specified by start and end indices. (The end index has the
+ * same value as the start index of the neighboring data block.) But indices
+ * are not simply offsets into the byte array. They are logical position
+ * values (lpos) that always increase but map directly to byte array offsets.
+ *
+ * For example, for a byte array of 1000, a data block may have have a start
+ * lpos of 100. Another data block may have a start lpos of 1100. And yet
+ * another 2100. All of these data blocks are pointing to the same data, but
+ * only the most recent data block is valid. The other data blocks are pointing
+ * to valid memory, but represent data blocks that have been overwritten.
+ *
+ * Also note that due to overflowing, the most recent data block is not
+ * necessarily the one with the highest lpos. Indeed, the printk ring buffer
+ * initializes its data such that an overflow happens relatively quickly in
+ * order to validate the handling of this situation.
+ *
+ * If a data block starts near the end of the byte array but would extend
+ * beyond it, that data block is handled differently: a special "wrapping data
+ * block" is inserted into the byte array and the real data block is placed at
+ * the beginning of the byte array. This can waste space at the end of the byte
+ * array, but simplifies the implementation by allowing writers to always work
+ * with contiguous buffers. For example, for a 1000 byte array, a descriptor
+ * may show a start lpos of 1950 and an end lpos of 2100. The data block
+ * associated with this descriptor is 100 bytes in size and its data is found
+ * at offset 0 of the byte array.
+ *
+ * Descriptors
+ * -----------
+ * A descriptor is a handle to a data block. Like data blocks, all descriptors
+ * are also stored in their own single static array. The reasoning is the same
+ * as for the data blocks: pointers to descriptors should point to valid
+ * memory at all times, even if the descriptor itself has become invalid.
+ *
+ * Descriptors contain the start (data) and end (data_next) lpos of the data
+ * block they represent. They also have their own id that works like the lpos
+ * for data blocks: values that always increase but map directly to the
+ * descriptor array offset.
+ *
+ * For example, for a descriptor array of 10, a descriptor may have an id of
+ * 1, another of 11, and another of 21. All of these descriptor ids are
+ * pointing to the same descriptor, but only the most recent descriptor id
+ * is valid. The other values represent descriptors that have become invalid.
+ *
+ * Why Descriptors?
+ * ----------------
+ * At first glance it may seem as though descriptors are an unnecessary
+ * abstraction layer added over the data array. After all, couldn't we just put
+ * the fields of a descriptor into a structure at the head of the data block?
+ * The answer is no. The reason is that the printk ring buffer supports
+ * variable length records, which means that data blocks will not always begin
+ * at a predictable offset of the byte array. This is a major problem for
+ * lockless writers that, for example, will need to expire old data blocks
+ * when the ringbuffer is full. A writer has no way of knowing if it is
+ * allowed to push the oldest pointer. Flags could not be used because upon
+ * pushing the newest pointer (reserve), initially random data will be set
+ * that could falsely indicate the flag status. Introducing a third
+ * "committed" pointer also will not help because now the problem is
+ * advancing the committed pointer. (Reserve ordering does not match commit
+ * ordering.) Even using cmpxchg() will not help because random data could
+ * potentially match the metadata to replace.
+ *
+ * Descriptors allow safe and controlled access to data block metadata by
+ * providing predictable offsets for such metadata. This is key to supporting
+ * multiple concurrent lockless writers.
+ */
+
+/**
+ * DOC: memory barriers
+ *
+ * Writers
+ * -------
+ * The main issue with writers is expiring/invalidating old data blocks in
+ * order to create new data blocks. This is performed in 6 steps that must
+ * be observed in order by all writers to allow cooperation. Here is a list
+ * of the 6 steps and the named acquire/release memory barrier pairs that
+ * are used to synchronized them:
+ *
+ * * old data invalidation (MB1): Pushing rb.data_list.oldest forward.
+ *   Necessary for identifying if data has been expired.
+ *
+ * * new data reservation (MB2): Pushing rb.data_list.newest forward.
+ *   Necessary for validating data.
+ *
+ * * assign the data block to a descriptor (MB3): Setting data block id to
+ *   descriptor id. Necessary for finding the descriptor associated with th
+ *   data block.
+ *
+ * * commit data (MB4): Setting data block data_next. (Now data block is
+ *   valid). Necessary for validating data.
+ *
+ * * make descriptor newest (MB5): Setting rb.descr_list.newest to descriptor.
+ *   (Now following new descriptors will be linked to this one.) Necessary for
+ *   ensuring the descriptor's next is set to EOL before adding to the list.
+ *
+ * * link descriprtor to previous newest (MB6): Setting the next of the
+ *   previous descriptor to this one. Necessary for correctly identifying if
+ *   a descriptor is the only descriptor on the list.
+ *
+ * Readers
+ * -------
+ * Readers only make of smb_rmb() to ensure that certain critical load
+ * operations are performed in an order that allows readers to evaluate if
+ * the data they read is really valid.
+ */
+
+/* end of list marker */
+#define EOL 0
+
+/**
+ * struct prb_datablock - A data block.
+ * @id: The descriptor id that is associated with this data block.
+ * @data: The data committed by the writer.
+ */
+struct prb_datablock {
+	unsigned long id;
+	char data[0];
+};
+
+#define DATAARRAY_SIZE(rb) (1 << rb->data_array_size_bits)
+#define DATAARRAY_SIZE_BITMASK(rb) (DATAARRAY_SIZE(rb) - 1)
+
+/**
+ * DATA_INDEX() - Determine the data array index from logical position.
+ * @rb: The associated ringbuffer.
+ * @lpos: The logical position (data/data_next).
+ */
+#define DATA_INDEX(rb, lpos) (lpos & DATAARRAY_SIZE_BITMASK(rb))
+
+/**
+ * DATA_WRAPS() - Determine how many times the data array has wrapped.
+ * @rb: The associated ringbuffer.
+ * @lpos: The logical position (data/data_next).
+ *
+ * The number of wraps is useful when determining if one logical position
+ * is overtaking the data array index another logical position.
+ */
+#define DATA_WRAPS(rb, lpos) (lpos >> rb->data_array_size_bits)
+
+/**
+ * DATA_THIS_WRAP_START_LPOS() - Get the position at the start of the wrap.
+ * @rb: The associated ringbuffer.
+ * @lpos: The logical position (data/data_next).
+ *
+ * Given a logical position, return the logical position if backed up to the
+ * beginning (data array index 0) of the current wrap. This is used when a
+ * data block wraps and therefore needs to begin at the beginning of the data
+ * array (for the next wrap).
+ */
+#define DATA_THIS_WRAP_START_LPOS(rb, lpos) \
+	(DATA_WRAPS(rb, lpos) << rb->data_array_size_bits)
+
+#define DATA_ALIGN sizeof(long)
+#define DATA_ALIGN_SIZE(sz) \
+	((sz + (DATA_ALIGN - 1)) & ~(DATA_ALIGN - 1))
+
+#define DESCR_COUNT_BITMASK(rb) (rb->descr_max_count - 1)
+
+/**
+ * DESCR_INDEX() - Determine the descriptor array index from the id.
+ * @rb: The associated ringbuffer.
+ * @id: The descriptor id.
+ */
+#define DESCR_INDEX(rb, id) (id & DESCR_COUNT_BITMASK(rb))
+
+#define TO_DATABLOCK(rb, lpos) \
+	((struct prb_datablock *)&rb->data_array[DATA_INDEX(rb, lpos)])
+#define TO_DESCR(rb, id) \
+	(&rb->descr_array[DESCR_INDEX(rb, id)])
+
+/**
+ * data_valid() - Check if a data block is valid.
+ * @rb: The ringbuffer containing the data.
+ * @oldest_data: The oldest data logical position.
+ * @newest_data: The newest data logical position.
+ * @data: The logical position for the data block to check.
+ * @data_next: The logical position for the data block next to this one.
+ *             This value is used to identify the end of the data block.
+ *
+ * A data block is considered valid if it satisfies the two conditions:
+ *
+ * * oldest_data <= data < data_next <= newest_data
+ * * oldest_data is at most exactly 1 wrap behind newest_data
+ *
+ * Return: true if the specified data block is valid.
+ */
+static inline bool data_valid(struct printk_ringbuffer *rb,
+			      unsigned long oldest_data,
+			      unsigned long newest_data,
+			      unsigned long data, unsigned long data_next)
+
+{
+	return ((data - oldest_data) < DATAARRAY_SIZE(rb) &&
+		data_next != data &&
+		(data_next - data) < DATAARRAY_SIZE(rb) &&
+		(newest_data - data_next) < DATAARRAY_SIZE(rb) &&
+		(newest_data - oldest_data) <= DATAARRAY_SIZE(rb));
+}
+
+/**
+ * add_descr_list() - Add a descriptor to the descriptor list.
+ * @e: An entry that has already reserved data.
+ *
+ * The provided entry contains a pointer to a descriptor that has already
+ * been reserved for this entry. However, the reserved descriptor is not
+ * yet on the list. Add this descriptor as the newest item.
+ *
+ * A descriptor is added in two steps. The first step is to make this
+ * descriptor the newest. The second step is to update the "next" field of
+ * the former newest item to point to this item.
+ */
+static void add_descr_list(struct prb_reserved_entry *e)
+{
+	struct printk_ringbuffer *rb = e->rb;
+	struct prb_list *l = &rb->descr_list;
+	struct prb_descr *d = e->descr;
+	struct prb_descr *newest_d;
+	unsigned long newest_id;
+
+	/* set as newest */
+	do {
+		/* MB5: synchronize add descr */
+		newest_id = smp_load_acquire(&l->newest);
+		newest_d = TO_DESCR(rb, newest_id);
+
+		if (newest_id == EOL)
+			WRITE_ONCE(d->seq, 1);
+		else
+			WRITE_ONCE(d->seq, READ_ONCE(newest_d->seq) + 1);
+		/*
+		 * MB5: synchronize add descr
+		 *
+		 * In particular: next written before cmpxchg
+		 */
+	} while (cmpxchg_release(&l->newest, newest_id, e->id) != newest_id);
+
+	if (unlikely(newest_id == EOL)) {
+		/* no previous newest means we *are* the list, set oldest */
+
+		/*
+		 * MB UNPAIRED
+		 *
+		 * In particular: Force cmpxchg _after_ cmpxchg on newest.
+		 */
+		WARN_ON_ONCE(cmpxchg_release(&l->oldest, EOL, e->id) != EOL);
+	} else {
+		/* link to previous chain */
+
+		/*
+		 * MB6: synchronize link descr
+		 *
+		 * In particular: Force cmpxchg _after_ cmpxchg on newest.
+		 */
+		WARN_ON_ONCE(cmpxchg_release(&newest_d->next,
+					     EOL, e->id) != EOL);
+	}
+}
+
+/**
+ * remove_oldest_descr() - Remove the oldest descriptor from the list.
+ * @rb: The ringbuffer from which to remove the oldest descriptor.
+ *
+ * A oldest descriptor can be removed from the descriptor list on two
+ * conditions:
+ *
+ * * The data block for the descriptor is invalid.
+ * * The descriptor is not the only descriptor on the list.
+ *
+ * If, during this function, another task removes the oldest, this function
+ * will try again.
+ *
+ * Return: The removed descriptor or NULL if the oldest descriptor cannot
+ *         removed.
+ */
+static struct prb_descr *remove_oldest_descr(struct printk_ringbuffer *rb)
+{
+	struct prb_list *l = &rb->descr_list;
+	unsigned long oldest_id;
+	struct prb_descr *d;
+	unsigned long next;
+
+	for (;;) {
+		oldest_id = READ_ONCE(l->oldest);
+
+		/* list empty */
+		if (oldest_id == EOL)
+			return NULL;
+
+		d = TO_DESCR(rb, oldest_id);
+
+		/* only descriptors with _invalid_ data can be removed */
+		if (data_valid(rb, READ_ONCE(rb->data_list.oldest),
+			       READ_ONCE(rb->data_list.newest),
+			       READ_ONCE(d->data),
+			       READ_ONCE(d->data_next))) {
+			return NULL;
+		}
+
+		/*
+		 * MB6: synchronize link descr
+		 *
+		 * In particular: l->oldest is loaded as a data dependency so
+		 * d->next and the following l->oldest will load afterwards,
+		 * respectively.
+		 */
+		next = smp_load_acquire(&d->next);
+
+		if (next == EOL && READ_ONCE(l->oldest) == oldest_id) {
+			/*
+			 * The oldest has no next, so this is a list of one
+			 * descriptor. Lists must always have at least one
+			 * descriptor.
+			 */
+			return NULL;
+		}
+
+		if (cmpxchg(&l->oldest, oldest_id, next) == oldest_id) {
+			/* removed successfully */
+			break;
+		}
+
+		/* oldest descriptor removed by another task, try again */
+	}
+
+	return d;
+}
+
+/**
+ * expire_oldest_data() - Invalidate the oldest data block.
+ * @rb: The ringbuffer containing the data block.
+ * @oldest_lpos: The logical position of the oldest data block.
+ *
+ * This function expects to "push" the pointer to the oldest data block
+ * forward, thus invalidating the oldest data block. However, before pushing,
+ * it is verified if the data block is valid. (For example, if the data block
+ * was reserved but not yet committed, it is not permitted to invalidate the
+ * "in use by a writer" data.)
+ *
+ * If the data is valid, it will be associated with a descriptor, which will
+ * then provide the necessary information to validate the data.
+ *
+ * Return: true if the oldest data was invalidated (regardless if this
+ *         task was the one that did it or not), otherwise false.
+ */
+static bool expire_oldest_data(struct printk_ringbuffer *rb,
+			       unsigned long oldest_lpos)
+{
+	unsigned long newest_lpos;
+	struct prb_datablock *b;
+	unsigned long data_next;
+	struct prb_descr *d;
+	unsigned long data;
+
+	/* MB2: synchronize data reservation */
+	newest_lpos = smp_load_acquire(&rb->data_list.newest);
+
+	b = TO_DATABLOCK(rb, oldest_lpos);
+
+	/* MB3: synchronize descr setup */
+	d = TO_DESCR(rb, smp_load_acquire(&b->id));
+
+	data = READ_ONCE(d->data);
+
+	/* sanity check to check to see if b->id was correct */
+	if (oldest_lpos != data)
+		goto out;
+
+	/* MB4: synchronize commit */
+	data_next = smp_load_acquire(&d->data_next);
+
+	if (!data_valid(rb, oldest_lpos, newest_lpos, data, data_next))
+		goto out;
+
+	/* MB1: synchronize data invalidation */
+	cmpxchg_release(&rb->data_list.oldest, data, data_next);
+
+	/* Some task (maybe this one) successfully expired the oldest data. */
+	return true;
+out:
+	return (oldest_lpos != READ_ONCE(rb->data_list.oldest));
+}
+
+/**
+ * get_new_lpos() - Determine the logical positions of a new data block.
+ * @rb: The ringbuffer to contain the data.
+ * @size: The size of the new data block.
+ * @data: A pointer to the start logical position value to be set.
+ *        This will be the beginning of the data block.
+ * @data_next: A pointer to the end logical position value to be set.
+ *             This value is used to identify the end of the data block.
+ *
+ * Based on the logical position of the newest data block to create,
+ * determine what the data and data_next values will be. If the data block
+ * would overwrite the oldest data block, this function will invalidate the
+ * oldest data block, thus providing itself space for the new data block.
+ *
+ * Return: true if logical positions were determined, otherwise false.
+ *
+ * This will only fail if it was not possible to invalidate the oldest data
+ * block. This can happen if a writer has reserved but not yet committed data
+ * and that reserved data is currently the oldest data.
+ */
+static bool get_new_lpos(struct printk_ringbuffer *rb, unsigned int size,
+			 unsigned long *data, unsigned long *data_next)
+{
+	unsigned long oldest_lpos;
+	unsigned long data_begin;
+
+	for (;;) {
+		*data = READ_ONCE(rb->data_list.newest);
+		data_begin = *data;
+
+		for (;;) {
+			*data_next = data_begin + size;
+
+			/* MB1: synchronize data invalidation */
+			oldest_lpos = smp_load_acquire(&rb->data_list.oldest);
+
+			if (*data_next - oldest_lpos > DATAARRAY_SIZE(rb)) {
+				/* would overwrite oldest */
+				if (!expire_oldest_data(rb, oldest_lpos))
+					return false;
+				break;
+			}
+
+			if (DATA_WRAPS(rb, data_begin) ==
+			    DATA_WRAPS(rb, *data_next)) {
+				return true;
+			}
+
+			data_begin = DATA_THIS_WRAP_START_LPOS(rb, *data_next);
+		}
+	}
+}
+
+/**
+ * assign_descr() - Assign a descriptor to an entry.
+ * @e: The entry to assign a descriptor to.
+ *
+ * Find an available descriptor to assign to the entry. First it is checked
+ * if the oldest descriptor can be used. If not, perhaps a never-used
+ * descriptor is available.
+ *
+ * If no descriptors are found, data blocks will be invalidated until the
+ * oldest descriptor can be used.
+ *
+ * Return: true if a descriptor was assigned, otherwise false.
+ *
+ * This will only fail if it was not possible to invalidate the oldest data
+ * block. This can happen if a writer has reserved but not yet committed data
+ * and that reserved data is currently the oldest data.
+ */
+static bool assign_descr(struct prb_reserved_entry *e)
+{
+	struct printk_ringbuffer *rb = e->rb;
+	struct prb_descr *d;
+	unsigned long id;
+
+	for (;;) {
+		/* use invalid descriptor at oldest */
+		d = remove_oldest_descr(rb);
+		if (d) {
+			id = READ_ONCE(d->id) + rb->descr_max_count;
+			/*
+			 * EOL has special meaning (to represent a terminator
+			 * for the list) so no descriptor is allowed to use
+			 * it as its id.
+			 */
+			if (id == EOL)
+				id += rb->descr_max_count;
+
+			/*
+			 * Any readers sitting at this descriptor can still
+			 * traverse forward until the new id is assigned.
+			 */
+			break;
+		}
+
+		/* fallback to static never-used descriptors */
+		if (atomic_read(&rb->descr_next) < rb->descr_max_count) {
+			id = atomic_fetch_inc(&rb->descr_next);
+			if (id < rb->descr_max_count) {
+				d = &rb->descr_array[id];
+				break;
+			}
+		}
+
+		/* no descriptors, free one */
+		/* MB1: synchronize data invalidation */
+		if (!expire_oldest_data(rb,
+				smp_load_acquire(&rb->data_list.oldest))) {
+			return false;
+		}
+	}
+
+	e->id = id;
+	e->descr = d;
+	return true;
+}
+
+/**
+ * data_reserve() - Reserve data in the data array.
+ * @e: The entry to reserve data for.
+ * @size: The size to reserve.
+ *
+ * This function expects to "push" the pointer to the newest data block
+ * forward. If this would result in overtaking the data array index of the
+ * oldest data, that oldest data will be invalidated.
+ *
+ * Return: true if data was reservied, otherwise false.
+ *
+ * This will only fail if it was not possible to invalidate the oldest data
+ * block. This can happen if a writer has reserved but not yet committed data
+ * and that reserved data is currently the oldest data.
+ */
+static bool data_reserve(struct prb_reserved_entry *e, unsigned int size)
+{
+	struct printk_ringbuffer *rb = e->rb;
+
+	do {
+		if (!get_new_lpos(rb, size, &e->data, &e->data_next))
+			return false;
+		/* MB2: synchronize data reservation */
+	} while (cmpxchg_release(&rb->data_list.newest,
+				 e->data, e->data_next) != e->data);
+
+	return true;
+}
+
+/**
+ * prb_reserve() - Reserve data in the ringbuffer.
+ * @e: The entry structure to setup.
+ * @rb: The ringbuffer to reserve data in.
+ * @size: The size of the data to reserve.
+ *
+ * This is the public function available to writers to reserve data.
+ *
+ * Context: Any context. Disables local interrupts on success.
+ * Return: A pointer to the reserved data or NULL if data could not be
+ *         reserved.
+ *
+ * Assuming the provided size is legal, this will only fail if it was not
+ * possible to invalidate the oldest data block. This can happen if a writer
+ * has reserved but not yet committed data and that reserved data is
+ * currently the oldest data.
+ */
+char *prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
+		  unsigned int size)
+{
+	struct prb_datablock *b;
+	struct prb_descr *d;
+	char *buf;
+
+	if (size == 0)
+		return NULL;
+
+	size += sizeof(struct prb_datablock);
+	size = DATA_ALIGN_SIZE(size);
+	if (size > DATAARRAY_SIZE(rb))
+		return NULL;
+
+	e->rb = rb;
+
+	local_irq_save(e->irqflags);
+
+	if (!assign_descr(e))
+		goto err_out;
+
+	d = e->descr;
+	WRITE_ONCE(d->id, e->id);
+
+	if (!data_reserve(e, size)) {
+		/* put invalid descriptor on list, can still be traversed */
+		WRITE_ONCE(d->next, EOL);
+		add_descr_list(e);
+		goto err_out;
+	}
+
+	WRITE_ONCE(d->data, e->data);
+	WRITE_ONCE(d->data_next, e->data);
+
+	if (DATA_WRAPS(rb, e->data) != DATA_WRAPS(rb, e->data_next)) {
+		b = TO_DATABLOCK(rb, 0);
+		WRITE_ONCE(b->id, e->id);
+	} else {
+		b = TO_DATABLOCK(rb, e->data);
+	}
+	buf = &b->data[0];
+
+	b = TO_DATABLOCK(rb, e->data);
+
+	/* MB3: synchronize descr setup */
+	smp_store_release(&b->id, e->id);
+
+	return buf;
+err_out:
+	local_irq_restore(e->irqflags);
+	return NULL;
+}
+EXPORT_SYMBOL(prb_reserve);
+
+/**
+ * prb_commit() - Commit (previously reserved) data to the ringbuffer.
+ * @e: The entry containing the reserved data information.
+ *
+ * This is the public function available to writers to commit data.
+ *
+ * Context: Any context. Enables local interrupts.
+ */
+void prb_commit(struct prb_reserved_entry *e)
+{
+	struct prb_descr *d = e->descr;
+
+	WRITE_ONCE(d->next, EOL);
+
+	/* MB4: synchronize commit */
+	smp_store_release(&d->data_next, e->data_next);
+
+	/* from this point on, the data could be expired */
+
+	add_descr_list(e);
+
+	/* now the descriptor is visible to the readers */
+
+	local_irq_restore(e->irqflags);
+}
+EXPORT_SYMBOL(prb_commit);
+
+/**
+ * get_datablock() - Return the data block for the provided logical positions.
+ * @rb: The ringbuffer containin the data block.
+ * @data: The logical position for the beginning of the data block.
+ * @data_next: The logical position for the data block next to this one.
+ *             This value is used to identify the end of the data block.
+ * @size: A pointer to an integer to set to the size of the data block.
+ *
+ * Since datablocks always contain contiguous data, the situation will occur
+ * where there is not enough room at the end of the array for a new data
+ * block. In this situation, two data blocks are created:
+ *
+ * * A "wrapping" data block at the end of the data array.
+ * * The real data block at the beginning of the data array.
+ *
+ * The descriptor contains the beginning position of the wrapping data block
+ * and the end position of the real data block. This function is used
+ * determines if a wrapping data block is being used and always returns the
+ * real data block and size. (Note that the descriptor id from the wrapping
+ * data block is used.)
+ *
+ * Return: A pointer to data block structure. Also, size is set to the size of
+ *         the data block.
+ */
+static struct prb_datablock *get_datablock(struct printk_ringbuffer *rb,
+					   unsigned long data,
+					   unsigned long data_next, int *size)
+{
+	if (DATA_WRAPS(rb, data) == DATA_WRAPS(rb, data_next)) {
+		*size = data_next - data;
+	} else {
+		*size = DATA_INDEX(rb, data_next);
+		data = 0;
+	}
+	*size -= sizeof(struct prb_datablock);
+
+	return TO_DATABLOCK(rb, data);
+}
+
+/**
+ * prb_iter_init() - Initialize an iterator structure.
+ * @iter: The iterator to initialize.
+ * @rb: The ringbuffer to associate with the iterator.
+ * @e: An entry structure to use during iteration.
+ *
+ * This is the public function available to readers to initialize their
+ * iterator structure.
+ *
+ * As an alternative, DECLARE_PRINTKRB_ITER() could be used.
+ *
+ * Context: Any context.
+ */
+void prb_iter_init(struct prb_iterator *iter, struct printk_ringbuffer *rb,
+		   struct prb_entry *e)
+{
+	iter->rb = rb;
+	iter->e = e;
+	iter->id = EOL;
+	iter->id_next = EOL;
+}
+EXPORT_SYMBOL(prb_iter_init);
+
+/**
+ * iter_peek_next_id() - Determine the next (newer) descriptor id.
+ * @iter: The iterator used for list traversal.
+ *
+ * If the iterator has not yet been used or has fallen behind and no longer
+ * has a pointer to a valid descriptor, the next descriptor will be the oldest
+ * descriptor in the list.
+ *
+ * Return: The next descriptor id. A value of EOL means there is no next
+ *         descriptor.
+ */
+static unsigned long iter_peek_next_id(struct prb_iterator *iter)
+{
+	struct printk_ringbuffer *rb = iter->rb;
+	unsigned long next_id = iter->id_next;
+	struct prb_descr *d;
+
+	if (iter->id == EOL) {
+		next_id = READ_ONCE(rb->descr_list.oldest);
+	} else if (iter->id_next == EOL) {
+		d = TO_DESCR(rb, iter->id);
+		next_id = READ_ONCE(d->next);
+
+		if (READ_ONCE(d->id) != iter->id)
+			next_id = READ_ONCE(rb->descr_list.oldest);
+	}
+
+	return next_id;
+}
+
+/**
+ * prb_iter_peek_next_entry() - Check if there is a next (newer) entry.
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
+	return (iter_peek_next_id(iter) != EOL);
+}
+EXPORT_SYMBOL(prb_iter_peek_next_entry);
+
+/**
+ * prb_iter_next_valid_entry() - Traverse to and read the next (newer) entry.
+ * @iter: The iterator used for list traversal.
+ *
+ * This is the public function available to readers to traverse the entry
+ * list.
+ *
+ * If the iterator has not yet been used or has fallen behind and no longer
+ * has a pointer to a valid descriptor, the next descriptor will be the oldest
+ * descriptor in the list.
+ *
+ * Context: Any context.
+ * Return: The size of the entry data or 0 if there is no next entry.
+ *
+ * The entry data is padded (if necessary) to allow aligment for following
+ * data blocks. Therefore the size value can be larger than the size reserved.
+ * If users want the exact size to be tracked, they should include this
+ * information within their data.
+ */
+int prb_iter_next_valid_entry(struct prb_iterator *iter)
+{
+	struct printk_ringbuffer *rb = iter->rb;
+	struct prb_entry *e = iter->e;
+	struct prb_datablock *b;
+	unsigned long data_next;
+	unsigned long next_id;
+	struct prb_descr *d;
+	unsigned long data;
+	int size;
+
+	iter->id_next = iter_peek_next_id(iter);
+
+	while (iter->id_next != EOL) {
+		d = TO_DESCR(rb, iter->id_next);
+		data = READ_ONCE(d->data);
+		data_next = READ_ONCE(d->data_next);
+
+		/*
+		 * Loaded a local copy of the data pointers before
+		 * checking for validity of the data.
+		 */
+		smp_rmb();
+
+		if (READ_ONCE(d->id) == iter->id_next &&
+		    data_valid(rb, READ_ONCE(rb->data_list.oldest),
+			       READ_ONCE(rb->data_list.newest),
+			       data, data_next)) {
+
+			b = get_datablock(rb, data, data_next, &size);
+
+			memcpy(&e->buffer[0], &b->data[0],
+			       size > e->buffer_size ? e->buffer_size : size);
+			e->seq = READ_ONCE(d->seq);
+
+			/*
+			 * Loaded a local copy of the data/seq before
+			 * rechecking the validity of the data.
+			 */
+			smp_rmb();
+
+			if (READ_ONCE(d->id) == iter->id_next &&
+			    data_valid(rb,
+				       READ_ONCE(rb->data_list.oldest),
+				       READ_ONCE(rb->data_list.newest),
+				       data,
+				       data_next)) {
+
+				iter->id = iter->id_next;
+				iter->id_next = READ_ONCE(d->next);
+				return size;
+			}
+		}
+
+		next_id = READ_ONCE(d->next);
+
+		/*
+		 * Loaded a local copy of the next descr before
+		 * checking the traversal-validity of the descr.
+		 * (It is enough for the id to be consistent.)
+		 */
+		smp_rmb();
+
+		if (READ_ONCE(d->id) == iter->id_next) {
+			iter->id = iter->id_next;
+			iter->id_next = next_id;
+		} else {
+			iter->id = EOL;
+			iter->id_next = READ_ONCE(rb->descr_list.oldest);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(prb_iter_next_valid_entry);
+
+/**
+ * prb_inc_lost() - Increment internal lost counter.
+ * @rb: The ringbuffer, whose counter to modify.
+ *
+ * This is the public function available to writers to update statistics about
+ * failed writes where the writer has given up.
+ *
+ * Context: Any context.
+ */
+void prb_inc_lost(struct printk_ringbuffer *rb)
+{
+        atomic_long_inc(&rb->lost);
+}
+EXPORT_SYMBOL(prb_inc_lost);
-- 
2.11.0


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ED6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B37214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389600AbfHGW1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:27:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51855 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389581AbfHGW1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:27:50 -0400
Received: from [5.158.153.52] (helo=g2noscherz.tec.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hvUP2-0007mg-V2; Thu, 08 Aug 2019 00:27:31 +0200
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
Subject: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
Date:   Thu,  8 Aug 2019 00:32:34 +0206
Message-Id: <20190807222634.1723-10-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807222634.1723-1-john.ogness@linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a major change because the API (and underlying workings)
of the new ringbuffer are completely different than the previous
ringbuffer. Since there are several components of the printk
infrastructure that use the ringbuffer API (console, /dev/kmsg,
syslog, kmsg_dump), there are quite a few changes throughout the
printk implementation.

This is also a conservative change because it continues to use the
logbuf_lock raw spinlock even though the new ringbuffer is lockless.

The externally visible changes are:

1. The exported vmcore info has changed:

    - VMCOREINFO_SYMBOL(log_buf);
    - VMCOREINFO_SYMBOL(log_buf_len);
    - VMCOREINFO_SYMBOL(log_first_idx);
    - VMCOREINFO_SYMBOL(clear_idx);
    - VMCOREINFO_SYMBOL(log_next_idx);
    + VMCOREINFO_SYMBOL(printk_rb_static);
    + VMCOREINFO_SYMBOL(printk_rb_dynamic);

2. For the CONFIG_PPC_POWERNV powerpc platform, kernel log buffer
   registration is no longer available because there is no longer
   a single contigous block of memory to represent all of the
   ringbuffer.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/powerpc/platforms/powernv/opal.c |  22 +-
 include/linux/kmsg_dump.h             |   6 +-
 include/linux/printk.h                |  12 -
 kernel/printk/printk.c                | 745 ++++++++++++++------------
 kernel/printk/ringbuffer.h            |  24 +
 5 files changed, 415 insertions(+), 394 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index aba443be7daa..8c4b894b6663 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -806,30 +806,10 @@ static void opal_export_attrs(void)
 
 static void __init opal_dump_region_init(void)
 {
-	void *addr;
-	uint64_t size;
-	int rc;
-
 	if (!opal_check_token(OPAL_REGISTER_DUMP_REGION))
 		return;
 
-	/* Register kernel log buffer */
-	addr = log_buf_addr_get();
-	if (addr == NULL)
-		return;
-
-	size = log_buf_len_get();
-	if (size == 0)
-		return;
-
-	rc = opal_register_dump_region(OPAL_DUMP_REGION_LOG_BUF,
-				       __pa(addr), size);
-	/* Don't warn if this is just an older OPAL that doesn't
-	 * know about that call
-	 */
-	if (rc && rc != OPAL_UNSUPPORTED)
-		pr_warn("DUMP: Failed to register kernel log buffer. "
-			"rc = %d\n", rc);
+	pr_warn("DUMP: This kernel does not support kernel log buffer registration.\n");
 }
 
 static void opal_pdev_init(const char *compatible)
diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 2e7a1e032c71..d9b721347742 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -46,10 +46,8 @@ struct kmsg_dumper {
 	bool registered;
 
 	/* private state of the kmsg iterator */
-	u32 cur_idx;
-	u32 next_idx;
-	u64 cur_seq;
-	u64 next_seq;
+	u64 last_seq;
+	u64 until_seq;
 };
 
 #ifdef CONFIG_PRINTK
diff --git a/include/linux/printk.h b/include/linux/printk.h
index cefd374c47b1..fd3007659cfb 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -194,8 +194,6 @@ devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write, void __user *buf,
 
 extern void wake_up_klogd(void);
 
-char *log_buf_addr_get(void);
-u32 log_buf_len_get(void);
 void log_buf_vmcoreinfo_setup(void);
 void __init setup_log_buf(int early);
 __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
@@ -235,16 +233,6 @@ static inline void wake_up_klogd(void)
 {
 }
 
-static inline char *log_buf_addr_get(void)
-{
-	return NULL;
-}
-
-static inline u32 log_buf_len_get(void)
-{
-	return 0;
-}
-
 static inline void log_buf_vmcoreinfo_setup(void)
 {
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1888f6a3b694..1a50e0c43775 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -56,6 +56,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/printk.h>
 
+#include "ringbuffer.h"
 #include "console_cmdline.h"
 #include "braille.h"
 #include "internal.h"
@@ -409,28 +410,38 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
-/* the next printk record to read by syslog(READ) or /proc/kmsg */
-static u64 syslog_seq;
-static u32 syslog_idx;
-static size_t syslog_partial;
-static bool syslog_time;
 
-/* index and sequence number of the first record stored in the buffer */
-static u64 log_first_seq;
-static u32 log_first_idx;
+/*
+ * Define the average message size. This only affects the number of
+ * descriptors that will be available. Underestimating is better than
+ * overestimating (too many available descriptors is better than not enough).
+ */
+#define PRB_AVGBITS 6
+
+DECLARE_PRINTKRB(printk_rb_static, PRB_AVGBITS,
+		 CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS, &log_wait);
+
+static struct printk_ringbuffer printk_rb_dynamic;
 
-/* index and sequence number of the next record to store in the buffer */
-static u64 log_next_seq;
-static u32 log_next_idx;
+static struct printk_ringbuffer *prb = &printk_rb_static;
 
-/* the next printk record to write to the console */
-static u64 console_seq;
-static u32 console_idx;
+/* the last printk record read by syslog(READ) or /proc/kmsg */
+static u64 syslog_last_seq;
+DECLARE_PRINTKRB_ENTRY(syslog_entry,
+	sizeof(struct printk_log) + CONSOLE_EXT_LOG_MAX);
+DECLARE_PRINTKRB_ITER(syslog_iter, &printk_rb_static, &syslog_entry);
+static size_t syslog_partial;
+static bool syslog_time;
+
+/* the last printk record written to the console */
+static u64 console_last_seq;
+DECLARE_PRINTKRB_ENTRY(console_entry,
+	sizeof(struct printk_log) + CONSOLE_EXT_LOG_MAX);
+DECLARE_PRINTKRB_ITER(console_iter, &printk_rb_static, &console_entry);
 static u64 exclusive_console_stop_seq;
 
-/* the next printk record to read after the last 'clear' command */
-static u64 clear_seq;
-static u32 clear_idx;
+/* the last printk record read before the last 'clear' command */
+static u64 clear_last_seq;
 
 #ifdef CONFIG_PRINTK_CALLER
 #define PREFIX_MAX		48
@@ -446,22 +457,8 @@ static u32 clear_idx;
 #define LOG_ALIGN __alignof__(struct printk_log)
 #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
 #define LOG_BUF_LEN_MAX (u32)(1 << 31)
-static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
-static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
 
-/* Return log buffer address */
-char *log_buf_addr_get(void)
-{
-	return log_buf;
-}
-
-/* Return log buffer size */
-u32 log_buf_len_get(void)
-{
-	return log_buf_len;
-}
-
 /* human readable text of the record */
 static char *log_text(const struct printk_log *msg)
 {
@@ -474,92 +471,12 @@ static char *log_dict(const struct printk_log *msg)
 	return (char *)msg + sizeof(struct printk_log) + msg->text_len;
 }
 
-/* get record by index; idx must point to valid msg */
-static struct printk_log *log_from_idx(u32 idx)
-{
-	struct printk_log *msg = (struct printk_log *)(log_buf + idx);
-
-	/*
-	 * A length == 0 record is the end of buffer marker. Wrap around and
-	 * read the message at the start of the buffer.
-	 */
-	if (!msg->len)
-		return (struct printk_log *)log_buf;
-	return msg;
-}
-
-/* get next record; idx must point to valid msg */
-static u32 log_next(u32 idx)
-{
-	struct printk_log *msg = (struct printk_log *)(log_buf + idx);
-
-	/* length == 0 indicates the end of the buffer; wrap */
-	/*
-	 * A length == 0 record is the end of buffer marker. Wrap around and
-	 * read the message at the start of the buffer as *this* one, and
-	 * return the one after that.
-	 */
-	if (!msg->len) {
-		msg = (struct printk_log *)log_buf;
-		return msg->len;
-	}
-	return idx + msg->len;
-}
-
-/*
- * Check whether there is enough free space for the given message.
- *
- * The same values of first_idx and next_idx mean that the buffer
- * is either empty or full.
- *
- * If the buffer is empty, we must respect the position of the indexes.
- * They cannot be reset to the beginning of the buffer.
- */
-static int logbuf_has_space(u32 msg_size, bool empty)
-{
-	u32 free;
-
-	if (log_next_idx > log_first_idx || empty)
-		free = max(log_buf_len - log_next_idx, log_first_idx);
-	else
-		free = log_first_idx - log_next_idx;
-
-	/*
-	 * We need space also for an empty header that signalizes wrapping
-	 * of the buffer.
-	 */
-	return free >= msg_size + sizeof(struct printk_log);
-}
-
-static int log_make_free_space(u32 msg_size)
-{
-	while (log_first_seq < log_next_seq &&
-	       !logbuf_has_space(msg_size, false)) {
-		/* drop old messages until we have enough contiguous space */
-		log_first_idx = log_next(log_first_idx);
-		log_first_seq++;
-	}
-
-	if (clear_seq < log_first_seq) {
-		clear_seq = log_first_seq;
-		clear_idx = log_first_idx;
-	}
-
-	/* sequence numbers are equal, so the log buffer is empty */
-	if (logbuf_has_space(msg_size, log_first_seq == log_next_seq))
-		return 0;
-
-	return -ENOMEM;
-}
-
-/* compute the message size including the padding bytes */
-static u32 msg_used_size(u16 text_len, u16 dict_len, u32 *pad_len)
+/* compute the message size */
+static u32 msg_used_size(u16 text_len, u16 dict_len)
 {
 	u32 size;
 
 	size = sizeof(struct printk_log) + text_len + dict_len;
-	*pad_len = (-size) & (LOG_ALIGN - 1);
-	size += *pad_len;
 
 	return size;
 }
@@ -573,21 +490,39 @@ static u32 msg_used_size(u16 text_len, u16 dict_len, u32 *pad_len)
 static const char trunc_msg[] = "<truncated>";
 
 static u32 truncate_msg(u16 *text_len, u16 *trunc_msg_len,
-			u16 *dict_len, u32 *pad_len)
+			u16 *dict_len)
 {
 	/*
 	 * The message should not take the whole buffer. Otherwise, it might
 	 * get removed too soon.
 	 */
 	u32 max_text_len = log_buf_len / MAX_LOG_TAKE_PART;
+	unsigned long max_available;
+
+	/* determine available text space in the ringbuffer */
+	max_available = prb_unused(prb);
+	if (max_available <= sizeof(struct printk_log))
+		return 0;
+	max_available -= sizeof(struct printk_log);
+
+	if (max_available < max_text_len)
+		max_text_len = max_available;
+
 	if (*text_len > max_text_len)
 		*text_len = max_text_len;
-	/* enable the warning message */
+
+	/* enable the warning message (if there is room) */
 	*trunc_msg_len = strlen(trunc_msg);
+	if (*text_len >= *trunc_msg_len)
+		*text_len -= *trunc_msg_len;
+	else
+		*trunc_msg_len = 0;
+
 	/* disable the "dict" completely */
 	*dict_len = 0;
+
 	/* compute the size again, count also the warning message */
-	return msg_used_size(*text_len + *trunc_msg_len, 0, pad_len);
+	return msg_used_size(*text_len + *trunc_msg_len, 0);
 }
 
 /* insert record into the buffer, discard old ones, update heads */
@@ -596,34 +531,26 @@ static int log_store(u32 caller_id, int facility, int level,
 		     const char *dict, u16 dict_len,
 		     const char *text, u16 text_len)
 {
+	struct prb_reserved_entry res_entry;
 	struct printk_log *msg;
-	u32 size, pad_len;
 	u16 trunc_msg_len = 0;
+	char *rbuf;
+	u32 size;
 
-	/* number of '\0' padding bytes to next message */
-	size = msg_used_size(text_len, dict_len, &pad_len);
+	size = msg_used_size(text_len, dict_len);
 
-	if (log_make_free_space(size)) {
+	rbuf = prb_reserve(&res_entry, prb, size);
+	if (IS_ERR(rbuf)) {
 		/* truncate the message if it is too long for empty buffer */
-		size = truncate_msg(&text_len, &trunc_msg_len,
-				    &dict_len, &pad_len);
+		size = truncate_msg(&text_len, &trunc_msg_len, &dict_len);
 		/* survive when the log buffer is too small for trunc_msg */
-		if (log_make_free_space(size))
+		rbuf = prb_reserve(&res_entry, prb, size);
+		if (IS_ERR(rbuf))
 			return 0;
 	}
 
-	if (log_next_idx + size + sizeof(struct printk_log) > log_buf_len) {
-		/*
-		 * This message + an additional empty header does not fit
-		 * at the end of the buffer. Add an empty header with len == 0
-		 * to signify a wrap around.
-		 */
-		memset(log_buf + log_next_idx, 0, sizeof(struct printk_log));
-		log_next_idx = 0;
-	}
-
 	/* fill message */
-	msg = (struct printk_log *)(log_buf + log_next_idx);
+	msg = (struct printk_log *)rbuf;
 	memcpy(log_text(msg), text, text_len);
 	msg->text_len = text_len;
 	if (trunc_msg_len) {
@@ -642,14 +569,13 @@ static int log_store(u32 caller_id, int facility, int level,
 #ifdef CONFIG_PRINTK_CALLER
 	msg->caller_id = caller_id;
 #endif
-	memset(log_dict(msg) + dict_len, 0, pad_len);
 	msg->len = size;
 
 	/* insert message */
-	log_next_idx += msg->len;
-	log_next_seq++;
+	prb_commit(&res_entry);
 
-	return msg->text_len;
+	/* msg is no longer valid, return the local copy */
+	return text_len;
 }
 
 int dmesg_restrict = IS_ENABLED(CONFIG_SECURITY_DMESG_RESTRICT);
@@ -770,13 +696,18 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return p - buf;
 }
 
+#define PRINTK_RECORD_MAX (sizeof(struct printk_log) + \
+			   CONSOLE_EXT_LOG_MAX + LOG_LINE_MAX + PREFIX_MAX)
+
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
-	u64 seq;
-	u32 idx;
+	u64 last_seq;
+	struct prb_iterator iter;
 	struct ratelimit_state rs;
 	struct mutex lock;
 	char buf[CONSOLE_EXT_LOG_MAX];
+	struct prb_entry entry;
+	char msgbuf[PRINTK_RECORD_MAX];
 };
 
 static __printf(3, 4) __cold
@@ -859,6 +790,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *ppos)
 {
 	struct devkmsg_user *user = file->private_data;
+	struct prb_iterator backup_iter;
 	struct printk_log *msg;
 	size_t len;
 	ssize_t ret;
@@ -871,7 +803,11 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		return ret;
 
 	logbuf_lock_irq();
-	while (user->seq == log_next_seq) {
+
+	/* make a backup copy in case there is a problem */
+	prb_iter_copy(&backup_iter, &user->iter);
+
+	if (prb_iter_next_valid_entry(&user->iter) == 0) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			logbuf_unlock_irq();
@@ -879,43 +815,53 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		}
 
 		logbuf_unlock_irq();
-		ret = wait_event_interruptible(log_wait,
-					       user->seq != log_next_seq);
-		if (ret)
+		ret = prb_iter_wait_next_valid_entry(&user->iter);
+		if (ret < 0)
 			goto out;
 		logbuf_lock_irq();
 	}
 
-	if (user->seq < log_first_seq) {
-		/* our last seen message is gone, return error and reset */
-		user->idx = log_first_idx;
-		user->seq = log_first_seq;
-		ret = -EPIPE;
-		logbuf_unlock_irq();
-		goto out;
+	if (user->entry.seq - user->last_seq != 1) {
+		DECLARE_PRINTKRB_SEQENTRY(e);
+		DECLARE_PRINTKRB_ITER(i, prb, &e);
+		u64 last_seq;
+
+		prb_iter_peek_next_entry(&i, &last_seq);
+		if (last_seq > user->last_seq) {
+			/* a record was missed, return error and reset */
+			prb_iter_sync(&user->iter, &i);
+			user->last_seq = last_seq;
+			ret = -EPIPE;
+			logbuf_unlock_irq();
+			goto out;
+		}
 	}
 
-	msg = log_from_idx(user->idx);
+	user->last_seq = user->entry.seq;
+
+	msg = (struct printk_log *)&user->entry.buffer[0];
 	len = msg_print_ext_header(user->buf, sizeof(user->buf),
-				   msg, user->seq);
+				   msg, user->last_seq);
 	len += msg_print_ext_body(user->buf + len, sizeof(user->buf) - len,
 				  log_dict(msg), msg->dict_len,
 				  log_text(msg), msg->text_len);
 
-	user->idx = log_next(user->idx);
-	user->seq++;
 	logbuf_unlock_irq();
 
 	if (len > count) {
 		ret = -EINVAL;
-		goto out;
+		goto restore_out;
 	}
 
 	if (copy_to_user(buf, user->buf, len)) {
 		ret = -EFAULT;
-		goto out;
+		goto restore_out;
 	}
 	ret = len;
+	goto out;
+restore_out:
+	prb_iter_copy(&user->iter, &backup_iter);
+	user->last_seq = user->entry.seq - 1;
 out:
 	mutex_unlock(&user->lock);
 	return ret;
@@ -935,8 +881,7 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	switch (whence) {
 	case SEEK_SET:
 		/* the first record */
-		user->idx = log_first_idx;
-		user->seq = log_first_seq;
+		user->last_seq = prb_iter_seek(&user->iter, 0);
 		break;
 	case SEEK_DATA:
 		/*
@@ -944,13 +889,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		 * like issued by 'dmesg -c'. Reading /dev/kmsg itself
 		 * changes no global state, and does not clear anything.
 		 */
-		user->idx = clear_idx;
-		user->seq = clear_seq;
+		user->last_seq = prb_iter_seek(&user->iter, clear_last_seq);
 		break;
 	case SEEK_END:
 		/* after the last record */
-		user->idx = log_next_idx;
-		user->seq = log_next_seq;
+		user->last_seq = prb_iter_seek(&user->iter, -1);
 		break;
 	default:
 		ret = -EINVAL;
@@ -963,19 +906,39 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 {
 	struct devkmsg_user *user = file->private_data;
 	__poll_t ret = 0;
+	u64 last_seq;
 
 	if (!user)
 		return EPOLLERR|EPOLLNVAL;
 
-	poll_wait(file, &log_wait, wait);
+	poll_wait(file, prb_wait_queue(prb), wait);
 
 	logbuf_lock_irq();
-	if (user->seq < log_next_seq) {
-		/* return error when data has vanished underneath us */
-		if (user->seq < log_first_seq)
-			ret = EPOLLIN|EPOLLRDNORM|EPOLLERR|EPOLLPRI;
-		else
-			ret = EPOLLIN|EPOLLRDNORM;
+	if (prb_iter_peek_next_entry(&user->iter, &last_seq)) {
+		ret = EPOLLIN|EPOLLRDNORM;
+		if (last_seq - user->last_seq != 1) {
+			DECLARE_PRINTKRB_SEQENTRY(e);
+			DECLARE_PRINTKRB_ITER(i, prb, &e);
+			u64 last_seq;
+
+			/*
+			 * The sequence number has jumped. This might mean
+			 * that the ringbuffer has overtaken the reader,
+			 * which would mean that the sequence number previous
+			 * the first entry will now be later than the last
+			 * entry the reader has seen.
+			 *
+			 * If instead the sequence number jump is due to
+			 * iterating over invalid entries, there is no error.
+			 */
+
+			/* get the sequence number previous the first entry */
+			prb_iter_peek_next_entry(&i, &last_seq);
+
+			/* return error when data has vanished underneath us */
+			if (last_seq > user->last_seq)
+				ret |= EPOLLERR|EPOLLPRI;
+		}
 	}
 	logbuf_unlock_irq();
 
@@ -1008,8 +971,10 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 	mutex_init(&user->lock);
 
 	logbuf_lock_irq();
-	user->idx = log_first_idx;
-	user->seq = log_first_seq;
+	user->entry.buffer = &user->msgbuf[0];
+	user->entry.buffer_size = sizeof(user->msgbuf);
+	prb_iter_init(&user->iter, prb, &user->entry);
+	prb_iter_peek_next_entry(&user->iter, &user->last_seq);
 	logbuf_unlock_irq();
 
 	file->private_data = user;
@@ -1050,11 +1015,8 @@ const struct file_operations kmsg_fops = {
  */
 void log_buf_vmcoreinfo_setup(void)
 {
-	VMCOREINFO_SYMBOL(log_buf);
-	VMCOREINFO_SYMBOL(log_buf_len);
-	VMCOREINFO_SYMBOL(log_first_idx);
-	VMCOREINFO_SYMBOL(clear_idx);
-	VMCOREINFO_SYMBOL(log_next_idx);
+	VMCOREINFO_SYMBOL(printk_rb_static);
+	VMCOREINFO_SYMBOL(printk_rb_dynamic);
 	/*
 	 * Export struct printk_log size and field offsets. User space tools can
 	 * parse it and detect any changes to structure down the line.
@@ -1136,13 +1098,36 @@ static void __init log_buf_add_cpu(void)
 static inline void log_buf_add_cpu(void) {}
 #endif /* CONFIG_SMP */
 
+static void __init add_to_rb(struct printk_ringbuffer *rb,
+			     struct prb_entry *e)
+{
+	struct printk_log *msg = (struct printk_log *)&e->buffer[0];
+	struct prb_reserved_entry re;
+	int size;
+	char *b;
+
+	size = sizeof(*msg) + msg->text_len + msg->dict_len;
+
+	b = prb_reserve(&re, rb, size);
+	if (!IS_ERR(b)) {
+		memcpy(b, msg, size);
+		prb_commit(&re);
+	}
+}
+
+static char setup_buf[PRINTK_RECORD_MAX] __initdata;
+
 void __init setup_log_buf(int early)
 {
+	struct prb_desc *new_descs;
+	struct prb_iterator i;
 	unsigned long flags;
+	struct prb_entry e;
 	char *new_log_buf;
 	unsigned int free;
+	int l;
 
-	if (log_buf != __log_buf)
+	if (prb != &printk_rb_static)
 		return;
 
 	if (!early && !new_log_buf_len)
@@ -1151,19 +1136,47 @@ void __init setup_log_buf(int early)
 	if (!new_log_buf_len)
 		return;
 
+	if (!is_power_of_2(new_log_buf_len))
+		return;
+
 	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
 	if (unlikely(!new_log_buf)) {
-		pr_err("log_buf_len: %lu bytes not available\n",
-			new_log_buf_len);
+		pr_err("log_buf_len: %lu data bytes not available\n",
+		       new_log_buf_len);
+		return;
+	}
+
+	new_descs = memblock_alloc((new_log_buf_len >> PRB_AVGBITS) *
+				   sizeof(struct prb_desc), LOG_ALIGN);
+	if (unlikely(!new_descs)) {
+		pr_err("log_buf_len: %lu desc bytes not available\n",
+		       new_log_buf_len >> PRB_AVGBITS);
+		memblock_free(__pa(new_log_buf), new_log_buf_len);
 		return;
 	}
 
+	e.buffer = &setup_buf[0];
+	e.buffer_size = sizeof(setup_buf);
+
 	logbuf_lock_irqsave(flags);
-	log_buf_len = new_log_buf_len;
-	log_buf = new_log_buf;
-	new_log_buf_len = 0;
-	free = __LOG_BUF_LEN - log_next_idx;
-	memcpy(log_buf, __log_buf, __LOG_BUF_LEN);
+
+	prb_init(&printk_rb_dynamic, new_log_buf,
+		 bits_per(new_log_buf_len) - 1, new_descs,
+		 (bits_per(new_log_buf_len) - 1) - PRB_AVGBITS, &log_wait);
+
+	free = __LOG_BUF_LEN;
+	prb_for_each_entry(&i, &printk_rb_static, &e, l) {
+		add_to_rb(&printk_rb_dynamic, &e);
+		free -= l;
+	}
+
+	prb_iter_init(&syslog_iter, &printk_rb_dynamic, &syslog_entry);
+	prb_iter_init(&console_iter, &printk_rb_dynamic, &console_entry);
+
+	prb_iter_seek(&console_iter, e.seq);
+
+	prb = &printk_rb_dynamic;
+
 	logbuf_unlock_irqrestore(flags);
 
 	pr_info("log_buf_len: %u bytes\n", log_buf_len);
@@ -1340,29 +1353,43 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog,
 static int syslog_print(char __user *buf, int size)
 {
 	char *text;
+	struct prb_iterator iter;
 	struct printk_log *msg;
+	struct prb_entry e;
+	char *msgbuf;
 	int len = 0;
 
 	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
+	msgbuf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
+	if (!msgbuf) {
+		kfree(text);
+		return -ENOMEM;
+	}
+
+	e.buffer = msgbuf;
+	e.buffer_size = PRINTK_RECORD_MAX;
+	prb_iter_init(&iter, prb, &e);
+	msg = (struct printk_log *)msgbuf;
 
 	while (size > 0) {
 		size_t n;
 		size_t skip;
 
 		logbuf_lock_irq();
-		if (syslog_seq < log_first_seq) {
-			/* messages are gone, move to first one */
-			syslog_seq = log_first_seq;
-			syslog_idx = log_first_idx;
-			syslog_partial = 0;
-		}
-		if (syslog_seq == log_next_seq) {
+		prb_iter_sync(&iter, &syslog_iter);
+		if (prb_iter_next_valid_entry(&iter) == 0) {
 			logbuf_unlock_irq();
 			break;
 		}
 
+		if (e.seq - syslog_last_seq != 1) {
+			/* messages are gone, move to first one */
+			syslog_last_seq = e.seq - 1;
+			syslog_partial = 0;
+		}
+
 		/*
 		 * To keep reading/counting partial line consistent,
 		 * use printk_time value as of the beginning of a line.
@@ -1371,16 +1398,15 @@ static int syslog_print(char __user *buf, int size)
 			syslog_time = printk_time;
 
 		skip = syslog_partial;
-		msg = log_from_idx(syslog_idx);
 		n = msg_print_text(msg, true, syslog_time, text,
 				   LOG_LINE_MAX + PREFIX_MAX);
 		if (n - syslog_partial <= size) {
 			/* message fits into buffer, move forward */
-			syslog_idx = log_next(syslog_idx);
-			syslog_seq++;
+			prb_iter_sync(&syslog_iter, &iter);
+			syslog_last_seq++;
 			n -= syslog_partial;
 			syslog_partial = 0;
-		} else if (!len){
+		} else if (!len) {
 			/* partial read(), remember position */
 			n = size;
 			syslog_partial += n;
@@ -1402,22 +1428,73 @@ static int syslog_print(char __user *buf, int size)
 		buf += n;
 	}
 
+	kfree(msgbuf);
 	kfree(text);
 	return len;
 }
 
+/**
+ * count_remaining() - Count the text bytes in following entries.
+ *
+ * @iter:      The iterator to use for counting.
+ *
+ * @until_seq: A sequence number to stop counting at.
+ *             The entry with this sequence number is not counted.
+ *
+ * Note that although this function will not modify @iter, it does make
+ * use of the prb_entry of @iter.
+ *
+ * Return: The number of bytes of text counted.
+ */
+static int count_remaining(struct prb_iterator *iter, const u64 until_seq)
+{
+	bool time = syslog_partial ? syslog_time : printk_time;
+	struct printk_log *msg;
+	struct prb_iterator i;
+	struct prb_entry *e;
+	int len = 0;
+
+	prb_iter_copy(&i, iter);
+	e = prb_iter_entry(&i);
+	msg = (struct printk_log *)&e->buffer[0];
+
+	for (;;) {
+		if (prb_iter_next_valid_entry(&i) == 0)
+			break;
+
+		if (e->seq >= until_seq)
+			break;
+
+		len += msg_print_text(msg, true, time, NULL, 0);
+		time = printk_time;
+	}
+
+	return len;
+}
+
 static int syslog_print_all(char __user *buf, int size, bool clear)
 {
+	struct prb_iterator iter;
+	struct printk_log *msg;
+	struct prb_entry e;
+	char *msgbuf;
+	int textlen;
 	char *text;
 	int len = 0;
-	u64 next_seq;
-	u64 seq;
-	u32 idx;
 	bool time;
 
 	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
+	msgbuf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
+	if (!msgbuf) {
+		kfree(text);
+		return -ENOMEM;
+	}
+
+	e.buffer = msgbuf;
+	e.buffer_size = PRINTK_RECORD_MAX;
+	msg = (struct printk_log *)msgbuf;
 
 	time = printk_time;
 	logbuf_lock_irq();
@@ -1425,73 +1502,65 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	 * Find first record that fits, including all following records,
 	 * into the user-provided buffer for this dump.
 	 */
-	seq = clear_seq;
-	idx = clear_idx;
-	while (seq < log_next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
-
-		len += msg_print_text(msg, true, time, NULL, 0);
-		idx = log_next(idx);
-		seq++;
-	}
+	prb_iter_init(&iter, prb, &e);
+	prb_iter_seek(&iter, clear_last_seq);
+	len = count_remaining(&iter, -1);
 
-	/* move first record forward until length fits into the buffer */
-	seq = clear_seq;
-	idx = clear_idx;
-	while (len > size && seq < log_next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
+	/* move iterator forward until text fits into the buffer */
+	while (len > size) {
+		if (prb_iter_next_valid_entry(&iter) == 0)
+			break;
 
 		len -= msg_print_text(msg, true, time, NULL, 0);
-		idx = log_next(idx);
-		seq++;
 	}
 
-	/* last message fitting into this dump */
-	next_seq = log_next_seq;
-
+	/* copy the rest of the messages into the buffer */
 	len = 0;
-	while (len >= 0 && seq < next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
-		int textlen = msg_print_text(msg, true, time, text,
-					     LOG_LINE_MAX + PREFIX_MAX);
+	for (;;) {
+		if (prb_iter_next_valid_entry(&iter) == 0)
+			break;
+
+		textlen = msg_print_text(msg, true, time, text,
+					 LOG_LINE_MAX + PREFIX_MAX);
 
-		idx = log_next(idx);
-		seq++;
+		if (len + textlen > size)
+			break;
 
 		logbuf_unlock_irq();
-		if (copy_to_user(buf + len, text, textlen))
+		if (copy_to_user(buf + len, text, textlen)) {
 			len = -EFAULT;
-		else
-			len += textlen;
+			logbuf_lock_irq();
+			break;
+		}
 		logbuf_lock_irq();
 
-		if (seq < log_first_seq) {
-			/* messages are gone, move to next one */
-			seq = log_first_seq;
-			idx = log_first_idx;
-		}
-	}
+		len += textlen;
 
-	if (clear) {
-		clear_seq = log_next_seq;
-		clear_idx = log_next_idx;
+		if (clear)
+			clear_last_seq = e.seq;
 	}
 	logbuf_unlock_irq();
 
+	kfree(msgbuf);
 	kfree(text);
 	return len;
 }
 
 static void syslog_clear(void)
 {
+	DECLARE_PRINTKRB_SEQENTRY(e);
+	DECLARE_PRINTKRB_ITER(i, prb, &e);
+
 	logbuf_lock_irq();
-	clear_seq = log_next_seq;
-	clear_idx = log_next_idx;
+	prb_iter_sync(&i, &syslog_iter);
+	clear_last_seq = prb_iter_seek(&i, -1);
 	logbuf_unlock_irq();
 }
 
 int do_syslog(int type, char __user *buf, int len, int source)
 {
+	DECLARE_PRINTKRB_SEQENTRY(e);
+	DECLARE_PRINTKRB_ITER(iter, prb, &e);
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
 	int error;
@@ -1512,10 +1581,15 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			return 0;
 		if (!access_ok(buf, len))
 			return -EFAULT;
-		error = wait_event_interruptible(log_wait,
-						 syslog_seq != log_next_seq);
-		if (error)
+
+		logbuf_lock_irq();
+		prb_iter_sync(&iter, &syslog_iter);
+		logbuf_unlock_irq();
+
+		error = prb_iter_wait_next_valid_entry(&iter);
+		if (error < 0)
 			return error;
+
 		error = syslog_print(buf, len);
 		break;
 	/* Read/clear last kernel messages */
@@ -1562,33 +1636,15 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
 		logbuf_lock_irq();
-		if (syslog_seq < log_first_seq) {
-			/* messages are gone, move to first one */
-			syslog_seq = log_first_seq;
-			syslog_idx = log_first_idx;
-			syslog_partial = 0;
-		}
 		if (source == SYSLOG_FROM_PROC) {
 			/*
 			 * Short-cut for poll(/"proc/kmsg") which simply checks
-			 * for pending data, not the size; return the count of
-			 * records, not the length.
+			 * for pending data, not the size; return true if there
+			 * is a pending record
 			 */
-			error = log_next_seq - syslog_seq;
+			error = prb_iter_peek_next_entry(&syslog_iter, NULL);
 		} else {
-			u64 seq = syslog_seq;
-			u32 idx = syslog_idx;
-			bool time = syslog_partial ? syslog_time : printk_time;
-
-			while (seq < log_next_seq) {
-				struct printk_log *msg = log_from_idx(idx);
-
-				error += msg_print_text(msg, true, time, NULL,
-							0);
-				time = printk_time;
-				idx = log_next(idx);
-				seq++;
-			}
+			error = count_remaining(&syslog_iter, -1);
 			error -= syslog_partial;
 		}
 		logbuf_unlock_irq();
@@ -1948,7 +2004,6 @@ asmlinkage int vprintk_emit(int facility, int level,
 	int printed_len;
 	bool in_sched = false, pending_output;
 	unsigned long flags;
-	u64 curr_log_seq;
 
 	/* Suppress unimportant messages after panic happens */
 	if (unlikely(suppress_printk))
@@ -1964,9 +2019,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	/* This stops the holder of console_sem just where we want him */
 	logbuf_lock_irqsave(flags);
-	curr_log_seq = log_next_seq;
 	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
-	pending_output = (curr_log_seq != log_next_seq);
+	pending_output = prb_iter_peek_next_entry(&console_iter, NULL);
 	logbuf_unlock_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
@@ -2056,18 +2110,15 @@ EXPORT_SYMBOL(printk);
 #define PREFIX_MAX		0
 #define printk_time		false
 
-static u64 syslog_seq;
-static u32 syslog_idx;
-static u64 console_seq;
-static u32 console_idx;
+DECLARE_PRINTKRB_SEQENTRY(syslog_entry);
+DECLARE_PRINTKRB_ITER(syslog_iter, NULL, NULL);
+DECLARE_PRINTKRB_SEQENTRY(console_entry);
+DECLARE_PRINTKRB_ITER(console_iter, NULL, NULL);
+
+static u64 console_last_seq;
 static u64 exclusive_console_stop_seq;
-static u64 log_first_seq;
-static u32 log_first_idx;
-static u64 log_next_seq;
 static char *log_text(const struct printk_log *msg) { return NULL; }
 static char *log_dict(const struct printk_log *msg) { return NULL; }
-static struct printk_log *log_from_idx(u32 idx) { return NULL; }
-static u32 log_next(u32 idx) { return 0; }
 static ssize_t msg_print_ext_header(char *buf, size_t size,
 				    struct printk_log *msg,
 				    u64 seq) { return 0; }
@@ -2402,36 +2453,32 @@ void console_unlock(void)
 
 		printk_safe_enter_irqsave(flags);
 		raw_spin_lock(&logbuf_lock);
-		if (console_seq < log_first_seq) {
-			len = sprintf(text,
-				      "** %llu printk messages dropped **\n",
-				      log_first_seq - console_seq);
+skip:
+		if (prb_iter_next_valid_entry(&console_iter) == 0)
+			break;
 
-			/* messages are gone, move to first one */
-			console_seq = log_first_seq;
-			console_idx = log_first_idx;
+		if (console_entry.seq - console_last_seq != 1) {
+			len = sprintf(text,
+				"** %llu printk messages dropped **\n",
+				console_entry.seq - (console_last_seq + 1));
 		} else {
 			len = 0;
 		}
-skip:
-		if (console_seq == log_next_seq)
-			break;
+		console_last_seq = console_entry.seq;
 
-		msg = log_from_idx(console_idx);
+		msg = (struct printk_log *)&console_entry.buffer[0];
 		if (suppress_message_printing(msg->level)) {
 			/*
 			 * Skip record we have buffered and already printed
 			 * directly to the console when we received it, and
 			 * record that has level above the console loglevel.
 			 */
-			console_idx = log_next(console_idx);
-			console_seq++;
 			goto skip;
 		}
 
 		/* Output to all consoles once old messages replayed. */
 		if (unlikely(exclusive_console &&
-			     console_seq >= exclusive_console_stop_seq)) {
+			     console_last_seq > exclusive_console_stop_seq)) {
 			exclusive_console = NULL;
 		}
 
@@ -2441,14 +2488,12 @@ void console_unlock(void)
 		if (nr_ext_console_drivers) {
 			ext_len = msg_print_ext_header(ext_text,
 						sizeof(ext_text),
-						msg, console_seq);
+						msg, console_last_seq);
 			ext_len += msg_print_ext_body(ext_text + ext_len,
 						sizeof(ext_text) - ext_len,
 						log_dict(msg), msg->dict_len,
 						log_text(msg), msg->text_len);
 		}
-		console_idx = log_next(console_idx);
-		console_seq++;
 		raw_spin_unlock(&logbuf_lock);
 
 		/*
@@ -2487,7 +2532,7 @@ void console_unlock(void)
 	 * flush, no worries.
 	 */
 	raw_spin_lock(&logbuf_lock);
-	retry = console_seq != log_next_seq;
+	retry = prb_iter_peek_next_entry(&console_iter, NULL);
 	raw_spin_unlock(&logbuf_lock);
 	printk_safe_exit_irqrestore(flags);
 
@@ -2556,8 +2601,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		unsigned long flags;
 
 		logbuf_lock_irqsave(flags);
-		console_seq = log_first_seq;
-		console_idx = log_first_idx;
+		console_last_seq = 0;
+		prb_iter_seek(&console_iter, 0);
 		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
@@ -2760,8 +2805,7 @@ void register_console(struct console *newcon)
 		 * for us.
 		 */
 		logbuf_lock_irqsave(flags);
-		console_seq = syslog_seq;
-		console_idx = syslog_idx;
+		prb_iter_sync(&console_iter, &syslog_iter);
 		/*
 		 * We're about to replay the log buffer.  Only do this to the
 		 * just-registered console to avoid excessive message spam to
@@ -2772,7 +2816,8 @@ void register_console(struct console *newcon)
 		 * ignores console_lock.
 		 */
 		exclusive_console = newcon;
-		exclusive_console_stop_seq = console_seq;
+		exclusive_console_stop_seq = console_last_seq;
+		console_last_seq = 0;
 		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
@@ -3033,6 +3078,8 @@ EXPORT_SYMBOL(printk_timed_ratelimit);
 static DEFINE_SPINLOCK(dump_list_lock);
 static LIST_HEAD(dump_list);
 
+static char kmsg_dump_msgbuf[PRINTK_RECORD_MAX];
+
 /**
  * kmsg_dump_register - register a kernel log dumper.
  * @dumper: pointer to the kmsg_dumper structure
@@ -3102,7 +3149,6 @@ module_param_named(always_kmsg_dump, always_kmsg_dump, bool, S_IRUGO | S_IWUSR);
 void kmsg_dump(enum kmsg_dump_reason reason)
 {
 	struct kmsg_dumper *dumper;
-	unsigned long flags;
 
 	if ((reason > KMSG_DUMP_OOPS) && !always_kmsg_dump)
 		return;
@@ -3115,12 +3161,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 		/* initialize iterator with data about the stored records */
 		dumper->active = true;
 
-		logbuf_lock_irqsave(flags);
-		dumper->cur_seq = clear_seq;
-		dumper->cur_idx = clear_idx;
-		dumper->next_seq = log_next_seq;
-		dumper->next_idx = log_next_idx;
-		logbuf_unlock_irqrestore(flags);
+		kmsg_dump_rewind(dumper);
 
 		/* invoke dumper which will iterate over records */
 		dumper->dump(dumper, reason);
@@ -3153,28 +3194,27 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 			       char *line, size_t size, size_t *len)
 {
-	struct printk_log *msg;
+	struct prb_entry e = {
+		.buffer		= &kmsg_dump_msgbuf[0],
+		.buffer_size	= sizeof(kmsg_dump_msgbuf),
+	};
+	DECLARE_PRINTKRB_ITER(i, prb, &e);
+	struct printk_log *msg = (struct printk_log *)&e.buffer[0];
 	size_t l = 0;
 	bool ret = false;
 
 	if (!dumper->active)
 		goto out;
 
-	if (dumper->cur_seq < log_first_seq) {
-		/* messages are gone, move to first available one */
-		dumper->cur_seq = log_first_seq;
-		dumper->cur_idx = log_first_idx;
-	}
+	dumper->last_seq = prb_iter_seek(&i, dumper->last_seq);
 
 	/* last entry */
-	if (dumper->cur_seq >= log_next_seq)
+	if (prb_iter_next_valid_entry(&i) == 0)
 		goto out;
 
-	msg = log_from_idx(dumper->cur_idx);
 	l = msg_print_text(msg, syslog, printk_time, line, size);
 
-	dumper->cur_idx = log_next(dumper->cur_idx);
-	dumper->cur_seq++;
+	dumper->last_seq = e.seq;
 	ret = true;
 out:
 	if (len)
@@ -3235,11 +3275,14 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
 bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 			  char *buf, size_t size, size_t *len)
 {
+	struct prb_entry e = {
+		.buffer		= &kmsg_dump_msgbuf[0],
+		.buffer_size	= sizeof(kmsg_dump_msgbuf),
+	};
+	DECLARE_PRINTKRB_ITER(i, prb, &e);
+	struct printk_log *msg = (struct printk_log *)&e.buffer[0];
 	unsigned long flags;
-	u64 seq;
-	u32 idx;
-	u64 next_seq;
-	u32 next_idx;
+	u64 next_until_seq;
 	size_t l = 0;
 	bool ret = false;
 	bool time = printk_time;
@@ -3248,55 +3291,45 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 		goto out;
 
 	logbuf_lock_irqsave(flags);
-	if (dumper->cur_seq < log_first_seq) {
-		/* messages are gone, move to first available one */
-		dumper->cur_seq = log_first_seq;
-		dumper->cur_idx = log_first_idx;
-	}
+
+	if (!dumper->until_seq)
+		dumper->until_seq = -1;
+
+	dumper->last_seq = prb_iter_seek(&i, dumper->last_seq);
 
 	/* last entry */
-	if (dumper->cur_seq >= dumper->next_seq) {
+	if (!prb_iter_peek_next_entry(&i, NULL)) {
 		logbuf_unlock_irqrestore(flags);
 		goto out;
 	}
 
 	/* calculate length of entire buffer */
-	seq = dumper->cur_seq;
-	idx = dumper->cur_idx;
-	while (seq < dumper->next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
+	l = count_remaining(&i, dumper->until_seq);
 
-		l += msg_print_text(msg, true, time, NULL, 0);
-		idx = log_next(idx);
-		seq++;
-	}
-
-	/* move first record forward until length fits into the buffer */
-	seq = dumper->cur_seq;
-	idx = dumper->cur_idx;
-	while (l > size && seq < dumper->next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
+	if (l <= size) {
+		/* last message in next iteration */
+		next_until_seq = dumper->last_seq;
+	} else {
+		/* move iterator forward until text fits into the buffer */
+		while (l > size) {
+			prb_iter_next_valid_entry(&i);
+			l -= msg_print_text(msg, true, time, NULL, 0);
+		}
 
-		l -= msg_print_text(msg, true, time, NULL, 0);
-		idx = log_next(idx);
-		seq++;
+		/* last message in next iteration */
+		next_until_seq = e.seq + 1;
 	}
 
-	/* last message in next interation */
-	next_seq = seq;
-	next_idx = idx;
-
+	/* copy messages to buffer */
 	l = 0;
-	while (seq < dumper->next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
-
+	for (;;) {
+		prb_iter_next_valid_entry(&i);
+		if (e.seq >= dumper->until_seq)
+			break;
 		l += msg_print_text(msg, syslog, time, buf + l, size - l);
-		idx = log_next(idx);
-		seq++;
 	}
 
-	dumper->next_seq = next_seq;
-	dumper->next_idx = next_idx;
+	dumper->until_seq = next_until_seq;
 	ret = true;
 	logbuf_unlock_irqrestore(flags);
 out:
@@ -3318,10 +3351,8 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
  */
 void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
 {
-	dumper->cur_seq = clear_seq;
-	dumper->cur_idx = clear_idx;
-	dumper->next_seq = log_next_seq;
-	dumper->next_idx = log_next_idx;
+	dumper->last_seq = clear_last_seq;
+	dumper->until_seq = 0;
 }
 
 /**
diff --git a/kernel/printk/ringbuffer.h b/kernel/printk/ringbuffer.h
index 70cb9ad284d4..02b4c53e287e 100644
--- a/kernel/printk/ringbuffer.h
+++ b/kernel/printk/ringbuffer.h
@@ -134,6 +134,8 @@ struct prb_iterator {
 	unsigned long			next_id;
 };
 
+#ifdef CONFIG_PRINTK
+
 /* writer interface */
 char *prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		  unsigned long size);
@@ -163,6 +165,28 @@ struct nl_node *prb_desc_node(unsigned long id, void *arg);
 bool prb_desc_busy(unsigned long id, void *arg);
 struct dr_desc *prb_getdesc(unsigned long id, void *arg);
 
+#else /* CONFIG_PRINTK */
+
+#define prb_reserve(e, rb, size) NULL
+#define prb_commit(e)
+#define prb_iter_init(iter, rb, e)
+#define prb_iter_next_valid_entry(iter) 0
+#define prb_iter_wait_next_valid_entry(iter) -ERESTARTSYS
+#define prb_iter_sync(dst, src)
+#define prb_iter_copy(dst, src)
+#define prb_iter_peek_next_entry(iter, last_seq) false
+#define prb_iter_seek(iter, last_seq) 0
+#define prb_wait_queue(rb) NULL
+#define prb_iter_entry(iter) NULL
+#define prb_getfail(rb) 0
+#define prb_init(rb, data, data_size_bits, descs, desc_count_bits, waitq)
+#define prb_unused(rb) 0
+#define prb_desc_node NULL
+#define prb_desc_busy NULL
+#define prb_getdesc NULL
+
+#endif /* CONFIG_PRINTK */
+
 /**
  * DECLARE_PRINTKRB() - Declare a printk ringbuffer.
  *
-- 
2.20.1


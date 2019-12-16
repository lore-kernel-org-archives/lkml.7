Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2ADC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3FB20725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfLPKBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:01:37 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:65497 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLPKBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:01:37 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBGA0EVj008200;
        Mon, 16 Dec 2019 19:00:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Mon, 16 Dec 2019 19:00:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBGA04DQ008154
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 Dec 2019 19:00:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] kconfig: Add kernel config option for fuzz testing.
Date:   Mon, 16 Dec 2019 18:59:55 +0900
Message-Id: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While syzkaller is finding many bugs, sometimes syzkaller examines
stupid operations. But disabling operations using kernel config option
is problematic because "kernel config option excludes whole module when
there is still room for examining all but specific operation" and
"the list of kernel config options becomes too complicated to maintain
because such list changes over time". Thus, this patch introduces a
kernel config option which allows disabling only specific operations.
This kernel config option should be enabled only when building kernels
for fuzz testing.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 drivers/char/mem.c                  |  6 +++---
 drivers/tty/serial/8250/8250_port.c |  7 +++++--
 drivers/tty/vt/keyboard.c           |  3 +++
 fs/ioctl.c                          |  5 +++++
 include/linux/uaccess.h             | 12 ++++++++++++
 kernel/printk/printk.c              |  8 ++++++++
 lib/Kconfig.debug                   | 10 ++++++++++
 lib/usercopy.c                      | 27 +++++++++++++++++++++++++++
 8 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 43dd0891ca1e..63aff3ae7c2b 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -246,7 +246,7 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 				return -EFAULT;
 			}
 
-			copied = copy_from_user(ptr, buf, sz);
+			copied = copy_from_user_to_any(ptr, buf, sz);
 			unxlate_dev_mem_ptr(p, ptr);
 			if (copied) {
 				written += sz - copied;
@@ -550,7 +550,7 @@ static ssize_t do_write_kmem(unsigned long p, const char __user *buf,
 		if (!virt_addr_valid(ptr))
 			return -ENXIO;
 
-		copied = copy_from_user(ptr, buf, sz);
+		copied = copy_from_user_to_any(ptr, buf, sz);
 		if (copied) {
 			written += sz - copied;
 			if (written)
@@ -604,7 +604,7 @@ static ssize_t write_kmem(struct file *file, const char __user *buf,
 				err = -ENXIO;
 				break;
 			}
-			n = copy_from_user(kbuf, buf, sz);
+			n = copy_from_user_to_any(kbuf, buf, sz);
 			if (n) {
 				err = -EFAULT;
 				break;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 90655910b0c7..367b92ad598b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -519,11 +519,14 @@ serial_port_out_sync(struct uart_port *p, int offset, int value)
 	case UPIO_MEM32:
 	case UPIO_MEM32BE:
 	case UPIO_AU:
-		p->serial_out(p, offset, value);
+		/* Writing to random kernel address causes crash. */
+		if (!IS_ENABLED(CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING))
+			p->serial_out(p, offset, value);
 		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
 		break;
 	default:
-		p->serial_out(p, offset, value);
+		if (!IS_ENABLED(CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING))
+			p->serial_out(p, offset, value);
 	}
 }
 
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 15d33fa0c925..367820b8ff59 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -633,6 +633,9 @@ static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
 	     kbd->kbdmode == VC_OFF) &&
 	     value != KVAL(K_SAK))
 		return;		/* SAK is allowed even in raw mode */
+	/* Repeating SysRq-t forever causes RCU stalls. */
+	if (IS_ENABLED(CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING))
+		return;
 	fn_handler[value](vc);
 }
 
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 2f5e4e5b97e1..f879aa94b118 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -601,6 +601,11 @@ static int ioctl_fsfreeze(struct file *filp)
 	if (sb->s_op->freeze_fs == NULL && sb->s_op->freeze_super == NULL)
 		return -EOPNOTSUPP;
 
+#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
+	/* Freezing filesystems causes hung tasks. */
+	return -EBUSY;
+#endif
+
 	/* Freeze */
 	if (sb->s_op->freeze_super)
 		return sb->s_op->freeze_super(sb);
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67f016010aad..6e5ddd0fdcce 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -387,4 +387,16 @@ void __noreturn usercopy_abort(const char *name, const char *detail,
 			       unsigned long len);
 #endif
 
+#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
+unsigned long __must_check copy_from_user_to_any(void *to,
+						 const void __user *from,
+						 unsigned long n);
+#else
+static __always_inline unsigned long __must_check
+copy_from_user_to_any(void *to, const void __user *from, unsigned long n)
+{
+	return copy_from_user(to, from, n);
+}
+#endif
+
 #endif		/* __LINUX_UACCESS_H__ */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1ef6f75d92f1..9a2f95a78fef 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1198,6 +1198,14 @@ MODULE_PARM_DESC(ignore_loglevel,
 
 static bool suppress_message_printing(int level)
 {
+#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
+	/*
+	 * Changing console_loglevel causes "no output". But ignoring
+	 * console_loglevel is easier than preventing change of
+	 * console_loglevel.
+	 */
+	return (level >= CONSOLE_LOGLEVEL_DEFAULT && !ignore_loglevel);
+#endif
 	return (level >= console_loglevel && !ignore_loglevel);
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d1842fe756d5..f9836cc23942 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2184,4 +2184,14 @@ config HYPERV_TESTING
 	help
 	  Select this option to enable Hyper-V vmbus testing.
 
+config KERNEL_BUILT_FOR_FUZZ_TESTING
+       bool "Build kernel for fuzz testing"
+       default n
+       help
+	 Say N unless you are building kernels for fuzz testing.
+	 Saying Y here disables several things that legitimately cause
+	 damage under a fuzzer workload (e.g. copying to arbitrary
+	 user-specified kernel address, changing console loglevel,
+	 freezing filesystems).
+
 endmenu # Kernel hacking
diff --git a/lib/usercopy.c b/lib/usercopy.c
index cbb4d9ec00f2..f7d5d243a63d 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -86,3 +86,30 @@ int check_zeroed_user(const void __user *from, size_t size)
 	return -EFAULT;
 }
 EXPORT_SYMBOL(check_zeroed_user);
+
+#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
+/*
+ * Since copying to arbitrary user-specified kernel address will crash
+ * the kernel trivially, do not copy to user-specified kernel address
+ * if the kernel was build for fuzz testing.
+ */
+unsigned long __must_check copy_from_user_to_any(void *to,
+						 const void __user *from,
+						 unsigned long n)
+{
+	static char dummybuf[PAGE_SIZE];
+	unsigned long ret = 0;
+
+	while (n) {
+		unsigned long size = min(n, sizeof(dummybuf));
+
+		ret = copy_from_user(dummybuf, from, size);
+		if (ret)
+			break;
+		from += size;
+		n -= size;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(copy_from_user_to_any);
+#endif
-- 
2.18.1


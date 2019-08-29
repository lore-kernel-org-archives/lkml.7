Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D37C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28A32054F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=volatile.bz header.i=@volatile.bz header.b="LXWLVOfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfH2BxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 21:53:23 -0400
Received: from mx1.volatile.bz ([185.163.46.97]:46492 "EHLO mx1.volatile.bz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfH2BxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 21:53:23 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Aug 2019 21:53:20 EDT
Received: from thedarkness.local (unknown [IPv6:2600:6c5d:4200:1e2a:5ae6:e27c:4008:d85e])
        by mx1.volatile.bz (Postfix) with ESMTPSA id 98A1659E;
        Thu, 29 Aug 2019 01:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=volatile.bz;
        s=default; t=1567043095;
        bh=XF5ep0RSxhs2O+Ubui44MzrRwO3yQMVktN3z00o66U8=;
        h=Date:From:To:Subject;
        b=LXWLVOfxsFLDu0KF2gYdo8ZKgbrqbPe3wEEGQGwxA2kZGgVkF369NkFzjhl5TLXfP
         4uB4MasuzjPmJFNNlCEJD5L9AowaNZhZWDcAwL0jINCit9Qu3DfQc8/6cShOnc2eO1
         cYKLAP/cdHRAdx44S2HL4lGENljWxKwtE8DJbWgg=
Date:   Wed, 28 Aug 2019 21:44:50 -0400
From:   Alexander Neville <dark@volatile.bz>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] um: Rewrite host RNG driver.
Message-ID: <20190828204609.02a7ff70@TheDarkness>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old driver had a bug that would cause it to outright stop working if
the host's /dev/random were to block. Instead of trying to track down
the cause of said bug, rewriting it from scratch turned out to be a much
better option as it came with a few benefits:

 - The new driver properly registers itself as an hardware RNG.

 - The code is simpler and therefore easier to maintain.

 - It serves as a minimal example of writing a hardware RNG driver.

I also edited the Kconfig symbol to bring it up to more modern
standards.

Signed-off-by: Alexander Neville <dark@volatile.bz>
---
 arch/um/drivers/Makefile       |   3 +-
 arch/um/drivers/random.c       | 192 ++++++++-------------------------
 drivers/char/hw_random/Kconfig |  21 ++--
 3 files changed, 59 insertions(+), 157 deletions(-)

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 693319839f69..29b0364f267d 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -17,6 +17,7 @@ hostaudio-objs := hostaudio_kern.o
 ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
+uml-rng-objs := random.o
 
 LDFLAGS_pcap.o := -r $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
 
@@ -60,7 +61,7 @@ obj-$(CONFIG_TTY_CHAN) += tty.o
 obj-$(CONFIG_XTERM_CHAN) += xterm.o xterm_kern.o
 obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
-obj-$(CONFIG_UML_RANDOM) += random.o
+obj-$(CONFIG_UML_RANDOM) += uml-rng.o
 
 # pcap_user.o must be added explicitly.
 USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o vde_user.o vector_user.o
diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
index 1d5d3057e6f1..7a3099277ebd 100644
--- a/arch/um/drivers/random.c
+++ b/arch/um/drivers/random.c
@@ -1,175 +1,75 @@
-/* Copyright (C) 2005 - 2008 Jeff Dike <jdike@{linux.intel,addtoit}.com> */
-
-/* Much of this ripped from drivers/char/hw_random.c, see there for other
- * copyright.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * UML Host RNG Driver
+ *
+ * (c) Copright 2019 Alexander Neville <dark@volatile.bz>
  *
- * This software may be used and distributed according to the terms
- * of the GNU General Public License, incorporated herein by reference.
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
  */
-#include <linux/sched/signal.h>
+
+#include <linux/kernel.h>
+#include <linux/types.h>
 #include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/interrupt.h>
-#include <linux/miscdevice.h>
-#include <linux/delay.h>
-#include <linux/uaccess.h>
-#include <init.h>
-#include <irq_kern.h>
+#include <linux/hw_random.h>
+#include <linux/fcntl.h>
 #include <os.h>
 
-/*
- * core module and version information
- */
-#define RNG_VERSION "1.0.0"
-#define RNG_MODULE_NAME "hw_random"
-
-#define RNG_MISCDEV_MINOR		183 /* official */
-
-/* Changed at init time, in the non-modular case, and at module load
- * time, in the module case.  Presumably, the module subsystem
- * protects against a module being loaded twice at the same time.
- */
-static int random_fd = -1;
-static DECLARE_WAIT_QUEUE_HEAD(host_read_wait);
-
-static int rng_dev_open (struct inode *inode, struct file *filp)
+static int uml_rng_read(struct hwrng *rng, void *data, size_t bufsize,
+			bool wait)
 {
-	/* enforce read-only access to this chrdev */
-	if ((filp->f_mode & FMODE_READ) == 0)
-		return -EINVAL;
-	if ((filp->f_mode & FMODE_WRITE) != 0)
-		return -EINVAL;
-
-	return 0;
+	return os_read_file(rng->priv, data, bufsize);
 }
 
-static atomic_t host_sleep_count = ATOMIC_INIT(0);
-
-static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
-			     loff_t *offp)
+static int uml_rng_init(struct hwrng *rng)
 {
-	u32 data;
-	int n, ret = 0, have_data;
-
-	while (size) {
-		n = os_read_file(random_fd, &data, sizeof(data));
-		if (n > 0) {
-			have_data = n;
-			while (have_data && size) {
-				if (put_user((u8) data, buf++)) {
-					ret = ret ? : -EFAULT;
-					break;
-				}
-				size--;
-				ret++;
-				have_data--;
-				data >>= 8;
-			}
-		}
-		else if (n == -EAGAIN) {
-			DECLARE_WAITQUEUE(wait, current);
-
-			if (filp->f_flags & O_NONBLOCK)
-				return ret ? : -EAGAIN;
-
-			atomic_inc(&host_sleep_count);
-			add_sigio_fd(random_fd);
-
-			add_wait_queue(&host_read_wait, &wait);
-			set_current_state(TASK_INTERRUPTIBLE);
-
-			schedule();
-			remove_wait_queue(&host_read_wait, &wait);
-
-			if (atomic_dec_and_test(&host_sleep_count)) {
-				ignore_sigio_fd(random_fd);
-				deactivate_fd(random_fd, RANDOM_IRQ);
-			}
-		}
-		else
-			return n;
+	int fd = os_open_file("/dev/random", of_read(OPENFLAGS()), O_NONBLOCK);
 
-		if (signal_pending (current))
-			return ret ? : -ERESTARTSYS;
+	if (fd < 0) {
+		pr_debug("uml-rng: failed to open /dev/random");
+		return fd;
 	}
-	return ret;
-}
 
-static const struct file_operations rng_chrdev_ops = {
-	.owner		= THIS_MODULE,
-	.open		= rng_dev_open,
-	.read		= rng_dev_read,
-	.llseek		= noop_llseek,
-};
+	int err = os_set_fd_async(fd);
 
-/* rng_init shouldn't be called more than once at boot time */
-static struct miscdevice rng_miscdev = {
-	RNG_MISCDEV_MINOR,
-	RNG_MODULE_NAME,
-	&rng_chrdev_ops,
-};
+	if (err < 0) {
+		os_close_file(fd);
+		return err;
+	}
 
-static irqreturn_t random_interrupt(int irq, void *data)
-{
-	wake_up(&host_read_wait);
+	rng->priv = fd;
 
-	return IRQ_HANDLED;
+	return 0;
 }
 
-/*
- * rng_init - initialize RNG module
- */
-static int __init rng_init (void)
+static void uml_rng_cleanup(struct hwrng *rng)
 {
-	int err;
-
-	err = os_open_file("/dev/random", of_read(OPENFLAGS()), 0);
-	if (err < 0)
-		goto out;
-
-	random_fd = err;
-
-	err = um_request_irq(RANDOM_IRQ, random_fd, IRQ_READ, random_interrupt,
-			     0, "random", NULL);
-	if (err)
-		goto err_out_cleanup_hw;
-
-	sigio_broken(random_fd, 1);
-
-	err = misc_register (&rng_miscdev);
-	if (err) {
-		printk (KERN_ERR RNG_MODULE_NAME ": misc device register "
-			"failed\n");
-		goto err_out_cleanup_hw;
-	}
-out:
-	return err;
-
-err_out_cleanup_hw:
-	os_close_file(random_fd);
-	random_fd = -1;
-	goto out;
+	os_close_file(rng->priv);
 }
 
-/*
- * rng_cleanup - shutdown RNG module
- */
 
-static void cleanup(void)
+static struct hwrng uml_rng_ops = {
+	.name		= "uml-rng",
+	.init		= uml_rng_init,
+	.cleanup	= uml_rng_cleanup,
+	.read		= uml_rng_read,
+	.quality	= 1024
+};
+
+static int __init uml_rng_mod_init(void)
 {
-	free_irq_by_fd(random_fd);
-	os_close_file(random_fd);
+	return hwrng_register(&uml_rng_ops);
 }
 
-static void __exit rng_cleanup(void)
+static void __exit uml_rng_mod_exit(void)
 {
-	os_close_file(random_fd);
-	misc_deregister (&rng_miscdev);
+	hwrng_unregister(&uml_rng_ops);
 }
 
-module_init (rng_init);
-module_exit (rng_cleanup);
-__uml_exitcall(cleanup);
+module_init(uml_rng_mod_init);
+module_exit(uml_rng_mod_exit);
 
-MODULE_DESCRIPTION("UML Host Random Number Generator (RNG) driver");
+MODULE_AUTHOR("Alexander Neville <dark@volatile.bz>");
+MODULE_DESCRIPTION("UML Host RNG Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 59f25286befe..762acbdd52ce 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -440,22 +440,23 @@ config HW_RANDOM_OPTEE
 
 	  If unsure, say Y.
 
-endif # HW_RANDOM
-
 config UML_RANDOM
+	tristate "UML Host Random Number Generator Support"
 	depends on UML
-	tristate "Hardware random number generator"
+	default HW_RANDOM
 	help
 	  This option enables UML's "hardware" random number generator.  It
 	  attaches itself to the host's /dev/random, supplying as much entropy
 	  as the host has, rather than the small amount the UML gets from its
-	  own drivers.  It registers itself as a standard hardware random number
-	  generator, major 10, minor 183, and the canonical device name is
-	  /dev/hwrng.
-	  The way to make use of this is to install the rng-tools package
-	  (check your distro, or download from
-	  http://sourceforge.net/projects/gkernel/).  rngd periodically reads
-	  /dev/hwrng and injects the entropy into /dev/random.
+	  own drivers.
+
+	  To compile this driver as a moudle, choose M here: the module
+	  will be called uml-rng
+
+	  If unsure, say Y.
+
+endif # HW_RANDOM
+
 
 config HW_RANDOM_KEYSTONE
 	depends on ARCH_KEYSTONE
-- 
2.23.0

Sorry about the diff being a bit messy. If desired, I can manually fix
the diff.

Also, please let me know if my mail client decided to mangle my patch.

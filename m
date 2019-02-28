Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B67AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B352F206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ho8lwH0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfB1Wp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:45:29 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:37802 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfB1Wp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:45:27 -0500
Received: by mail-it1-f202.google.com with SMTP id q141so9757125itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 14:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u73jCkXFL2POTTvMCMv7ZqTMPf3k7bn3erx/FRu/gvg=;
        b=Ho8lwH0YxKGVNqvm0Jc1+0KjU9E8HBG83DZ88mkt7s+RcUpsxl5Dt1Kf/PJHbYqBE+
         3aJ8Fy0y5/XsvOvy+bsnO4Xg/M47lofri1LrCfL/z01+gecD7HrSbbwZl+5vPqtRMLFR
         t7W5W6FUeHYeJeJUuU2A/2YArKj2t0E2Qou4mrj905z9GhNT/iNEGNRoyBAGtXEfE2w6
         Hx9sjpK33Rf/Y6gl4F/yZTsOgFI7a8FUQ11XiSEUNeCuR5lWx+E+8J0+TPJ1nkfnt/wY
         lh+X88Y1yHssjnxD9KefEB5Ghk/nSBNTp5OzIzigdllGkaa7Ytp6rlwK2xwemKvxwqt5
         72sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u73jCkXFL2POTTvMCMv7ZqTMPf3k7bn3erx/FRu/gvg=;
        b=BR4E4qBpQViVSDyPHujbjdNCM5JyEximjmRaq5b017wpJV2sdbw2f8/5+hTSrFjUse
         vN1qL62bub9a1AwQ5f13qJEAiGCgeY3mmy4nQ/QHYz1P/UQIGKv1MocrZxYvuhC+dEx3
         17FtppH+BKk/BMjVdc9HNreGlt2jWElmo4DemkwK9fnG+MIZ5myN7N/egv3pLgCfyGgG
         b52pYPiUpU9gbzMYof/6yEO8J4S2PjXd1gZznoj0/Pvm0IskxfXR0bW7FGUj5BsNAhxE
         Yi3fM7BcUCePCjv8+c9+MbH2tYOortsFVHMPMqUgkbHDeNPn5Ly8zShnat56Pla/PXQ8
         G70A==
X-Gm-Message-State: APjAAAWfbNF8H7Lg5ofjYzqCcNXBdEtxfn2aPVv7nDgDEpD+eDuFl+G9
        aZvFggVIriwMCZ9haMzzlr0OsZwm1xDNWEwViCouLA==
X-Google-Smtp-Source: APXvYqxQUufBGv+9yQHLXwUt7jCwll9cNotUOq6WihISWPeN2VIti0sBUHVAXLv+3PnXSszKrncSQVuzl2Y16WWYw+QE6A==
X-Received: by 2002:a24:508e:: with SMTP id m136mr1396084itb.34.1551393926426;
 Thu, 28 Feb 2019 14:45:26 -0800 (PST)
Date:   Thu, 28 Feb 2019 14:44:42 -0800
In-Reply-To: <20190228224507.198833-1-matthewgarrett@google.com>
Message-Id: <20190228224507.198833-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228224507.198833-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 02/27] Add a SysRq option to lift kernel lockdown
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Kyle McMartin <kyle@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle McMartin <kyle@redhat.com>

Make an option to provide a sysrq key that will lift the kernel lockdown,
thereby allowing the running kernel image to be accessed and modified.

On x86 this is triggered with SysRq+x, but this key may not be available on
all arches, so it is set by setting LOCKDOWN_LIFT_KEY in asm/setup.h.
Since this macro must be defined in an arch to be able to use this facility
for that arch, the Kconfig option is restricted to arches that support it.

Signed-off-by: Kyle McMartin <kyle@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: x86@kernel.org
---
 arch/x86/include/asm/setup.h |  2 ++
 drivers/input/misc/uinput.c  |  1 +
 drivers/tty/sysrq.c          | 19 ++++++++++-----
 include/linux/input.h        |  5 ++++
 include/linux/sysrq.h        |  8 +++++-
 kernel/debug/kdb/kdb_main.c  |  2 +-
 security/Kconfig             |  9 +++++++
 security/lock_down.c         | 47 ++++++++++++++++++++++++++++++++++++
 8 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ed8ec011a9fd..8daf633a5347 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -9,6 +9,8 @@
 #include <linux/linkage.h>
 #include <asm/page_types.h>
 
+#define LOCKDOWN_LIFT_KEY 'x'
+
 #ifdef __i386__
 
 #include <linux/pfn.h>
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 26ec603fe220..a73e92490286 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -366,6 +366,7 @@ static int uinput_create_device(struct uinput_device *udev)
 		dev->flush = uinput_dev_flush;
 	}
 
+	dev->flags |= INPUTDEV_FLAGS_SYNTHETIC;
 	dev->event = uinput_dev_event;
 
 	input_set_drvdata(udev->dev, udev);
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 1f03078ec352..0a05d336008e 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -480,6 +480,7 @@ static struct sysrq_key_op *sysrq_key_table[36] = {
 	/* x: May be registered on mips for TLB dump */
 	/* x: May be registered on ppc/powerpc for xmon */
 	/* x: May be registered on sparc64 for global PMU dump */
+	/* x: May be registered on x86_64 for disabling secure boot */
 	NULL,				/* x */
 	/* y: May be registered on sparc64 for global register dump */
 	NULL,				/* y */
@@ -523,7 +524,7 @@ static void __sysrq_put_key_op(int key, struct sysrq_key_op *op_p)
                 sysrq_key_table[i] = op_p;
 }
 
-void __handle_sysrq(int key, bool check_mask)
+void __handle_sysrq(int key, unsigned int from)
 {
 	struct sysrq_key_op *op_p;
 	int orig_log_level;
@@ -543,11 +544,15 @@ void __handle_sysrq(int key, bool check_mask)
 
         op_p = __sysrq_get_key_op(key);
         if (op_p) {
+		/* Ban synthetic events from some sysrq functionality */
+		if ((from == SYSRQ_FROM_PROC || from == SYSRQ_FROM_SYNTHETIC) &&
+		    op_p->enable_mask & SYSRQ_DISABLE_USERSPACE)
+			printk("This sysrq operation is disabled from userspace.\n");
 		/*
 		 * Should we check for enabled operations (/proc/sysrq-trigger
 		 * should not) and is the invoked operation enabled?
 		 */
-		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
+		if (from == SYSRQ_FROM_KERNEL || sysrq_on_mask(op_p->enable_mask)) {
 			pr_cont("%s\n", op_p->action_msg);
 			console_loglevel = orig_log_level;
 			op_p->handler(key);
@@ -579,7 +584,7 @@ void __handle_sysrq(int key, bool check_mask)
 void handle_sysrq(int key)
 {
 	if (sysrq_on())
-		__handle_sysrq(key, true);
+		__handle_sysrq(key, SYSRQ_FROM_KERNEL);
 }
 EXPORT_SYMBOL(handle_sysrq);
 
@@ -659,7 +664,7 @@ static void sysrq_do_reset(struct timer_list *t)
 static void sysrq_handle_reset_request(struct sysrq_state *state)
 {
 	if (state->reset_requested)
-		__handle_sysrq(sysrq_xlate[KEY_B], false);
+		__handle_sysrq(sysrq_xlate[KEY_B], SYSRQ_FROM_KERNEL);
 
 	if (sysrq_reset_downtime_ms)
 		mod_timer(&state->keyreset_timer,
@@ -812,8 +817,10 @@ static bool sysrq_handle_keypress(struct sysrq_state *sysrq,
 
 	default:
 		if (sysrq->active && value && value != 2) {
+			int from = sysrq->handle.dev->flags & INPUTDEV_FLAGS_SYNTHETIC ?
+					SYSRQ_FROM_SYNTHETIC : 0;
 			sysrq->need_reinject = false;
-			__handle_sysrq(sysrq_xlate[code], true);
+			__handle_sysrq(sysrq_xlate[code], from);
 		}
 		break;
 	}
@@ -1096,7 +1103,7 @@ static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
 
 		if (get_user(c, buf))
 			return -EFAULT;
-		__handle_sysrq(c, false);
+		__handle_sysrq(c, SYSRQ_FROM_PROC);
 	}
 
 	return count;
diff --git a/include/linux/input.h b/include/linux/input.h
index 7c7516eb7d76..38cd0ea72c37 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -42,6 +42,7 @@ struct input_value {
  * @phys: physical path to the device in the system hierarchy
  * @uniq: unique identification code for the device (if device has it)
  * @id: id of the device (struct input_id)
+ * @flags: input device flags (SYNTHETIC, etc.)
  * @propbit: bitmap of device properties and quirks
  * @evbit: bitmap of types of events supported by the device (EV_KEY,
  *	EV_REL, etc.)
@@ -124,6 +125,8 @@ struct input_dev {
 	const char *uniq;
 	struct input_id id;
 
+	unsigned int flags;
+
 	unsigned long propbit[BITS_TO_LONGS(INPUT_PROP_CNT)];
 
 	unsigned long evbit[BITS_TO_LONGS(EV_CNT)];
@@ -190,6 +193,8 @@ struct input_dev {
 };
 #define to_input_dev(d) container_of(d, struct input_dev, dev)
 
+#define	INPUTDEV_FLAGS_SYNTHETIC	0x000000001
+
 /*
  * Verify that we are in sync with input_device_id mod_devicetable.h #defines
  */
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 8c71874e8485..7de1f08b60a9 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -29,6 +29,8 @@
 #define SYSRQ_ENABLE_BOOT	0x0080
 #define SYSRQ_ENABLE_RTNICE	0x0100
 
+#define SYSRQ_DISABLE_USERSPACE	0x00010000
+
 struct sysrq_key_op {
 	void (*handler)(int);
 	char *help_msg;
@@ -43,8 +45,12 @@ struct sysrq_key_op {
  * are available -- else NULL's).
  */
 
+#define SYSRQ_FROM_KERNEL	0x0001
+#define SYSRQ_FROM_PROC		0x0002
+#define SYSRQ_FROM_SYNTHETIC	0x0004
+
 void handle_sysrq(int key);
-void __handle_sysrq(int key, bool check_mask);
+void __handle_sysrq(int key, unsigned int from);
 int register_sysrq_key(int key, struct sysrq_key_op *op);
 int unregister_sysrq_key(int key, struct sysrq_key_op *op);
 struct sysrq_key_op *__sysrq_get_key_op(int key);
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 82a3b32a7cfc..efee1abf5e8e 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1981,7 +1981,7 @@ static int kdb_sr(int argc, const char **argv)
 		return KDB_ARGCOUNT;
 
 	kdb_trap_printk++;
-	__handle_sysrq(*argv[1], check_mask);
+	__handle_sysrq(*argv[1], check_mask ? SYSRQ_FROM_KERNEL : 0);
 	kdb_trap_printk--;
 
 	return 0;
diff --git a/security/Kconfig b/security/Kconfig
index c2aff0006de2..afaf6fa17c9a 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -245,6 +245,15 @@ config LOCK_DOWN_KERNEL_FORCE
         help
           Enable the kernel lock down functionality automatically at boot.
 
+config ALLOW_LOCKDOWN_LIFT_BY_SYSRQ
+	bool "Allow the kernel lockdown to be lifted by SysRq"
+	depends on LOCK_DOWN_KERNEL
+	depends on MAGIC_SYSRQ
+	depends on X86
+	help
+	  Allow the lockdown on a kernel to be lifted, by pressing a SysRq key
+	  combination on a wired keyboard.
+
 source "security/selinux/Kconfig"
 source "security/smack/Kconfig"
 source "security/tomoyo/Kconfig"
diff --git a/security/lock_down.c b/security/lock_down.c
index 13a8228c1034..cfbc2c39712b 100644
--- a/security/lock_down.c
+++ b/security/lock_down.c
@@ -11,8 +11,14 @@
 
 #include <linux/security.h>
 #include <linux/export.h>
+#include <linux/sysrq.h>
+#include <asm/setup.h>
 
+#ifdef CONFIG_ALLOW_LOCKDOWN_LIFT_BY_SYSRQ
+static __read_mostly bool kernel_locked_down;
+#else
 static __ro_after_init bool kernel_locked_down;
+#endif
 
 /*
  * Put the kernel into lock-down mode.
@@ -57,3 +63,44 @@ bool __kernel_is_locked_down(const char *what, bool first)
 	return kernel_locked_down;
 }
 EXPORT_SYMBOL(__kernel_is_locked_down);
+
+#ifdef CONFIG_ALLOW_LOCKDOWN_LIFT_BY_SYSRQ
+
+/*
+ * Take the kernel out of lockdown mode.
+ */
+static void lift_kernel_lockdown(void)
+{
+	pr_notice("Lifting lockdown\n");
+	kernel_locked_down = false;
+}
+
+/*
+ * Allow lockdown to be lifted by pressing something like SysRq+x (and not by
+ * echoing the appropriate letter into the sysrq-trigger file).
+ */
+static void sysrq_handle_lockdown_lift(int key)
+{
+	if (kernel_locked_down)
+		lift_kernel_lockdown();
+}
+
+static struct sysrq_key_op lockdown_lift_sysrq_op = {
+	.handler	= sysrq_handle_lockdown_lift,
+	.help_msg	= "unSB(x)",
+	.action_msg	= "Disabling Secure Boot restrictions",
+	.enable_mask	= SYSRQ_DISABLE_USERSPACE,
+};
+
+static int __init lockdown_lift_sysrq(void)
+{
+	if (kernel_locked_down) {
+		lockdown_lift_sysrq_op.help_msg[5] = LOCKDOWN_LIFT_KEY;
+		register_sysrq_key(LOCKDOWN_LIFT_KEY, &lockdown_lift_sysrq_op);
+	}
+	return 0;
+}
+
+late_initcall(lockdown_lift_sysrq);
+
+#endif /* CONFIG_ALLOW_LOCKDOWN_LIFT_BY_SYSRQ */
-- 
2.21.0.352.gf09ad66450-goog


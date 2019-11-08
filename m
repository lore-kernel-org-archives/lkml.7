Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF2C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB8A2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbfKHUHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:07:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52534 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbfKHUHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:07:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iTAX5-0002Bl-8G; Fri, 08 Nov 2019 21:06:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B13771C0105;
        Fri,  8 Nov 2019 21:06:58 +0100 (CET)
Date:   Fri, 08 Nov 2019 20:06:58 -0000
From:   "tip-bot2 for Zhang Xiaoxu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Restrict MTRR ranges dumping and ioctl()
Cc:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tyler Hicks <tyhicks@canonical.com>, "x86-ml" <x86@kernel.org>,
        zhangxiaoxu@huawei.com, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191105071714.27376-1-zhangxiaoxu5@huawei.com>
References: <20191105071714.27376-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Message-ID: <157324361834.29376.5328593346754751963.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     d5a8b06841082ead88493eb918dd646a12c19d8e
Gitweb:        https://git.kernel.org/tip/d5a8b06841082ead88493eb918dd646a12c19d8e
Author:        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
AuthorDate:    Tue, 05 Nov 2019 15:17:14 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 08 Nov 2019 20:59:40 +01:00

x86/mtrr: Restrict MTRR ranges dumping and ioctl()

/proc/mtrr dumps the physical memory ranges of the variable range MTRRs
along with their respective sizes and caching attributes. Since that
file is world-readable, it presents a small information leak about the
physical address ranges of a system which should be blocked.

Make that file root-only.

Make the ioctl root-only as well because the $NAME read ioctl also
allows access. Replace the checks in the write ioctls with a single one
on entry.

 [ bp: rewrite commit message. ]

Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: x86-ml <x86@kernel.org>
Cc: zhangxiaoxu@huawei.com
Link: https://lkml.kernel.org/r/20191105071714.27376-1-zhangxiaoxu5@huawei.com
---
 arch/x86/kernel/cpu/mtrr/if.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 4d36dcc..8e0cee8 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -84,6 +84,15 @@ mtrr_file_del(unsigned long base, unsigned long size,
 	return reg;
 }
 
+static ssize_t
+mtrr_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return seq_read(file, buf, size, ppos);
+}
+
 /*
  * seq_file can seek but we ignore it.
  *
@@ -165,6 +174,9 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 	struct mtrr_gentry gentry;
 	void __user *arg = (void __user *) __arg;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	memset(&gentry, 0, sizeof(gentry));
 
 	switch (cmd) {
@@ -226,8 +238,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_ADD_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
 				  file, 0);
@@ -236,24 +246,18 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_SET_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_add(sentry.base, sentry.size, sentry.type, false);
 		break;
 	case MTRRIOC_DEL_ENTRY:
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_DEL_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 0);
 		break;
 	case MTRRIOC_KILL_ENTRY:
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_KILL_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_del(-1, sentry.base, sentry.size);
 		break;
 	case MTRRIOC_GET_ENTRY:
@@ -279,8 +283,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_ADD_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
 				  file, 1);
@@ -289,8 +291,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_SET_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_add_page(sentry.base, sentry.size, sentry.type, false);
 		break;
@@ -298,16 +298,12 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_DEL_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 1);
 		break;
 	case MTRRIOC_KILL_PAGE_ENTRY:
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_KILL_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_del_page(-1, sentry.base, sentry.size);
 		break;
 	case MTRRIOC_GET_PAGE_ENTRY:
@@ -387,7 +383,7 @@ static int mtrr_open(struct inode *inode, struct file *file)
 static const struct file_operations mtrr_fops = {
 	.owner			= THIS_MODULE,
 	.open			= mtrr_open,
-	.read			= seq_read,
+	.read			= mtrr_read,
 	.llseek			= seq_lseek,
 	.write			= mtrr_write,
 	.unlocked_ioctl		= mtrr_ioctl,
@@ -436,7 +432,7 @@ static int __init mtrr_if_init(void)
 	    (!cpu_has(c, X86_FEATURE_CENTAUR_MCR)))
 		return -ENODEV;
 
-	proc_create("mtrr", S_IWUSR | S_IRUGO, NULL, &mtrr_fops);
+	proc_create("mtrr", 0600, NULL, &mtrr_fops);
 	return 0;
 }
 arch_initcall(mtrr_if_init);

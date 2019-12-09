Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A9FC2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4660C205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLIIvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:51:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37918 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfLIIvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:51:48 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ieElS-000546-TS; Mon, 09 Dec 2019 09:51:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4739D1C2782;
        Mon,  9 Dec 2019 09:51:34 +0100 (CET)
Date:   Mon, 09 Dec 2019 08:51:34 -0000
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Require CAP_SYS_ADMIN for all access
Cc:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        James Morris <jamorris@linux.microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tyler Hicks <tyhicks@canonical.com>, "x86-ml" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <201911181308.63F06502A1@keescook>
References: <201911181308.63F06502A1@keescook>
MIME-Version: 1.0
Message-ID: <157588149410.21853.5799502733139367173.tip-bot2@tip-bot2>
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

Commit-ID:     4fc265a9c9b258ddd7eafbd0dbfca66687c3d8aa
Gitweb:        https://git.kernel.org/tip/4fc265a9c9b258ddd7eafbd0dbfca66687c3d8aa
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Mon, 18 Nov 2019 13:09:21 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 09 Dec 2019 09:24:24 +01:00

x86/mtrr: Require CAP_SYS_ADMIN for all access

Zhang Xiaoxu noted that physical address locations for MTRR were visible
to non-root users, which could be considered an information leak.
In discussing[1] the options for solving this, it sounded like just
moving the capable check into open() was the first step.

If this breaks userspace, then we will have a test case for the more
conservative approaches discussed in the thread. In summary:

- MTRR should check capabilities at open time (or retain the
  checks on the opener's permissions for later checks).

- changing the DAC permissions might break something that expects to
  open mtrr when not uid 0.

- if we leave the DAC permissions alone and just move the capable check
  to the opener, we should get the desired protection. (i.e. check
  against CAP_SYS_ADMIN not just the wider uid 0.)

- if that still breaks things, as in userspace expects to be able to
  read other parts of the file as non-uid-0 and non-CAP_SYS_ADMIN, then
  we need to censor the contents using the opener's permissions. For
  example, as done in other /proc cases, like commit

  51d7b120418e ("/proc/iomem: only expose physical resource addresses to privileged users").

[1] https://lore.kernel.org/lkml/201911110934.AC5BA313@keescook/

Reported-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: James Morris <jamorris@linux.microsoft.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-security-module@vger.kernel.org
Cc: Matthew Garrett <mjg59@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: x86-ml <x86@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/201911181308.63F06502A1@keescook
---
 arch/x86/kernel/cpu/mtrr/if.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 268d318..da532f6 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -101,9 +101,6 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	int length;
 	size_t linelen;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	memset(line, 0, LINE_SIZE);
 
 	len = min_t(size_t, len, LINE_SIZE - 1);
@@ -226,8 +223,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_ADD_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
 				  file, 0);
@@ -236,24 +231,18 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
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
@@ -279,8 +268,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_ADD_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
 				  file, 1);
@@ -289,8 +276,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_SET_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_add_page(sentry.base, sentry.size, sentry.type, false);
 		break;
@@ -298,16 +283,12 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
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
@@ -410,6 +391,8 @@ static int mtrr_open(struct inode *inode, struct file *file)
 		return -EIO;
 	if (!mtrr_if->get)
 		return -ENXIO;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
 	return single_open(file, mtrr_seq_show, NULL);
 }
 

Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5327BC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283B42085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbfKHUMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:12:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52549 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKHUMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:12:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iTAcj-0002Fz-1P; Fri, 08 Nov 2019 21:12:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A0F331C0105;
        Fri,  8 Nov 2019 21:12:48 +0100 (CET)
Date:   Fri, 08 Nov 2019 20:12:48 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Get rid of mtrr_seq_show() forward declaration
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108200815.24589-1-bp@alien8.de>
References: <20191108200815.24589-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <157324396829.29376.10225460729022651496.tip-bot2@tip-bot2>
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

Commit-ID:     bb2385bc38ffcea8afd0968e1895424e512c176c
Gitweb:        https://git.kernel.org/tip/bb2385bc38ffcea8afd0968e1895424e512c176c
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 08 Nov 2019 21:05:45 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 08 Nov 2019 21:10:02 +01:00

x86/mtrr: Get rid of mtrr_seq_show() forward declaration

... by moving the function up in the file.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20191108200815.24589-1-bp@alien8.de
---
 arch/x86/kernel/cpu/mtrr/if.c | 42 ++++++++++++++++------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 8e0cee8..79f0d2d 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -369,28 +369,6 @@ static int mtrr_close(struct inode *ino, struct file *file)
 	return single_release(ino, file);
 }
 
-static int mtrr_seq_show(struct seq_file *seq, void *offset);
-
-static int mtrr_open(struct inode *inode, struct file *file)
-{
-	if (!mtrr_if)
-		return -EIO;
-	if (!mtrr_if->get)
-		return -ENXIO;
-	return single_open(file, mtrr_seq_show, NULL);
-}
-
-static const struct file_operations mtrr_fops = {
-	.owner			= THIS_MODULE,
-	.open			= mtrr_open,
-	.read			= mtrr_read,
-	.llseek			= seq_lseek,
-	.write			= mtrr_write,
-	.unlocked_ioctl		= mtrr_ioctl,
-	.compat_ioctl		= mtrr_ioctl,
-	.release		= mtrr_close,
-};
-
 static int mtrr_seq_show(struct seq_file *seq, void *offset)
 {
 	char factor;
@@ -422,6 +400,26 @@ static int mtrr_seq_show(struct seq_file *seq, void *offset)
 	return 0;
 }
 
+static int mtrr_open(struct inode *inode, struct file *file)
+{
+	if (!mtrr_if)
+		return -EIO;
+	if (!mtrr_if->get)
+		return -ENXIO;
+	return single_open(file, mtrr_seq_show, NULL);
+}
+
+static const struct file_operations mtrr_fops = {
+	.owner			= THIS_MODULE,
+	.open			= mtrr_open,
+	.read			= mtrr_read,
+	.llseek			= seq_lseek,
+	.write			= mtrr_write,
+	.unlocked_ioctl		= mtrr_ioctl,
+	.compat_ioctl		= mtrr_ioctl,
+	.release		= mtrr_close,
+};
+
 static int __init mtrr_if_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;

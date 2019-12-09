Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CA5C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD9F20828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLIIvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:51:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37907 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIIvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:51:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ieElS-000547-VQ; Mon, 09 Dec 2019 09:51:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 781451C28F2;
        Mon,  9 Dec 2019 09:51:34 +0100 (CET)
Date:   Mon, 09 Dec 2019 08:51:34 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Get rid of mtrr_seq_show() forward declaration
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191108200815.24589-1-bp@alien8.de>
References: <20191108200815.24589-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <157588149438.21853.11921626365712409629.tip-bot2@tip-bot2>
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

Commit-ID:     2e30dd9e0698d5a04698f38e932a6e29893d8a93
Gitweb:        https://git.kernel.org/tip/2e30dd9e0698d5a04698f38e932a6e29893d8a93
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 08 Nov 2019 21:05:45 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 09 Dec 2019 09:23:44 +01:00

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
index 4d36dcc..268d318 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -373,28 +373,6 @@ static int mtrr_close(struct inode *ino, struct file *file)
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
-	.read			= seq_read,
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
@@ -426,6 +404,26 @@ static int mtrr_seq_show(struct seq_file *seq, void *offset)
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
+	.read			= seq_read,
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

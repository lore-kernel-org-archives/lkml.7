Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C9CFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B688F2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="iY8l3XFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbfKHUIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:08:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44480 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387873AbfKHUIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:08:23 -0500
Received: from zn.tnic (p200300EC2F0D370031FC6389B14AE3A0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3700:31fc:6389:b14a:e3a0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 972141EC0ABC;
        Fri,  8 Nov 2019 21:08:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573243702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=HbbJZAVi5Zm0MCj/wpA4pAwtwIej6bFGtURXyje7Puo=;
        b=iY8l3XFs3Frq89SYHo1SAfcWn1tsw1g1+Rv9eQoFLVIrSlWmyhWjf/rkLanrCan7hm9oaV
        bpyJ81WJksFpEEK1HlD4lTVnrsOIeoosn2pg2akuJ7c2Ln/lONYactFDTBSjL2FlkPP/hN
        zDNFkPTU+e2UqWiIYUWX2z6vJjICDPQ=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [PATCH] x86/mtrr: Get rid of mtrr_seq_show() forward declaration
Date:   Fri,  8 Nov 2019 21:08:15 +0100
Message-Id: <20191108200815.24589-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... by moving the function up in the file.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/mtrr/if.c | 42 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 8e0cee89fd11..79f0d2d42b0d 100644
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
-- 
2.21.0


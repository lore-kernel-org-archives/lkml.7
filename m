Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A07C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC7921851
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419395;
	bh=c9LPplSzz/uVr4cX4W0O58ybJ3HneGqBkRGgS8Tz5aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F31YpaY9LzDjp9+YIZs+9WkSIj8Msi9yNqdfUQV98sAPZhSRhthUwlFKl1glk1XWc
	 KD64BVsEHK5HTOJJ9ckfBzQJLmV2xpl+belAWKlAqwjpcR1VAoFelPDs2uLBRn7vWA
	 zhWiM/c+3i4O4lmoxPMz19i/gYUwiUwR243ORvUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403836AbfGRDJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391084AbfGRDJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:09:51 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DEB6205F4;
        Thu, 18 Jul 2019 03:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419390;
        bh=c9LPplSzz/uVr4cX4W0O58ybJ3HneGqBkRGgS8Tz5aI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRYG/LKV8Zb7GpI0gcsl9FOq7WMw1OHYwEZDohLNHgZISWIkUxEVpeSeJjXCUFJBr
         p3u79i24ujf88cTIN9jwMrS/6Ebuv4nS1j7DAEdA1FGW6KYWdgCce+37Z2CehhmgFy
         YT+fPc/JZ770k4DAzXvBfGWxqxhZlzHUyl9uo4Pg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dianzhang Chen <dianzhangchen0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        hpa@zytor.com
Subject: [PATCH 4.14 45/80] x86/tls: Fix possible spectre-v1 in do_get_thread_area()
Date:   Thu, 18 Jul 2019 12:01:36 +0900
Message-Id: <20190718030102.121554920@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dianzhang Chen <dianzhangchen0@gmail.com>

commit 993773d11d45c90cb1c6481c2638c3d9f092ea5b upstream.

The index to access the threads tls array is controlled by userspace
via syscall: sys_ptrace(), hence leading to a potential exploitation
of the Spectre variant 1 vulnerability.

The index can be controlled from:
        ptrace -> arch_ptrace -> do_get_thread_area.

Fix this by sanitizing the user supplied index before using it to access
the p->thread.tls_array.

Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1561524630-3642-1-git-send-email-dianzhangchen0@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/tls.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -5,6 +5,7 @@
 #include <linux/user.h>
 #include <linux/regset.h>
 #include <linux/syscalls.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <asm/desc.h>
@@ -220,6 +221,7 @@ int do_get_thread_area(struct task_struc
 		       struct user_desc __user *u_info)
 {
 	struct user_desc info;
+	int index;
 
 	if (idx == -1 && get_user(idx, &u_info->entry_number))
 		return -EFAULT;
@@ -227,8 +229,11 @@ int do_get_thread_area(struct task_struc
 	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
 
-	fill_user_desc(&info, idx,
-		       &p->thread.tls_array[idx - GDT_ENTRY_TLS_MIN]);
+	index = idx - GDT_ENTRY_TLS_MIN;
+	index = array_index_nospec(index,
+			GDT_ENTRY_TLS_MAX - GDT_ENTRY_TLS_MIN + 1);
+
+	fill_user_desc(&info, idx, &p->thread.tls_array[index]);
 
 	if (copy_to_user(u_info, &info, sizeof(info)))
 		return -EFAULT;



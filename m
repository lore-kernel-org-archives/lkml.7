Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1047CC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE75A21738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pANqH+Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfF0Vww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:52:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42901 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Vwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:52:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RLqiID465029
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 14:52:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RLqiID465029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561672365;
        bh=khn3r00Mh/oll3SSxEsnbv3xA1Z7S/uSRwMBTSlDevs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pANqH+EeH7+SsPxR8hRgsSImY+lQBHI7vFclhD/uxnBHAnMj23FVqX2ChvW2mCfhA
         yfzUV6xYd8Ku2MbnvJZpp8C7k2VuBe6jsaYC/2nsmWODgZs8/iPyuDdV07duqOd1h6
         wfTidXLvVuvGtgYNmx06nnvj5YJ7cwVFlpzGtMebutUIjadIq5jRVTfTrbhi6rNcN3
         jTMpqQaIneAO5J7x2Ul4PbM2oOfLFi46/U1lDUmbFbUgoafqtvCxcY3sWqW0leHwFL
         bB6cEaOPpaczbG9xXWMdZLvlLj8+g/z8+VyynygT6girD3QJ0TL+x94W3fPjuZBIDw
         hWQ4gJ7sjsxdw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RLqirW465026;
        Thu, 27 Jun 2019 14:52:44 -0700
Date:   Thu, 27 Jun 2019 14:52:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dianzhang Chen <tipbot@zytor.com>
Message-ID: <tip-993773d11d45c90cb1c6481c2638c3d9f092ea5b@git.kernel.org>
Cc:     dianzhangchen0@gmail.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          dianzhangchen0@gmail.com
In-Reply-To: <1561524630-3642-1-git-send-email-dianzhangchen0@gmail.com>
References: <1561524630-3642-1-git-send-email-dianzhangchen0@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/tls: Fix possible spectre-v1 in
 do_get_thread_area()
Git-Commit-ID: 993773d11d45c90cb1c6481c2638c3d9f092ea5b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  993773d11d45c90cb1c6481c2638c3d9f092ea5b
Gitweb:     https://git.kernel.org/tip/993773d11d45c90cb1c6481c2638c3d9f092ea5b
Author:     Dianzhang Chen <dianzhangchen0@gmail.com>
AuthorDate: Wed, 26 Jun 2019 12:50:30 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Jun 2019 23:48:04 +0200

x86/tls: Fix possible spectre-v1 in do_get_thread_area()

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

---
 arch/x86/kernel/tls.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index a5b802a12212..71d3fef1edc9 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -5,6 +5,7 @@
 #include <linux/user.h>
 #include <linux/regset.h>
 #include <linux/syscalls.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <asm/desc.h>
@@ -220,6 +221,7 @@ int do_get_thread_area(struct task_struct *p, int idx,
 		       struct user_desc __user *u_info)
 {
 	struct user_desc info;
+	int index;
 
 	if (idx == -1 && get_user(idx, &u_info->entry_number))
 		return -EFAULT;
@@ -227,8 +229,11 @@ int do_get_thread_area(struct task_struct *p, int idx,
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

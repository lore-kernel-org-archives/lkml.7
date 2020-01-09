Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF384C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 01:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEC92067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 01:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgAIBnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 20:43:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:53410 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbgAIBnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 20:43:11 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 860306547382F741E094;
        Thu,  9 Jan 2020 09:43:09 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 09:43:00 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <mark.rutland@arm.com>, <hch@infradead.org>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <yangyingliang@huawei.com>,
        <bobo.shaobowang@huawei.com>, <guohanjun@huawei.com>,
        <wcohen@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mtk.manpages@gmail.com>, <wezhang@redhat.com>
Subject: [PATCH] sys_personality: Add a optional arch hook arch_check_personality() for common sys_personality()
Date:   Thu, 9 Jan 2020 09:38:46 +0800
Message-ID: <20200109013846.174796-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently arm64 use __arm64_sys_arm64_personality() as its default
syscall. But using a normal hook arch_check_personality() can reject
personality settings for special case of different archs.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 arch/arm64/kernel/sys.c |  7 +++----
 kernel/exec_domain.c    | 14 ++++++++++----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index d5ffaaab31a7..5c01816d7a77 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -28,12 +28,13 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
 }
 
-SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
+int arch_check_personality(unsigned int personality)
 {
 	if (personality(personality) == PER_LINUX32 &&
 		!system_supports_32bit_el0())
 		return -EINVAL;
-	return ksys_personality(personality);
+
+	return 0;
 }
 
 asmlinkage long sys_ni_syscall(void);
@@ -46,8 +47,6 @@ asmlinkage long __arm64_sys_ni_syscall(const struct pt_regs *__unused)
 /*
  * Wrappers to pass the pt_regs argument.
  */
-#define __arm64_sys_personality		__arm64_sys_arm64_personality
-
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	asmlinkage long __arm64_##sym(const struct pt_regs *);
 #include <asm/unistd.h>
diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
index 33f07c5f2515..d1d5d14441e2 100644
--- a/kernel/exec_domain.c
+++ b/kernel/exec_domain.c
@@ -35,12 +35,18 @@ static int __init proc_execdomains_init(void)
 module_init(proc_execdomains_init);
 #endif
 
+int __weak arch_check_personality(unsigned int personality)
+{
+	return 0;
+}
+
 SYSCALL_DEFINE1(personality, unsigned int, personality)
 {
-	unsigned int old = current->personality;
+	int check;
 
-	if (personality != 0xffffffff)
-		set_personality(personality);
+	check = arch_check_personality(personality);
+	if (check)
+		return check;
 
-	return old;
+	return ksys_personality(personality);
 }
-- 
2.20.1


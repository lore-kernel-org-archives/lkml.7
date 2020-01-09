Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64904C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BDB20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgAINk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:40:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8247 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbgAINk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:40:57 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A5C634568D018053A16A;
        Thu,  9 Jan 2020 21:40:54 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 21:40:47 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <mark.rutland@arm.com>, <hch@infradead.org>,
        <linux@dominikbrodowski.net>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <yangyingliang@huawei.com>,
        <bobo.shaobowang@huawei.com>, <guohanjun@huawei.com>,
        <wcohen@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mtk.manpages@gmail.com>, <wezhang@redhat.com>
Subject: [PATCH v2] sys_personality: Add a optional arch hook arch_check_personality() for common sys_personality()
Date:   Thu, 9 Jan 2020 21:36:34 +0800
Message-ID: <20200109133634.176483-1-bobo.shaobowang@huawei.com>
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
 Changes in v2:
  - Delete inline ksys_personality() definition.
  - Update sys_personality() definition.
 Changes in v1:
  - Delete macro __arm64_sys_personality.
  - Add hook arch_check_personality() and update sys_personality().
---
 arch/arm64/kernel/sys.c  |  7 +++----
 include/linux/syscalls.h | 10 ----------
 kernel/exec_domain.c     | 14 +++++++++++++-
 3 files changed, 16 insertions(+), 15 deletions(-)

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
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2960dedcfde8..b7ead4c933d5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1389,16 +1389,6 @@ static inline long ksys_truncate(const char __user *pathname, loff_t length)
 	return do_sys_truncate(pathname, length);
 }
 
-static inline unsigned int ksys_personality(unsigned int personality)
-{
-	unsigned int old = current->personality;
-
-	if (personality != 0xffffffff)
-		set_personality(personality);
-
-	return old;
-}
-
 /* for __ARCH_WANT_SYS_IPC */
 long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 		     unsigned int nsops,
diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
index 33f07c5f2515..1e70b41bf348 100644
--- a/kernel/exec_domain.c
+++ b/kernel/exec_domain.c
@@ -35,9 +35,21 @@ static int __init proc_execdomains_init(void)
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
+	unsigned int old;
+
+	check = arch_check_personality(personality);
+	if (check)
+		return check;
+
+	old = current->personality;
 
 	if (personality != 0xffffffff)
 		set_personality(personality);
-- 
2.20.1


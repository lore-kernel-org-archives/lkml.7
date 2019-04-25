Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A12C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837F3206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbfDYVqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:46:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388254AbfDYVqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:46:36 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3PLY9eu187566
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 17:46:34 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s3mqh8ran-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 17:46:34 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 25 Apr 2019 22:46:32 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Apr 2019 22:46:27 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3PLkQoE46923988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Apr 2019 21:46:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F4B3AE04D;
        Thu, 25 Apr 2019 21:46:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EECBFAE051;
        Thu, 25 Apr 2019 21:46:23 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.209])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Apr 2019 21:46:23 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Fri, 26 Apr 2019 00:46:23 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [RFC PATCH 7/7] sci: add example system calls to exercse SCI
Date:   Fri, 26 Apr 2019 00:45:54 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19042521-0020-0000-0000-000003360C05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042521-0021-0000-0000-000021887A43
Message-Id: <1556228754-12996-8-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-25_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904250133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/entry/common.c                |  6 +++-
 arch/x86/entry/syscalls/syscall_64.tbl |  3 ++
 kernel/Makefile                        |  2 +-
 kernel/sci-examples.c                  | 52 ++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 kernel/sci-examples.c

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 8f2a6fd..be0e1a7 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -275,7 +275,11 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 #ifdef CONFIG_SYSCALL_ISOLATION
 static inline bool sci_required(unsigned long nr)
 {
-	return false;
+	if (!static_cpu_has(X86_FEATURE_SCI))
+		return false;
+	if (nr < __NR_get_answer)
+		return false;
+	return true;
 }
 
 static inline unsigned long sci_syscall_enter(unsigned long nr)
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f0b1709..a25e838 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,9 @@
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
+335	64	get_answer		__x64_sys_get_answer
+336	64	sci_write_dmesg		__x64_sys_sci_write_dmesg
+337	64	sci_write_dmesg_bad	__x64_sys_sci_write_dmesg_bad
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/kernel/Makefile b/kernel/Makefile
index 6aa7543..d6441d0 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,7 +10,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    extable.o params.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
-	    async.o range.o smpboot.o ucount.o
+	    async.o range.o smpboot.o ucount.o sci-examples.o
 
 obj-$(CONFIG_MODULES) += kmod.o
 obj-$(CONFIG_MULTIUSER) += groups.o
diff --git a/kernel/sci-examples.c b/kernel/sci-examples.c
new file mode 100644
index 0000000..9bfaad0
--- /dev/null
+++ b/kernel/sci-examples.c
@@ -0,0 +1,52 @@
+#include <linux/kernel.h>
+#include <linux/pid.h>
+#include <linux/syscalls.h>
+#include <linux/hugetlb.h>
+#include <asm/special_insns.h>
+
+SYSCALL_DEFINE0(get_answer)
+{
+	return 42;
+}
+
+#define BUF_SIZE 1024
+
+typedef void (*foo)(void);
+
+SYSCALL_DEFINE2(sci_write_dmesg, const char __user *, ubuf, size_t, count)
+{
+	char buf[BUF_SIZE];
+
+	if (!ubuf || count >= BUF_SIZE)
+		return -EINVAL;
+
+	buf[count] = '\0';
+	if (copy_from_user(buf, ubuf, count))
+		return -EFAULT;
+
+	printk("%s\n", buf);
+
+	return count;
+}
+
+SYSCALL_DEFINE2(sci_write_dmesg_bad, const char __user *, ubuf, size_t, count)
+{
+	unsigned long addr = (unsigned long)(void *)hugetlb_reserve_pages;
+	char buf[BUF_SIZE];
+	foo func1;
+
+	addr += 0xc5;
+	func1 = (foo)(void *)addr;
+	func1();
+
+	if (!ubuf || count >= BUF_SIZE)
+		return -EINVAL;
+
+	buf[count] = '\0';
+	if (copy_from_user(buf, ubuf, count))
+		return -EFAULT;
+
+	printk("%s\n", buf);
+
+	return count;
+}
-- 
2.7.4


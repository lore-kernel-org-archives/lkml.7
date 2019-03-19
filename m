Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BB0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7A2205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfCSDHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:07:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbfCSDHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:07:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6EC93082200;
        Tue, 19 Mar 2019 03:07:43 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FCC25D75C;
        Tue, 19 Mar 2019 03:07:36 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/1] userfaultfd/sysctl: add vm.unprivileged_userfaultfd
Date:   Tue, 19 Mar 2019 11:07:22 +0800
Message-Id: <20190319030722.12441-2-peterx@redhat.com>
In-Reply-To: <20190319030722.12441-1-peterx@redhat.com>
References: <20190319030722.12441-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 19 Mar 2019 03:07:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a global sysctl knob "vm.unprivileged_userfaultfd" to control
whether userfaultfd is allowed by unprivileged users.  When this is
set to zero, only privileged users (root user, or users with the
CAP_SYS_PTRACE capability) will be able to use the userfaultfd
syscalls.

Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Suggested-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/sysctl/vm.txt   | 12 ++++++++++++
 fs/userfaultfd.c              |  5 +++++
 include/linux/userfaultfd_k.h |  2 ++
 kernel/sysctl.c               | 12 ++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index 187ce4f599a2..f146712f67bb 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -61,6 +61,7 @@ Currently, these files are in /proc/sys/vm:
 - stat_refresh
 - numa_stat
 - swappiness
+- unprivileged_userfaultfd
 - user_reserve_kbytes
 - vfs_cache_pressure
 - watermark_boost_factor
@@ -818,6 +819,17 @@ The default value is 60.
 
 ==============================================================
 
+unprivileged_userfaultfd
+
+This flag controls whether unprivileged users can use the userfaultfd
+syscalls.  Set this to 1 to allow unprivileged users to use the
+userfaultfd syscalls, or set this to 0 to restrict userfaultfd to only
+privileged users (with SYS_CAP_PTRACE capability).
+
+The default value is 1.
+
+==============================================================
+
 - user_reserve_kbytes
 
 When overcommit_memory is set to 2, "never overcommit" mode, reserve
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 89800fc7dc9d..7e856a25cc2f 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -30,6 +30,8 @@
 #include <linux/security.h>
 #include <linux/hugetlb.h>
 
+int sysctl_unprivileged_userfaultfd __read_mostly = 1;
+
 static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
 
 enum userfaultfd_state {
@@ -1921,6 +1923,9 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
+	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
+		return -EPERM;
+
 	BUG_ON(!current->mm);
 
 	/* Check the UFFD_* constants for consistency.  */
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 37c9eba75c98..ac9d71e24b81 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -28,6 +28,8 @@
 #define UFFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
 
+extern int sysctl_unprivileged_userfaultfd;
+
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
 extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7578e21a711b..9b8ff1881df9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -66,6 +66,7 @@
 #include <linux/kexec.h>
 #include <linux/bpf.h>
 #include <linux/mount.h>
+#include <linux/userfaultfd_k.h>
 
 #include <linux/uaccess.h>
 #include <asm/processor.h>
@@ -1704,6 +1705,17 @@ static struct ctl_table vm_table[] = {
 		.extra1		= (void *)&mmap_rnd_compat_bits_min,
 		.extra2		= (void *)&mmap_rnd_compat_bits_max,
 	},
+#endif
+#ifdef CONFIG_USERFAULTFD
+	{
+		.procname	= "unprivileged_userfaultfd",
+		.data		= &sysctl_unprivileged_userfaultfd,
+		.maxlen		= sizeof(sysctl_unprivileged_userfaultfd),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
 #endif
 	{ }
 };
-- 
2.17.1


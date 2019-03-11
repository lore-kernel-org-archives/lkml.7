Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C5C10F0C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4952075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfCKJhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:37:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfCKJhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:37:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71CFD30821E2;
        Mon, 11 Mar 2019 09:37:22 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 595225D706;
        Mon, 11 Mar 2019 09:37:15 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        kvm@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] userfaultfd/sysctl: introduce unprivileged_userfaultfd
Date:   Mon, 11 Mar 2019 17:36:59 +0800
Message-Id: <20190311093701.15734-2-peterx@redhat.com>
In-Reply-To: <20190311093701.15734-1-peterx@redhat.com>
References: <20190311093701.15734-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 11 Mar 2019 09:37:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new sysctl called "vm.unprivileged_userfaultfd" that can
be used to decide whether userfaultfd syscalls are allowed by
unprivileged users.  It'll allow three modes:

  - disabled: disallow unprivileged users to use uffd

  - enabled:  allow unprivileged users to use uffd

  - kvm:      allow unprivileged users to use uffd only if the user
              had enough permission to open /dev/kvm (this option only
              exists if the kernel turned on KVM).

This patch only introduce the new interface but not yet applied it to
the userfaultfd syscalls, which will be done in the follow up patch.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c              | 96 +++++++++++++++++++++++++++++++++++
 include/linux/userfaultfd_k.h |  5 ++
 init/Kconfig                  | 11 ++++
 kernel/sysctl.c               | 11 ++++
 4 files changed, 123 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 89800fc7dc9d..c2188464555a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -29,6 +29,8 @@
 #include <linux/ioctl.h>
 #include <linux/security.h>
 #include <linux/hugetlb.h>
+#include <linux/sysctl.h>
+#include <linux/string.h>
 
 static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
 
@@ -93,6 +95,95 @@ struct userfaultfd_wake_range {
 	unsigned long len;
 };
 
+enum unprivileged_userfaultfd {
+	/* Disallow unprivileged users to use userfaultfd syscalls */
+	UFFD_UNPRIV_DISABLED = 0,
+	/* Allow unprivileged users to use userfaultfd syscalls */
+	UFFD_UNPRIV_ENABLED,
+#if IS_ENABLED(CONFIG_KVM)
+	/*
+	 * Allow unprivileged users to use userfaultfd syscalls only
+	 * if the user had enough permission to open /dev/kvm
+	 */
+	UFFD_UNPRIV_KVM,
+#endif
+	UFFD_UNPRIV_NUM,
+};
+
+static int unprivileged_userfaultfd __read_mostly;
+static const char *unprivileged_userfaultfd_str[UFFD_UNPRIV_NUM] = {
+	"disabled", "enabled",
+#if IS_ENABLED(CONFIG_KVM)
+	"kvm",
+#endif
+};
+
+static int unprivileged_uffd_parse(char *buf, size_t size)
+{
+	int i;
+
+	for (i = 0; i < UFFD_UNPRIV_NUM; i++) {
+		if (!strncmp(unprivileged_userfaultfd_str[i], buf, size)) {
+			unprivileged_userfaultfd = i;
+			return 0;
+		}
+	}
+
+	return -EFAULT;
+}
+
+static void unprivileged_uffd_dump(char *buf, size_t size)
+{
+	int i;
+
+	*buf = 0x00;
+	for (i = 0; i < UFFD_UNPRIV_NUM; i++) {
+		if (i == unprivileged_userfaultfd)
+			strncat(buf, "[", size - strlen(buf));
+		strncat(buf, unprivileged_userfaultfd_str[i],
+			size - strlen(buf));
+		if (i == unprivileged_userfaultfd)
+			strncat(buf, "]", size - strlen(buf));
+		strncat(buf, " ", size - strlen(buf));
+	}
+
+}
+
+int proc_unprivileged_userfaultfd(struct ctl_table *table, int write,
+				  void __user *buffer, size_t *lenp,
+				  loff_t *ppos)
+{
+	struct ctl_table tmp_table = { .maxlen = 0 };
+	int ret;
+
+	if (write) {
+		tmp_table.maxlen = UFFD_UNPRIV_STRLEN;
+		tmp_table.data = kmalloc(UFFD_UNPRIV_STRLEN, GFP_KERNEL);
+
+		ret = proc_dostring(&tmp_table, write, buffer, lenp, ppos);
+		if (ret)
+			goto out;
+
+		ret = unprivileged_uffd_parse(tmp_table.data,
+					      UFFD_UNPRIV_STRLEN);
+	} else {
+		/* Leave space for "[]" */
+		int len = UFFD_UNPRIV_STRLEN * UFFD_UNPRIV_NUM + 2;
+
+		tmp_table.maxlen = len;
+		tmp_table.data = kmalloc(len, GFP_KERNEL);
+
+		unprivileged_uffd_dump(tmp_table.data, len);
+
+		ret = proc_dostring(&tmp_table, write, buffer, lenp, ppos);
+	}
+
+out:
+	if (tmp_table.data)
+		kfree(tmp_table.data);
+	return ret;
+}
+
 static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
 				     int wake_flags, void *key)
 {
@@ -1955,6 +2046,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 
 static int __init userfaultfd_init(void)
 {
+	char unpriv_uffd[UFFD_UNPRIV_STRLEN] =
+	    CONFIG_USERFAULTFD_UNPRIVILEGED_DEFAULT;
+
+	unprivileged_uffd_parse(unpriv_uffd, sizeof(unpriv_uffd));
+
 	userfaultfd_ctx_cachep = kmem_cache_create("userfaultfd_ctx_cache",
 						sizeof(struct userfaultfd_ctx),
 						0,
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 37c9eba75c98..f53bc02ccffc 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -28,6 +28,11 @@
 #define UFFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
 
+#define UFFD_UNPRIV_STRLEN 16
+int proc_unprivileged_userfaultfd(struct ctl_table *table, int write,
+				  void __user *buffer, size_t *lenp,
+				  loff_t *ppos);
+
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
 extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
diff --git a/init/Kconfig b/init/Kconfig
index c9386a365eea..d90caa4fed17 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1512,6 +1512,17 @@ config USERFAULTFD
 	  Enable the userfaultfd() system call that allows to intercept and
 	  handle page faults in userland.
 
+config USERFAULTFD_UNPRIVILEGED_DEFAULT
+        string "Default behavior for unprivileged userfault syscalls"
+        depends on USERFAULTFD
+        default "disabled"
+        help
+          Set this to "enabled" to allow userfaultfd syscalls from
+          unprivileged users.  Set this to "disabled" to forbid
+          userfaultfd syscalls from unprivileged users.  Set this to
+          "kvm" to forbid unpriviledged users but still allow users
+          who had enough permission to open /dev/kvm.
+
 config ARCH_HAS_MEMBARRIER_CALLBACKS
 	bool
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7578e21a711b..5dc9f3d283dd 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -96,6 +96,9 @@
 #ifdef CONFIG_LOCKUP_DETECTOR
 #include <linux/nmi.h>
 #endif
+#ifdef CONFIG_USERFAULTFD
+#include <linux/userfaultfd_k.h>
+#endif
 
 #if defined(CONFIG_SYSCTL)
 
@@ -1704,6 +1707,14 @@ static struct ctl_table vm_table[] = {
 		.extra1		= (void *)&mmap_rnd_compat_bits_min,
 		.extra2		= (void *)&mmap_rnd_compat_bits_max,
 	},
+#endif
+#ifdef CONFIG_USERFAULTFD
+	{
+		.procname	= "unprivileged_userfaultfd",
+		.maxlen		= UFFD_UNPRIV_STRLEN,
+		.mode		= 0644,
+		.proc_handler	= proc_unprivileged_userfaultfd,
+	},
 #endif
 	{ }
 };
-- 
2.17.1


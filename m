Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC0420652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611246;
	bh=68vjEtZdHJYt4cQL8EsqWidmKAxDUcje7xAa2mUdGBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0oW24NFBPF1y5VtUq6D8vZ8UYxC62LrrLWLl7uN8tg5q/lI1p1EG85+RLK55IK8Z1
	 NYvxkPZ+qI9ZCmsfERJMOlfTQU+IeiZhzQCgbHqJeLzlfCVTsmaDcZ9IG50uMpRKtr
	 ux1dh8SqXKEqCBEjkQ0/VuOFg60u4HoH6z7zrDaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403957AbfDRSOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404187AbfDRSNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:13:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE9E206B6;
        Thu, 18 Apr 2019 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611194;
        bh=68vjEtZdHJYt4cQL8EsqWidmKAxDUcje7xAa2mUdGBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNniseFEN3YEw2ZLdUMEXRsv2v78Sb32Aimvz3NNZq4yyttCK3Ya69dg0LKbY4YS9
         aMGoKg9nei/44ws7M35z6WywW7gOJBaLnljsTbcyfHXvctIEWixt0BK7gODgpuyYET
         JDYPbhquEzERcarNLfuLeSAdceUpejIckNN4US7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Bohac <jbohac@suse.cz>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Omar Sandoval <osandov@fb.com>, Dave Young <dyoung@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 66/93] x86/gart: Exclude GART aperture from kcore
Date:   Thu, 18 Apr 2019 19:57:44 +0200
Message-Id: <20190418160444.005194851@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ffc8599aa9763f39f6736a79da4d1575e7006f9a ]

On machines where the GART aperture is mapped over physical RAM,
/proc/kcore contains the GART aperture range. Accessing the GART range via
/proc/kcore results in a kernel crash.

vmcore used to have the same issue, until it was fixed with commit
2a3e83c6f96c ("x86/gart: Exclude GART aperture from vmcore")', leveraging
existing hook infrastructure in vmcore to let /proc/vmcore return zeroes
when attempting to read the aperture region, and so it won't read from the
actual memory.

Apply the same workaround for kcore. First implement the same hook
infrastructure for kcore, then reuse the hook functions introduced in the
previous vmcore fix. Just with some minor adjustment, rename some functions
for more general usage, and simplify the hook infrastructure a bit as there
is no module usage yet.

Suggested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Dave Young <dyoung@redhat.com>
Link: https://lkml.kernel.org/r/20190308030508.13548-1-kasong@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/aperture_64.c | 20 +++++++++++++-------
 fs/proc/kcore.c               | 27 +++++++++++++++++++++++++++
 include/linux/kcore.h         |  2 ++
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 58176b56354e..294ed4392a0e 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) "AGP: " fmt
 
 #include <linux/kernel.h>
+#include <linux/kcore.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
@@ -57,7 +58,7 @@ int fallback_aper_force __initdata;
 
 int fix_aperture __initdata = 1;
 
-#ifdef CONFIG_PROC_VMCORE
+#if defined(CONFIG_PROC_VMCORE) || defined(CONFIG_PROC_KCORE)
 /*
  * If the first kernel maps the aperture over e820 RAM, the kdump kernel will
  * use the same range because it will remain configured in the northbridge.
@@ -66,20 +67,25 @@ int fix_aperture __initdata = 1;
  */
 static unsigned long aperture_pfn_start, aperture_page_count;
 
-static int gart_oldmem_pfn_is_ram(unsigned long pfn)
+static int gart_mem_pfn_is_ram(unsigned long pfn)
 {
 	return likely((pfn < aperture_pfn_start) ||
 		      (pfn >= aperture_pfn_start + aperture_page_count));
 }
 
-static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
+static void __init exclude_from_core(u64 aper_base, u32 aper_order)
 {
 	aperture_pfn_start = aper_base >> PAGE_SHIFT;
 	aperture_page_count = (32 * 1024 * 1024) << aper_order >> PAGE_SHIFT;
-	WARN_ON(register_oldmem_pfn_is_ram(&gart_oldmem_pfn_is_ram));
+#ifdef CONFIG_PROC_VMCORE
+	WARN_ON(register_oldmem_pfn_is_ram(&gart_mem_pfn_is_ram));
+#endif
+#ifdef CONFIG_PROC_KCORE
+	WARN_ON(register_mem_pfn_is_ram(&gart_mem_pfn_is_ram));
+#endif
 }
 #else
-static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
+static void exclude_from_core(u64 aper_base, u32 aper_order)
 {
 }
 #endif
@@ -474,7 +480,7 @@ int __init gart_iommu_hole_init(void)
 			 * may have allocated the range over its e820 RAM
 			 * and fixed up the northbridge
 			 */
-			exclude_from_vmcore(last_aper_base, last_aper_order);
+			exclude_from_core(last_aper_base, last_aper_order);
 
 			return 1;
 		}
@@ -520,7 +526,7 @@ int __init gart_iommu_hole_init(void)
 	 * overlap with the first kernel's memory. We can't access the
 	 * range through vmcore even though it should be part of the dump.
 	 */
-	exclude_from_vmcore(aper_alloc, aper_order);
+	exclude_from_core(aper_alloc, aper_order);
 
 	/* Fix up the north bridges */
 	for (i = 0; i < amd_nb_bus_dev_ranges[i].dev_limit; i++) {
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index bbcc185062bb..d29d869abec1 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -54,6 +54,28 @@ static LIST_HEAD(kclist_head);
 static DECLARE_RWSEM(kclist_lock);
 static int kcore_need_update = 1;
 
+/*
+ * Returns > 0 for RAM pages, 0 for non-RAM pages, < 0 on error
+ * Same as oldmem_pfn_is_ram in vmcore
+ */
+static int (*mem_pfn_is_ram)(unsigned long pfn);
+
+int __init register_mem_pfn_is_ram(int (*fn)(unsigned long pfn))
+{
+	if (mem_pfn_is_ram)
+		return -EBUSY;
+	mem_pfn_is_ram = fn;
+	return 0;
+}
+
+static int pfn_is_ram(unsigned long pfn)
+{
+	if (mem_pfn_is_ram)
+		return mem_pfn_is_ram(pfn);
+	else
+		return 1;
+}
+
 /* This doesn't grab kclist_lock, so it should only be used at init time. */
 void __init kclist_add(struct kcore_list *new, void *addr, size_t size,
 		       int type)
@@ -465,6 +487,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				goto out;
 			}
 			m = NULL;	/* skip the list anchor */
+		} else if (!pfn_is_ram(__pa(start) >> PAGE_SHIFT)) {
+			if (clear_user(buffer, tsz)) {
+				ret = -EFAULT;
+				goto out;
+			}
 		} else if (m->type == KCORE_VMALLOC) {
 			vread(buf, (char *)start, tsz);
 			/* we have to zero-fill user buffer even if no read */
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index 8c3f8c14eeaa..c843f4a9c512 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -44,6 +44,8 @@ void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
 	m->vaddr = (unsigned long)vaddr;
 	kclist_add(m, addr, sz, KCORE_REMAP);
 }
+
+extern int __init register_mem_pfn_is_ram(int (*fn)(unsigned long pfn));
 #else
 static inline
 void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
-- 
2.19.1




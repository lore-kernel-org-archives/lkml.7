Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A74C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B4221872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610422;
	bh=RzXzIs912GVJNk3o2T6lzXAUBv9g1nfp5FIsO5NAlxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1CuVPsyQO5Vo7RxrvGTopiZuxmK0BnCDwjT1KNpO7E5v+mqYnQyEL14SSl3ig2JXc
	 kusZC6pVfjCVxqdQZFhlkffIXWn+WbH/9rRHRxce89HA0yFXYG3lBTxTvuw/ST+YTr
	 kT2wEihDAguFaiMv7nbMNtrGqLRLmAeDGS/yC8D4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390341AbfDRSAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390318AbfDRSAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:00:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1CB21871;
        Thu, 18 Apr 2019 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610414;
        bh=RzXzIs912GVJNk3o2T6lzXAUBv9g1nfp5FIsO5NAlxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OImP3YHeT3PdLVIlO5fFR3nmp99L7gzHSW6eodk6VmOVlljGZQhiv+1RxGDCWmk5i
         YhO+odcJDRdcz/8DYeyoXwBtq4asRyU/3mwiIm0XDWrI3KvWnMEcppxVoQYLi6IZz8
         KIpDtRf3/anYDLDYkfjYqvcdefIRNDRIf1FNdzjY=
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
Subject: [PATCH 4.19 051/110] x86/gart: Exclude GART aperture from kcore
Date:   Thu, 18 Apr 2019 19:56:40 +0200
Message-Id: <20190418160443.585413374@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
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
index 2c4d5ece7456..93426c5fc70f 100644
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
@@ -469,7 +475,7 @@ int __init gart_iommu_hole_init(void)
 			 * may have allocated the range over its e820 RAM
 			 * and fixed up the northbridge
 			 */
-			exclude_from_vmcore(last_aper_base, last_aper_order);
+			exclude_from_core(last_aper_base, last_aper_order);
 
 			return 1;
 		}
@@ -515,7 +521,7 @@ int __init gart_iommu_hole_init(void)
 	 * overlap with the first kernel's memory. We can't access the
 	 * range through vmcore even though it should be part of the dump.
 	 */
-	exclude_from_vmcore(aper_alloc, aper_order);
+	exclude_from_core(aper_alloc, aper_order);
 
 	/* Fix up the north bridges */
 	for (i = 0; i < amd_nb_bus_dev_ranges[i].dev_limit; i++) {
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index d297fe4472a9..d0137e3e585e 100644
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




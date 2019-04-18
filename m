Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BA6C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD5F21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lvDxQ1M6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbfDRKBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:01:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50372 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDRKBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:01:44 -0400
Received: from zn.tnic (p200300EC2F112E00403003D72BA0966D.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:4030:3d7:2ba0:966d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 01EDE1EC04CD;
        Thu, 18 Apr 2019 12:01:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555581703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/0FfKvAJDQhBCJF5PtTJV7/q9yNOSVSxQTT8GwUi6EQ=;
        b=lvDxQ1M69c8g0b88j8I2swyRaqhzsUpGa1bUTSWLTJZNdDqHCe83YlsXpI07yGNNZry3ub
        +bPu5jGVCCS2y+Yc6beoaPweF7HMgVTuNtH3woQWFYApbwSXhQf+5VZaOEXjEMOhNSFnds
        o1ns4itmw8ddbL3VlXLJNB1pHqbthvM=
Date:   Thu, 18 Apr 2019 12:01:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     Thomas.Lendacky@amd.com, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
Message-ID: <20190418100138.GD27160@zn.tnic>
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com>
 <20190402090652.GD6826@zn.tnic>
 <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
 <20190402124328.GG6826@zn.tnic>
 <384ba880-1b53-8013-8be8-66f294c27100@redhat.com>
 <20190415154155.GH29317@zn.tnic>
 <60d67667-c9c4-29bd-0a8a-d3ae13022d87@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60d67667-c9c4-29bd-0a8a-d3ae13022d87@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 02:40:09PM +0800, lijiang wrote:
> Based on the above description, i made a draft patch, please refer to it. But it
> seems that the code has been changed a lot.

It goes in the right direction. Here is a version where I corrected some
things:

---
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index dd73d5d74393..0c1392e76b7d 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -27,9 +27,8 @@
 
 #include "physaddr.h"
 
-struct ioremap_mem_flags {
-	bool system_ram;
-	bool desc_other;
+struct ioremap_desc {
+	u64 flags;
 };
 
 /*
@@ -61,13 +60,13 @@ int ioremap_change_attr(unsigned long vaddr, unsigned long size,
 	return err;
 }
 
-static bool __ioremap_check_ram(struct resource *res)
+static u64 __ioremap_check_ram(struct resource *res)
 {
 	unsigned long start_pfn, stop_pfn;
 	unsigned long i;
 
 	if ((res->flags & IORESOURCE_SYSTEM_RAM) != IORESOURCE_SYSTEM_RAM)
-		return false;
+		return 0;
 
 	start_pfn = (res->start + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	stop_pfn = (res->end + 1) >> PAGE_SHIFT;
@@ -75,28 +74,39 @@ static bool __ioremap_check_ram(struct resource *res)
 		for (i = 0; i < (stop_pfn - start_pfn); ++i)
 			if (pfn_valid(start_pfn + i) &&
 			    !PageReserved(pfn_to_page(start_pfn + i)))
-				return true;
+				return IORES_MAP_SYSTEM_RAM;
 	}
 
-	return false;
+	return 0;
 }
 
-static int __ioremap_check_desc_other(struct resource *res)
+/*
+ * NONE and RESERVED should not be mapped encrypted in SEV because there
+ * the whole memory is already encrypted.
+ */
+static unsigned long __ioremap_check_desc(struct resource *res)
 {
-	return (res->desc != IORES_DESC_NONE);
+	if (!sev_active())
+		return 0;
+
+	if (res->desc & (IORES_DESC_NONE | IORES_DESC_RESERVED))
+		return 0;
+
+	return IORES_MAP_ENCRYPTED;
 }
 
 static int __ioremap_res_check(struct resource *res, void *arg)
 {
-	struct ioremap_mem_flags *flags = arg;
+	struct ioremap_desc *desc = arg;
 
-	if (!flags->system_ram)
-		flags->system_ram = __ioremap_check_ram(res);
+	if (!(desc->flags & IORES_MAP_SYSTEM_RAM))
+		desc->flags |= __ioremap_check_ram(res);
 
-	if (!flags->desc_other)
-		flags->desc_other = __ioremap_check_desc_other(res);
+	if (!(desc->flags & IORES_MAP_ENCRYPTED))
+		desc->flags |= __ioremap_check_desc(res);
 
-	return flags->system_ram && flags->desc_other;
+	return ((desc->flags & (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED)) ==
+			       (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED));
 }
 
 /*
@@ -105,13 +115,13 @@ static int __ioremap_res_check(struct resource *res, void *arg)
  * resource described not as IORES_DESC_NONE (e.g. IORES_DESC_ACPI_TABLES).
  */
 static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
-				struct ioremap_mem_flags *flags)
+				struct ioremap_desc *desc)
 {
 	u64 start, end;
 
 	start = (u64)addr;
 	end = start + size - 1;
-	memset(flags, 0, sizeof(*flags));
+	memset(desc, 0, sizeof(struct ioremap_desc));
 
 	walk_mem_res(start, end, flags, __ioremap_res_check);
 }
@@ -138,7 +148,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 	resource_size_t last_addr;
 	const resource_size_t unaligned_phys_addr = phys_addr;
 	const unsigned long unaligned_size = size;
-	struct ioremap_mem_flags mem_flags;
+	struct ioremap_desc io_desc;
 	struct vm_struct *area;
 	enum page_cache_mode new_pcm;
 	pgprot_t prot;
@@ -157,12 +167,12 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 		return NULL;
 	}
 
-	__ioremap_check_mem(phys_addr, size, &mem_flags);
+	__ioremap_check_mem(phys_addr, size, &io_desc);
 
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
-	if (mem_flags.system_ram) {
+	if (io_desc.flags & IORES_MAP_SYSTEM_RAM) {
 		WARN_ONCE(1, "ioremap on RAM at %pa - %pa\n",
 			  &phys_addr, &last_addr);
 		return NULL;
@@ -200,7 +210,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 	 * resulting mapping.
 	 */
 	prot = PAGE_KERNEL_IO;
-	if ((sev_active() && mem_flags.desc_other) || encrypted)
+	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
 
 	switch (pcm) {
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..2a5e0f1ded93 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -12,6 +12,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/bits.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
@@ -135,6 +136,14 @@ enum {
 	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
 };
 
+/*
+ * Flags controlling ioremap() behavior.
+ */
+enum {
+	IORES_MAP_SYSTEM_RAM	= BIT(0),
+	IORES_MAP_ENCRYPTED	= BIT(1),
+};
+
 /* helpers to define resources */
 #define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
 	{								\

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

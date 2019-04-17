Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA0CC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86A3204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfDQGk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:40:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfDQGk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:40:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E44803084212;
        Wed, 17 Apr 2019 06:40:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDA05608A7;
        Wed, 17 Apr 2019 06:40:14 +0000 (UTC)
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
To:     Borislav Petkov <bp@alien8.de>, Thomas.Lendacky@amd.com
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com> <20190402090652.GD6826@zn.tnic>
 <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
 <20190402124328.GG6826@zn.tnic>
 <384ba880-1b53-8013-8be8-66f294c27100@redhat.com>
 <20190415154155.GH29317@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <60d67667-c9c4-29bd-0a8a-d3ae13022d87@redhat.com>
Date:   Wed, 17 Apr 2019 14:40:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190415154155.GH29317@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 17 Apr 2019 06:40:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年04月15日 23:41, Borislav Petkov 写道:
> On Mon, Apr 15, 2019 at 08:22:22PM +0800, lijiang wrote:
>> They are different problems.
> 
> Aha, so we're getting closer. You should've lead with that!
> 
>> The first problem is that passes the e820 reserved ranges to the second kernel,
> 
> Passes or *doesn't* pass?
> 
> Because from all the staring, it wants to pass the reserved ranges.
> 
>> for this case, it is good enough to use the IORES_DESC_RESERVED, which
>> can ensure that exactly matches the reserved resource ranges when
>> walking through iomem resources.
> 
> Ok.
> 
>> The second problem is about the SEV case. Now, the IORES_DESC_RESERVED has been
>> created for the reserved areas, therefore the check needs to be expanded so that
>> these areas are not mapped encrypted when using ioremap().
>>
>> +static int __ioremap_check_desc_none_and_reserved(struct resource *res)
> 
> That name is crap. If you need to add another desc type, it becomes
> wrong again. And that whole code around flags->desc_other is just silly:
> 
> Make that machinery around it something like this:
> 
> struct ioremap_desc {
>         u64 flags;
> };
> 
> instead of "struct ioremap_mem_flags" and that struct ioremap_desc is an
> ioremap descriptor which will carry all kinds of settings. system_ram
> can then be a simple flag too.
> 
> __ioremap_caller() will hand it down to __ioremap_check_mem() etc
> and there it will set flags like IOREMAP_DESC_MAP_ENCRYPTED or
> IOREMAP_DESC_MAP_DECRYPTED and this way you'll have it explicit and
> clear in __ioremap_caller():
> 
>         if ((sev_active() &&
> 	    (io_desc.flags & IOREMAP_DESC_MAP_ENCRYPTED)) ||
> 	    encrypted)
>                 prot = pgprot_encrypted(prot);
> 
> But that would need a pre-patch which does that conversion.
> 
Thanks for your comment.

Based on the above description, i made a draft patch, please refer to it. But it
seems that the code has been changed a lot.

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 0029604af8a4..04217b61635e 100644
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
+static unsigned long __ioremap_check_ram(struct resource *res)
 {
 	unsigned long start_pfn, stop_pfn;
 	unsigned long i;
 
 	if ((res->flags & IORESOURCE_SYSTEM_RAM) != IORESOURCE_SYSTEM_RAM)
-		return false;
+		return IOREMAP_DESC_MAP_NONE;
 
 	start_pfn = (res->start + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	stop_pfn = (res->end + 1) >> PAGE_SHIFT;
@@ -75,28 +74,44 @@ static bool __ioremap_check_ram(struct resource *res)
 		for (i = 0; i < (stop_pfn - start_pfn); ++i)
 			if (pfn_valid(start_pfn + i) &&
 			    !PageReserved(pfn_to_page(start_pfn + i)))
-				return true;
+				return IOREMAP_DESC_MAP_SYSTEM_RAM_USING;
 	}
 
-	return false;
+	return IOREMAP_DESC_MAP_NONE;
 }
 
-static int __ioremap_check_desc_other(struct resource *res)
+/*
+ * Originally, these areas described as IORES_DESC_NONE are not mapped
+ * as encrypted when using ioremap(), for example, E820_TYPE_{RESERVED,
+ * RESERVED_KERN,RAM,UNUSABLE}, etc. It checks for a resource that is
+ * not described as IORES_DESC_NONE, which can make sure the reserved
+ * areas are not mapped as encrypted when using ioremap().
+ *
+ * Now IORES_DESC_RESERVED has been created for the reserved areas so
+ * the check needs to be expanded so that these areas are not mapped
+ * encrypted when using ioremap().
+ */
+static unsigned long __ioremap_check_desc(struct resource *res)
 {
-	return (res->desc != IORES_DESC_NONE);
+	if ((res->desc != IORES_DESC_NONE) &&
+	    (res->desc != IORES_DESC_RESERVED))
+		return IOREMAP_DESC_MAP_ENCRYPTED;
+
+	return IOREMAP_DESC_MAP_NONE;
 }
 
 static int __ioremap_res_check(struct resource *res, void *arg)
 {
-	struct ioremap_mem_flags *flags = arg;
+	struct ioremap_desc *desc = arg;
 
-	if (!flags->system_ram)
-		flags->system_ram = __ioremap_check_ram(res);
+	if (!(desc->flags & IOREMAP_DESC_MAP_SYSTEM_RAM_USING))
+		desc->flags |= __ioremap_check_ram(res);
 
-	if (!flags->desc_other)
-		flags->desc_other = __ioremap_check_desc_other(res);
+	if (!(desc->flags & IOREMAP_DESC_MAP_ENCRYPTED))
+		desc->flags |= __ioremap_check_desc(res);
 
-	return flags->system_ram && flags->desc_other;
+	return ((desc->flags & IOREMAP_DESC_MAP_SYSTEM_RAM_USING) &&
+		(desc->flags & IOREMAP_DESC_MAP_ENCRYPTED))
 }
 
 /*
@@ -105,13 +120,13 @@ static int __ioremap_res_check(struct resource *res, void *arg)
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
+	memset(desc, 0, sizeof(*desc));
 
 	walk_mem_res(start, end, flags, __ioremap_res_check);
 }
@@ -138,7 +153,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 	resource_size_t last_addr;
 	const resource_size_t unaligned_phys_addr = phys_addr;
 	const unsigned long unaligned_size = size;
-	struct ioremap_mem_flags mem_flags;
+	struct ioremap_desc io_desc;
 	struct vm_struct *area;
 	enum page_cache_mode new_pcm;
 	pgprot_t prot;
@@ -157,12 +172,12 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 		return NULL;
 	}
 
-	__ioremap_check_mem(phys_addr, size, &mem_flags);
+	__ioremap_check_mem(phys_addr, size, &io_desc);
 
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
-	if (mem_flags.system_ram) {
+	if (io_desc.flags & IOREMAP_DESC_MAP_SYSTEM_RAM_USING) {
 		WARN_ONCE(1, "ioremap on RAM at %pa - %pa\n",
 			  &phys_addr, &last_addr);
 		return NULL;
@@ -200,7 +215,9 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 	 * resulting mapping.
 	 */
 	prot = PAGE_KERNEL_IO;
-	if ((sev_active() && mem_flags.desc_other) || encrypted)
+	if ((sev_active() &&
+	    (io_desc.flags & IOREMAP_DESC_MAP_ENCRYPTED)) ||
+	    encrypted)
 		prot = pgprot_encrypted(prot);
 
 	switch (pcm) {
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6ed59de48bd5..48b2d21ad9e5 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -136,6 +136,15 @@ enum {
 	IORES_DESC_RESERVED			= 8,
 };
 
+/*
+ * IORemap Descriptors Helper
+ */
+enum {
+	IOREMAP_DESC_MAP_NONE				= 0,
+	IOREMAP_DESC_MAP_SYSTEM_RAM_USING		= 1,
+	IOREMAP_DESC_MAP_ENCRYPTED			= 2,
+};
+
 /* helpers to define resources */
 #define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
 	{								\

Are you sure about this changes? Or Do other reviewers have any suggestions?

Thanks.

>> Maybe i should split it into two patches. The change of
>> __ioremap_check_desc_none_and_reserved() should be a separate patch.
>> Any idea?
> 
> See above and yes, definitely separate patches.
> 
OK. Thank you very much.

Lianbo

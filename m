Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D7AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73DE2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565698010;
	bh=TET6WjOQahzKuCbEBc/ELlWuL5zy2JXUgDdm39iIfKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I0X0LsCWIVGJG1k6/r8kvpZlIa1ia9Qps4CvHXWrh4oOK4N3eFWf3KOwX4fF5a3RI
	 PrSruN9+Gz52+oOrCpnBHt15CuihRKYUxLEtIrKpqsDKeF4cvtAjQ9+3OoETXpaMc7
	 5IkGazMzK3Anb0V4Nat9wk61XMpFtMeneJMKa9no=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfHMMGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfHMMGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:06:49 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE6D020578;
        Tue, 13 Aug 2019 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565698008;
        bh=TET6WjOQahzKuCbEBc/ELlWuL5zy2JXUgDdm39iIfKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOqcEo9DN08hqiKR3LQUsdgfppxOeTWnE/FRtSeNk8YDI9lY1+JQfiHsqAVoTl10M
         ZfyAt2ot6Gxj0JNN7DgFCftwU/8DuU4lmOWdTryiULq9CV+n1lSIH8/jmyt/IQ3jgc
         AlTFjS71ifJBWAOsSwnmMjIvLYg9WBe94TywDnjI=
Date:   Tue, 13 Aug 2019 13:06:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        steve.capper@arm.com
Subject: Re: "arm64/for-next/core" causes boot panic
Message-ID: <20190813120643.25y5px4andu6cfwp@willie-the-truck>
References: <1565646695.8572.6.camel@lca.pw>
 <20190813090200.h2rz4xphgnb5j5bc@willie-the-truck>
 <20190813105852.ovk5gtzddwlsm4ly@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813105852.ovk5gtzddwlsm4ly@willie-the-truck>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Steve]

On Tue, Aug 13, 2019 at 11:58:52AM +0100, Will Deacon wrote:
> On Tue, Aug 13, 2019 at 10:02:01AM +0100, Will Deacon wrote:
> > On Mon, Aug 12, 2019 at 05:51:35PM -0400, Qian Cai wrote:
> > > Booting today's linux-next on an arm64 server triggers a panic with
> > > CONFIG_KASAN_SW_TAGS=y pointing to this line,
> > 
> > Is this the only change on top of defconfig? If not, please can you share
> > your full .config?
> > 
> > > kfree()->virt_to_head_page()->compound_head()
> > > 
> > > unsigned long head = READ_ONCE(page->compound_head);
> > > 
> > > The bisect so far indicates one of those could be bad,
> > 
> > I guess that means the issue is reproducible on the arm64 for-next/core
> > branch. Once I have your .config, I'll give it a go.
> 
> FWIW, I've managed to reproduce this using defconfig + SW_TAGS on
> for-next/core, so I'll keep investigating.

Right, hacky diff below seems to resolve this, so I'll split this up into
some proper patches as there is more than one bug here.

Thanks,

Will

--->8

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index afaf512c0e1b..541e8dcb5ab3 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -244,7 +244,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 /*
  * The linear kernel range starts in the middle of the virtual adddress
  * space. Testing the top bit for the start of the region is a
- * sufficient check.
+ * sufficient check and avoids having to worry about the tag.
  */
 #define __is_lm_address(addr)	(!((addr) & BIT(vabits_actual - 1)))
 
@@ -252,7 +252,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 #define __kimg_to_phys(addr)	((addr) - kimage_voffset)
 
 #define __virt_to_phys_nodebug(x) ({					\
-	phys_addr_t __x = (phys_addr_t)(x);				\
+	phys_addr_t __x = (phys_addr_t)(__tag_reset(x));		\
 	__is_lm_address(__x) ? __lm_to_phys(__x) :			\
 			       __kimg_to_phys(__x);			\
 })
@@ -301,8 +301,8 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define __pa_nodebug(x)		__virt_to_phys_nodebug((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
-#define virt_to_pfn(x)      __phys_to_pfn(__virt_to_phys((unsigned long)(x)))
-#define sym_to_pfn(x)	    __phys_to_pfn(__pa_symbol(x))
+#define virt_to_pfn(x)		__phys_to_pfn(__virt_to_phys((unsigned long)(x)))
+#define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
 /*
  *  virt_to_page(k)	convert a _valid_ virtual address to struct page *
@@ -311,7 +311,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define ARCH_PFN_OFFSET		((unsigned long)PHYS_PFN_OFFSET)
 
 #if !defined(CONFIG_SPARSEMEM_VMEMMAP) || defined(CONFIG_DEBUG_VIRTUAL)
-#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #else
 #define __virt_to_pgoff(kaddr)	(((u64)(kaddr) - PAGE_OFFSET) / PAGE_SIZE * sizeof(struct page))
 #define __page_to_voff(kaddr)	(((u64)(kaddr) - VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
@@ -324,15 +324,17 @@ static inline void *phys_to_virt(phys_addr_t x)
 	((void *)__addr_tag);						\
 })
 
-#define virt_to_page(vaddr)	((struct page *)((__virt_to_pgoff(vaddr)) + VMEMMAP_START))
+#define virt_to_page(kaddr)	({					\
+	unsigned long __addr = __tag_reset((unsigned long)kaddr);	\
+	(struct page *)((__virt_to_pgoff(__addr) + VMEMMAP_START));	\
+})
 #endif
 #endif
 
-#define _virt_addr_is_linear(kaddr)	\
-	(__tag_reset((u64)(kaddr)) >= PAGE_OFFSET)
-
-#define virt_addr_valid(kaddr)		\
-	(_virt_addr_is_linear(kaddr) && pfn_valid(virt_to_pfn(kaddr)))
+#define virt_addr_valid(kaddr)	({					\
+	unsigned long __addr = (unsigned long)kaddr;			\
+	__is_lm_address(__addr) && pfn_valid(virt_to_pfn(__addr));	\
+})
 
 /*
  * Given that the GIC architecture permits ITS implementations that can only be

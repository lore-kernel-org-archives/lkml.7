Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215CAC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBD621670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="uoufnWNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbfIPOQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:16:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39721 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfIPOQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:16:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id g12so195615eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iYHGzDIv1KzvKWmRcaQWixDVtJ/l+waBXIAZNFlOORY=;
        b=uoufnWNYyyoUFU3I8EZ2FjWQJI1fk2jaowm+PRXps1aPXy/Bug4LyT1HxxPWDIv/gx
         ANWG2jH6BrrUuB2d5wGTccaP+GFqG3qPb7ZKXUI3CynXAtCk55Z24FrgrfqmKB+HYqv9
         eZX5A2WbBYQjf/PJRS3Xp0IG8jaF5ccjPMOXiAGspyptVDnN7CWLlKXp8HqdiOMVMNwi
         Lrztn2exL7MwdI2hCKpYgfLeBmc15ls/95jBGOwVuKGevojnCjWqS+a4SJWaIiWPUZRz
         PCdGAfCrQ1uxmBWoOH2T6g4YGi0KF8n+ShssDAEo3r9fL7UylNepRARP+ObCVqe7w+d1
         J2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iYHGzDIv1KzvKWmRcaQWixDVtJ/l+waBXIAZNFlOORY=;
        b=AVcUsulRfSNRy/sUPwzJlqRpJu8cGuMdkeYLdwg/Y3KOIS8GJxvzhvheNDZcuJ8dFp
         KkiKUm+TOckJRdPPEyWobWLWKdR98jKGiRKsOsCiknZ6d8crjm5YJkmfOVi0FeGcHbov
         Oh4ppbcAYcGzwLFhUVtMuQTqioDFK0k3WeONzdxCZbj9ZQy1CEYwYbJ0194rK7bimhNO
         Tx6+dVmJ8zSTn+IHZJReQIw4ovrGvFHWR00Pib3YdmWTRAUfal8KjcUemBjdIkpmUQ4a
         EXc1kw0FK/9SVkhwKG/y58qCXFAxh/g+FP+Og1BpWVFQ5vIoiFkp5KQsGO2K812DzBNz
         0D9A==
X-Gm-Message-State: APjAAAUzJ/yGvvQ+HNCtdamLpnxYRSbpaelbbZhVFkflzC5enELftZqd
        7kdx6S4o+sLmoq0llnB0cH5mCQ==
X-Google-Smtp-Source: APXvYqwVELfEYu/2by3UrulbVxWW2SeDDD32u+0bbNxJnb0ZeHSHXe+A09WBLHGeiz74P6WslA1xdg==
X-Received: by 2002:a50:eb07:: with SMTP id y7mr26445045edp.240.1568643375711;
        Mon, 16 Sep 2019 07:16:15 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s26sm2044850eds.80.2019.09.16.07.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 07:16:14 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D99A310019A; Mon, 16 Sep 2019 17:16:16 +0300 (+03)
Date:   Mon, 16 Sep 2019 17:16:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Justin He (Arm Technology China)" <Justin.He@arm.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "hejianet@gmail.com" <hejianet@gmail.com>
Subject: Re: [PATCH v3 2/2] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190916141616.ikanlznwcgkaxady@box.shutemov.name>
References: <20190913163239.125108-1-justin.he@arm.com>
 <20190913163239.125108-3-justin.he@arm.com>
 <20190916091628.bkuvd3g3ie3x6qav@box.shutemov.name>
 <DB7PR08MB30825C23ABB0962CC8826CBAF78C0@DB7PR08MB3082.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR08MB30825C23ABB0962CC8826CBAF78C0@DB7PR08MB3082.eurprd08.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 09:35:21AM +0000, Justin He (Arm Technology China) wrote:
> 
> Hi Kirill
> > -----Original Message-----
> > From: Kirill A. Shutemov <kirill@shutemov.name>
> > Sent: 2019年9月16日 17:16
> > To: Justin He (Arm Technology China) <Justin.He@arm.com>
> > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
> > <will@kernel.org>; Mark Rutland <Mark.Rutland@arm.com>; James Morse
> > <James.Morse@arm.com>; Marc Zyngier <maz@kernel.org>; Matthew
> > Wilcox <willy@infradead.org>; Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com>; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; linux-mm@kvack.org; Punit Agrawal
> > <punitagrawal@gmail.com>; Anshuman Khandual
> > <Anshuman.Khandual@arm.com>; Jun Yao <yaojun8558363@gmail.com>;
> > Alex Van Brunt <avanbrunt@nvidia.com>; Robin Murphy
> > <Robin.Murphy@arm.com>; Thomas Gleixner <tglx@linutronix.de>;
> > Andrew Morton <akpm@linux-foundation.org>; Jérôme Glisse
> > <jglisse@redhat.com>; Ralph Campbell <rcampbell@nvidia.com>;
> > hejianet@gmail.com
> > Subject: Re: [PATCH v3 2/2] mm: fix double page fault on arm64 if PTE_AF
> > is cleared
> >
> > On Sat, Sep 14, 2019 at 12:32:39AM +0800, Jia He wrote:
> > > When we tested pmdk unit test [1] vmmalloc_fork TEST1 in arm64 guest,
> > there
> > > will be a double page fault in __copy_from_user_inatomic of
> > cow_user_page.
> > >
> > > Below call trace is from arm64 do_page_fault for debugging purpose
> > > [  110.016195] Call trace:
> > > [  110.016826]  do_page_fault+0x5a4/0x690
> > > [  110.017812]  do_mem_abort+0x50/0xb0
> > > [  110.018726]  el1_da+0x20/0xc4
> > > [  110.019492]  __arch_copy_from_user+0x180/0x280
> > > [  110.020646]  do_wp_page+0xb0/0x860
> > > [  110.021517]  __handle_mm_fault+0x994/0x1338
> > > [  110.022606]  handle_mm_fault+0xe8/0x180
> > > [  110.023584]  do_page_fault+0x240/0x690
> > > [  110.024535]  do_mem_abort+0x50/0xb0
> > > [  110.025423]  el0_da+0x20/0x24
> > >
> > > The pte info before __copy_from_user_inatomic is (PTE_AF is cleared):
> > > [ffff9b007000] pgd=000000023d4f8003, pud=000000023da9b003,
> > pmd=000000023d4b3003, pte=360000298607bd3
> > >
> > > As told by Catalin: "On arm64 without hardware Access Flag, copying
> > from
> > > user will fail because the pte is old and cannot be marked young. So we
> > > always end up with zeroed page after fork() + CoW for pfn mappings. we
> > > don't always have a hardware-managed access flag on arm64."
> > >
> > > This patch fix it by calling pte_mkyoung. Also, the parameter is
> > > changed because vmf should be passed to cow_user_page()
> > >
> > > [1]
> > https://github.com/pmem/pmdk/tree/master/src/test/vmmalloc_fork
> > >
> > > Reported-by: Yibo Cai <Yibo.Cai@arm.com>
> > > Signed-off-by: Jia He <justin.he@arm.com>
> > > ---
> > >  mm/memory.c | 30 +++++++++++++++++++++++++-----
> > >  1 file changed, 25 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index e2bb51b6242e..a64af6495f71 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -118,6 +118,13 @@ int randomize_va_space __read_mostly =
> > >                                     2;
> > >  #endif
> > >
> > > +#ifndef arch_faults_on_old_pte
> > > +static inline bool arch_faults_on_old_pte(void)
> > > +{
> > > +   return false;
> > > +}
> > > +#endif
> > > +
> > >  static int __init disable_randmaps(char *s)
> > >  {
> > >     randomize_va_space = 0;
> > > @@ -2140,7 +2147,8 @@ static inline int pte_unmap_same(struct
> > mm_struct *mm, pmd_t *pmd,
> > >     return same;
> > >  }
> > >
> > > -static inline void cow_user_page(struct page *dst, struct page *src,
> > unsigned long va, struct vm_area_struct *vma)
> > > +static inline void cow_user_page(struct page *dst, struct page *src,
> > > +                           struct vm_fault *vmf)
> > >  {
> > >     debug_dma_assert_idle(src);
> > >
> > > @@ -2152,20 +2160,32 @@ static inline void cow_user_page(struct page
> > *dst, struct page *src, unsigned lo
> > >      */
> > >     if (unlikely(!src)) {
> > >             void *kaddr = kmap_atomic(dst);
> > > -           void __user *uaddr = (void __user *)(va & PAGE_MASK);
> > > +           void __user *uaddr = (void __user *)(vmf->address &
> > PAGE_MASK);
> > > +           pte_t entry;
> > >
> > >             /*
> > >              * This really shouldn't fail, because the page is there
> > >              * in the page tables. But it might just be unreadable,
> > >              * in which case we just give up and fill the result with
> > > -            * zeroes.
> > > +            * zeroes. If PTE_AF is cleared on arm64, it might
> > > +            * cause double page fault. So makes pte young here
> > >              */
> > > +           if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte))
> > {
> > > +                   spin_lock(vmf->ptl);
> > > +                   entry = pte_mkyoung(vmf->orig_pte);
> >
> > Should't you re-validate that orig_pte after re-taking ptl? It can be
> > stale by now.
> Thanks, do you mean flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte))
> before pte_mkyoung?

No. You need to check pte_same(*vmf->pte, vmf->orig_pte) before modifying
anything and bail out if *vmf->pte has changed under you.

-- 
 Kirill A. Shutemov

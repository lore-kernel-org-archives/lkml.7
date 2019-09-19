Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E24C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158E921907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="02D+wngb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389795AbfISPAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:00:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41275 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387407AbfISPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:00:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id f20so3477370edv.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rsy153zpl4yxoGCSq5N5IH86opdKnCHpMC3JulF2khA=;
        b=02D+wngbGXHZGUTd/OI3S4I3/pW/FS6cieICZCCkmbioDgm+zgBjOiH57lPnSWirfN
         +B4Feg8AmGwk7F+utHKC7GrdfJzUHKCJ4ajtySG8KxAouv6EvlG1yoqerF06hXnVcWwX
         TrHOQhOgYP9grvwP04SfPFkRbIDxj+NuVLs1X1zXVqDtLbxDjQS4pC2SXJhJs7ObyuVM
         84MyFS80tqrbS4agYsvbwWVXwVHM/klMaBAKH+F+n4o1l5/a6xCmwxBcLGRO6bLWNKLD
         CeK3wIOS9gOxliCa8/h+Ka9CNuPH34azA0jVtIpCsVsr6Jne05lWZg1kpU+YucTZKd7W
         LCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rsy153zpl4yxoGCSq5N5IH86opdKnCHpMC3JulF2khA=;
        b=XC4GcBcfXhN/QTd7tkz6nKPfqVzri+58us2Eo1IrKWJwK/hos7tleCfkvFCO16LuaM
         ZqAxMthhOjvzFLm3P8+0ETN9PWLXDrNlbCiz+u5Gwt/5cedkCHkZ7LNipPOdtGUcBMaF
         U+9f+EAmNRmjZxhu15wQJraiWADo5EaUp7+3QXmTZPP9KAT9ho4v8UDoLoXwMmdBxkMw
         uCCzukljKKijZ8OnbHYKrurAqwvtkLWT5DT7Yb+kz+TAqG7enTsSg7+27LXAKblMW5kG
         27ePhKtYR6ZWTYARoPSmpzeWBP5z3xTMaEFfuD3snQOEqBnuR88POp86iVRY4d6s/7dD
         kbuQ==
X-Gm-Message-State: APjAAAXDuUpeG9xujfoTQqvbciNB5WCTJirgiE86yPxIIN8TqxT8DnXG
        wV15oCO5H78HcbWOiZHtdajHmw==
X-Google-Smtp-Source: APXvYqyx/AckV5APDHiZafOBx5pGNPnvX1/IDqUdyyu9pyklLZREADmTvqxKDNf7fmed54UHx0fVzA==
X-Received: by 2002:a05:6402:1688:: with SMTP id a8mr7542905edv.225.1568905209039;
        Thu, 19 Sep 2019 08:00:09 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a22sm1039452ejs.17.2019.09.19.08.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 08:00:08 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8BBF3101F17; Thu, 19 Sep 2019 18:00:07 +0300 (+03)
Date:   Thu, 19 Sep 2019 18:00:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v4 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190919150007.k7scjplcya53j7r4@box>
References: <20190918131914.38081-1-justin.he@arm.com>
 <20190918131914.38081-4-justin.he@arm.com>
 <20190918140027.ckj32xnryyyesc23@box>
 <20190918180029.GB20601@iMac.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918180029.GB20601@iMac.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 07:00:30PM +0100, Catalin Marinas wrote:
> On Wed, Sep 18, 2019 at 05:00:27PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Sep 18, 2019 at 09:19:14PM +0800, Jia He wrote:
> > > @@ -2152,20 +2163,34 @@ static inline void cow_user_page(struct page *dst, struct page *src, unsigned lo
> > >  	 */
> > >  	if (unlikely(!src)) {
> > >  		void *kaddr = kmap_atomic(dst);
> > > -		void __user *uaddr = (void __user *)(va & PAGE_MASK);
> > > +		void __user *uaddr = (void __user *)(addr & PAGE_MASK);
> > > +		pte_t entry;
> > >  
> > >  		/*
> > >  		 * This really shouldn't fail, because the page is there
> > >  		 * in the page tables. But it might just be unreadable,
> > >  		 * in which case we just give up and fill the result with
> > > -		 * zeroes.
> > > +		 * zeroes. On architectures with software "accessed" bits,
> > > +		 * we would take a double page fault here, so mark it
> > > +		 * accessed here.
> > >  		 */
> > > +		if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
> > > +			spin_lock(vmf->ptl);
> > > +			if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
> > > +				entry = pte_mkyoung(vmf->orig_pte);
> > > +				if (ptep_set_access_flags(vma, addr,
> > > +							  vmf->pte, entry, 0))
> > > +					update_mmu_cache(vma, addr, vmf->pte);
> > > +			}
> > 
> > I don't follow.
> > 
> > So if pte has changed under you, you don't set the accessed bit, but never
> > the less copy from the user.
> > 
> > What makes you think it will not trigger the same problem?
> > 
> > I think we need to make cow_user_page() fail in this case and caller --
> > wp_page_copy() -- return zero. If the fault was solved by other thread, we
> > are fine. If not userspace would re-fault on the same address and we will
> > handle the fault from the second attempt.
> 
> It would be nice to clarify the semantics of this function and do as
> you suggest but the current comment is slightly confusing:
> 
> 	/*
> 	 * If the source page was a PFN mapping, we don't have
> 	 * a "struct page" for it. We do a best-effort copy by
> 	 * just copying from the original user address. If that
> 	 * fails, we just zero-fill it. Live with it.
> 	 */
> 
> Would any user-space rely on getting a zero-filled page here instead of
> a recursive fault?

I don't see the point in zero-filled page in this case. SIGBUS sounds like
more appropriate response, no?

-- 
 Kirill A. Shutemov

Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7FBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820B720B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="2OJhJbUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391397AbfITRAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 13:00:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41692 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388450AbfITRAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 13:00:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id f20so7132223edv.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CoI9aEF1VTiw5Xhyqba7lfuNeKaTTzmcsltHbdSRkHo=;
        b=2OJhJbUbpQmn+x3xQD0IdUL9dWYC/YbYOg+H5Rw3+hLXeib7Fw/NkPDuWjgbqZRyhH
         UhmCvyDveVppNSNLWGUKKRYDph/8hy+GnlI9BVJWv0qh74USl2ktYfyjzTL8u4DiloGy
         HnmblWT8RimK7hpAAi8c6P5HsIihYVZ8Je0xC3YEpMKV9Yetl1W5YiYuZ+6wOC/Uh2Kr
         VZ1PH7IUzV63vSz619E375gvI6LfJ7yVXe1yfFLtVhvs0ek4tvLZGZloHPwyM+S9/UZ9
         gi+hz7IU0w427OYGIpgdEyH0pB9IaeIh59t9zYXHgLMoCPNUG9Oyu/8Emo7f+Ps51Xut
         LF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CoI9aEF1VTiw5Xhyqba7lfuNeKaTTzmcsltHbdSRkHo=;
        b=oYKyYwOxPNm2YjIa+/tBhigTDFqMlcVZiRyLkH3U1FdJg/7rrhzlKhwoP/quPR+mTs
         8pTOc+uMm+pixaGBDoaW8erpJJcqOxqOmmi5hGmhA3f31dowZbbd08bo6ZkVpzXrORYp
         SDLJwFehI+Z28eDtmAhNaohetYg7nCSWxDJZaoV9NcCXkEL+O4Lfv5BsMviC+7VyCuMu
         t7YTF5d/1cI9Hp30VWA3HFbyKAWpSmdc0BB34eqV0jp0Ahei8rH8sMcUExDdQMCouVYQ
         bPRfn5vPzPggCHAazgZfUe6WHPP8fOn0hjBY93UIN7mkn2/9o4hA7oh88/QfU2sByBPE
         SsXw==
X-Gm-Message-State: APjAAAXv95vEk3L9VCO/4DaXOa/x7Zw8EIdDPHWEEJd193os6CfbsfC/
        Lsae3jeS7t6OlBXgeiGVz2Hr4Q==
X-Google-Smtp-Source: APXvYqxVUZ2ch3TYcwVRBpaEIcvJMThHoIdj+VR77186UorLBRy6kohaNp2UxH3nVDesW7lAnd7TZg==
X-Received: by 2002:a17:906:5c49:: with SMTP id c9mr20265396ejr.78.1568998831579;
        Fri, 20 Sep 2019 10:00:31 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id jr18sm285103ejb.89.2019.09.20.10.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 10:00:30 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id DB3CE10140A; Fri, 20 Sep 2019 20:00:30 +0300 (+03)
Date:   Fri, 20 Sep 2019 20:00:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jia He <justin.he@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com
Subject: Re: [PATCH v7 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190920170030.bpse5rlpjodbiv62@box>
References: <20190920135437.25622-1-justin.he@arm.com>
 <20190920135437.25622-4-justin.he@arm.com>
 <20190920155300.GC15392@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920155300.GC15392@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 08:53:00AM -0700, Matthew Wilcox wrote:
> On Fri, Sep 20, 2019 at 09:54:37PM +0800, Jia He wrote:
> > -static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
> > +static inline int cow_user_page(struct page *dst, struct page *src,
> > +				struct vm_fault *vmf)
> >  {
> 
> Can we talk about the return type here?
> 
> > +			} else {
> > +				/* Other thread has already handled the fault
> > +				 * and we don't need to do anything. If it's
> > +				 * not the case, the fault will be triggered
> > +				 * again on the same address.
> > +				 */
> > +				pte_unmap_unlock(vmf->pte, vmf->ptl);
> > +				return -1;
> ...
> > +	return 0;
> >  }
> 
> So -1 for "try again" and 0 for "succeeded".
> 
> > +		if (cow_user_page(new_page, old_page, vmf)) {
> 
> Then we use it like a bool.  But it's kind of backwards from a bool because
> false is success.
> 
> > +			/* COW failed, if the fault was solved by other,
> > +			 * it's fine. If not, userspace would re-fault on
> > +			 * the same address and we will handle the fault
> > +			 * from the second attempt.
> > +			 */
> > +			put_page(new_page);
> > +			if (old_page)
> > +				put_page(old_page);
> > +			return 0;
> 
> And we don't use the return value; in fact we invert it.
> 
> Would this make more sense:
> 
> static inline bool cow_user_page(struct page *dst, struct page *src,
> 					struct vm_fault *vmf)
> ...
> 				pte_unmap_unlock(vmf->pte, vmf->ptl);
> 				return false;
> ...
> 	return true;
> ...
> 		if (!cow_user_page(new_page, old_page, vmf)) {
> 
> That reads more sensibly for me.

I like this idea too.

-- 
 Kirill A. Shutemov

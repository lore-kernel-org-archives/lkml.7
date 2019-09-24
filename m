Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF09C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A8821783
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="RwAr5QCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbfIXPQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:16:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42989 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731440AbfIXPQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:16:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id y91so2190892ede.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bijUKP9uPxouhGcd1htXTfvDLPDNF2aF59LJ8pKbGVw=;
        b=RwAr5QCFNuqjuBy75MwEOPtlduLb8CpVBSMDCwFghHcPVcvL8pujx/O6FmjBSO6Cld
         4Vir9A55d3m/02fGYrTT30yNRDejCIS/GX2MaI/Hpgr1yuhXnIzJ9lbWA6YmpMu+Ssh6
         +3UrM4y3uwpc/Fuh52w3WOAxql427aic7/Su4igir/ot9V2Irz/HP6m45geigtNyqPvE
         UTUOcIAD8yVeu5+SMEVeQ+GBWjreDSi3yaZjMLUQ4AWDYlECZQu7HwZ47IRXsRStyuul
         I3kQbSPl6lQLuK4p2AQu1M7ygHgLC/do+Rw0BALPBr+L3KziJDWvIBq+gVHOOZhfZswB
         cAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bijUKP9uPxouhGcd1htXTfvDLPDNF2aF59LJ8pKbGVw=;
        b=XIASHgJx/5d4wIf2MXyxmwHU9KQsp1SZ2joKK/apOWyqod7XFJjWnGuindpWdvewSf
         huIDtJZ6DrBwrCGQ+MKMny/rycdvi4U6oqwkQYOifzBlNMu49oza+B+BlKpgFWr2ICju
         XcVj3exvX/mqnRwykZWAklOEcvetKc8kPXVWyaWTwoFkj4w4jSBbJAJKTVv9I+Q6KMYw
         qRAFQk4uxQGRCpotDzQWYC9CURhI+Nzh1NCT+7M6YSiEnyJUqsuhxSI2AC3df9NU2d5L
         CLDEHv6kmFuCOEt6beo6HieskJz3SC1mceMpkor1ubQAODGV1yW2RNixbg4FcMuIIVZh
         0kUg==
X-Gm-Message-State: APjAAAVuqAheqw4MyPorybACyGKLgoa6090Qx96pSbJSv7RA93+Rc4PT
        +Vl2ZXZEwyVBegplFo/hot5L0g==
X-Google-Smtp-Source: APXvYqzQcMhs5X+f3hlVnseFIl/P8nstkjyohZ+qybVIWqBtACSnnwdlq/O6aEoTRP2ZHbeRHAJBxw==
X-Received: by 2002:a17:906:c4b:: with SMTP id t11mr2963153ejf.131.1569338213558;
        Tue, 24 Sep 2019 08:16:53 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y25sm239403eju.39.2019.09.24.08.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 08:16:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id AA0201022AB; Tue, 24 Sep 2019 18:16:52 +0300 (+03)
Date:   Tue, 24 Sep 2019 18:16:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 2/4] mm, page_owner: record page owner for each subpage
Message-ID: <20190924151652.bjtjgj7brflrgcuv@box>
References: <20190820131828.22684-1-vbabka@suse.cz>
 <20190820131828.22684-3-vbabka@suse.cz>
 <20190924113135.2ekb7bmil3rxge6w@box>
 <ee93f01a-9f34-d237-9a34-33314f4298bc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee93f01a-9f34-d237-9a34-33314f4298bc@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:10:59PM +0200, Vlastimil Babka wrote:
> On 9/24/19 1:31 PM, Kirill A. Shutemov wrote:
> > On Tue, Aug 20, 2019 at 03:18:26PM +0200, Vlastimil Babka wrote:
> >> Currently, page owner info is only recorded for the first page of a high-order
> >> allocation, and copied to tail pages in the event of a split page. With the
> >> plan to keep previous owner info after freeing the page, it would be benefical
> >> to record page owner for each subpage upon allocation. This increases the
> >> overhead for high orders, but that should be acceptable for a debugging option.
> >>
> >> The order stored for each subpage is the order of the whole allocation. This
> >> makes it possible to calculate the "head" pfn and to recognize "tail" pages
> >> (quoted because not all high-order allocations are compound pages with true
> >> head and tail pages). When reading the page_owner debugfs file, keep skipping
> >> the "tail" pages so that stats gathered by existing scripts don't get inflated.
> >>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/page_owner.c | 40 ++++++++++++++++++++++++++++------------
> >>  1 file changed, 28 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/mm/page_owner.c b/mm/page_owner.c
> >> index addcbb2ae4e4..813fcb70547b 100644
> >> --- a/mm/page_owner.c
> >> +++ b/mm/page_owner.c
> >> @@ -154,18 +154,23 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
> >>  	return handle;
> >>  }
> >>  
> >> -static inline void __set_page_owner_handle(struct page_ext *page_ext,
> >> -	depot_stack_handle_t handle, unsigned int order, gfp_t gfp_mask)
> >> +static inline void __set_page_owner_handle(struct page *page,
> >> +	struct page_ext *page_ext, depot_stack_handle_t handle,
> >> +	unsigned int order, gfp_t gfp_mask)
> >>  {
> >>  	struct page_owner *page_owner;
> >> +	int i;
> >>  
> >> -	page_owner = get_page_owner(page_ext);
> >> -	page_owner->handle = handle;
> >> -	page_owner->order = order;
> >> -	page_owner->gfp_mask = gfp_mask;
> >> -	page_owner->last_migrate_reason = -1;
> >> +	for (i = 0; i < (1 << order); i++) {
> >> +		page_owner = get_page_owner(page_ext);
> >> +		page_owner->handle = handle;
> >> +		page_owner->order = order;
> >> +		page_owner->gfp_mask = gfp_mask;
> >> +		page_owner->last_migrate_reason = -1;
> >> +		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
> >>  
> >> -	__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
> >> +		page_ext = lookup_page_ext(page + i);
> > 
> > Isn't it off-by-one? You are calculating page_ext for the next page,
> > right?
> 
> You're right, thanks!
> 
> > And cant we just do page_ext++ here instead?
> 
> Unfortunately no, as that implies sizeof(page_ext), which only declares
> unsigned long flags; and the rest is runtime-determined.
> Perhaps I could add a wrapper named e.g. page_ext_next() that would use
> get_entry_size() internally and hide the necessary casts to void * and back?

Yeah, it looks less costly than calling lookup_page_ext() on each
iteration. And looks like it can be inlined if we make 'extra_mem' visible
(under different name) outside page_ext.c.

-- 
 Kirill A. Shutemov

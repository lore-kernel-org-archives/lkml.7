Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FF6C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C312133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="O+XctjsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDJBUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:20:41 -0400
Received: from owa.iluvatar.ai ([103.91.158.24]:5258 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbfDJBUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:20:41 -0400
X-AuditID: 0a650161-773ff700000078a3-da-5cad44e6e592
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id AB.C4.30883.6E44DAC5; Wed, 10 Apr 2019 09:20:38 +0800 (HKT)
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1554859237; h=from:subject:to:date:message-id;
        bh=GcuAOHRiKIFSZeRnIegs+sx9nR6bVTMEV5kQiFAX6gE=;
        b=O+XctjsQKh9LHjxwrPveCyJsIuMjwXVgEkBmPe5T004HJ/7DIvdDJwozzctACuW2oZIMZIdoJEA
        p7t+SS5TB1u7iiIW3H/T4pp4DGjCwIa9iw57crF8B/IsNPXhFtxU9c39eWaaY09CKwBP8QN5FRIty
        YuRvoWuzFD4uXczpBRU=
Received: from hsj-Precision-5520 (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Wed, 10 Apr 2019 09:20:37 +0800
Date:   Wed, 10 Apr 2019 09:20:36 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     "Weiny, Ira" <ira.weiny@intel.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/gup.c: fix the wrong comments
Message-ID: <20190410012034.GB3640@hsj-Precision-5520>
References: <20190408023746.16916-1-sjhuang@iluvatar.ai>
 <20190408141313.GU22763@bombadil.infradead.org>
 <20190409010832.GA28081@hsj-Precision-5520>
 <20190409024929.GW22763@bombadil.infradead.org>
 <20190409030417.GA3324@hsj-Precision-5520>
 <20190409111905.GY22763@bombadil.infradead.org>
 <2807E5FD2F6FDA4886F6618EAC48510E79CA51BA@CRSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E79CA51BA@CRSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsXClcqYpvvMZW2MwZ7rzBZz1q9hs1h9t5/N
        Yv/T5ywWZ7pzLS7vmsNmcW/Nf1aLzRMWAInFXUwWv3/MYXPg9JjdcJHFY/MKLY/Fe14yeVw+
        W+qx6dMkdo8TM36zeHx8eovF41LzdXaPz5vkAjijuGxSUnMyy1KL9O0SuDJmL9zNXrBIpmLZ
        wjfsDYzvhLsYOTkkBEwkFkycyNLFyMUhJHCCUeLK35VsIAlmAR2JBbs/AdkcQLa0xPJ/HCA1
        LAJvmSQOnbrICNHwnVFi3tKlTCANLAKqEg2T1oHZbAIaEnNP3GUGsUUE1CQWTVrGAjF0MrPE
        /VOxILawgKXEuu5j7CA2r4CZxLyX/VBDPzNJvFveygKREJQ4OfMJC8gVnAIhEpMn5YKERQWU
        JQ5sO84EEhYSUJB4sVIL4hkliSV7ZzFB2IUS31/eZZnAKDwLyTuzEN6ZhWT+AkbmVYz8xbnp
        epk5pWWJJYlFeomZmxghUZW4g/FG50u9Q4wCHIxKPLwB09fECLEmlhVX5h5ilOBgVhLh/fgG
        KMSbklhZlVqUH19UmpNafIhRmoNFSZy3bKJJjJBAemJJanZqakFqEUyWiYNTqoFpN+Ovf+9Z
        M6f/XaNSKbC29pXINNeljKYlaueVEif7O0zz1N4mybyJ/0P/+x/+Djcu7dZft9Liaku5anXv
        b/slf2oXrOFZxbmgMvDWJNW7LH2vAvZ33f/Mr/+t7ajLI4UT+/YdTT/6K/5R/8ZO1aqbBy85
        FHlM4C8MS/kpxG+iffHmAZftx57aqBgbH3ULnJDOOIV5k6Fxsa0Ap+/dHdofnTMYfh2392gI
        cygp6L5g16b4kdPiwq8/N55xHmRT3twx97/l5K4PBzSFrl3Q2lBxWOnKSufinGo2s9s1WiYf
        L9m1iOnEFXDuUlUo6L1hYHPtFIvk78qFwlvPcHwwkQvQUre7l/nu4DnG8vSO/2VKLMUZiYZa
        zEXFiQC7gcoaJwMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:55:31PM +0000, Weiny, Ira wrote:
> > On Tue, Apr 09, 2019 at 11:04:18AM +0800, Huang Shijie wrote:
> > > On Mon, Apr 08, 2019 at 07:49:29PM -0700, Matthew Wilcox wrote:
> > > > On Tue, Apr 09, 2019 at 09:08:33AM +0800, Huang Shijie wrote:
> > > > > On Mon, Apr 08, 2019 at 07:13:13AM -0700, Matthew Wilcox wrote:
> > > > > > On Mon, Apr 08, 2019 at 10:37:45AM +0800, Huang Shijie wrote:
> > > > > > > The root cause is that sg_alloc_table_from_pages() requires
> > > > > > > the page order to keep the same as it used in the user space,
> > > > > > > but
> > > > > > > get_user_pages_fast() will mess it up.
> > > > > >
> > > > > > I don't understand how get_user_pages_fast() can return the
> > > > > > pages in a different order in the array from the order they appear in
> > userspace.
> > > > > > Can you explain?
> > > > > Please see the code in gup.c:
> > > > >
> > > > > 	int get_user_pages_fast(unsigned long start, int nr_pages,
> > > > > 				unsigned int gup_flags, struct page **pages)
> > > > > 	{
> > > > > 		.......
> > > > > 		if (gup_fast_permitted(start, nr_pages)) {
> > > > > 			local_irq_disable();
> > > > > 			gup_pgd_range(addr, end, gup_flags, pages, &nr);
> > // The @pages array maybe filled at the first time.
> > > >
> > > > Right ... but if it's not filled entirely, it will be filled
> > > > part-way, and then we stop.
> > > >
> > > > > 			local_irq_enable();
> > > > > 			ret = nr;
> > > > > 		}
> > > > > 		.......
> > > > > 		if (nr < nr_pages) {
> > > > > 			/* Try to get the remaining pages with
> > get_user_pages */
> > > > > 			start += nr << PAGE_SHIFT;
> > > > > 			pages += nr;                                                  // The
> > @pages is moved forward.
> > > >
> > > > Yes, to the point where gup_pgd_range() stopped.
> > > >
> > > > > 			if (gup_flags & FOLL_LONGTERM) {
> > > > > 				down_read(&current->mm->mmap_sem);
> > > > > 				ret = __gup_longterm_locked(current,
> > current->mm,      // The @pages maybe filled at the second time
> > > >
> > > > Right.
> > > >
> > > > > 				/*
> > > > > 				 * retain FAULT_FOLL_ALLOW_RETRY
> > optimization if
> > > > > 				 * possible
> > > > > 				 */
> > > > > 				ret = get_user_pages_unlocked(start,
> > nr_pages - nr,    // The @pages maybe filled at the second time.
> > > > > 							      pages, gup_flags);
> > > >
> > > > Yes.  But they'll be in the same order.
> > > >
> > > > > BTW, I do not know why we mess up the page order. It maybe used in
> > some special case.
> > > >
> > > > I'm not discounting the possibility that you've found a bug.
> > > > But documenting that a bug exists is not the solution; the solution
> > > > is fixing the bug.
> > > I do not think it is a bug :)
> > >
> > > If we use the get_user_pages_unlocked(), DMA is okay, such as:
> > >                      ....
> > > 		     get_user_pages_unlocked()
> > > 		     sg_alloc_table_from_pages()
> > > 	             .....
> > >
> > > I think the comment is not accurate enough. So just add more comments,
> > > and tell the driver users how to use the GUPs.
> > 
> > gup_fast() and gup_unlocked() should return the pages in the same order.
> > If they do not, then it is a bug.
> 
> Is there a reproducer for this?  Or do you have some debug output which shows this problem?
Is Matthew right?

 " gup_fast() and gup_unlocked() should return the pages in the same order.
 If they do not, then it is a bug."

If Matthew is right,
I need more time to debug the DMA issue...
	

Thanks
Huang Shijie
 

> 
> Ira
> 

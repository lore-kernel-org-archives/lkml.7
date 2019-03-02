Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F9BC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA2220836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E69ej4bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfCBRLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 12:11:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfCBRLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 12:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kl5e37WI7w9hPYD4s95DfL0cvVBczbmwLkcTsoBgW1o=; b=E69ej4bwFLApvoJgbCNCL59MA
        09sYMmuFN2CRP+jsSrQ489rnRpZ+PxTpVsoa8+j9uB5h4i2twJJrUUr4pozB4CFd3tKbMhT8Vjr9h
        71HnjqpdyASNmSFaF/SWjvkIsi+nucHv5h93bAkoNWm6TUQgBwGtbmfmNLln1k2qo6pURI13Ymn9A
        3pdyMcBRbquct9OXX6mRNcdYt0E7wSb8jDCmGOEaDwUmaOxmp++RTfTzPmUtFN0kTGzM9mvncRoNJ
        yLLiOMFp6cm1hv/BJqG9d3Su7PqLLXpSzHiEQehqE6oxqxaHKek2RldjAQbW37hmwdIZLDjUZLOVG
        vvJcw3p1Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h089s-0004Ts-1J; Sat, 02 Mar 2019 17:10:44 +0000
Date:   Sat, 2 Mar 2019 09:10:43 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        peterz@infradead.org, riel@surriel.com, mhocko@suse.com,
        ying.huang@intel.com, jrdr.linux@gmail.com, jglisse@redhat.com,
        aneesh.kumar@linux.ibm.com, david@redhat.com, aarcange@redhat.com,
        raquini@redhat.com, rientjes@google.com, kirill@shutemov.name,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory.c: do_fault: avoid usage of stale
 vm_area_struct
Message-ID: <20190302171043.GP11592@bombadil.infradead.org>
References: <0b7a4604529e16ace8d65a42dac7c78582e7fb28.1551538524.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7a4604529e16ace8d65a42dac7c78582e7fb28.1551538524.git.jstancek@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 04:11:26PM +0100, Jan Stancek wrote:
> Problem is that "vmf->vma" used in do_fault() can become stale.
> Because mmap_sem may be released, other threads can come in,
> call munmap() and cause "vma" be returned to kmem cache, and
> get zeroed/re-initialized and re-used:

> This patch pins mm_struct and stores its value, to avoid using
> potentially stale "vma" when calling pte_free().

OK, we need to cache the mm_struct, but why do we need the extra atomic op?
There's surely no way the mm can be freed while the thread is in the middle
of handling a fault.

ie I would drop these lines:

> +	mmgrab(vm_mm);
> +
...
> +
> +	mmdrop(vm_mm);
> +

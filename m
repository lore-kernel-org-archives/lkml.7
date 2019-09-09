Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B8DC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 21:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF9D218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 21:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FFZylopi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391835AbfIIV1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 17:27:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfIIV1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 17:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FVpH6a1GjetVsJXM8dC8LnKY9cXJasZ0yXsRe7v9nF4=; b=FFZylopiX0MRcLVE9xNjWLC6Q
        TpqbVNdQ5HXEGy9Ps5pYE9V4XqsgifwYDY1/QwBluSYu6OQS/JzjC2fWA3vzDWkVcrViBeHFUCwJN
        dvX4RTYnXnb9HqLfvVIvR5+dX/5YLqPb1osYpd1uQv9pr0RjioVyuy+wVG+mwdTtZxherGaU/Y5/G
        EXVteWsYr/aQa9OM1CO9gHhRwS5/xc6uUzzhPAJ1ITOOldHZAfWOIH7epJ1ArZABZcZAla8stZLvL
        b/J2X633j39/pVgKMqIp+CHcEbxa8lu3RRilVgD43SIjLwPv1JqnVMY1m/I7AqV8wQscsroB+uPrj
        xIrmFrQ/Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i7RBo-0003Yd-Ip; Mon, 09 Sep 2019 21:27:12 +0000
Date:   Mon, 9 Sep 2019 14:27:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jia He <justin.he@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <Catalin.Marinas@arm.com>
Subject: Re: [PATCH v2] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190909212712.GE29434@bombadil.infradead.org>
References: <20190906135747.211836-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906135747.211836-1-justin.he@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 09:57:47PM +0800, Jia He wrote:
> +		if (!pte_young(vmf->orig_pte)) {
> +			entry = pte_mkyoung(vmf->orig_pte);
> +			if (ptep_set_access_flags(vmf->vma, vmf->address,
> +				vmf->pte, entry, 0))
> +				update_mmu_cache(vmf->vma, vmf->address,
> +						vmf->pte);
> +		}
> +

Oh, btw, why call update_mmu_cache() here?  All you've done is changed
the 'accessed' bit.  What is any architecture supposed to do in response
to this?

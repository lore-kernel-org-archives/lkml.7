Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E49C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9754D22C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FY1NJT9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404204AbfGYLoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:44:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbfGYLoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=i19VkmUA/JjV1baDqjaCUFBUl3HEhx06QA8y1Sjqx2Y=; b=FY1NJT9VDEPZNIxz3Cx6zp8eE
        AkhT6C4nMXH4+xI8bgTRfVlXBfYv/c4iwNpHN7E14TH/fPjMP23dDVpoW5UoQPGUloknxIVUUiKf/
        5fAhay9ppAQSPw3QccU0LY31rX1wQtRKb3rscJqLglpgxytDWRZBWANdnLWRFwdLLt5Jwe778enkK
        UB5erxDzKrkcWYDPYUpcOZxRq5z90AuZZk4n7oaw7YuwZyvaX+SXFbpbrf1ORsKcJORe0F1sXNt1q
        OWuhktmc6pQaocLPV9QXGyClV2YzweTCDwCV+dV/bN/4ENX6+kOaEK37+gLGnLUzTjCIJ/IwcDaco
        lUlZavJuQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqcAK-0000R5-94; Thu, 25 Jul 2019 11:44:08 +0000
Date:   Thu, 25 Jul 2019 04:44:08 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: kernel BUG at mm/swap_state.c:170!
Message-ID: <20190725114408.GV363@bombadil.infradead.org>
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CAC=cRTMz5S636Wfqdn3UGbzwzJ+v_M46_juSfoouRLS1H62orQ@mail.gmail.com>
 <CABXGCsOo-4CJicvTQm4jF4iDSqM8ic+0+HEEqP+632KfCntU+w@mail.gmail.com>
 <878ssqbj56.fsf@yhuang-dev.intel.com>
 <CABXGCsOhimxC17j=jApoty-o1roRhKYoe+oiqDZ3c1s2r3QxFw@mail.gmail.com>
 <87zhl59w2t.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhl59w2t.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 01:08:42PM +0800, Huang, Ying wrote:
> @@ -2489,6 +2491,14 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	/* complete memcg works before add pages to LRU */
>  	mem_cgroup_split_huge_fixup(head);
>  
> +	if (PageAnon(head) && PageSwapCache(head)) {
> +		swp_entry_t entry = { .val = page_private(head) };
> +
> +		offset = swp_offset(entry);
> +		swap_cache = swap_address_space(entry);
> +		xa_lock(&swap_cache->i_pages);
> +	}
> +
>  	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
>  		__split_huge_page_tail(head, i, lruvec, list);
>  		/* Some pages can be beyond i_size: drop them from page cache */
> @@ -2501,6 +2511,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		} else if (!PageAnon(page)) {
>  			__xa_store(&head->mapping->i_pages, head[i].index,
>  					head + i, 0);
> +		} else if (swap_cache) {
> +			__xa_store(&swap_cache->i_pages, offset + i,
> +				   head + i, 0);

I tried something along these lines (though I think I messed up the offset
calculation which is why it wasn't working for me).  My other concern
was with the case where SWAPFILE_CLUSTER was less than HPAGE_PMD_NR.
Don't we need to drop the lock and look up a new swap_cache if offset >=
SWAPFILE_CLUSTER?


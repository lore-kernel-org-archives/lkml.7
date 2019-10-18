Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC032CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B7221897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uvI7mKv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634130AbfJROZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:25:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbfJROZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jcc1+ecujeFP9amWaaEK0sWmcb9810FGXg7viupUUuw=; b=uvI7mKv4KgeqsE8Kvolcfmo+a
        P+z6BiDQNqceXE9dwMVcat/M3UZU70pZTGU1DeCqwPQwUi5YvvBUce17id8+Bj/LangeR+r/Qsvhw
        3b17jFLtLzh5j6raTeO/jvrHNRwvVikywv0lJokbuLnvoObWEFTPBRn0NSazfEU5/NKDkAmMNBQQp
        tGDszPqsOU8VWIQ9bKfSBMiEjQRRmTP4/2laIqNrrXBxXuJigUUAKcIAnpIEE0WlaYYglTe4JSeNd
        DBNG2jH3S/zIkjBTtNsHl8bsPkUsUmDrZ/2fbzuS4+6HegzlBSSYLAt5K6BdU0N7QONuUeCeTNuhY
        Zl4EgwyAQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLTBz-0001xl-Gq; Fri, 18 Oct 2019 14:25:23 +0000
Date:   Fri, 18 Oct 2019 07:25:23 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kernel-team@fb.com, william.kucharski@oracle.com,
        kirill.shutemov@linux.intel.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm,thp: recheck each page before collapsing file THP
Message-ID: <20191018142523.GL32665@bombadil.infradead.org>
References: <20191018050832.1251306-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018050832.1251306-1-songliubraving@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:08:32PM -0700, Song Liu wrote:
> +			/* double check the page is correct and clean */
> +			if (unlikely(!PageUptodate(page)) ||
> +			    unlikely(PageDirty(page)) ||
> +			    unlikely(page->mapping != mapping)) {

That's kind of an ugly way of writing it.  Why not more simply:

			if (unlikely(!PageUptodate(page) || PageDirty(page) ||
				     page->mapping != mapping)) {


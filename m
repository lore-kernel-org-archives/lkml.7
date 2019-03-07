Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD9420449
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hcf+6bUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfCGPGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:06:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfCGPGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qb+k4GhrBX2hxsqg3i9im3MoXFh0HQnNOWfXG9OtdlM=; b=hcf+6bUqLpzgnUybBrYqB2G8Z
        UmmQcyI+2HIvQ9/9P3mpkBnEdqombSYLvaqqgyJKyY89ZsAONGFwjRH8ebdUoaPTpiEH5w4+TcOTq
        RLivVxI3g6nzUUEQjhHl9fcEWv+qn52w7zxcRpTvi8AS5A/kJ8OejMz3AoxjUyhMQn4s40RTLlGWR
        Fdd8SchL2qZRJCRGTBQzaTMtRqfJA1YUGSz2v9QTcTRpvqMNmB0hm/PygVem4AOpBOHoDjhLKMkYx
        pgwhbailvbUIl9xKaqyEIofDgJdoWdYpmsHscFfvEKNfpGfDoT8eLSZ4QXy1ZnTlzpt/FuQ4DSNBG
        HvecyzSNA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1ubI-00016F-1H; Thu, 07 Mar 2019 15:06:24 +0000
Date:   Thu, 7 Mar 2019 07:06:23 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Song Liu <liu.song.a23@gmail.com>
Subject: Re: [PATCH v3] page cache: Store only head pages in i_pages
Message-ID: <20190307150623.GL13380@bombadil.infradead.org>
References: <20190215222525.17802-1-willy@infradead.org>
 <CAPhsuW7Hu6jBn-ti7S2cJhO1YQYg_RDZUgkqtgFO8zpBMV_9LA@mail.gmail.com>
 <CAPhsuW5a8=QJe2acWXQGWic1a=CJigwPR6BxSu2O2vg4W1mhzA@mail.gmail.com>
 <863F9255-E992-402F-827D-DA5F4661B9AB@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <863F9255-E992-402F-827D-DA5F4661B9AB@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 02:36:35AM -0700, William Kucharski wrote:
> 
> Other than the bug Song found in memfd_tag_pins(), I'd like to suggest two quick
> but pedantic changes to mm/filemap.c:
> 
> Though not modified in this patch, in line 284, the parenthesis should be moved
> to after the period:
> 
>  * modified.) The function expects only THP head pages to be present in the

https://english.stackexchange.com/questions/6632/where-does-the-period-go-when-using-parentheses disagrees with you

> > +		 * Move to the next page in the vector if this is a small page
> > +		 * or the index is of the last page in this compound page).
> 
> A few lines later, there is an extraneous parenthesis, and the comment could be a bit
> clearer.
> 
> Might I suggest:
> 
>                  * Move to the next page in the vector if this is a PAGESIZE
>                  * page or if the index is of the last PAGESIZE page within
>                  * this compound page.
> 
> You can say "base" instead of "PAGESIZE," but "small" seems open to interpretation.

Agreed on the spurios close paren.  The THP documentation prefers the
term 'regular page', so I went with:

                 * Move to the next page in the vector if this is a regular
                 * page or the index is of the last sub-page of this compound
                 * page.

> I haven't run across any problems and have been hammering the code for over five days
> without issue; all my testing was with transparent_hugepage/enabled set to
> "always."
> 
> Tested-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Thanks!

Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8821C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6A72087C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552725278;
	bh=jN5SbvzDRPlYKMurUXtI72O3MA59kys2b7QF9paRTds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qZsRTZQt1tu5WKIQzRKOuWNwJdOtMHHs/UadXi/hjqg6ab92P+2Xa2iBuc/RszXix
	 oBKd0lZIVa91dIi7ZlnLL0PvY2JETV1aRIbfbTqBbqNNKVi2TzqkZ72pQj6m7GTtCW
	 SkO3VL2yFmQjmZGl43px9WLXBe1M9w+OoxBrhEOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfCPIeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:34:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:34920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfCPIeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:34:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8205ACD7;
        Sat, 16 Mar 2019 08:34:35 +0000 (UTC)
Date:   Sat, 16 Mar 2019 09:34:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, william.kucharski@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm: Fix __dump_page when mapping->host is not set
Message-ID: <20190316083434.GI15672@dhcp22.suse.cz>
References: <20190315121826.23609-1-osalvador@suse.de>
 <20190315124733.GE15672@dhcp22.suse.cz>
 <20190315143304.pkuvj4qwtlzgm7iq@d104.suse.de>
 <alpine.LSU.2.11.1903150952270.2934@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1903150952270.2934@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[my mbox didn't get synced completely so our emails "crossed"]

On Fri 15-03-19 10:21:18, Hugh Dickins wrote:
> On Fri, 15 Mar 2019, Oscar Salvador wrote:
> > On Fri, Mar 15, 2019 at 01:47:33PM +0100, Michal Hocko wrote:
> > > diff --git a/mm/debug.c b/mm/debug.c
> > > index 1611cf00a137..499c26d5ebe5 100644
> > > --- a/mm/debug.c
> > > +++ b/mm/debug.c
> > > @@ -78,6 +78,9 @@ void __dump_page(struct page *page, const char *reason)
> > >  	else if (PageKsm(page))
> > >  		pr_warn("ksm ");
> > >  	else if (mapping) {
> > > +		if (PageSwapCache(page))
> > > +			mapping = page_swap_info(page)->swap_file->f_mapping;
> > > +
> > >  		pr_warn("%ps ", mapping->a_ops);
> > >  		if (mapping->host->i_dentry.first) {
> > >  			struct dentry *dentry;
> > 
> > This looks like a much nicer fix, indeed.
> > I gave it a spin and it works.
> > 
> > Since the mapping is set during the swapon, I would assume that this should
> > always work for swap.
> > Although I am not sure if once you start playing with e.g zswap the picture can
> > change.
> > 
> > Let us wait for Hugh and Jan.
> > 
> > Thanks Michal
> 
> Sorry, I don't agree that Michal's more sophisticated patch is nicer:
> the appropriate patch was your original, just checking for NULL.
> 
> Though, would I be too snarky to suggest that your patch description
> would be better at 2 lines than 90?  Swap mapping->host is NULL,
> so of course __dump_page() needs to be careful about that.
> 
> I was a little disturbed to see __dump_page() now getting into dentries,
> but admit that it can sometimes be very helpful to see the name of the
> file involved; so if that is not in danger of breaking anything, okay.
> 
> It is very often useful to see if a page is PageSwapCache (typically
> because that should account for 1 of its refcount); I cannot think of
> a time when it's been useful to know the name of the underlying swap
> device (if that's indeed what f_mapping leads to: it's new to me).
> And if you need swp_type and swp_offset, they're in the raw output.
> 
> The cleverer __dump_page() tries to get, the more likely that it will
> itself crash just when you need it most. Please just keep it simple.

OK, fair enough. If we ever have anybody suggesting to follow the swap
lead then we can add it. I do not have a good use case for that right
now. Let's go with Oscar's original patch. Thanks!

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs

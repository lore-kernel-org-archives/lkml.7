Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD16C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72CD218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552724638;
	bh=83SpK4MyhZG/v57MFRJVaWHAEvI5uHjzqvt4kq+Daz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1FIKEzBJMWkDsmiHUwLiI0oFapsTguTPNT4BBnHWWoDmJwdmIQuQ0sHPd+h89hHms
	 kxWD9sT7WFWhd+vsrQKYsKDCleGrcSwkBnv61i6v5bPnN9eNCGYjIyOENweAwSoTfo
	 ALv7iTwwDU126rLhVQ3F3Z5OGNFP9/C7zElfj7rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCPIX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:23:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:33438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbfCPIX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:23:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4B91AD3B;
        Sat, 16 Mar 2019 08:23:55 +0000 (UTC)
Date:   Sat, 16 Mar 2019 09:23:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        william.kucharski@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: Fix __dump_page when mapping->host is not set
Message-ID: <20190316082354.GF15672@dhcp22.suse.cz>
References: <20190315121826.23609-1-osalvador@suse.de>
 <20190315124733.GE15672@dhcp22.suse.cz>
 <20190315143304.pkuvj4qwtlzgm7iq@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315143304.pkuvj4qwtlzgm7iq@d104.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-03-19 15:33:07, Oscar Salvador wrote:
> On Fri, Mar 15, 2019 at 01:47:33PM +0100, Michal Hocko wrote:
> > diff --git a/mm/debug.c b/mm/debug.c
> > index 1611cf00a137..499c26d5ebe5 100644
> > --- a/mm/debug.c
> > +++ b/mm/debug.c
> > @@ -78,6 +78,9 @@ void __dump_page(struct page *page, const char *reason)
> >  	else if (PageKsm(page))
> >  		pr_warn("ksm ");
> >  	else if (mapping) {
> > +		if (PageSwapCache(page))
> > +			mapping = page_swap_info(page)->swap_file->f_mapping;
> > +
> >  		pr_warn("%ps ", mapping->a_ops);
> >  		if (mapping->host->i_dentry.first) {
> >  			struct dentry *dentry;
> 
> This looks like a much nicer fix, indeed.

If we go this way then we should swap the order and print the mapping
before we alter it.

> I gave it a spin and it works.

Thanks for testing!

> Since the mapping is set during the swapon, I would assume that this should
> always work for swap.
> Although I am not sure if once you start playing with e.g zswap the picture can
> change.
> 
> Let us wait for Hugh and Jan.

Yes, I really cannot tell this is really safe. Maybe we want to do the
check for host anyway. Just to be sure.
-- 
Michal Hocko
SUSE Labs

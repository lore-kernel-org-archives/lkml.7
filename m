Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35239CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA5F21D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571383995;
	bh=WWhfIUGeyAdX3039RAFd4pa5upiMW7hePA7+4Sj9l88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UAVaSORf3kzgU4IuageQbHWnc5x5BDYEry0dEjfA/Pb1Bpj6M8QfZG/B0+B/nsJKz
	 UXMhlC14lgxD4cYLPnI+PyvcRmQei8nToq7AXws9f7UFI0uVplVcID08eGjpa7OaJd
	 VxxNdziCjG+29rqZ23O9Yyl7730haSu8QQbJoKqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390517AbfJRHdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:33:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:55816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733083AbfJRHdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:33:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BB85B6A5;
        Fri, 18 Oct 2019 07:33:11 +0000 (UTC)
Date:   Fri, 18 Oct 2019 09:33:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Qian Cai <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: memory offline infinite loop after soft offline
Message-ID: <20191018073310.GB5017@dhcp22.suse.cz>
References: <1570829564.5937.36.camel@lca.pw>
 <20191014083914.GA317@dhcp22.suse.cz>
 <20191017093410.GA19973@hori.linux.bs1.fc.nec.co.jp>
 <20191017100106.GF24485@dhcp22.suse.cz>
 <1571335633.5937.69.camel@lca.pw>
 <20191017182759.GN24485@dhcp22.suse.cz>
 <20191018021906.GA24978@hori.linux.bs1.fc.nec.co.jp>
 <20191018060635.GA5017@dhcp22.suse.cz>
 <20191018063222.GA15406@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018063222.GA15406@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-10-19 06:32:22, Naoya Horiguchi wrote:
> On Fri, Oct 18, 2019 at 08:06:35AM +0200, Michal Hocko wrote:
> > On Fri 18-10-19 02:19:06, Naoya Horiguchi wrote:
> > > On Thu, Oct 17, 2019 at 08:27:59PM +0200, Michal Hocko wrote:
> > > > On Thu 17-10-19 14:07:13, Qian Cai wrote:
> > > > > On Thu, 2019-10-17 at 12:01 +0200, Michal Hocko wrote:
> > > > > > On Thu 17-10-19 09:34:10, Naoya Horiguchi wrote:
> > > > > > > On Mon, Oct 14, 2019 at 10:39:14AM +0200, Michal Hocko wrote:
> > > > > > 
> > > > > > [...]
> > > > > > > > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > > > > > > > index 89c19c0feadb..5fb3fee16fde 100644
> > > > > > > > --- a/mm/page_isolation.c
> > > > > > > > +++ b/mm/page_isolation.c
> > > > > > > > @@ -274,7 +274,7 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
> > > > > > > >  			 * simple way to verify that as VM_BUG_ON(), though.
> > > > > > > >  			 */
> > > > > > > >  			pfn += 1 << page_order(page);
> > > > > > > > -		else if (skip_hwpoisoned_pages && PageHWPoison(page))
> > > > > > > > +		else if (skip_hwpoisoned_pages && PageHWPoison(compound_head(page)))
> > > > > > > >  			/* A HWPoisoned page cannot be also PageBuddy */
> > > > > > > >  			pfn++;
> > > > > > > >  		else
> > > > > > > 
> > > > > > > This fix looks good to me. The original code only addresses hwpoisoned 4kB-page,
> > > > > > > we seem to have this issue since the following commit,
> > > > > > 
> > > > > > Thanks a lot for double checking Naoya!
> > > > > >  
> > > > > > >   commit b023f46813cde6e3b8a8c24f432ff9c1fd8e9a64
> > > > > > >   Author: Wen Congyang <wency@cn.fujitsu.com>
> > > > > > >   Date:   Tue Dec 11 16:00:45 2012 -0800
> > > > > > >   
> > > > > > >       memory-hotplug: skip HWPoisoned page when offlining pages
> > > > > > > 
> > > > > > > and extension of LTP coverage finally discovered this.
> > > > > > 
> > > > > > Qian, could you give the patch some testing?
> > > > > 
> > > > > Unfortunately, this does not solve the problem. It looks to me that in
> > > > > soft_offline_huge_page(), set_hwpoison_free_buddy_page() will only set
> > > > > PG_hwpoison for buddy pages, so the even the compound_head() has no PG_hwpoison
> > > > > set.
> > > > > 
> > > > > 		if (PageBuddy(page_head) && page_order(page_head) >= order) {
> > > > > 			if (!TestSetPageHWPoison(page))
> > > > > 				hwpoisoned = true;
> > > > 
> > > > This is more than unexpected. How are we supposed to find out that the
> > > > page is poisoned? Any idea Naoya?
> > > 
> > > # sorry for my poor review...
> > > 
> > > We set PG_hwpoison bit only on the head page for hugetlb, that's because
> > > we handle multiple pages as a single one for hugetlb. So it's enough
> > > to check isolation only on the head page.  Simply skipping pfn cursor to
> > > the page after the hugepage should avoid the infinite loop:
> > 
> > But the page dump Qian provided shows that the head page doesn't have
> > HWPoison bit either. If it had then going pfn at a time should just work
> > because all tail pages would be skipped. Or do I miss something?
> 
> You're right, then I don't see how this happens.

OK, this is a bit relieving. I thought that there are legitimate cases
when none of the hugetlb gets the HWPoison bit (e.g. when the page has 0
reference count which is the case here). That would be utterly broken
because we would have no way to tell the page is hwpoisoned.

Anyway, do you think the patch as I've posted makes sense regardless
another potential problem? Or would you like to resend yours which skips
over tail pages at once?
-- 
Michal Hocko
SUSE Labs

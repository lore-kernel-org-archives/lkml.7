Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8439CC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FC922CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567601549;
	bh=6jQ7RfzG50udZVMQnvXV9plnwfNhGt0NH+WEy0xU/qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1kcBV/JeVtLA/s38y40ijeUFaZjkbeuP0q+Dq7PpzVTiK/D8sCqlLZid0hHXBsboq
	 X7iFNicEfjmkvsfB/OCvfMce83exixWMc01QicmotBfTa298KA3PcWavb1CwLMVIvK
	 nCT8FXH4fjlcCPK4UWbLIgRLZdfH60v+iMl+/csM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfIDMw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:52:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:49034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbfIDMw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:52:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1084EAF47;
        Wed,  4 Sep 2019 12:52:27 +0000 (UTC)
Date:   Wed, 4 Sep 2019 14:52:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     sunqiuyang <sunqiuyang@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Message-ID: <20190904125226.GV3838@dhcp22.suse.cz>
References: <20190903082746.20736-1-sunqiuyang@huawei.com>
 <20190903131737.GB18939@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C1B09@dggeml512-mbx.china.huawei.com>
 <20190904063836.GD3838@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C2EBD@dggeml512-mbx.china.huawei.com>
 <20190904081408.GF3838@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C3402@dggeml512-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157FC541501A9C4C862B2F16FFE316DC190C3402@dggeml512-mbx.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-09-19 12:19:11, sunqiuyang wrote:
> > Do not top post please
> > 
> > On Wed 04-09-19 07:27:25, sunqiuyang wrote:
> > > isolate_migratepages_block() from another thread may try to isolate the page again:
> > >
> > > for (; low_pfn < end_pfn; low_pfn++) {
> > >   /* ... */
> > >   page = pfn_to_page(low_pfn);
> > >  /* ... */
> > >   if (!PageLRU(page)) {
> > >     if (unlikely(__PageMovable(page)) && !PageIsolated(page)) {
> > >         /* ... */
> > >         if (!isolate_movable_page(page, isolate_mode))
> > >           goto isolate_success;
> > >       /*... */
> > > isolate_success:
> > >      list_add(&page->lru, &cc->migratepages);
> > >
> > > And this page will be added to another list.
> > > Or, do you see any reason that the page cannot go through this path?
> > 
> > The page shouldn't be __PageMovable after the migration is done. All the
> > state should have been transfered to the new page IIUC.
> > 
>
> I don't see where page->mapping is modified after the migration is done. 
> 
> Actually, the last comment in move_to_new_page() says,
> "Anonymous and movable page->mapping will be cleard by
> free_pages_prepare so don't reset it here for keeping
> the type to work PageAnon, for example. "
> 
> Or did I miss something? Thanks,

This talks about mapping rather than flags stored in the mapping.
I can see that in tree migration handlers (z3fold_page_migrate,
vmballoon_migratepage via balloon_page_delete, zs_page_migrate via
reset_page) all reset the movable flag. I am not sure whether that is a
documented requirement or just a coincidence. Maybe it should be
documented. I would like to hear from Minchan.

-- 
Michal Hocko
SUSE Labs

Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADFCC4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB90F2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568308890;
	bh=fDBeDyNF6sdUvn8Q7Blf6ysP3OEOAAZgXz22Q6wI0TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HKkYigeK05WYKehKYk89DEHQwVroMZzLKPmhlQonDFlBgZJRO3V7RvQ0OkQoneVc1
	 zEEXTc4/xh92tz1f4Sf1IVYj559e/y8voQax7roB89CAoWvG2681lJl/gGFabv5ak4
	 n0IeEKAB/3vA2zWz9b53vjgQUFAdjcqbfylM267k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbfILRVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 13:21:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47076 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfILRV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:21:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so16395360pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ELatS+qNwcqZFlGpoKi7iobXH6c8V+qxrhRPOrjs54=;
        b=fic/yNRoUbOshKf70uCLRttuKIFyNPCwbkyjVy7IaAkeyp9nOiqYEb2H5J8G6Hs3AH
         SaT2pHiD0cJBkcvWfdj5QRvUVKfC3uTwKIMrmxRMQnJ6QtDtZ9fK8cNcQCnDCk6OWL0r
         ie25/fC0n7gs7E2KLdSIX/xwj+GBedVQPOYJK2gYcmy2lY7U/sjaK1Bn28yF+aZUnG15
         ji0c6d/gqdBPDKYhKET84p010KEYjswZ6Kee8LyX2fb/sbgGFLsbvDjJ05gmyDOEdnt3
         f0SqN0YffMqViC6+4yTyNq9QHPeyvyasDNthkbw+tILxKD4/KLTEYPTflwMgrI7CvdLW
         /tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ELatS+qNwcqZFlGpoKi7iobXH6c8V+qxrhRPOrjs54=;
        b=XL0YlmXy0LYvMfmaCYstXFj7+IxsBQlV6NOiEurhtf7up7LOsGJ369v5o09FLShtzp
         0nfzR0uB+5+Ab6m6K2yy1E7uy7Zf7AhvXkzJBGwln+X85g0ZdX4gjoy0i47ashlzpj4L
         QiO+40n5HQ3RP6qPLby0kGGobCbtwnoYtc2yP2jWTBJrOQA/Cv1XVepEwsN3lhqdyuDk
         lWkp9A+Tx/Z94+pNYxmQDFqsGqc9mk09kKXQAn9NJMdK8xgxuCXdISuF24cLNgHOWZiz
         eStbgA/ezJsCKrvoSQRVQcu05qgBDu2e31VEHWbEI3H2zsRk2TmlnPz80GdcusHS8jEq
         GvIw==
X-Gm-Message-State: APjAAAUfan11SbezZ/mpQHvxopJTwbpFyTT2uAOhZTCXi7wLjo00QTIC
        /ETBTWDcs5TiUfXw7pR14Vs=
X-Google-Smtp-Source: APXvYqyNX7lxxxME/8dFZo9+JTc1bHPD2IOSqYLwAAfvYJAiKIQRg83EKM9Vk+aVP1tSkjhJCil0qg==
X-Received: by 2002:a62:5ac1:: with SMTP id o184mr49440519pfb.67.1568308888895;
        Thu, 12 Sep 2019 10:21:28 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id h70sm22082955pgc.36.2019.09.12.10.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 10:21:27 -0700 (PDT)
Date:   Thu, 12 Sep 2019 10:21:25 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     sunqiuyang <sunqiuyang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Message-ID: <20190912172125.GB119788@google.com>
References: <20190903082746.20736-1-sunqiuyang@huawei.com>
 <20190903131737.GB18939@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C1B09@dggeml512-mbx.china.huawei.com>
 <20190904063836.GD3838@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C2EBD@dggeml512-mbx.china.huawei.com>
 <20190904081408.GF3838@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C3402@dggeml512-mbx.china.huawei.com>
 <20190904125226.GV3838@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C5990@dggeml512-mbx.china.huawei.com>
 <20190909084029.GE27159@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909084029.GE27159@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 10:40:29AM +0200, Michal Hocko wrote:
> On Thu 05-09-19 01:44:12, sunqiuyang wrote:
> > > 
> > > ________________________________________
> > > From: Michal Hocko [mhocko@kernel.org]
> > > Sent: Wednesday, September 04, 2019 20:52
> > > To: sunqiuyang
> > > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org
> > > Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of non-LRU movable pages
> > > 
> > > On Wed 04-09-19 12:19:11, sunqiuyang wrote:
> > > > > Do not top post please
> > > > >
> > > > > On Wed 04-09-19 07:27:25, sunqiuyang wrote:
> > > > > > isolate_migratepages_block() from another thread may try to isolate the page again:
> > > > > >
> > > > > > for (; low_pfn < end_pfn; low_pfn++) {
> > > > > >   /* ... */
> > > > > >   page = pfn_to_page(low_pfn);
> > > > > >  /* ... */
> > > > > >   if (!PageLRU(page)) {
> > > > > >     if (unlikely(__PageMovable(page)) && !PageIsolated(page)) {
> > > > > >         /* ... */
> > > > > >         if (!isolate_movable_page(page, isolate_mode))
> > > > > >           goto isolate_success;
> > > > > >       /*... */
> > > > > > isolate_success:
> > > > > >      list_add(&page->lru, &cc->migratepages);
> > > > > >
> > > > > > And this page will be added to another list.
> > > > > > Or, do you see any reason that the page cannot go through this path?
> > > > >
> > > > > The page shouldn't be __PageMovable after the migration is done. All the
> > > > > state should have been transfered to the new page IIUC.
> > > > >
> > > >
> > > > I don't see where page->mapping is modified after the migration is done.

Look at __ClearPageMovable which modify page->mapping.
Once driver is migrated the page successfully, it should call __ClearPageMovable.
To not consume new a page flag at that time, this flag is stored at page->mapping
since we already have squeezed several flags in there.

> > > >
> > > > Actually, the last comment in move_to_new_page() says,
> > > > "Anonymous and movable page->mapping will be cleard by
> > > > free_pages_prepare so don't reset it here for keeping
> > > > the type to work PageAnon, for example. "
> > > >
> > > > Or did I miss something? Thanks,
> > > 
> > > This talks about mapping rather than flags stored in the mapping.
> > > I can see that in tree migration handlers (z3fold_page_migrate,
> > > vmballoon_migratepage via balloon_page_delete, zs_page_migrate via
> > > reset_page) all reset the movable flag. I am not sure whether that is a
> > > documented requirement or just a coincidence. Maybe it should be
> > > documented. I would like to hear from Minchan.

It is intended. See Documentation/vm/page_migration.rst

   After isolation, VM calls migratepage of driver with isolated page.
   The function of migratepage is to move content of the old page to new page
   and set up fields of struct page newpage. Keep in mind that you should
   indicate to the VM the oldpage is no longer movable via __ClearPageMovable()
   under page_lock if you migrated the oldpage successfully and returns
   MIGRATEPAGE_SUCCESS.

Thanks.

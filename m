Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE00C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA530214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbfKFMED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:04:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:41544 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728610AbfKFMED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:04:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 262C8AEB3;
        Wed,  6 Nov 2019 12:04:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0BC791E4862; Wed,  6 Nov 2019 13:04:02 +0100 (CET)
Date:   Wed, 6 Nov 2019 13:04:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     snazy@snazy.de
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191106120402.GG16085@quack2.suse.cz>
References: <707b72c6dac76c534dcce60830fa300c44f53404.camel@gmx.de>
 <20191025135749.GK17610@dhcp22.suse.cz>
 <20191025140029.GL17610@dhcp22.suse.cz>
 <c2505804fda5326acf76b2be0155d558e5481fb5.camel@gmx.de>
 <fa6599459300c61da6348cdfd0cfda79e1c17a7a.camel@gmx.de>
 <ad13f479-3fda-b55a-d311-ef3914fbe649@suse.cz>
 <20191105182211.GA33242@cmpxchg.org>
 <46c58487acc05aa3c4d5d1e72b95cd84a5dba47b.camel@gmx.de>
 <9072e55e97f0c4f3b286eb57639c4e9bb4223dfc.camel@gmx.de>
 <b0a04e9953b0e714ec906fbee38f36b08e58da8a.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0a04e9953b0e714ec906fbee38f36b08e58da8a.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-11-19 12:26:24, Robert Stupp wrote:
> Maybe a native and wrong idea, but would it work to call
> __get_user_pages_locked() instead of __get_user_pages() in
> populate_vma_page_range() ?

See my reply to Johannes. It would work but it would be somewhat fragile.

								Honza

> On Wed, 2019-11-06 at 11:25 +0100, Robert Stupp wrote:
> > Here's one more dmesg output with more information captured in
> > __get_user_pages() as well. It basically confirms that
> > handle_mm_fault() returns VM_FAULT_RETRY.
> >
> > I'm not sure where and what to change ("fix with a FOLL_TRIED
> > somewhere") to make it work. My (uneducated) impression is, that only
> > __get_user_pages() needs to be changed - but I might be wrong.
> >
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

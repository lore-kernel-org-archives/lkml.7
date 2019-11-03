Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C90ACA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 17:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E794C20848
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 17:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PnLmUvEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfKCRHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 12:07:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfKCRHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 12:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wjKp2fqpiQjaUT6EIqxBycVubVBmTVdz/ReoRC4xHf0=; b=PnLmUvEvpyxH8pz/MANhPCpC7
        I3CdRUxk90B95AXWyukZvxp22FMI1Yy1Dwwm3HnxKiokd4NJJOo4oEJduVIqY4dF4Sj9TgTiRcfsr
        tcjTaHijlN89bjUruXQBmJdTsgmg5S7ZkdXPeag26Z3SGzMbHEfW1kRjAwK061pQhFUSbI9Axnjk6
        uyQRlvG+IxxI+Y/NV3FRXJYYGeTviLWPWVHWSHv+dsAnD9c/hrNWK8T0fdsCRU6OcexvXwvNbFD9B
        VfmiLUm06ix79hR2ahVJrfHrABBbKd4XzGn0eYorbDkWA8vskaXZLoBAPA3EjFLRm5kGfKf1Vd0us
        mlW2kiV+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRJKz-0000GL-Tl; Sun, 03 Nov 2019 17:06:49 +0000
Date:   Sun, 3 Nov 2019 09:06:49 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Jan Kara <jack@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3] mm: add page preemption
Message-ID: <20191103170649.GA11823@bombadil.infradead.org>
References: <20191103115727.9884-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103115727.9884-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 07:57:27PM +0800, Hillf Danton wrote:
> The cpu preemption feature makes a task able to preempt other tasks
> of lower priorities for cpu. It has been around for a while.
> 
> This work introduces task prio into page reclaiming in order to add
> the page preemption feature that makes a task able to preempt other
> tasks of lower priorities for page.
> 
> No page will be reclaimed on behalf of tasks of lower priorities
> under pp, a two-edge feature that functions only under memory
> pressure, laying a barrier to pages flowing to lower prio, and the
> nice syscall is what users need to fiddle with it for instance if
> they have a bunch of workloads to run in datacenter, and some
> difficulty predicting the runtime working set size for every
> individual workload which is sensitive to jitters in lru pages.
> 
> Currently pages are reclaimed without prio taken into account; pages
> can be reclaimed from tasks of lower priorities on behalf of
> higher-prio tasks and vice versa.
> 
> s/and vice versa/only/ is what we need to make pp by definition, but
> it could not make a sense without prio introduced; otherwise we can
> simply skip deactivating the lru pages based on prio comprison, and
> work is done.
> 
> The introduction consists of two parts. On the page side, we have to
> store the page owner task's prio in page, which needs an extra room the
> size of the int type in the page struct. That room sounds impossible
> without inflating the page struct size, and is walked around by making
> pp depend on CONFIG_64BIT.

... and !MEMCG.  Which means that your work is uninteresting because all
the distros turn on CONFIG_MEMCG.

You still haven't given us any numbers.  Or a workload which actually
benefits from this patch.

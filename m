Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2110FC04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D19205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556549577;
	bh=6JUGQ120cDF/m4dwMTnN3wocLjZBy1H6hlb6MdeFYk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BLj4g4cGkNO2fEWFICqk4o/lVlDds38pIi1Uf79XIjOxTa6xJ4oUvFa+nSoKSr9Md
	 uOo8LLkci3QXr27qu3L1lrVGommUFDJ/uj9KlS1HogKwim6HGVsVQaLILFT/Hm0pjJ
	 hBrZ6Hw/7Le14hDxJBGEnwDR3aaSAzeulYXUQz08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfD2Owz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:52:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:58660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728339AbfD2Owy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:52:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B56CAAF61;
        Mon, 29 Apr 2019 14:52:52 +0000 (UTC)
Date:   Mon, 29 Apr 2019 10:52:49 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg, oom: no oom-kill for __GFP_RETRY_MAYFAIL
Message-ID: <20190429145249.GN21837@dhcp22.suse.cz>
References: <20190428235613.166330-1-shakeelb@google.com>
 <20190429122214.GK21837@dhcp22.suse.cz>
 <CALvZod6-EOAkcuiuBpoE6uR2DFNUkUY8syHxenFEAZTxhgNMhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6-EOAkcuiuBpoE6uR2DFNUkUY8syHxenFEAZTxhgNMhQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-04-19 07:37:08, Shakeel Butt wrote:
> On Mon, Apr 29, 2019 at 5:22 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Sun 28-04-19 16:56:13, Shakeel Butt wrote:
> > > The documentation of __GFP_RETRY_MAYFAIL clearly mentioned that the
> > > OOM killer will not be triggered and indeed the page alloc does not
> > > invoke OOM killer for such allocations. However we do trigger memcg
> > > OOM killer for __GFP_RETRY_MAYFAIL. Fix that.
> >
> > An example of __GFP_RETRY_MAYFAIL memcg OOM report would be nice. I
> > thought we haven't been using that flag for memcg allocations yet.
> > But this is definitely good to have addressed.
> 
> Actually I am planning to use it for memcg allocations (specifically
> fsnotify allocations).

OK, then articulate it in the changelog please.

> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs

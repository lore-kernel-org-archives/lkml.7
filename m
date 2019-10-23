Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F76CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB52221906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571818108;
	bh=4oAsPmCE7NkhrzXpeL/BR1JvZGVK6Osp1an0jLKHdso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DUp8qq/k3Gxgv3HGAXYmIUMdY1b4+NmWTNKtlNSnnfKCn7c0TnSOP32fSgkupywdt
	 WfArZzPLBBFuZ1juzmVjRXDAbtXUs4Ogbtler3wGFI2ILRCYO/uwZklwAq3pLUvgYq
	 udV0KiBkaDYps239ThZlYmBN+ekJ9B1RnaI0WjHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390168AbfJWII1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:08:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:48720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390035AbfJWII1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:08:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99998BB64;
        Wed, 23 Oct 2019 08:08:25 +0000 (UTC)
Date:   Wed, 23 Oct 2019 10:08:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC v1] memcg: add memcg lru for page reclaiming
Message-ID: <20191023080823.GH754@dhcp22.suse.cz>
References: <20191022133050.15620-1-hdanton@sina.com>
 <20191023044448.16484-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023044448.16484-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 12:44:48, Hillf Danton wrote:
> 
> On Tue, 22 Oct 2019 15:58:32 +0200 Michal Hocko wrote:
> > 
> > On Tue 22-10-19 21:30:50, Hillf Danton wrote:
[...]
> > > in this RFC after ripping pages off
> > > the first victim, the work finishes with the first ancestor of the victim
> > > added to lru.
> > > 
> > > Recaliming is defered until kswapd becomes active.
> > 
> > This is a wrong assumption because high limit might be configured way
> > before kswapd is woken up.
> 
> This change was introduced because high limit breach looks not like a
> serious problem in the absence of memory pressure. Lets do the hard work,
> reclaiming one memcg a time up through the hierarchy, when kswapd becomes
> active. It also explains the BH introduced.

But this goes against the main motivation for the high limit - to
throttle. It is not all that important that there is not global memory
pressure. The preventive high limit reclaim is there to make sure that
the specific memcg is kept in a reasonable containment.
-- 
Michal Hocko
SUSE Labs

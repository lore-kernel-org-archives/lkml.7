Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EABC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 13:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349DD214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569331017;
	bh=sr7HSSP07N+1Pfayv559VRzxf5BLmIueP1ELZ5iJYho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J/xmxZtTe8ntq8nUR2rl6PjtOaNtrgwsMspqapZA8tqC9Ok58mPuKSGVQ/6DS3MMP
	 EQHh87b1nYs3ekD3/py3KhgnwtPINHeOVJvzURsAUeM0K4J+NPPobMtv+FE4p8Qqon
	 iv4AI8A7OIKz/kWpHE4BmPV9CzVEtNRoJyEUaQs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441127AbfIXNQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 09:16:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:49142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2441050AbfIXNQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 09:16:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D38BAD79;
        Tue, 24 Sep 2019 13:16:52 +0000 (UTC)
Date:   Tue, 24 Sep 2019 15:16:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] memcg: Only record foreign writebacks with dirty
 pages when memcg is not disabled
Message-ID: <20190924131651.GR23050@dhcp22.suse.cz>
References: <20190923083030.6442-1-bhe@redhat.com>
 <20190924111138.GA31919@MiWiFi-R3L-srv>
 <20190924122747.GQ23050@dhcp22.suse.cz>
 <20190924130458.GB31919@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924130458.GB31919@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 21:04:58, Baoquan He wrote:
> On 09/24/19 at 02:27pm, Michal Hocko wrote:
> > On Tue 24-09-19 19:11:51, Baoquan He wrote:
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index f3c15bb07cce..84e3fdb1ccb4 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -4317,6 +4317,9 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
> > >  
> > >  	trace_track_foreign_dirty(page, wb);
> > >  
> > > +	if (mem_cgroup_disabled())
> > > +		return;
> > > +
> > 
> > This doesn't seem correct. We shouldn't even enter the slowpath with
> > memcg disabled AFAIC. The check should be done at mem_cgroup_track_foreign_dirty
> > level.
> 
> You mean the way in v1 patch, right? It's also fine to me.
> 
> I am worried about the case that memcg is enabled, the checking by
> calling mem_cgroup_disabled() will lower efficiency.

This is hidden by a static branch so I wouldn't really be worried about
the overhead.

> And it entering
> into mem_cgroup_track_foreign_dirty_slowpath() should be a rare event.

But &page->mem_cgroup->css != wb->memcg_css doesn't make any sense when
memcg is disabled, right?
-- 
Michal Hocko
SUSE Labs

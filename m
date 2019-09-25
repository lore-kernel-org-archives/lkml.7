Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDF4C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9CE217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569394374;
	bh=vem+Ya5hTrdZxovEGCRBzOmw2a7tVEJFMEobzQZHFcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IHJT91LsSlV0JegRJnVKb16CA3ArlndktGci/3qMvppV4RyLY05yK5mKNk2j6WsM1
	 PEvnrEI0NDeIz+O9n5TEiC/OwkyXpbXbAWaS5YzSBMPlHFS4En1PMjb4z+mCmzpHtp
	 3xnwbrNn/abazuFFuTvEhxl1M7p3bF4fUcR3C6Hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442376AbfIYGwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:52:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:45958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436671AbfIYGww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:52:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49E1FB044;
        Wed, 25 Sep 2019 06:52:51 +0000 (UTC)
Date:   Wed, 25 Sep 2019 08:52:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] mm: memcg: add priority for soft limit reclaiming
Message-ID: <20190925065248.GF23050@dhcp22.suse.cz>
References: <20190924073642.3224-1-hdanton@sina.com>
 <20190924133016.GT23050@dhcp22.suse.cz>
 <20190925023530.6364-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925023530.6364-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-09-19 10:35:30, Hillf Danton wrote:
> 
> On Tue, 24 Sep 2019 17:23:35 +0000 from Roman Gushchin
> > 
> > On Tue, Sep 24, 2019 at 03:30:16PM +0200, Michal Hocko wrote:
> > >
> > > But really, make sure you look into the existing feature set that memcg
> > > v2 provides already and come back if you find it unsuitable and we can
> > > move from there. Soft limit reclaim is dead and we should let it RIP.
> > 
> > Can't agree more here.
> > 
> > Cgroup v2 memory protection mechanisms (memory.low/min) should perfectly
> > solve the described problem. If not, let's fix them rather than extend soft
> > reclaim which is already dead.
> > 
> Hehe, IIUC memory.low/min is essentially drawing a line that reclaimers
> would try their best not to cross. Page preemption OTOH is near ten miles
> away from that line though it is now on the shoulder of soft reclaiming.

Dynamic low limit tuning would achieve exactly what you are after - aka
prioritizing some memory consumers over others.
-- 
Michal Hocko
SUSE Labs

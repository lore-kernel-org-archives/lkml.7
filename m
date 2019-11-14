Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AD3C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F1E206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573760024;
	bh=+eititFgmWWKqMRh4n9iOgsONeXdzB6YZwq7YTacQxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yoCCwE4ljOxvAxQ7Gv4lwSKs3uYOpQ38aI4OG/U9UbpuH4VEQ2ygMBljAJnwLbbZu
	 oMI7qGt4ohhYedLRygXSdTFIUc76Cc+Z3PWZSvOsbAe9D6Ain8LexFs8MJ1eWXBjI4
	 NyfceZzyvFpaHtZ25hXBXrkDQ1m7xZG3lhPiPQsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfKNTdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:33:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:55164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbfKNTdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:33:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2A13B2AD;
        Thu, 14 Nov 2019 19:33:41 +0000 (UTC)
Date:   Thu, 14 Nov 2019 20:33:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: memcg: switch to css_tryget() in
 get_mem_cgroup_from_mm()
Message-ID: <20191114193340.GA24848@dhcp22.suse.cz>
References: <20191106225131.3543616-1-guro@fb.com>
 <20191113162934.GF19372@blackbody.suse.cz>
 <20191113170823.GA12464@castle.DHCP.thefacebook.com>
 <20191114191657.GN20866@dhcp22.suse.cz>
 <20191114192018.GJ4163745@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114192018.GJ4163745@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-11-19 11:20:18, Tejun Heo wrote:
> Hello,
> 
> On Thu, Nov 14, 2019 at 08:16:57PM +0100, Michal Hocko wrote:
> > Then what is the point of this function and what about all other users?
> 
> It is useful for controlling admissions of new userspace visible uses
> - e.g. a tracepoint shouldn't be allowed to be attached to a cgroup
> which has already been deleted.

I am not sure I understand. Roman says that the cgroup can get offline
right after the function returns. How is "already deleted" different
from "just deleted"? I thought that the state is preserved at least
while the rcu lock is held but my memory is dim here.

> We're just using it too liberally.

Can we get a doc update to be explicit about sensible usecases so that
others can be dropped accordingly? 
-- 
Michal Hocko
SUSE Labs

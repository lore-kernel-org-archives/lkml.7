Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB0C33C9A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AA02071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573759023;
	bh=eYXZWTUV/Zc8LTjU3n+JdsJKBj77YycMDHOgSOfgGrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UlyZLsl0He5auPR6s4x0IGTzL5sL7KOIQZSUeiYKNVO0+hNDfx93yi5wEnMf8MJoK
	 /5u1nDsXOUhh7hNGUjiU5occ+pSgnQ6mvac79ikW99umoWMAG8LsAiWzdF49dvS4NL
	 6djOCaSZp+/R7ncf97JnE7dOJjLpVF94v4DRG9ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKNTRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:17:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:46214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbfKNTRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:17:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C28CFB1F0;
        Thu, 14 Nov 2019 19:16:59 +0000 (UTC)
Date:   Thu, 14 Nov 2019 20:16:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] mm: memcg: switch to css_tryget() in
 get_mem_cgroup_from_mm()
Message-ID: <20191114191657.GN20866@dhcp22.suse.cz>
References: <20191106225131.3543616-1-guro@fb.com>
 <20191113162934.GF19372@blackbody.suse.cz>
 <20191113170823.GA12464@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191113170823.GA12464@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-11-19 17:08:29, Roman Gushchin wrote:
> On Wed, Nov 13, 2019 at 05:29:34PM +0100, Michal Koutný wrote:
> > Hi.
> > 
> > On Wed, Nov 06, 2019 at 02:51:30PM -0800, Roman Gushchin <guro@fb.com> wrote:
> > > Let's fix it by switching from css_tryget_online() to css_tryget().
> > Is this a safe thing to do? The stack captures a kmem charge path, with
> > css_tryget() it may happen it gets an offlined memcg and carry out
> > charge into it. What happens when e.g. memcg_deactivate_kmem_caches is
> > skipped as a consequence?
> 
> The thing here is that css_tryget_online() cannot pin the online state,
> so even if returned true, the cgroup can be offline at the return from
> the function. So if we rely somewhere on it, it's already broken.

Then what is the point of this function and what about all other users?

> Generally speaking, it's better to reduce it's usage to the bare minimum.

If it doesn't have any sensible semantic then I would argue it should go
altogether otherwise we are going to chase new users again and aagain?
 
> > > The problem is caused by an exiting task which is associated with
> > > an offline memcg. We're iterating over and over in the
> > > do {} while (!css_tryget_online()) loop, but obviously the memcg won't
> > > become online and the exiting task won't be migrated to a live memcg.
> > As discussed in other replies, the task is not yet exiting. However, the
> > access to memcg isn't through `current` but `mm->owner`, i.e. another
> > task of a threadgroup may have got stuck in an offlined memcg (I don't
> > have a good explanation for that though).

The trace however points to current->mm or current->active_memcg. Is it
possible that we have a stale active_memcg?
-- 
Michal Hocko
SUSE Labs

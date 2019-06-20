Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6190C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906D22083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561044921;
	bh=RzqcfmIOU09qV/zj5/we/P4b1oQKWWZQlrj7DOQbg7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P/s4Y2X+KtmE25X12UQRE1Cmv5ysdoIAiuJ/6psYNSCaspgOgLreSgQUofdc40ru7
	 petpIf1elUKgV4oJ8frG8pRGgBZGbsly27Wffe3ecfEE3d1JwMIShcN7DjTw7EjXop
	 7PhdqTVQ44JO9DBE1gdCfej9v+akUSa0a0hp/Gxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfFTPfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:35:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:41364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726757AbfFTPfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:35:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1977EAE46;
        Thu, 20 Jun 2019 15:35:18 +0000 (UTC)
Date:   Thu, 20 Jun 2019 17:35:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] slub: Don't panic for memcg kmem cache creation failure
Message-ID: <20190620153516.GG12083@dhcp22.suse.cz>
References: <20190619232514.58994-1-shakeelb@google.com>
 <20190620055028.GA12083@dhcp22.suse.cz>
 <CALvZod4Fd5X91CzDLaVAvspQL-zoD7+9OGTiOro-hiMda=DqBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4Fd5X91CzDLaVAvspQL-zoD7+9OGTiOro-hiMda=DqBA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-06-19 07:44:27, Shakeel Butt wrote:
> On Wed, Jun 19, 2019 at 10:50 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 19-06-19 16:25:14, Shakeel Butt wrote:
> > > Currently for CONFIG_SLUB, if a memcg kmem cache creation is failed and
> > > the corresponding root kmem cache has SLAB_PANIC flag, the kernel will
> > > be crashed. This is unnecessary as the kernel can handle the creation
> > > failures of memcg kmem caches.
> >
> > AFAICS it will handle those by simply not accounting those objects
> > right?
> >
> 
> The memcg kmem cache creation is async. The allocation has already
> been decided not to be accounted on creation trigger. If memcg kmem
> cache creation is failed, it will fail silently and the next
> allocation will trigger the creation process again.

Ohh, right I forgot that it will get retried. This would be useful to
mention in the changelog as it is not straightforward from reading just
the particular function.

> > > Additionally CONFIG_SLAB does not
> > > implement this behavior. So, to keep the behavior consistent between
> > > SLAB and SLUB, removing the panic for memcg kmem cache creation
> > > failures. The root kmem cache creation failure for SLAB_PANIC correctly
> > > panics for both SLAB and SLUB.
> >
> > I do agree that panicing is really dubious especially because it opens
> > doors to shut the system down from a restricted environment. So the
> > patch makes sesne to me.
> >
> > I am wondering whether SLAB_PANIC makes sense in general though. Why is
> > it any different from any other essential early allocations? We tend to
> > not care about allocation failures for those on bases that the system
> > must be in a broken state to fail that early already. Do you think it is
> > time to remove SLAB_PANIC altogether?
> >
> 
> That would need some investigation into the history of SLAB_PANIC. I
> will look into it.

Well, I strongly suspect this is a relict from the past. I have hard
time to believe that the system would get to a usable state if many of
those caches would fail to allocate. And as Dave said in his reply it is
quite silly to give this weapon to a random driver hands. Everybody just
thinks his toy is the most important one...

-- 
Michal Hocko
SUSE Labs

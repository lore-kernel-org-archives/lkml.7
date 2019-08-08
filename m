Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7765C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD8321883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565281953;
	bh=DPRrfHkMKoXC4AALhxw0NnF3blz40Gf+GGIQLiCnFFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KSMqczmJJC6ME0lCqNAtt9CXEpOxmJ2hi2OAd336VHKx8gnl74Xx2bOcX2xmD5P7s
	 KfSEwWoo0+QFN68SxX+udputk5/KUHd+ZccQCBcMIzGUPFjioRi7HRNQJhchSLHxJP
	 ojwuGBIM3F2CFlaYLye2mg9tfhJ+qAm1/nuf/tkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbfHHQcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:32:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:44080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfHHQcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:32:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEBE0AE7F;
        Thu,  8 Aug 2019 16:32:29 +0000 (UTC)
Date:   Thu, 8 Aug 2019 18:32:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     ndrw.xf@redhazel.co.uk
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190808163228.GE18351@dhcp22.suse.cz>
References: <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com>
 <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz>
 <20190806142728.GA12107@cmpxchg.org>
 <20190806143608.GE11812@dhcp22.suse.cz>
 <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com>
 <20190806220150.GA22516@cmpxchg.org>
 <20190807075927.GO11812@dhcp22.suse.cz>
 <20190807205138.GA24222@cmpxchg.org>
 <20190808114826.GC18351@dhcp22.suse.cz>
 <806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-08-19 16:10:07, ndrw.xf@redhazel.co.uk wrote:
> 
> 
> On 8 August 2019 12:48:26 BST, Michal Hocko <mhocko@kernel.org> wrote:
> >> 
> >> Per default, the OOM killer will engage after 15 seconds of at least
> >> 80% memory pressure. These values are tunable via sysctls
> >> vm.thrashing_oom_period and vm.thrashing_oom_level.
> >
> >As I've said earlier I would be somehow more comfortable with a kernel
> >command line/module parameter based tuning because it is less of a
> >stable API and potential future stall detector might be completely
> >independent on PSI and the current metric exported. But I can live with
> >that because a period and level sounds quite generic.
> 
> Would it be possible to reserve a fixed (configurable) amount of RAM for caches,

I am afraid there is nothing like that available and I would even argue
it doesn't make much sense either. What would you consider to be a
cache? A kernel/userspace reclaimable memory? What about any other in
kernel memory users? How would you setup such a limit and make it
reasonably maintainable over different kernel releases when the memory
footprint changes over time?

Besides that how does that differ from the existing reclaim mechanism?
Once your cache hits the limit, there would have to be some sort of the
reclaim to happen and then we are back to square one when the reclaim is
making progress but you are effectively treshing over the hot working
set (e.g. code pages)

> and trigger OOM killer earlier, before most UI code is evicted from memory?

How does the kernel knows that important memory is evicted? E.g. say
that your graphic stack is under pressure and it has to drop internal
caches. No outstanding processes will be swapped out yet your UI will be
completely frozen like.

> In my use case, I am happy sacrificing e.g. 0.5GB and kill runaway
> tasks _before_ the system freezes. Potentially OOM killer would also
> work better in such conditions. I almost never work at close to full
> memory capacity, it's always a single task that goes wrong and brings
> the system down.

If you know which task is that then you can put it into a memory cgroup
with a stricter memory limit and have it killed before the overal system
starts suffering.

> The problem with PSI sensing is that it works after the fact (after
> the freeze has already occurred). It is not very different from
> issuing SysRq-f manually on a frozen system, although it would still
> be a handy feature for batched tasks and remote access.

Not really. PSI is giving you a matric that tells you how much time you
spend on the memory reclaim. So you can start watching the system from
lower utilization already.
-- 
Michal Hocko
SUSE Labs

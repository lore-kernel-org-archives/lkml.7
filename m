Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761DDC06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DE821721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfGBHsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:48:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:60946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfGBHsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:48:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63296AFFB;
        Tue,  2 Jul 2019 07:48:21 +0000 (UTC)
Date:   Tue, 2 Jul 2019 09:48:18 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Rashmica Gupta <rashmica.g@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@soleen.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Allocate memmap from hotadded memory
Message-ID: <20190702074806.GA26836@linux>
References: <20190625075227.15193-1-osalvador@suse.de>
 <2ebfbd36-11bd-9576-e373-2964c458185b@redhat.com>
 <20190626080249.GA30863@linux>
 <2750c11a-524d-b248-060c-49e6b3eb8975@redhat.com>
 <20190626081516.GC30863@linux>
 <887b902e-063d-a857-d472-f6f69d954378@redhat.com>
 <9143f64391d11aa0f1988e78be9de7ff56e4b30b.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9143f64391d11aa0f1988e78be9de7ff56e4b30b.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 04:42:34PM +1000, Rashmica Gupta wrote:
> Hi David,
> 
> Sorry for the late reply.
> 
> On Wed, 2019-06-26 at 10:28 +0200, David Hildenbrand wrote:
> > On 26.06.19 10:15, Oscar Salvador wrote:
> > > On Wed, Jun 26, 2019 at 10:11:06AM +0200, David Hildenbrand wrote:
> > > > Back then, I already mentioned that we might have some users that
> > > > remove_memory() they never added in a granularity it wasn't
> > > > added. My
> > > > concerns back then were never fully sorted out.
> > > > 
> > > > arch/powerpc/platforms/powernv/memtrace.c
> > > > 
> > > > - Will remove memory in memory block size chunks it never added
> > > > - What if that memory resides on a DIMM added via
> > > > MHP_MEMMAP_DEVICE?
> > > > 
> > > > Will it at least bail out? Or simply break?
> > > > 
> > > > IOW: I am not yet 100% convinced that MHP_MEMMAP_DEVICE is save
> > > > to be
> > > > introduced.
> > > 
> > > Uhm, I will take a closer look and see if I can clear your
> > > concerns.
> > > TBH, I did not try to use arch/powerpc/platforms/powernv/memtrace.c
> > > yet.
> > > 
> > > I will get back to you once I tried it out.
> > > 
> > 
> > BTW, I consider the code in arch/powerpc/platforms/powernv/memtrace.c
> > very ugly and dangerous.
> 
> Yes it would be nice to clean this up.
> 
> > We should never allow to manually
> > offline/online pages / hack into memory block states.
> > 
> > What I would want to see here is rather:
> > 
> > 1. User space offlines the blocks to be used
> > 2. memtrace installs a hotplug notifier and hinders the blocks it
> > wants
> > to use from getting onlined.
> > 3. memory is not added/removed/onlined/offlined in memtrace code.
> >
> 
> I remember looking into doing it a similar way. I can't recall the
> details but my issue was probably 'how does userspace indicate to
> the kernel that this memory being offlined should be removed'?
> 
> I don't know the mm code nor how the notifiers work very well so I
> can't quite see how the above would work. I'm assuming memtrace would
> register a hotplug notifier and when memory is offlined from userspace,
> the callback func in memtrace would be called if the priority was high
> enough? But how do we know that the memory being offlined is intended
> for usto touch? Is there a way to offline memory from userspace not
> using sysfs or have I missed something in the sysfs interface?
> 
> On a second read, perhaps you are assuming that memtrace is used after
> adding new memory at runtime? If so, that is not the case. If not, then
> would you be able to clarify what I'm not seeing?

Hi Rashmica,

let us go the easy way here.
Could you please explain:

1) How memtrace works
2) Why it was designed, what is the goal of the interface?
3) When it is supposed to be used?

I have seen a couple of reports in the past from people running memtrace
and failing to do so sometimes, and back then I could not grasp why people
was using it, or under which circumstances was nice to have.
So it would be nice to have a detailed explanation from the person who wrote
it.

Thanks

-- 
Oscar Salvador
SUSE L3

Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4891C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED29205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbfHORMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:12:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20203 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730474AbfHORMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:12:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 732FD30832E1;
        Thu, 15 Aug 2019 17:12:00 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9562687A9;
        Thu, 15 Aug 2019 17:11:58 +0000 (UTC)
Date:   Thu, 15 Aug 2019 13:11:56 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190815171156.GB30916@redhat.com>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-3-daniel.vetter@ffwll.ch>
 <20190814235805.GB11200@ziepe.ca>
 <20190815065829.GA7444@phenom.ffwll.local>
 <20190815122344.GA21596@ziepe.ca>
 <20190815132127.GI9477@dhcp22.suse.cz>
 <20190815141219.GF21596@ziepe.ca>
 <20190815155950.GN9477@dhcp22.suse.cz>
 <20190815165631.GK21596@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190815165631.GK21596@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 15 Aug 2019 17:12:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 01:56:31PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2019 at 06:00:41PM +0200, Michal Hocko wrote:
> 
> > > AFAIK 'GFP_NOWAIT' is characterized by the lack of __GFP_FS and
> > > __GFP_DIRECT_RECLAIM..
> > >
> > > This matches the existing test in __need_fs_reclaim() - so if you are
> > > OK with GFP_NOFS, aka __GFP_IO which triggers try_to_compact_pages(),
> > > allocations during OOM, then I think fs_reclaim already matches what
> > > you described?
> > 
> > No GFP_NOFS is equally bad. Please read my other email explaining what
> > the oom_reaper actually requires. In short no blocking on direct or
> > indirect dependecy on memory allocation that might sleep.
> 
> It is much easier to follow with some hints on code, so the true
> requirement is that the OOM repear not block on GFP_FS and GFP_IO
> allocations, great, that constraint is now clear.
> 
> > If you can express that in the existing lockdep machinery. All
> > fine. But then consider deployments where lockdep is no-no because
> > of the overhead.
> 
> This is all for driver debugging. The point of lockdep is to find all
> these paths without have to hit them as actual races, using debug
> kernels.
> 
> I don't think we need this kind of debugging on production kernels?
> 
> > > The best we got was drivers tested the VA range and returned success
> > > if they had no interest. Which is a big win to be sure, but it looks
> > > like getting any more is not really posssible.
> > 
> > And that is already a great win! Because many notifiers only do care
> > about particular mappings. Please note that backing off unconditioanlly
> > will simply cause that the oom reaper will have to back off not doing
> > any tear down anything.
> 
> Well, I'm working to propose that we do the VA range test under core
> mmu notifier code that cannot block and then we simply remove the idea
> of blockable from drivers using this new 'range notifier'. 
> 
> I think this pretty much solves the concern?

I am not sure i follow what you propose here ? Like i pointed out in
another email for GPU we do need to be able to sleep (we might get
lucky and not need too but this is runtime thing) within notifier
range_start callback. This has been something allow by notifier since
it has been introduced in the kernel.

Cheers,
Jérôme

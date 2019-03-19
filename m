Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DD8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDC02082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCSUZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:25:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48633 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfCSUZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:25:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0578881F18;
        Tue, 19 Mar 2019 20:25:32 +0000 (UTC)
Received: from redhat.com (ovpn-120-246.rdu2.redhat.com [10.10.120.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B87F19C59;
        Tue, 19 Mar 2019 20:25:30 +0000 (UTC)
Date:   Tue, 19 Mar 2019 16:25:28 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
Message-ID: <20190319202527.GA3096@redhat.com>
References: <20190319094007.a47ce9222b5faacec3e96da4@linux-foundation.org>
 <20190319165802.GA3656@redhat.com>
 <20190319101249.d2076f4bacbef948055ae758@linux-foundation.org>
 <20190319171847.GC3656@redhat.com>
 <CAPcyv4iesGET_PV-QcdBbxJGgmJ_HhoGczyvb=0+SnLkFDhRuQ@mail.gmail.com>
 <20190319174552.GA3769@redhat.com>
 <CAPcyv4hFPOO0-=v3ZCNFA=LgE_QCvyFXGqF24Crveoj_NTbq0Q@mail.gmail.com>
 <20190319190528.GA4012@redhat.com>
 <CAPcyv4hg5Y_NC1iu56zcznYkCRnwg+_7bGFr==7=AC6ii=O=Ng@mail.gmail.com>
 <20190319191849.GA4310@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319191849.GA4310@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Mar 2019 20:25:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:18:49PM -0400, Jerome Glisse wrote:
> On Tue, Mar 19, 2019 at 12:13:40PM -0700, Dan Williams wrote:
> > On Tue, Mar 19, 2019 at 12:05 PM Jerome Glisse <jglisse@redhat.com> wrote:
> > >
> > > On Tue, Mar 19, 2019 at 11:42:00AM -0700, Dan Williams wrote:
> > > > On Tue, Mar 19, 2019 at 10:45 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > > > >
> > > > > On Tue, Mar 19, 2019 at 10:33:57AM -0700, Dan Williams wrote:
> > > > > > On Tue, Mar 19, 2019 at 10:19 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Mar 19, 2019 at 10:12:49AM -0700, Andrew Morton wrote:
> > > > > > > > On Tue, 19 Mar 2019 12:58:02 -0400 Jerome Glisse <jglisse@redhat.com> wrote:
> > > > > > [..]
> > > > > > > > Also, the discussion regarding [07/10] is substantial and is ongoing so
> > > > > > > > please let's push along wth that.
> > > > > > >
> > > > > > > I can move it as last patch in the serie but it is needed for ODP RDMA
> > > > > > > convertion too. Otherwise i will just move that code into the ODP RDMA
> > > > > > > code and will have to move it again into HMM code once i am done with
> > > > > > > the nouveau changes and in the meantime i expect other driver will want
> > > > > > > to use this 2 helpers too.
> > > > > >
> > > > > > I still hold out hope that we can find a way to have productive
> > > > > > discussions about the implementation of this infrastructure.
> > > > > > Threatening to move the code elsewhere to bypass the feedback is not
> > > > > > productive.
> > > > >
> > > > > I am not threatening anything that code is in ODP _today_ with that
> > > > > patchset i was factering it out so that i could also use it in nouveau.
> > > > > nouveau is built in such way that right now i can not use it directly.
> > > > > But i wanted to factor out now in hope that i can get the nouveau
> > > > > changes in 5.2 and then convert nouveau in 5.3.
> > > > >
> > > > > So when i said that code will be in ODP it just means that instead of
> > > > > removing it from ODP i will keep it there and it will just delay more
> > > > > code sharing for everyone.
> > > >
> > > > The point I'm trying to make is that the code sharing for everyone is
> > > > moving the implementation closer to canonical kernel code and use
> > > > existing infrastructure. For example, I look at 'struct hmm_range' and
> > > > see nothing hmm specific in it. I think we can make that generic and
> > > > not build up more apis and data structures in the "hmm" namespace.
> > >
> > > Right now i am trying to unify driver for device that have can support
> > > the mmu notifier approach through HMM. Unify to a superset of driver
> > > that can not abide by mmu notifier is on my todo list like i said but
> > > it comes after. I do not want to make the big jump in just one go. So
> > > i doing thing under HMM and thus in HMM namespace, but once i tackle
> > > the larger set i will move to generic namespace what make sense.
> > >
> > > This exact approach did happen several time already in the kernel. In
> > > the GPU sub-system we did it several time. First do something for couple
> > > devices that are very similar then grow to a bigger set of devices and
> > > generalise along the way.
> > >
> > > So i do not see what is the problem of me repeating that same pattern
> > > here again. Do something for a smaller set before tackling it on for
> > > a bigger set.
> > 
> > All of that is fine, but when I asked about the ultimate trajectory
> > that replaces hmm_range_dma_map() with an updated / HMM-aware GUP
> > implementation, the response was that hmm_range_dma_map() is here to
> > stay. The issue is not with forking off a small side effort, it's the
> > plan to absorb that capability into a common implementation across
> > non-HMM drivers where possible.
> 
> hmm_range_dma_map() is a superset of gup_range_dma_map() because on
> top of gup_range_dma_map() the hmm version deals with mmu notifier.
> 
> But everything that is not mmu notifier related can be share through
> gup_range_dma_map() so plan is to end up with:
>     hmm_range_dma_map(hmm_struct) {
>         hmm_mmu_notifier_specific_prep_step();
>         gup_range_dma_map(hmm_struct->common_base_struct);
>         hmm_mmu_notifier_specific_post_step();
>     }
> 
> ie share as much as possible. Does that not make sense ? To get
> there i will need to do non trivial addition to GUP and so i went
> first to get HMM bits working and then work on common gup API.
> 

And more to the hmm_range struct:

struct hmm_range {
    struct vm_area_struct *vma;       // Common
    struct list_head      list;       // HMM specific this is only useful
                                      // to track valid range if a mmu
                                      // notifier happens while we do
                                      // lookup the CPU page table
    unsigned long         start;      // Common
    unsigned long         end;        // Common
    uint64_t              *pfns;      // Common
    const uint64_t        *flags;     // Some flags would be HMM specific
    const uint64_t        *values;    // HMM specific
    uint8_t               pfn_shift;  // Common
    bool                  valid;      // HMM specific
};

So it is not all common they are thing that just do not make sense out
side a HMM capable driver.

Cheers,
Jérôme

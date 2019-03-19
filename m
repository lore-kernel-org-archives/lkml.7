Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21487C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E642C2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfCSWTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:19:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:58372 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfCSWTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:19:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 15:19:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,246,1549958400"; 
   d="scan'208";a="308616822"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2019 15:19:46 -0700
Date:   Tue, 19 Mar 2019 07:18:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
Message-ID: <20190319141826.GJ7485@iweiny-DESK2.sc.intel.com>
References: <20190318170404.GA6786@redhat.com>
 <20190319094007.a47ce9222b5faacec3e96da4@linux-foundation.org>
 <20190319165802.GA3656@redhat.com>
 <20190319101249.d2076f4bacbef948055ae758@linux-foundation.org>
 <20190319171847.GC3656@redhat.com>
 <CAPcyv4iesGET_PV-QcdBbxJGgmJ_HhoGczyvb=0+SnLkFDhRuQ@mail.gmail.com>
 <20190319174552.GA3769@redhat.com>
 <CAPcyv4hFPOO0-=v3ZCNFA=LgE_QCvyFXGqF24Crveoj_NTbq0Q@mail.gmail.com>
 <20190319190528.GA4012@redhat.com>
 <CAPcyv4hg5Y_NC1iu56zcznYkCRnwg+_7bGFr==7=AC6ii=O=Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hg5Y_NC1iu56zcznYkCRnwg+_7bGFr==7=AC6ii=O=Ng@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:13:40PM -0700, Dan Williams wrote:
> On Tue, Mar 19, 2019 at 12:05 PM Jerome Glisse <jglisse@redhat.com> wrote:
> >
> > On Tue, Mar 19, 2019 at 11:42:00AM -0700, Dan Williams wrote:
> > > On Tue, Mar 19, 2019 at 10:45 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > > >
> > > > On Tue, Mar 19, 2019 at 10:33:57AM -0700, Dan Williams wrote:
> > > > > On Tue, Mar 19, 2019 at 10:19 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Mar 19, 2019 at 10:12:49AM -0700, Andrew Morton wrote:
> > > > > > > On Tue, 19 Mar 2019 12:58:02 -0400 Jerome Glisse <jglisse@redhat.com> wrote:

[snip]

> >
> > Right now i am trying to unify driver for device that have can support
> > the mmu notifier approach through HMM. Unify to a superset of driver
> > that can not abide by mmu notifier is on my todo list like i said but
> > it comes after. I do not want to make the big jump in just one go. So
> > i doing thing under HMM and thus in HMM namespace, but once i tackle
> > the larger set i will move to generic namespace what make sense.
> >
> > This exact approach did happen several time already in the kernel. In
> > the GPU sub-system we did it several time. First do something for couple
> > devices that are very similar then grow to a bigger set of devices and
> > generalise along the way.
> >
> > So i do not see what is the problem of me repeating that same pattern
> > here again. Do something for a smaller set before tackling it on for
> > a bigger set.
> 
> All of that is fine, but when I asked about the ultimate trajectory
> that replaces hmm_range_dma_map() with an updated / HMM-aware GUP
> implementation, the response was that hmm_range_dma_map() is here to
> stay. The issue is not with forking off a small side effort, it's the
> plan to absorb that capability into a common implementation across
> non-HMM drivers where possible.

Just to get on the record in this thread.

+1

I think having an interface which handles the MMU notifier stuff for drivers is
awesome but we need to agree that the trajectory is to help more drivers if
possible.

Ira


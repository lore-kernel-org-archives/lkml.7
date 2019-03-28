Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9A6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EB02183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfC2CpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:45:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:1928 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfC2CpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:45:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 19:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,282,1549958400"; 
   d="scan'208";a="156817100"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga004.fm.intel.com with ESMTP; 28 Mar 2019 19:45:15 -0700
Date:   Thu, 28 Mar 2019 11:44:08 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 10/11] mm/hmm: add helpers for driver to safely take
 the mmap_sem v2
Message-ID: <20190328184408.GK31324@iweiny-DESK2.sc.intel.com>
References: <20190328213047.GB13560@redhat.com>
 <a16efd42-3e2b-1b72-c205-0c2659de2750@nvidia.com>
 <20190328220824.GE13560@redhat.com>
 <068db0a8-fade-8ed1-3b9d-c29c27797301@nvidia.com>
 <20190328224032.GH13560@redhat.com>
 <0b698b36-da17-434b-b8e7-4a91ac6c9d82@nvidia.com>
 <20190328230543.GI13560@redhat.com>
 <9e414b8c-0f98-a2f7-4f46-d335c015fc1b@nvidia.com>
 <20190328232404.GK13560@redhat.com>
 <c02bcb34-bb3c-c3c9-f070-050006390776@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c02bcb34-bb3c-c3c9-f070-050006390776@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 04:34:04PM -0700, John Hubbard wrote:
> On 3/28/19 4:24 PM, Jerome Glisse wrote:
> > On Thu, Mar 28, 2019 at 04:20:37PM -0700, John Hubbard wrote:
> >> On 3/28/19 4:05 PM, Jerome Glisse wrote:
> >>> On Thu, Mar 28, 2019 at 03:43:33PM -0700, John Hubbard wrote:
> >>>> On 3/28/19 3:40 PM, Jerome Glisse wrote:
> >>>>> On Thu, Mar 28, 2019 at 03:25:39PM -0700, John Hubbard wrote:
> >>>>>> On 3/28/19 3:08 PM, Jerome Glisse wrote:
> >>>>>>> On Thu, Mar 28, 2019 at 02:41:02PM -0700, John Hubbard wrote:
> >>>>>>>> On 3/28/19 2:30 PM, Jerome Glisse wrote:
> >>>>>>>>> On Thu, Mar 28, 2019 at 01:54:01PM -0700, John Hubbard wrote:
> >>>>>>>>>> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
> >>>>>>>>>>> From: Jérôme Glisse <jglisse@redhat.com>
> >>>>>> [...]
> >>>>>> OK, so let's either drop this patch, or if merge windows won't allow that,
> >>>>>> then *eventually* drop this patch. And instead, put in a hmm_sanity_check()
> >>>>>> that does the same checks.
> >>>>>
> >>>>> RDMA depends on this, so does the nouveau patchset that convert to new API.
> >>>>> So i do not see reason to drop this. They are user for this they are posted
> >>>>> and i hope i explained properly the benefit.
> >>>>>
> >>>>> It is a common pattern. Yes it only save couple lines of code but down the
> >>>>> road i will also help for people working on the mmap_sem patchset.
> >>>>>
> >>>>
> >>>> It *adds* a couple of lines that are misleading, because they look like they
> >>>> make things safer, but they don't actually do so.
> >>>
> >>> It is not about safety, sorry if it confused you but there is nothing about
> >>> safety here, i can add a big fat comment that explains that there is no safety
> >>> here. The intention is to allow the page fault handler that potential have
> >>> hundred of page fault queue up to abort as soon as it sees that it is pointless
> >>> to keep faulting on a dying process.
> >>>
> >>> Again if we race it is _fine_ nothing bad will happen, we are just doing use-
> >>> less work that gonna be thrown on the floor and we are just slowing down the
> >>> process tear down.
> >>>
> >>
> >> In addition to a comment, how about naming this thing to indicate the above 
> >> intention?  I have a really hard time with this odd down_read() wrapper, which
> >> allows code to proceed without really getting a lock. It's just too wrong-looking.
> >> If it were instead named:
> >>
> >> 	hmm_is_exiting()
> > 
> > What about: hmm_lock_mmap_if_alive() ?
> > 
> 
> That's definitely better, but I want to vote for just doing a check, not 
> taking any locks.
> 
> I'm not super concerned about the exact name, but I really want a routine that
> just checks (and optionally asserts, via WARN or BUG), and that's *all*. Then
> drivers can scatter that around like pixie dust as they see fit. Maybe right before
> taking a lock, maybe in other places. Decoupled from locking.

I agree.  Names matter and any function which is called *_down_read and could
potentially not take the lock should be called try_*_down_read.  Furthermore
users should be checking the return values from any try_*.

It is also odd that we are calling "down/up" on something which is not a
semaphore.  So the user here needs to _know_ that they are really getting the
lock on the mm which sits behind the scenes.  What John is proposing is more
explicit when reading driver code.

Ira

> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 

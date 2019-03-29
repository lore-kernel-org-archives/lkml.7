Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F29EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 01:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE7420700
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 01:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfC2BnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 21:43:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbfC2BnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 21:43:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 735573082E1E;
        Fri, 29 Mar 2019 01:43:02 +0000 (UTC)
Received: from redhat.com (ovpn-121-118.rdu2.redhat.com [10.10.121.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 787981001E6E;
        Fri, 29 Mar 2019 01:43:01 +0000 (UTC)
Date:   Thu, 28 Mar 2019 21:42:59 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 07/11] mm/hmm: add default fault flags to avoid the
 need to pre-fill pfns arrays.
Message-ID: <20190329014259.GD16680@redhat.com>
References: <2f790427-ea87-b41e-b386-820ccdb7dd38@nvidia.com>
 <20190328221203.GF13560@redhat.com>
 <555ad864-d1f9-f513-9666-0d3d05dbb85d@nvidia.com>
 <20190328223153.GG13560@redhat.com>
 <768f56f5-8019-06df-2c5a-b4187deaac59@nvidia.com>
 <20190328232125.GJ13560@redhat.com>
 <d2008b88-962f-b7b4-8351-9e1df95ea2cc@nvidia.com>
 <20190328164231.GF31324@iweiny-DESK2.sc.intel.com>
 <20190329011727.GC16680@redhat.com>
 <f053e75e-25b5-d95a-bb3c-73411ba49e3e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f053e75e-25b5-d95a-bb3c-73411ba49e3e@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 29 Mar 2019 01:43:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 06:30:26PM -0700, John Hubbard wrote:
> On 3/28/19 6:17 PM, Jerome Glisse wrote:
> > On Thu, Mar 28, 2019 at 09:42:31AM -0700, Ira Weiny wrote:
> >> On Thu, Mar 28, 2019 at 04:28:47PM -0700, John Hubbard wrote:
> >>> On 3/28/19 4:21 PM, Jerome Glisse wrote:
> >>>> On Thu, Mar 28, 2019 at 03:40:42PM -0700, John Hubbard wrote:
> >>>>> On 3/28/19 3:31 PM, Jerome Glisse wrote:
> >>>>>> On Thu, Mar 28, 2019 at 03:19:06PM -0700, John Hubbard wrote:
> >>>>>>> On 3/28/19 3:12 PM, Jerome Glisse wrote:
> >>>>>>>> On Thu, Mar 28, 2019 at 02:59:50PM -0700, John Hubbard wrote:
> >>>>>>>>> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
> >>>>>>>>>> From: Jérôme Glisse <jglisse@redhat.com>
> >>> [...]
> >> Indeed I did not realize there is an hmm "pfn" until I saw this function:
> >>
> >> /*
> >>  * hmm_pfn_from_pfn() - create a valid HMM pfn value from pfn
> >>  * @range: range use to encode HMM pfn value
> >>  * @pfn: pfn value for which to create the HMM pfn
> >>  * Returns: valid HMM pfn for the pfn
> >>  */
> >> static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
> >>                                         unsigned long pfn)
> >>
> >> So should this patch contain some sort of helper like this... maybe?
> >>
> >> I'm assuming the "hmm_pfn" being returned above is the device pfn being
> >> discussed here?
> >>
> >> I'm also thinking calling it pfn is confusing.  I'm not advocating a new type
> >> but calling the "device pfn's" "hmm_pfn" or "device_pfn" seems like it would
> >> have shortened the discussion here.
> >>
> > 
> > That helper is also use today by nouveau so changing that name is not that
> > easy it does require the multi-release dance. So i am not sure how much
> > value there is in a name change.
> > 
> 
> Once the dust settles, I would expect that a name change for this could go
> via Andrew's tree, right? It seems incredible to claim that we've built something
> that effectively does not allow any minor changes!
> 
> I do think it's worth some *minor* trouble to improve the name, assuming that we
> can do it in a simple patch, rather than some huge maintainer-level effort.

Change to nouveau have to go through nouveau tree so changing name means:
 -  release N add function with new name, maybe make the old function just
    a wrapper to the new function
 -  release N+1 update user to use the new name
 -  release N+2 remove the old name

So it is do-able but it is painful so i rather do that one latter that now
as i am sure people will then complain again about some little thing and it
will post pone this whole patchset on that new bit. To avoid post-poning
RDMA and bunch of other patchset that build on top of that i rather get
this patchset in and then do more changes in the next cycle.

This is just a capacity thing.

Cheers,
Jérôme

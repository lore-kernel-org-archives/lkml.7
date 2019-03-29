Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6922173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfC2CM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:12:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbfC2CM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:12:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A6963082B67;
        Fri, 29 Mar 2019 02:12:29 +0000 (UTC)
Received: from redhat.com (ovpn-121-118.rdu2.redhat.com [10.10.121.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBE835D71A;
        Fri, 29 Mar 2019 02:12:27 +0000 (UTC)
Date:   Thu, 28 Mar 2019 22:12:25 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 07/11] mm/hmm: add default fault flags to avoid the
 need to pre-fill pfns arrays.
Message-ID: <20190329021225.GG16680@redhat.com>
References: <20190328223153.GG13560@redhat.com>
 <768f56f5-8019-06df-2c5a-b4187deaac59@nvidia.com>
 <20190328232125.GJ13560@redhat.com>
 <d2008b88-962f-b7b4-8351-9e1df95ea2cc@nvidia.com>
 <20190328164231.GF31324@iweiny-DESK2.sc.intel.com>
 <20190329011727.GC16680@redhat.com>
 <f053e75e-25b5-d95a-bb3c-73411ba49e3e@nvidia.com>
 <20190329014259.GD16680@redhat.com>
 <20190329015919.GF16680@redhat.com>
 <f7710f64-c17e-feef-f453-e01340461e7e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7710f64-c17e-feef-f453-e01340461e7e@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 29 Mar 2019 02:12:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 07:05:21PM -0700, John Hubbard wrote:
> On 3/28/19 6:59 PM, Jerome Glisse wrote:
> >>>>>> [...]
> >>>>> Indeed I did not realize there is an hmm "pfn" until I saw this function:
> >>>>>
> >>>>> /*
> >>>>>  * hmm_pfn_from_pfn() - create a valid HMM pfn value from pfn
> >>>>>  * @range: range use to encode HMM pfn value
> >>>>>  * @pfn: pfn value for which to create the HMM pfn
> >>>>>  * Returns: valid HMM pfn for the pfn
> >>>>>  */
> >>>>> static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
> >>>>>                                         unsigned long pfn)
> >>>>>
> >>>>> So should this patch contain some sort of helper like this... maybe?
> >>>>>
> >>>>> I'm assuming the "hmm_pfn" being returned above is the device pfn being
> >>>>> discussed here?
> >>>>>
> >>>>> I'm also thinking calling it pfn is confusing.  I'm not advocating a new type
> >>>>> but calling the "device pfn's" "hmm_pfn" or "device_pfn" seems like it would
> >>>>> have shortened the discussion here.
> >>>>>
> >>>>
> >>>> That helper is also use today by nouveau so changing that name is not that
> >>>> easy it does require the multi-release dance. So i am not sure how much
> >>>> value there is in a name change.
> >>>>
> >>>
> >>> Once the dust settles, I would expect that a name change for this could go
> >>> via Andrew's tree, right? It seems incredible to claim that we've built something
> >>> that effectively does not allow any minor changes!
> >>>
> >>> I do think it's worth some *minor* trouble to improve the name, assuming that we
> >>> can do it in a simple patch, rather than some huge maintainer-level effort.
> >>
> >> Change to nouveau have to go through nouveau tree so changing name means:
> 
> Yes, I understand the guideline, but is that always how it must be done? Ben (+cc)?

Yes, it is not only about nouveau, it will be about every single
upstream driver using HMM. It is the easiest solution all other
solution involve coordination and/or risk of people that handle
the conflict to do something that break things.

Cheers,
Jérôme

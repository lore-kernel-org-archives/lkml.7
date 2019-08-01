Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01913C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62F4206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564644275;
	bh=gby5yw74+tstAZHxPwBTPObHytAjvu9C/rbphaQ1XbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H5p6ZYVcb2Pw5SKFSKu31hFUC4ddljknHFyHYrdk1nugDZgHOdNGVsKCK9lnRhHOJ
	 kZG9JFypRjf7mUCAxLAqtErKX8i/C0LO6rlw8FKXTNYOMWV2Nu8eiNUciC+uvlMdsf
	 j/S89JAHnKnzpP6YcvnImz6khdXhD0f50lrT8cfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfHAHYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:24:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:55588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729459AbfHAHYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:24:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8CFDB022;
        Thu,  1 Aug 2019 07:24:32 +0000 (UTC)
Date:   Thu, 1 Aug 2019 09:24:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Rashmica Gupta <rashmica.g@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        pasha.tatashin@soleen.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Allocate memmap from hotadded memory
Message-ID: <20190801072430.GF11627@dhcp22.suse.cz>
References: <2750c11a-524d-b248-060c-49e6b3eb8975@redhat.com>
 <20190626081516.GC30863@linux>
 <887b902e-063d-a857-d472-f6f69d954378@redhat.com>
 <9143f64391d11aa0f1988e78be9de7ff56e4b30b.camel@gmail.com>
 <20190702074806.GA26836@linux>
 <CAC6rBskRyh5Tj9L-6T4dTgA18H0Y8GsMdC-X5_0Jh1SVfLLYtg@mail.gmail.com>
 <20190731120859.GJ9330@dhcp22.suse.cz>
 <4ddee0dd719abd50350f997b8089fa26f6004c0c.camel@gmail.com>
 <20190801071709.GE11627@dhcp22.suse.cz>
 <9bcbd574-7e23-5cfe-f633-646a085f935a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bcbd574-7e23-5cfe-f633-646a085f935a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-08-19 09:18:47, David Hildenbrand wrote:
> On 01.08.19 09:17, Michal Hocko wrote:
> > On Thu 01-08-19 09:06:40, Rashmica Gupta wrote:
> >> On Wed, 2019-07-31 at 14:08 +0200, Michal Hocko wrote:
> >>> On Tue 02-07-19 18:52:01, Rashmica Gupta wrote:
> >>> [...]
> >>>>> 2) Why it was designed, what is the goal of the interface?
> >>>>> 3) When it is supposed to be used?
> >>>>>
> >>>>>
> >>>> There is a hardware debugging facility (htm) on some power chips.
> >>>> To use
> >>>> this you need a contiguous portion of memory for the output to be
> >>>> dumped
> >>>> to - and we obviously don't want this memory to be simultaneously
> >>>> used by
> >>>> the kernel.
> >>>
> >>> How much memory are we talking about here? Just curious.
> >>
> >> From what I've seen a couple of GB per node, so maybe 2-10GB total.
> > 
> > OK, that is really a lot to keep around unused just in case the
> > debugging is going to be used.
> > 
> > I am still not sure the current approach of (ab)using memory hotplug is
> > ideal. Sure there is some overlap but you shouldn't really need to
> > offline the required memory range at all. All you need is to isolate the
> > memory from any existing user and the page allocator. Have you checked
> > alloc_contig_range?
> > 
> 
> Rashmica mentioned somewhere in this thread that the virtual mapping
> must not be in place, otherwise the HW might prefetch some of this
> memory, leading to errors with memtrace (which checks that in HW).

Does anything prevent from unmapping the pfn range from the direct
mapping?
-- 
Michal Hocko
SUSE Labs

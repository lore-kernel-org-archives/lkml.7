Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E071CC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF147214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfJKGvv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:51:51 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:53918 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfJKGvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:51:51 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9B6pbYx017817
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 Oct 2019 15:51:37 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9B6pb4S023079;
        Fri, 11 Oct 2019 15:51:37 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9B6oWag017958;
        Fri, 11 Oct 2019 15:51:37 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-9398317; Fri, 11 Oct 2019 15:50:37 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0439.000; Fri,
 11 Oct 2019 15:50:37 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
Thread-Topic: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
Thread-Index: AQHVfq1QC/9/3IlYuEK91tWnhgAEnKdSbnGAgABy8ACAAYrDAA==
Date:   Fri, 11 Oct 2019 06:50:36 +0000
Message-ID: <20191011065036.GB30500@hori.linux.bs1.fc.nec.co.jp>
References: <20191009142435.3975-1-david@redhat.com>
 <20191009142435.3975-3-david@redhat.com>
 <20191010002619.GB3585@hori.linux.bs1.fc.nec.co.jp>
 <134d4f03-a40a-fe62-fb93-53d209a91d2e@redhat.com>
In-Reply-To: <134d4f03-a40a-fe62-fb93-53d209a91d2e@redhat.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D19DDD501EA4B140AC1A4B2E53DBD620@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 09:17:42AM +0200, David Hildenbrand wrote:
> On 10.10.19 02:26, Naoya Horiguchi wrote:
> > On Wed, Oct 09, 2019 at 04:24:35PM +0200, David Hildenbrand wrote:
> >> We should check for pfn_to_online_page() to not access uninitialized
> >> memmaps. Reshuffle the code so we don't have to duplicate the error
> >> message.
> >>
> >> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Michal Hocko <mhocko@kernel.org>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  mm/memory-failure.c | 14 ++++++++------
> >>  1 file changed, 8 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >> index 7ef849da8278..e866e6e5660b 100644
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -1253,17 +1253,19 @@ int memory_failure(unsigned long pfn, int flags)
> >>  	if (!sysctl_memory_failure_recovery)
> >>  		panic("Memory failure on page %lx", pfn);
> >>  
> >> -	if (!pfn_valid(pfn)) {
> >> +	p = pfn_to_online_page(pfn);
> >> +	if (!p) {
> >> +		if (pfn_valid(pfn)) {
> >> +			pgmap = get_dev_pagemap(pfn, NULL);
> >> +			if (pgmap)
> >> +				return memory_failure_dev_pagemap(pfn, flags,
> >> +								  pgmap);
> >> +		}
> >>  		pr_err("Memory failure: %#lx: memory outside kernel control\n",
> >>  			pfn);
> >>  		return -ENXIO;
> >>  	}
> >>  
> >> -	pgmap = get_dev_pagemap(pfn, NULL);
> >> -	if (pgmap)
> >> -		return memory_failure_dev_pagemap(pfn, flags, pgmap);
> >> -
> >> -	p = pfn_to_page(pfn);
> > 
> > This change seems to assume that memory_failure_dev_pagemap() is never
> > called for online pages. Is it an intended behavior?
> > Or the concept "online pages" is not applicable to zone device pages?
> 
> Yes, that's the real culprit. ZONE_DEVICE/devmem pages are never online
> (SECTION_IS_ONLINE). The terminology "online" only applies to pages that
> were given to the buddy. And as we support sup-section hotadd for
> devmem, we cannot easily make use of the section flag it. I already
> proposed somewhere to convert SECTION_IS_ONLINE to a subsection bitmap
> and call it something like pfn_active().
> 
> pfn_online() would then be "pfn_active() && zone != ZONE_DEVICE". And we
> could use pfn_active() everywhere to test for initialized memmaps (well,
> besides some special cases like device reserved memory that does not
> span full sub-sections). Until now, nobody volunteered and I have other
> things to do.

Thank you for explanation.  I'm not sure how hard now but we try to do this.
You fix the problem from online/offline viewpoint now, and leave remaining
part untouched. I agree with that approach, and the suggested change looks
good to me.

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

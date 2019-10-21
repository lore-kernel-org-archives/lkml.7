Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEA2CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B6120830
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfJUHD7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:03:59 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:48753 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfJUHD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:03:58 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9L73gWO001390
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Oct 2019 16:03:42 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L73gft026641;
        Mon, 21 Oct 2019 16:03:42 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L70bGw016422;
        Mon, 21 Oct 2019 16:03:42 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-78430; Mon, 21 Oct 2019 16:02:56 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0439.000; Mon,
 21 Oct 2019 16:02:56 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Oscar Salvador <osalvador@suse.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 02/16] mm,madvise: call soft_offline_page()
 without MF_COUNT_INCREASED
Thread-Topic: [RFC PATCH v2 02/16] mm,madvise: call soft_offline_page()
 without MF_COUNT_INCREASED
Thread-Index: AQHVhPYwCpqVkzSBCkuqEwpsqhWqEqdftDqAgARmGYA=
Date:   Mon, 21 Oct 2019 07:02:55 +0000
Message-ID: <20191021070254.GB8782@hori.linux.bs1.fc.nec.co.jp>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-3-osalvador@suse.de>
 <20191018115227.GL5017@dhcp22.suse.cz>
In-Reply-To: <20191018115227.GL5017@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <2AF4CB226147A84E941E07FF5A1B5470@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:52:27PM +0200, Michal Hocko wrote:
> On Thu 17-10-19 16:21:09, Oscar Salvador wrote:
> > From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > 
> > The call to get_user_pages_fast is only to get the pointer to a struct
> > page of a given address, pinning it is memory-poisoning handler's job,
> > so drop the refcount grabbed by get_user_pages_fast
> > 
> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > ---
> >  mm/madvise.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 2be9f3fdb05e..89ed9a22ff4f 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -878,16 +878,24 @@ static int madvise_inject_error(int behavior,
> >  		 */
> >  		order = compound_order(compound_head(page));
> >  
> > -		if (PageHWPoison(page)) {
> > -			put_page(page);
> > +		/*
> > +		 * The get_user_pages_fast() is just to get the pfn of the
> > +		 * given address, and the refcount has nothing to do with
> > +		 * what we try to test, so it should be released immediately.
> > +		 * This is racy but it's intended because the real hardware
> > +		 * errors could happen at any moment and memory error handlers
> > +		 * must properly handle the race.
> > +		 */
> > +		put_page(page);
> > +
> > +		if (PageHWPoison(page))
> >  			continue;
> > -		}
> >  
> >  		if (behavior == MADV_SOFT_OFFLINE) {
> >  			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
> >  					pfn, start);
> >  
> > -			ret = soft_offline_page(page, MF_COUNT_INCREASED);
> > +			ret = soft_offline_page(page, 0);
> 
> What does prevent this struct page to go away completely?

Nothing does it.  Memory error handler tries to pin by itself and
then determines what state the page is in now.

Thanks,
Naoya Horiguchi

> 
> >  			if (ret)
> >  				return ret;
> >  			continue;
> > @@ -895,14 +903,6 @@ static int madvise_inject_error(int behavior,
> >  
> >  		pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
> >  				pfn, start);
> > -
> > -		/*
> > -		 * Drop the page reference taken by get_user_pages_fast(). In
> > -		 * the absence of MF_COUNT_INCREASED the memory_failure()
> > -		 * routine is responsible for pinning the page to prevent it
> > -		 * from being released back to the page allocator.
> > -		 */
> > -		put_page(page);
> >  		ret = memory_failure(pfn, 0);
> >  		if (ret)
> >  			return ret;
> > -- 
> > 2.12.3
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

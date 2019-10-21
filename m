Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08405CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D851E205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfJUHBW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:01:22 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:47257 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfJUHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:01:22 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9L715is011310
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Oct 2019 16:01:05 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L715qK029922;
        Mon, 21 Oct 2019 16:01:05 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L6wk2o015052;
        Mon, 21 Oct 2019 16:01:05 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-9696894; Mon, 21 Oct 2019 16:00:48 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0439.000; Mon,
 21 Oct 2019 16:00:47 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Oscar Salvador <osalvador@suse.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 01/16] mm,hwpoison: cleanup unused PageHuge()
 check
Thread-Topic: [RFC PATCH v2 01/16] mm,hwpoison: cleanup unused PageHuge()
 check
Thread-Index: AQHVhPYzQyNwsIsv3k6BqLdb1qTKQ6dfsyIAgARmlwA=
Date:   Mon, 21 Oct 2019 07:00:46 +0000
Message-ID: <20191021070046.GA8782@hori.linux.bs1.fc.nec.co.jp>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-2-osalvador@suse.de>
 <20191018114832.GK5017@dhcp22.suse.cz>
In-Reply-To: <20191018114832.GK5017@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <6BF87E54D030EF48B85507594593D748@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:48:32PM +0200, Michal Hocko wrote:
> On Thu 17-10-19 16:21:08, Oscar Salvador wrote:
> > From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > 
> > Drop the PageHuge check since memory_failure forks into memory_failure_hugetlb()
> > for hugetlb pages.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> 
> s-o-b chain is reversed.
> 
> The code is a bit confusing. Doesn't this check aim for THP?

No, PageHuge() is false for thp, so this if branch is just dead code.

> AFAICS
> PageTransHuge(hpage) will split the THP or fail so PageTransHuge
> shouldn't be possible anymore, right?

Yes, that's right.

> But why does hwpoison_user_mappings
> still work with hpage then?

hwpoison_user_mappings() is called both from memory_failure() and
from memory_failure_hugetlb(), so it need handle both cases.

Thanks,
Naoya Horiguchi

> 
> > ---
> >  mm/memory-failure.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 05c8c6df25e6..2cbadb58c7df 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1345,10 +1345,7 @@ int memory_failure(unsigned long pfn, int flags)
> >  	 * page_remove_rmap() in try_to_unmap_one(). So to determine page status
> >  	 * correctly, we save a copy of the page flags at this time.
> >  	 */
> > -	if (PageHuge(p))
> > -		page_flags = hpage->flags;
> > -	else
> > -		page_flags = p->flags;
> > +	page_flags = p->flags;
> >  
> >  	/*
> >  	 * unpoison always clear PG_hwpoison inside page lock
> > -- 
> > 2.12.3
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B045EC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C79820679
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfH0Bl3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:41:29 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:33827 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfH0Bl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:41:29 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x7R1fB5g018428
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Aug 2019 10:41:11 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x7R1fBC7004398;
        Tue, 27 Aug 2019 10:41:11 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x7R1f8NS009523;
        Tue, 27 Aug 2019 10:41:11 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-7897375; Tue, 27 Aug 2019 10:34:31 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0439.000; Tue,
 27 Aug 2019 10:34:29 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>
Subject: Re: poisoned pages do not play well in the buddy allocator
Thread-Topic: poisoned pages do not play well in the buddy allocator
Thread-Index: AQHVW/rikgbcCOwjjUKpu7s54tdytqcNoE2A
Date:   Tue, 27 Aug 2019 01:34:29 +0000
Message-ID: <20190827013429.GA5125@hori.linux.bs1.fc.nec.co.jp>
References: <20190826104144.GA7849@linux>
In-Reply-To: <20190826104144.GA7849@linux>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <5C3D0DDFB19E7145A3A8CE56A8E69AE7@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 12:41:50PM +0200, Oscar Salvador wrote:
> Hi,
> 
> When analyzing a problem reported by one of our customers, I stumbbled upon an issue
> that origins from the fact that poisoned pages end up in the buddy allocator.
> 
> Let me break down the stepts that lie to the problem:
> 
> 1) We soft-offline a page
> 2) Page gets flagged as HWPoison and is being sent to the buddy allocator.
>    This is done through set_hwpoison_free_buddy_page().
> 3) Kcompactd wakes up in order to perform some compaction.
> 4) compact_zone() will call migrate_pages()
> 5) migrate_pages() will try to get a new page from compaction_alloc() to migrate to
> 6) if cc->freelist is empty, compaction_alloc() will call isolate_free_pagesblock()
> 7) isolate_free_pagesblock only checks for PageBuddy() to assume that a page is OK
>    to be used to migrate to. Since HWPoisoned page are also PageBuddy, we add
>    the page to the list. (same problem exists in fast_isolate_freepages()).
> 
> The outcome of that is that we end up happily handing poisoned pages in compaction_alloc,
> so if we ever got a fault on that page through *_fault, we will return VM_FAULT_HWPOISON,
> and the process will be killed.
> 
> I first though that I could get away with it by checking PageHWPoison in
> {fast_isolate_freepages/isolate_free_pagesblock}, but not really.
> It might be that the page we are checking is an order > 0 page, so the first page
> might not be poisoned, but the one the follows might be, and we end up in the
> same situation.

Yes, this is a whole point of the current implementation.

> 
> After some more thought, I really came to the conclusion that HWPoison pages should not
> really be in the buddy allocator, as this is only asking for problems.
> In this case it is only compaction code, but it could be happening somewhere else,
> and one would expect that the pages you got from the buddy allocator are __ready__ to use.
> 
> I __think__ that we thought we were safe to put HWPoison pages in the buddy allocator as we
> perform healthy checks when getting a page from there, so we skip poisoned pages
> 
> Of course, this is not the end of the story, now that someone got a page, if he frees it,
> there is a high chance that this page ends up in a pcplist (I saw that).
> Unless we are on CONFIG_VM_DEBUG, we do not check for the health of pages got from pcplist,
> as we do when getting a page from the buddy allocator.
> 
> I checked [1], and it seems that [2] was going towards fixing this kind of issue.
> 
> I think it is about time to revamp the whole thing.
> 
> @Naoya: I could give it a try if you are busy.

Thanks for raising hand. That's really wonderful. I think that the series [1] is not
merge yet but not rejected yet, so feel free to reuse/update/revamp it.

> 
> [1] https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
> [2] https://lore.kernel.org/linux-mm/1541746035-13408-9-git-send-email-n-horiguchi@ah.jp.nec.com/
> 
> -- 
> Oscar Salvador
> SUSE L3
> 

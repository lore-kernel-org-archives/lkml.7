Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A5CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1062186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbfCAHbg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:31:36 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:45093 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCAHbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:31:36 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x217VEUe007072
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 1 Mar 2019 16:31:14 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x217VEAQ029944;
        Fri, 1 Mar 2019 16:31:14 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x217VEvO005275;
        Fri, 1 Mar 2019 16:31:14 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-2937063; Fri, 1 Mar 2019 16:29:21 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0319.002; Fri, 1
 Mar 2019 16:29:20 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     zhong jiang <zhongjiang@huawei.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "hughd@google.com" <hughd@google.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>
Subject: Re: [PATCH] mm: hwpoison: fix thp split handing in
 soft_offline_in_use_page()
Thread-Topic: [PATCH] mm: hwpoison: fix thp split handing in
 soft_offline_in_use_page()
Thread-Index: AQHUzcUNc4KTTJZZrEmx16Y+65H3QaXxgnUAgAAL5wCABEAwgA==
Date:   Fri, 1 Mar 2019 07:29:19 +0000
Message-ID: <20190301072919.GA3027@hori.linux.bs1.fc.nec.co.jp>
References: <1551179880-65331-1-git-send-email-zhongjiang@huawei.com>
 <20190226135156.mifspmbdyr6m3hff@kshutemo-mobl1>
 <5C754E78.4050804@huawei.com>
In-Reply-To: <5C754E78.4050804@huawei.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.148]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <151577097361A14A801F1E3D561D1638@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:34:32PM +0800, zhong jiang wrote:
> On 2019/2/26 21:51, Kirill A. Shutemov wrote:
> > On Tue, Feb 26, 2019 at 07:18:00PM +0800, zhong jiang wrote:
> >> From: zhongjiang <zhongjiang@huawei.com>
> >>
> >> When soft_offline_in_use_page() runs on a thp tail page after pmd is plit,
> > s/plit/split/
> >
> >> we trigger the following VM_BUG_ON_PAGE():
> >>
> >> Memory failure: 0x3755ff: non anonymous thp
> >> __get_any_page: 0x3755ff: unknown zero refcount page type 2fffff80000000
> >> Soft offlining pfn 0x34d805 at process virtual address 0x20fff000
> >> page:ffffea000d360140 count:0 mapcount:0 mapping:0000000000000000 index:0x1
> >> flags: 0x2fffff80000000()
> >> raw: 002fffff80000000 ffffea000d360108 ffffea000d360188 0000000000000000
> >> raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> >> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> >> ------------[ cut here ]------------
> >> kernel BUG at ./include/linux/mm.h:519!
> >>
> >> soft_offline_in_use_page() passed refcount and page lock from tail page to
> >> head page, which is not needed because we can pass any subpage to
> >> split_huge_page().
> > I don't see a description of what is going wrong and why change will fixed
> > it. From the description, it appears as it's cosmetic-only change.
> >
> > Please elaborate.
> When soft_offline_in_use_page runs on a thp tail page after pmd is split,  
> and we pass the head page to split_huge_page, Unfortunately, the tail page
> can be free or count turn into zero.

I guess that you have the similar fix on memory_failure() in your mind:

  commit c3901e722b2975666f42748340df798114742d6d
  Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
  Date:   Thu Nov 10 10:46:23 2016 -0800
  
      mm: hwpoison: fix thp split handling in memory_failure()

So it seems that I somehow missed fixing soft offline when I wrote commit
c3901e722b29, and now you find and fix that. Thank you very much.
If you resend the patch with fixing typo, can you add some reference to
c3901e722b29 in the patch description to show the linkage?
And you can add the following tags:

Fixes: 61f5d698cc97 ("mm: re-enable THP")
Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Thanks,
Naoya Horiguchi

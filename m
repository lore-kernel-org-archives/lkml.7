Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AEECA9EAE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 03:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98B32077C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 03:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfJUDSa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 23:18:30 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:55714 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfJUDSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 23:18:30 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9L3IC1U000642
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Oct 2019 12:18:12 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L3ICmL006879;
        Mon, 21 Oct 2019 12:18:12 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L3IBxT014625;
        Mon, 21 Oct 2019 12:18:12 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-69457; Mon, 21 Oct 2019 12:16:42 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0439.000; Mon,
 21 Oct 2019 12:16:42 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Qian Cai <cai@lca.pw>
CC:     Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: memory offline infinite loop after soft offline
Thread-Topic: memory offline infinite loop after soft offline
Thread-Index: AQHVgHtyUduz67i7AUWqxWZ+Pu+7vadZPeAAgATGWACAAAeGAIAAh9KAgAAFzYCAAIOhAIAAP4+AgAAHNACAAFp3gIAEJduA
Date:   Mon, 21 Oct 2019 03:16:41 +0000
Message-ID: <20191021031641.GA8007@hori.linux.bs1.fc.nec.co.jp>
References: <20191018063222.GA15406@hori.linux.bs1.fc.nec.co.jp>
 <64DC81FB-C1D2-44F2-981F-C6F766124B91@lca.pw>
In-Reply-To: <64DC81FB-C1D2-44F2-981F-C6F766124B91@lca.pw>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <734247A429D4B54397E93A316B55EC7A@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 07:56:09AM -0400, Qian Cai wrote:
> 
> 
>     On Oct 18, 2019, at 2:35 AM, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>     wrote:
> 
> 
>     You're right, then I don't see how this happens. If the error hugepage was
>     isolated without having PG_hwpoison set, it's unexpected and problematic.
>     I'm testing myself with v5.4-rc2 (simply ran move_pages12 and did hotremove
>     /hotadd)
>     but don't reproduce the issue yet.  Do we need specific kernel version/
>     config
>     to trigger this?
> 
> 
> This is reproducible on linux-next with the config. Not sure if it is
> reproducible on x86.
> 
> https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
> 
> and kernel cmdline if that matters
> 
> page_poison=on page_owner=on numa_balancing=enable \
> systemd.unified_cgroup_hierarchy=1 debug_guardpage_minorder=1 \
> page_alloc.shuffle=1

Thanks for the info.

> 
> BTW, where does the code set PG_hwpoison for the head page?

Precisely speaking, soft offline only sets PG_hwpoison after the target
hugepage is successfully dissolved (then it's not a hugepage any more),
so PG_hwpoison is set on the raw page in set_hwpoison_free_buddy_page().

In move_pages12 case, madvise(MADV_SOFT_OFFLINE) is called for the range
of 2 hugepages, so the expected result is that page offset 0 and 512
are marked as PG_hwpoison after injection.

Looking at your dump_page() output, the end_pfn is page offset 1
("page:c00c000800458040" is likely to point to pfn 0x11601.)
The page belongs to high order buddy free page, but doesn't have
PageBuddy nor PageHWPoison because it was not the head page or
the raw error page.

> Unfortunately, this does not solve the problem. It looks to me that in            
> soft_offline_huge_page(), set_hwpoison_free_buddy_page() will only set            
> PG_hwpoison for buddy pages, so the even the compound_head() has no PG_hwpoison   
> set.                                                                              

Your analysis is totally correct, and this behavior will be fixed by
the change (https://lkml.org/lkml/2019/10/17/551) in Oscar's rework.
The raw error page will be taken off from buddy system and the other
subpages are properly split into lower orderer pages (we'll properly
manage PageBuddy flags). So all possible cases would be covered by
branches in __test_page_isolated_in_pageblock.

Thanks,
Naoya Horiguchi

Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA3DC46470
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD23B217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfEUGyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:54:15 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:51097 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfEUGyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:54:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TSHoLiE_1558421650;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TSHoLiE_1558421650)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 May 2019 14:54:11 +0800
Subject: Re: [v2 PATCH] mm: vmscan: correct nr_reclaimed for THP
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        kirill.shutemov@linux.intel.com, Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        william.kucharski@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1557505420-21809-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190513080929.GC24036@dhcp22.suse.cz>
 <c3c26c7a-748c-6090-67f4-3014bedea2e6@linux.alibaba.com>
 <20190513214503.GB25356@dhcp22.suse.cz>
 <CAHbLzkpUE2wBp8UjH72ugXjWSfFY5YjV1Ps9t5EM2VSRTUKxRw@mail.gmail.com>
 <20190514062039.GB20868@dhcp22.suse.cz>
 <509de066-17bb-e3cf-d492-1daf1cb11494@linux.alibaba.com>
 <20190516151012.GA20038@cmpxchg.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <3c2ef3c2-4d39-11c3-acfa-2a809ca72b3c@linux.alibaba.com>
Date:   Tue, 21 May 2019 14:54:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190516151012.GA20038@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> [ check_move_unevictable_pages() seems weird. It gets a pagevec from
>    find_get_entries(), which, if I understand the THP page cache code
>    correctly, might contain the same compound page over and over. It'll
>    be !unevictable after the first iteration, so will only run once. So
>    it produces incorrect numbers now, but it is probably best to ignore
>    it until we figure out THP cache. Maybe add an XXX comment. ]

The commit 5fd4ca2d84b2 ("mm: page cache: store only head pages in 
i_pages") changed how THP is stored in page cache, but 
find_get_entries() would return base page by calling find_subpage(), so 
check_move_unevictable_pages() should just returns the number of base pages.



Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CE0C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50B32082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390235AbfIFDPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 23:15:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25926 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731938AbfIFDPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:15:42 -0400
X-UUID: 0c52a1504d08462fa88399dd2eb2bb08-20190906
X-UUID: 0c52a1504d08462fa88399dd2eb2bb08-20190906
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 791673129; Fri, 06 Sep 2019 11:15:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Sep 2019 11:15:31 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Sep 2019 11:15:31 +0800
Message-ID: <1567739734.32522.67.camel@mtksdccf07>
Subject: Re: [PATCH 1/2] mm/kasan: dump alloc/free stack for page allocator
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 6 Sep 2019 11:15:34 +0800
In-Reply-To: <99913463-0e2c-7dab-c1eb-8b9e149b3ee3@suse.cz>
References: <20190904065133.20268-1-walter-zh.wu@mediatek.com>
         <401064ae-279d-bef3-a8d5-0fe155d0886d@suse.cz>
         <1567605965.32522.14.camel@mtksdccf07>
         <7998e8f1-e5e2-da84-ea1f-33e696015dce@suse.cz>
         <1567607063.32522.24.camel@mtksdccf07>
         <99913463-0e2c-7dab-c1eb-8b9e149b3ee3@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-05 at 10:03 +0200, Vlastimil Babka wrote:
> On 9/4/19 4:24 PM, Walter Wu wrote:
> > On Wed, 2019-09-04 at 16:13 +0200, Vlastimil Babka wrote:
> >> On 9/4/19 4:06 PM, Walter Wu wrote:
> >>
> >> The THP fix is not required for the rest of the series, it was even merged to
> >> mainline separately.
> >>
> >>> And It looks like something is different, because we only need last
> >>> stack of page, so it can decrease memory overhead.
> >>
> >> That would save you depot_stack_handle_t (which is u32) per page. I guess that's
> >> nothing compared to KASAN overhead?
> >>
> > If we can use less memory, we can achieve what we want. Why not?
> 
> In my experience to solve some UAFs, it's important to know not only the
> freeing stack, but also the allocating stack. Do they make sense together,
> or not? In some cases, even longer history of alloc/free would be nice :)
> 
We think it only has free stack to find out the root cause. Maybe we can
refer to other people's experience and ideas.


> Also by simply recording the free stack in the existing depot handle,
> you might confuse existing page_owner file consumers, who won't know
> that this is a freeing stack.
> 
Don't worry it.
1. Our feature option has this description about last stack of page.
when consumer enable our feature, they should know the changing.
2. We add to print text message for alloc or free stack before dump the
stack of page. so consumers should know what is it.

> All that just doesn't seem to justify saving an u32 per page.

Actually, We want to slim memory usage instead of increasing the memory
usage at another mail discussion. Maybe, maintainer or reviewer can
provide some ideas. That will be great.

> > 
> > 
> 



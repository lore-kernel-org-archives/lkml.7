Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D95BC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52E82339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfIDOGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:06:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44382 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730462AbfIDOGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:06:12 -0400
X-UUID: f362c8a6c104411aa10ef7ebe1987d5b-20190904
X-UUID: f362c8a6c104411aa10ef7ebe1987d5b-20190904
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2107079500; Wed, 04 Sep 2019 22:06:06 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Sep 2019 22:06:05 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Sep 2019 22:06:04 +0800
Message-ID: <1567605965.32522.14.camel@mtksdccf07>
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
Date:   Wed, 4 Sep 2019 22:06:05 +0800
In-Reply-To: <401064ae-279d-bef3-a8d5-0fe155d0886d@suse.cz>
References: <20190904065133.20268-1-walter-zh.wu@mediatek.com>
         <401064ae-279d-bef3-a8d5-0fe155d0886d@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 14:49 +0200, Vlastimil Babka wrote:
> On 9/4/19 8:51 AM, Walter Wu wrote:
> > This patch is KASAN report adds the alloc/free stacks for page allocator
> > in order to help programmer to see memory corruption caused by page.
> > 
> > By default, KASAN doesn't record alloc/free stack for page allocator.
> > It is difficult to fix up page use-after-free issue.
> > 
> > This feature depends on page owner to record the last stack of pages.
> > It is very helpful for solving the page use-after-free or out-of-bound.
> > 
> > KASAN report will show the last stack of page, it may be:
> > a) If page is in-use state, then it prints alloc stack.
> >    It is useful to fix up page out-of-bound issue.
> 
> I expect this will conflict both in syntax and semantics with my series [1] that
> adds the freeing stack to page_owner when used together with debug_pagealloc,
> and it's now in mmotm. Glad others see the need as well :) Perhaps you could
> review the series, see if it fulfils your usecase (AFAICS the series should be a
> superset, by storing both stacks at once), and perhaps either make KASAN enable
> debug_pagealloc, or turn KASAN into an alternative enabler of the functionality
> there?
> 
> Thanks, Vlastimil
> 
> [1] https://lore.kernel.org/linux-mm/20190820131828.22684-1-vbabka@suse.cz/t/#u
> 
Thanks your information.
We focus on the smartphone, so it doesn't enable
CONFIG_TRANSPARENT_HUGEPAGE, Is it invalid for our usecase?
And It looks like something is different, because we only need last
stack of page, so it can decrease memory overhead.
I will try to enable debug_pagealloc(with your patch) and KASAN, then we
see the result.

Thanks.
Walter 


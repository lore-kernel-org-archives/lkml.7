Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01431C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DDF2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbfILOIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:08:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:42496 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732389AbfILOIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:08:44 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1i8Plm-0008P3-U4; Thu, 12 Sep 2019 17:08:23 +0300
Subject: Re: [PATCH v3] mm/kasan: dump alloc and free stack for page allocator
To:     Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
References: <20190911083921.4158-1-walter-zh.wu@mediatek.com>
 <5E358F4B-552C-4542-9655-E01C7B754F14@lca.pw>
 <c4d2518f-4813-c941-6f47-73897f420517@suse.cz>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e4e23249-9f37-1d66-d411-7786b7aba36e@virtuozzo.com>
Date:   Thu, 12 Sep 2019 17:08:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c4d2518f-4813-c941-6f47-73897f420517@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/19 4:53 PM, Vlastimil Babka wrote:
> On 9/11/19 5:19 PM, Qian Cai wrote:
>>
>> The new config looks redundant and confusing. It looks to me more of a document update
>> in Documentation/dev-tools/kasan.txt to educate developers to select PAGE_OWNER and
>> DEBUG_PAGEALLOC if needed.
>  
> Agreed. But if you want it fully automatic, how about something
> like this (on top of mmotm/next)? If you agree I'll add changelog
> and send properly.
> 
> ----8<----
> 
> From a528d14c71d7fdf5872ca8ab3bd1b5bad26670c9 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 12 Sep 2019 15:51:23 +0200
> Subject: [PATCH] make KASAN enable page_owner with free stack capture
> 
> ---
>  include/linux/page_owner.h |  1 +
>  lib/Kconfig.kasan          |  4 ++++
>  mm/Kconfig.debug           |  5 +++++
>  mm/page_alloc.c            |  6 +++++-
>  mm/page_owner.c            | 37 ++++++++++++++++++++++++-------------
>  5 files changed, 39 insertions(+), 14 deletions(-)
> 

Looks ok to me. This certainly better than full dependency on the DEBUG_PAGEALLOC which we don't need.

 

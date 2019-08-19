Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A16C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C598F20651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfHSOGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:06:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:58664 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfHSOGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:06:32 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hziIi-0001H7-Gd; Mon, 19 Aug 2019 17:06:24 +0300
Subject: Re: [PATCH] arm64: kasan: fix phys_to_virt() false positive on
 tag-based kasan
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20190819114420.2535-1-walter-zh.wu@mediatek.com>
 <20190819125625.bu3nbrldg7te5kwc@willie-the-truck>
 <20190819132347.GB9927@lakrids.cambridge.arm.com>
 <20190819133441.ejomv6cprdcz7hh6@willie-the-truck>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <8df7ec20-2fd2-8076-9a34-ac4c9785e91a@virtuozzo.com>
Date:   Mon, 19 Aug 2019 17:06:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819133441.ejomv6cprdcz7hh6@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/19 4:34 PM, Will Deacon wrote:
> On Mon, Aug 19, 2019 at 02:23:48PM +0100, Mark Rutland wrote:
>> On Mon, Aug 19, 2019 at 01:56:26PM +0100, Will Deacon wrote:
>>> On Mon, Aug 19, 2019 at 07:44:20PM +0800, Walter Wu wrote:
>>>> __arm_v7s_unmap() call iopte_deref() to translate pyh_to_virt address,
>>>> but it will modify pointer tag into 0xff, so there is a false positive.
>>>>
>>>> When enable tag-based kasan, phys_to_virt() function need to rewrite
>>>> its original pointer tag in order to avoid kasan report an incorrect
>>>> memory corruption.
>>>
>>> Hmm. Which tree did you see this on? We've recently queued a load of fixes
>>> in this area, but I /thought/ they were only needed after the support for
>>> 52-bit virtual addressing in the kernel.
>>
>> I'm seeing similar issues in the virtio blk code (splat below), atop of
>> the arm64 for-next/core branch. I think this is a latent issue, and
>> people are only just starting to test with KASAN_SW_TAGS.
>>
>> It looks like the virtio blk code will round-trip a SLUB-allocated pointer from
>> virt->page->virt, losing the per-object tag in the process.
>>
>> Our page_to_virt() seems to get a per-page tag, but this only makes
>> sense if you're dealing with the page allocator, rather than something
>> like SLUB which carves a page into smaller objects giving each object a
>> distinct tag.
>>
>> Any round-trip of a pointer from SLUB is going to lose the per-object
>> tag.
> 
> Urgh, I wonder how this is supposed to work?
> 

We supposed to ignore pointers with 0xff tags. We do ignore them when memory access checked,
but not in kfree() path.
This untested patch should fix the issue:



---
 mm/kasan/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 895dc5e2b3d5..0a81cc328049 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -407,7 +407,7 @@ static inline bool shadow_invalid(u8 tag, s8 shadow_byte)
 		return shadow_byte < 0 ||
 			shadow_byte >= KASAN_SHADOW_SCALE_SIZE;
 	else
-		return tag != (u8)shadow_byte;
+		return (tag != KASAN_TAG_KERNEL) && (tag != (u8)shadow_byte);
 }
 
 static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
-- 
2.21.0


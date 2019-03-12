Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293E2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24212077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfCLVxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:53:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbfCLVxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:53:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BF70C02C68F;
        Tue, 12 Mar 2019 21:53:41 +0000 (UTC)
Received: from [10.36.116.121] (ovpn-116-121.ams2.redhat.com [10.36.116.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0A7A5D706;
        Tue, 12 Mar 2019 21:53:31 +0000 (UTC)
Subject: Re: [RFC][Patch v9 2/6] KVM: Enables the kernel to isolate guest free
 pages
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
References: <20190306155048.12868-1-nitesh@redhat.com>
 <20190306155048.12868-3-nitesh@redhat.com>
 <CAKgT0UdDohCXZY3q9qhQsHw-2vKp_CAgvf2dd2e6U6KLsAkVng@mail.gmail.com>
 <2d9ae889-a9b9-7969-4455-ff36944f388b@redhat.com>
 <22e4b1cd-38a5-6642-8cbe-d68e4fcbb0b7@redhat.com>
 <CAKgT0UcAqGX26pcQLzFUevHsLu-CtiyOYe15uG3bkhGZ5BJKAg@mail.gmail.com>
 <78b604be-2129-a716-a7a6-f5b382c9fb9c@redhat.com>
 <CAKgT0Uc_z9Vi+JhQcJYX+J9c4J56RRSkzzegbb2=9xO-NY3dgw@mail.gmail.com>
 <20190307212845-mutt-send-email-mst@kernel.org>
 <CAKgT0Ucu3EMsYBfdKtEiprrn-VBZy3Y+0HdEp5b4PO2SQgGsRw@mail.gmail.com>
 <17d2afa6-556e-ec73-40dc-beac536b3f20@redhat.com>
 <CAKgT0UcdQZwHjmMBkSWmy_ZdShJCagjwomn13g+r7ZNJBRn1LQ@mail.gmail.com>
 <8f692047-4750-6827-1ee0-d3d354788f09@redhat.com>
 <CAKgT0UddT9CKg1uZo6ZODs9ARti-6XGm9Zvo+8QRZKUPSwzWMQ@mail.gmail.com>
 <41ae8afe-72c9-58e6-0cbb-9375c91ce37a@redhat.com>
 <CAKgT0Uftff+JVRW-sQ6u8DeVg4Fq9b-pgE6Ojr+XqQFn13JmGw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <be257778-3ecb-8f12-2d51-451a5e16fd3f@redhat.com>
Date:   Tue, 12 Mar 2019 22:53:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uftff+JVRW-sQ6u8DeVg4Fq9b-pgE6Ojr+XqQFn13JmGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 12 Mar 2019 21:53:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.19 22:13, Alexander Duyck wrote:
> On Tue, Mar 12, 2019 at 12:46 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>>
>> On 3/8/19 4:39 PM, Alexander Duyck wrote:
>>> On Fri, Mar 8, 2019 at 11:39 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>>>> On 3/8/19 2:25 PM, Alexander Duyck wrote:
>>>>> On Fri, Mar 8, 2019 at 11:10 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>>>>>> On 3/8/19 1:06 PM, Alexander Duyck wrote:
>>>>>>> On Thu, Mar 7, 2019 at 6:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>>> On Thu, Mar 07, 2019 at 02:35:53PM -0800, Alexander Duyck wrote:
>>>>>>>>> The only other thing I still want to try and see if I can do is to add
>>>>>>>>> a jiffies value to the page private data in the case of the buddy
>>>>>>>>> pages.
>>>>>>>> Actually there's one extra thing I think we should do, and that is make
>>>>>>>> sure we do not leave less than X% off the free memory at a time.
>>>>>>>> This way chances of triggering an OOM are lower.
>>>>>>> If nothing else we could probably look at doing a watermark of some
>>>>>>> sort so we have to have X amount of memory free but not hinted before
>>>>>>> we will start providing the hints. It would just be a matter of
>>>>>>> tracking how much memory we have hinted on versus the amount of memory
>>>>>>> that has been pulled from that pool.
>>>>>> This is to avoid false OOM in the guest?
>>>>> Partially, though it would still be possible. Basically it would just
>>>>> be a way of determining when we have hinted "enough". Basically it
>>>>> doesn't do us much good to be hinting on free memory if the guest is
>>>>> already constrained and just going to reallocate the memory shortly
>>>>> after we hinted on it. The idea is with a watermark we can avoid
>>>>> hinting until we start having pages that are actually going to stay
>>>>> free for a while.
>>>>>
>>>>>>>  It is another reason why we
>>>>>>> probably want a bit in the buddy pages somewhere to indicate if a page
>>>>>>> has been hinted or not as we can then use that to determine if we have
>>>>>>> to account for it in the statistics.
>>>>>> The one benefit which I can see of having an explicit bit is that it
>>>>>> will help us to have a single hook away from the hot path within buddy
>>>>>> merging code (just like your arch_merge_page) and still avoid duplicate
>>>>>> hints while releasing pages.
>>>>>>
>>>>>> I still have to check PG_idle and PG_young which you mentioned but I
>>>>>> don't think we can reuse any existing bits.
>>>>> Those are bits that are already there for 64b. I think those exist in
>>>>> the page extension for 32b systems. If I am not mistaken they are only
>>>>> used in VMA mapped memory. What I was getting at is that those are the
>>>>> bits we could think about reusing.
>>>>>
>>>>>> If we really want to have something like a watermark, then can't we use
>>>>>> zone->free_pages before isolating to see how many free pages are there
>>>>>> and put a threshold on it? (__isolate_free_page() does a similar thing
>>>>>> but it does that on per request basis).
>>>>> Right. That is only part of it though since that tells you how many
>>>>> free pages are there. But how many of those free pages are hinted?
>>>>> That is the part we would need to track separately and then then
>>>>> compare to free_pages to determine if we need to start hinting on more
>>>>> memory or not.
>>>> Only pages which are isolated will be hinted, and once a page is
>>>> isolated it will not be counted in the zone free pages.
>>>> Feel free to correct me if I am wrong.
>>> You are correct up to here. When we isolate the page it isn't counted
>>> against the free pages. However after we complete the hint we end up
>>> taking it out of isolation and returning it to the "free" state, so it
>>> will be counted against the free pages.
>>>
>>>> If I am understanding it correctly you only want to hint the idle pages,
>>>> is that right?
>>> Getting back to the ideas from our earlier discussion, we had 3 stages
>>> for things. Free but not hinted, isolated due to hinting, and free and
>>> hinted. So what we would need to do is identify the size of the first
>>> pool that is free and not hinted by knowing the total number of free
>>> pages, and then subtract the size of the pages that are hinted and
>>> still free.
>> To summarize, for now, I think it makes sense to stick with the current
>> approach as this way we can avoid any locking in the allocation path and
>> reduce the number of hypercalls for a bunch of MAX_ORDER - 1 page.
> 
> I'm not sure what you are talking about by "avoid any locking in the
> allocation path". Are you talking about the spin on idle bit, if so
> then yes. However I have been testing your patches and I was correct
> in the assumption that you forgot to handle the zone lock when you
> were freeing __free_one_page. I just did a quick copy/paste from your
> zone lock handling from the guest_free_page_hinting function into the
> release_buddy_pages function and then I was able to enable multiple
> CPUs without any issues.
> 
>> For the next step other than the comments received in the code and what
>> I mentioned in the cover email, I would like to do the following:
>> 1. Explore the watermark idea suggested by Alex and bring down memhog
>> execution time if possible.
> 
> So there are a few things that are hurting us on the memhog test:
> 1. The current QEMU patch is only madvising 4K pages at a time, this
> is disabling THP and hurts the test.
> 
> 2. The fact that we madvise the pages away makes it so that we have to
> fault the page back in in order to use it for the memhog test. In
> order to avoid that penalty we may want to see if we can introduce
> some sort of "timeout" on the pages so that we are only hinting away
> old pages that have not been used for some period of time.
> 
> 3. Currently we are still doing a large amount of processing in the
> page free path. Ideally we should look at getting away from trying to
> do so much per-cpu work and instead just have some small tasks that
> put the data needed in the page, and then have a separate thread
> walking the free_list checking that data, isolating the pages, hinting
> them, and then returning them back to the free_list.

This is highly debatable. Whenever the is concurrency, there is the need
for locking (well, at least synchronization - maybe using existing locks
like the zone lock). The other thread has to run somewhere. One thread
per VCPU might not what we want ... sorting this out might be more
complicated than it would seem. I would suggest to defer the discussion
of this change to a later stage. It can be easily reworked later - in
theory :)

1 and 2 you mention are the lower hanging fruits that will definitely
improve performance.

-- 

Thanks,

David / dhildenb

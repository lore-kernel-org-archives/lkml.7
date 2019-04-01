Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996CCC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64992218FF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDAOL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:11:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfDAOL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:11:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5FB7230832F4;
        Mon,  1 Apr 2019 14:11:56 +0000 (UTC)
Received: from [10.36.118.81] (unknown [10.36.118.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC96A5D70E;
        Mon,  1 Apr 2019 14:11:42 +0000 (UTC)
Subject: Re: On guest free page hinting and OOM
From:   David Hildenbrand <david@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, alexander.duyck@gmail.com
References: <20190329084058-mutt-send-email-mst@kernel.org>
 <f6332928-d6a4-7a75-245d-2c534cf6e710@redhat.com>
 <20190329104311-mutt-send-email-mst@kernel.org>
 <7a3baa90-5963-e6e2-c862-9cd9cc1b5f60@redhat.com>
 <f0ee075d-3e99-efd5-8c82-98d53b9f204f@redhat.com>
 <20190329125034-mutt-send-email-mst@kernel.org>
 <fb23fd70-4f1b-26a8-5ecc-4c14014ef29d@redhat.com>
 <20190401073007-mutt-send-email-mst@kernel.org>
 <29e11829-c9ac-a21b-b2f1-ed833e4ca449@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <dc14a711-a306-d00b-c4ce-c308598ee386@redhat.com>
Date:   Mon, 1 Apr 2019 16:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <29e11829-c9ac-a21b-b2f1-ed833e4ca449@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 01 Apr 2019 14:11:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.19 16:09, David Hildenbrand wrote:
>>> Thinking about your approach, there is one elementary thing to notice:
>>>
>>> Giving the guest pages from the buffer while hinting requests are being
>>> processed means that the guest can and will temporarily make use of more
>>> memory than desired. Essentially up to the point where MADV_FREE is
>>> finally called for the hinted pages.
>>
>> Right - but that seems like exactly the reverse of the issue with the current
>> approach which is guest can temporarily use less memory than desired.
>>
>>> Even then the guest will logicall
>>> make use of more memory than desired until core MM takes pages away.
>>
>> That sounds more like a host issue though. If it wants to
>> it can use e.g. MAD_DONTNEED.
> 
> Indeed. But MADV_DONTNEED is somewhat undesired for performance reasons.
> You want to do the work when swapping not when hinting.
> 
> But what I wanted to say here: Looking at the pure size of your guest
> will at least not help you to identify if more memory than desired will
> be used.
> 
>>
>>> So:
>>> 1) Unmodified guests will make use of more memory than desired.
>>
>> One interesting possibility for this is to add the buffer memory
>> by hotplug after the feature has been negotiated.
>> I agree this sounds complex.
> 
> Yes it is, and it goes into the direction of virtio-mem that essentially
> does that. But bad news: memory hotplug is complicated stuff, both on
> the hypervisor and guest side. And things like NUMA make it more involved.
> 
> But even then, malicious guest can simply fake feature negotiation and
> make use of all hotplugged memory. Won't work, at least not for
> malicious guests.
> 
>>
>> But I have an idea: how about we include the hint size in the
>> num_pages counter? Then unmodified guests put
>> it in the balloon and don't use it. Modified ones
>> will know to use it just for hinting.
> 
> These are the nightmares I was talking about. I would like to decouple
> this feature as far as possible from balloon inflation/deflation.
> Ballooning is 4k based and might have other undesirable side effect.
> Just because somebody wants to use page hinting does not mean he wants
> to use ballooning. Effectively, many people will want to avoid
> ballooning completely by using page hinting for their use case.
> 
>>
>>
>>> 2) Malicious guests will make use of more memory than desired.
>>
>> Well this limitation is fundamental to balloon right?
> 
> Yep, it is the fundamental issue of ballooning. If memory is available
> right from the boot, the system is free to do with it whatever it wants.
> (one of the main things virtio-mem will do differently/better)
> 
>> If host wants to add tracking of balloon memory, it
>> can enforce the limits. So far no one bothered,
>> but maybe with this feature we should start to do that.
> 
> I think I already had endless rants about why this is not possible.
> Ballooning as it is currently implemented by virtio-balloon is broken by
> design. Period. You can and never will be able to distinguish unmodified
> guests from malicious guests. Please don't design new approaches based
> on broken design.
> 
>>
>>> 3) Sane, modified guests will make use of more memory than desired.
>>>
>>> Instead, we could make our life much easier by doing the following:
>>>
>>> 1) Introduce a parameter to cap the amount of memory concurrently hinted
>>> similar like you suggested, just don't consider it a buffer value.
>>> "-device virtio-balloon,hinting_size=1G". This gives us control over the
>>> hinting proceess.
>>>
>>> hinting_size=0 (default) disables hinting
>>>
>>> The admin can tweak the number along with memory requirements of the
>>> guest. We can make suggestions (e.g. calculate depending on #cores,#size
>>> of memory, or simply "1GB")
>>
>> So if it's all up to the guest and for the benefit of the guest, and
>> with no cost/benefit to the host, then why are we supplying this value
>> from the host?
> 
> See 3), the admin has to be aware of hinting behavior.
> 
>>
>>> 2) In the guest, track the size of hints in progress, cap at the
>>> hinting_size.
>>>
>>> 3) Document hinting behavior
>>>
>>> "When hinting is enabled, memory up to hinting_size might temporarily be
>>> removed from your guest in order to be hinted to the hypervisor. This is
>>> only for a very short time, but might affect applications. Consider the
>>> hinting_size when sizing your guest. If your application was tested with
>>> XGB and a hinting size of 1G is used, please configure X+1GB for the
>>> guest. Otherwise, performance degradation might be possible."
>>
>> OK, so let's start with this. Now let us assume that guest follows
>> the advice.  We thus know that 1GB is not needed for guest applications.
>> So why do we want to allow applications to still use this extra memory?
> 
> If the application does not need the 1GB, the 1GB will be hinted to the
> hypervisor and are effectively only a buffer for the OOM scenario.
> (ignoring page cache discussions for now).
> 
> "So why do we want to allow applications to still use this extra memory"
> is the EXACT same issue you have with your buffer approach. Any guest
> can make use of the buffer and you won't be able to detect it. Very same
> problem. Only in your approach, the guest might agree to play nicely by
> not making use of the 1G you provided. Just as if the application does
> not need/use the additional 1GB.
> 
> The interesting thing is most probably: Will the hinting size usually be
> reasonable small? At least I guess a guest with 4TB of RAM will not
> suddenly get a hinting size of hundreds of GB. Most probably also only
> something in the range of 1GB. But this is an interesting question to
> look into.
> 
> Also, if the admin does not care about performance implications when
> already close to hinting, no need to add the additional 1Gb to the ram size.

"close to OOM" is what I meant.


-- 

Thanks,

David / dhildenb

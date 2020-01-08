Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB81DC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713E72070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJzvyYXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgAHMUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:20:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45764 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727212AbgAHMUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578486051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DkwyC8e4L1gr00xRIhy7SZZ8U8+tOEWE992M4MOPnfU=;
        b=ZJzvyYXPeJ362TXpt8iOmJpW6zAXWeaXIzT0kUQqcewqNnODeRpVaXJD8MfFXAqbSqmdNZ
        S8CIahAP02U2d9ymDvh1tzerKLdf5o9kfpBhBDZWHkOIxCxGENLQwqh+hRtarwY272x6KY
        Fj45s0N5gwmbvJxSTOxgs5HXkB58f9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-dEYRJG2sMMyGRzxdX5640A-1; Wed, 08 Jan 2020 07:20:48 -0500
X-MC-Unique: dEYRJG2sMMyGRzxdX5640A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C04918B9FC2;
        Wed,  8 Jan 2020 12:20:46 +0000 (UTC)
Received: from [10.36.117.90] (ovpn-117-90.ams2.redhat.com [10.36.117.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05AD519C58;
        Wed,  8 Jan 2020 12:20:44 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm/memory-failure.c: not necessary to recalculate
 hpage
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, n-horiguchi@ah.jp.nec.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20191118082003.26240-1-richardw.yang@linux.intel.com>
 <20191118082003.26240-2-richardw.yang@linux.intel.com>
 <fdba31c8-d0c0-83a8-62d1-c04c1e894218@redhat.com>
 <20191202222827.isaelnqmuyn7zrns@master>
 <37eedde2-05ab-e42e-7bcd-09090b090366@redhat.com>
 <20191206014825.GA3846@richard>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <fd9dc6a9-3fe8-2258-3fc3-0cbdd6b3ef98@redhat.com>
Date:   Wed, 8 Jan 2020 13:20:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191206014825.GA3846@richard>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.19 02:48, Wei Yang wrote:
> On Thu, Dec 05, 2019 at 04:06:20PM +0100, David Hildenbrand wrote:
>> On 02.12.19 23:28, Wei Yang wrote:
>>> On Wed, Nov 20, 2019 at 04:07:38PM +0100, David Hildenbrand wrote:
>>>> On 18.11.19 09:20, Wei Yang wrote:
>>>>> hpage is not changed.
>>>>>
>>>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>>>> ---
>>>>>   mm/memory-failure.c | 1 -
>>>>>   1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>>> index 392ac277b17d..9784f4339ae7 100644
>>>>> --- a/mm/memory-failure.c
>>>>> +++ b/mm/memory-failure.c
>>>>> @@ -1319,7 +1319,6 @@ int memory_failure(unsigned long pfn, int flags)
>>>>>   		}
>>>>>   		unlock_page(p);
>>>>>   		VM_BUG_ON_PAGE(!page_count(p), p);
>>>>> -		hpage = compound_head(p);
>>>>>   	}
>>>>>   	/*
>>>>>
>>>>
>>>> I am *absolutely* no transparent huge page expert (sorry :) ), but won't the
>>>> split_huge_page(p) eventually split the compound page, such that
>>>> compound_head(p) will return something else after that call?
>>>>
>>>
>>> Hi, David
>>>
>>> Took sometime to look into the code and re-think about it. Found maybe we can
>>> simplify this in another way.
>>>
>>> First, code touches here means split_huge_page() succeeds and "p" is now a PTE
>>> page. So compound_head(p) == p.
>>
>> While this would also be my intuition, I can't state that this is
>> guaranteed to be the case (IOW, I did not check the code/documentation) :)
>>
> 
> If my understanding is correct, split_huge_page() succeeds the THP would be
> tear down to normal page.
> 
>>>
>>> Then let's look at who will use hpage in the following function. There are two
>>> uses in current upstream:
>>>
>>>     * page_flags calculation
>>>     * hwpoison_user_mappings()
>>>
>>> The first one would be removed in next patch since PageHuge is handled at the
>>> beginning.
>>>
>>> And in the second place, comment says if split succeeds, hpage points to page
>>> "p".
>>>
>>> After all, we don't need to re-calculate hpage after split, and just replace
>>> hpage in hwpoison_user_mappings() with p is enough.
>>
>> That assumption would only be true in case all compound pages at this
>> point are transparent huge pages, no? AFAIK that is not necessarily
>> true. Or am I missing something?
>>
> 
> Function hwpoison_user_mappings() just handle user space mapping. If my
> understanding is correct, we just have three type of pages would be used in
> user space mapping:
> 
>     * normal page
>     * THP
>     * hugetlb
> 
> Since THP would be split or already returned and hugetlb is handled in another
> branch, this means for other pages hwpoison_user_mappings() would just return
> true.
> 

Sorry for the late reply :)

While I think you are correct, I am not sure if the change you are
suggesting is a) future proof and b) worth it. IOW, the recalculation
after the split makes it clear that something changed and that the
compound page does no longer exist. I might be wrong of course and this
cleanup makes perfect sense :)


-- 
Thanks,

David / dhildenb


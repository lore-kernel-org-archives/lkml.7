Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDD3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5206120865
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2STPfwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLBW2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:28:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38968 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:28:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so1244937wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 14:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BMjiRy3QJEUM7qi9iVtt3EpRL4urnDNurtn48A3AP18=;
        b=M2STPfwqrNHD9OcY0KGbYeWlNtCjqaz0glKPsVV2z8Rdh22fPf3UgtQSxE2Y4L97X/
         LTGM6llw3dSR29MPdKwcygrfakK9W82mmZgd19q+dBV6Nkm/EPU4gXaILzTxPZvLPXyz
         48OvcgS/LYVWFwdxM05VJfxISnJknSx79+rCgh+a4oCnCPm66DmltP3MYtHb6LPxdUVR
         BN9kEXTtBUdTRN2MhjZ7FUsOqIibXcqzB/c4tqKBVch00IILr/pVeJyCwckMy2HN5fZX
         FSNjAtsILVfEWtsZ6zeE7NhRVHvShnKrSuv7Q/bAmz2cA5lyPN13UFe3i737os8vHYFI
         Vfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMjiRy3QJEUM7qi9iVtt3EpRL4urnDNurtn48A3AP18=;
        b=KtDWH8rNglm/wGxlRlN/kDmtuAy6Yu9TojSsPsozJyKFp4QzIepdRcf4SZCvMFxNv4
         AdWgSnNVH2S63KXSPiBP0r5YXjybiP3gH7WLiXAjNP+RajIQFWkn+WBXa6XkFnazAurx
         832YDs7Jy+wrp1y4biDbEkh6n/oB2xVUJUq8G0QUsdR4j3kEnSSwXmlpauhN6IZjfCdc
         YKO1mSH7i/l7tFdons/9SWA9LX3I+msCc1HdqPYI7+TqHMzGVhYFxMfH36F28dqv08yJ
         QeIRtoOPCcAnpPrQSALy/rJ8dSQkqWam5sHfo+TLs+b2odiAeJLT1MVzecLqHcvu7Ija
         Ynwg==
X-Gm-Message-State: APjAAAVp7Lfj8w2j00zQu5xj8SXGA8DiM8icngFb8w4uQDsbcSXorQr4
        e5Z6m3hEP5fEETdXBfCqaF4=
X-Google-Smtp-Source: APXvYqxVufMWAPntjkOfUuktfrfgT33XpBapZ9/uwzUSD06bk8TCn9ojcnCzzSD5MJcghbNho4Ksbg==
X-Received: by 2002:adf:8150:: with SMTP id 74mr1558824wrm.114.1575325709070;
        Mon, 02 Dec 2019 14:28:29 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id o21sm835335wmc.17.2019.12.02.14.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 14:28:28 -0800 (PST)
Date:   Mon, 2 Dec 2019 22:28:27 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/memory-failure.c: not necessary to recalculate
 hpage
Message-ID: <20191202222827.isaelnqmuyn7zrns@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20191118082003.26240-1-richardw.yang@linux.intel.com>
 <20191118082003.26240-2-richardw.yang@linux.intel.com>
 <fdba31c8-d0c0-83a8-62d1-c04c1e894218@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdba31c8-d0c0-83a8-62d1-c04c1e894218@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 04:07:38PM +0100, David Hildenbrand wrote:
>On 18.11.19 09:20, Wei Yang wrote:
>> hpage is not changed.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>   mm/memory-failure.c | 1 -
>>   1 file changed, 1 deletion(-)
>> 
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 392ac277b17d..9784f4339ae7 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1319,7 +1319,6 @@ int memory_failure(unsigned long pfn, int flags)
>>   		}
>>   		unlock_page(p);
>>   		VM_BUG_ON_PAGE(!page_count(p), p);
>> -		hpage = compound_head(p);
>>   	}
>>   	/*
>> 
>
>I am *absolutely* no transparent huge page expert (sorry :) ), but won't the
>split_huge_page(p) eventually split the compound page, such that
>compound_head(p) will return something else after that call?
>

Hi, David

Took sometime to look into the code and re-think about it. Found maybe we can
simplify this in another way.

First, code touches here means split_huge_page() succeeds and "p" is now a PTE
page. So compound_head(p) == p.

Then let's look at who will use hpage in the following function. There are two
uses in current upstream:

    * page_flags calculation
    * hwpoison_user_mappings()

The first one would be removed in next patch since PageHuge is handled at the
beginning.

And in the second place, comment says if split succeeds, hpage points to page
"p".

After all, we don't need to re-calculate hpage after split, and just replace
hpage in hwpoison_user_mappings() with p is enough.

>-- 
>
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

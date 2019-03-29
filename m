Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305EAC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00902218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zWOUKifR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfC2QPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:15:37 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35635 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfC2QPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:15:37 -0400
Received: by mail-it1-f196.google.com with SMTP id w15so4780751itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=33CxlXQHXC0S6M1Uolu/19/3Ah7FDE+HyfACUH2HypU=;
        b=zWOUKifRuq6P8xB/UQHw4IcqIBl8TGZWNSQspjG7UXFAorSLBj9U4yP0173xjK64UT
         otIq83PhZlKOv2iFAckaiMTdrUgjkEIlX9xwNYl+ACeamXDGfMGX3uxtwSRblX9iXkXu
         lnTahK2C3uQg6g19WtfMWKCQAG0YA/cx0QiiJSRxW3Ejglk+wZTCf14XyB4BnG8CswAM
         paZwvgzOYjmaiEHIK01VcUcvBuKls5S8XAIergYBfAtcTKHJpSgeoZNU2TGM5ImFVi0v
         w94ZPf12WihqoFennzhsGivEgrYXfbHfVZa95K6r8nYPE2NUsCbFwOiGqzuxALHZp5u4
         nY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=33CxlXQHXC0S6M1Uolu/19/3Ah7FDE+HyfACUH2HypU=;
        b=qoetNnm8CQF9PM0Icc+pIEsV2eP1x2mlxnR6sUQdYji9Zeo7yMGdwmktZWqTLi0VQW
         xbISfNhxzC8BYeGPPl35Iku3er/puLCOGDsnwWL4kjNsALBYp25Wb8/K2qtyGC3AhTjk
         YbI7eviddMk/pK1vRnk+L8gylePK+V4AaCcCyP3aDbPCvKnTdNaQnnkfLN/7BaB2mSTD
         /mrQn6+Wsqx8EBwPuO0aLPcl8/pBYDIXIATu+0+zj6y5I5ucPi2Vx5dlVIEx7GpYbU1q
         fN9cr373tQfVJr0nyyVVblAaFUwzLwIGczXhWtSIrADQcr1JmVurdnTJvcQ8PZAjL6wo
         k7MQ==
X-Gm-Message-State: APjAAAWxZHcyGWylh3S/mQgVNTWJuyVWhid6wbdKKiVIszyZGm0zI/al
        VJcFN9WPoE4+f/73DQ5uSR70+l1iepT+fQ==
X-Google-Smtp-Source: APXvYqy131RiI5afWzKJi0E6wSTIfRafb7CgdWXhPzy5IcWahZwUpe/hYUQ2ASYpUrMCZq+lzRateg==
X-Received: by 2002:a02:b008:: with SMTP id p8mr35973604jah.90.1553876135956;
        Fri, 29 Mar 2019 09:15:35 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id p18sm1224758itp.10.2019.03.29.09.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:15:34 -0700 (PDT)
Subject: Re: [PATCH] block/bfq: fix ifdef for CONFIG_BFQ_GROUP_IOSCHED=y
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
References: <155386807826.3190.16175453392005064129.stgit@buzz>
 <c40b8d4a-c504-fdf4-0b96-64aaeb167435@applied-asynchrony.com>
 <5234a971-2b6a-47b1-0071-8f3bd07d9fc3@kernel.dk>
 <cf0dc6b2-6ecf-c895-6c21-8746700bdae4@applied-asynchrony.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6be15f08-dbb4-6b43-3d95-44044f1acdbc@kernel.dk>
Date:   Fri, 29 Mar 2019 10:15:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cf0dc6b2-6ecf-c895-6c21-8746700bdae4@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 10:12 AM, Holger Hoffstätte wrote:
> On 3/29/19 4:58 PM, Jens Axboe wrote:
>> On 3/29/19 9:56 AM, Holger Hoffstätte wrote:
>>> On 3/29/19 3:01 PM, Konstantin Khlebnikov wrote:
>>>> Replace BFQ_GROUP_IOSCHED_ENABLED with CONFIG_BFQ_GROUP_IOSCHED.
>>>> Code under these ifdefs never worked, something might be broken.
>>>>
>>>> Fixes: 0471559c2fbd ("block, bfq: add/remove entity weights correctly")
>>>> Fixes: 73d58118498b ("block, bfq: consider also ioprio classes in symmetry detection")
>>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>>> ---
>>>>    block/bfq-iosched.c |    2 +-
>>>>    block/bfq-wf2q.c    |    2 +-
>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>> index 4c592496a16a..fac188dd78fa 100644
>>>> --- a/block/bfq-iosched.c
>>>> +++ b/block/bfq-iosched.c
>>>> @@ -674,7 +674,7 @@ static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
>>>>    	 * at least two nodes.
>>>>    	 */
>>>>    	return !(varied_queue_weights || multiple_classes_busy
>>>> -#ifdef BFQ_GROUP_IOSCHED_ENABLED
>>>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>>>    	       || bfqd->num_groups_with_pending_reqs > 0
>>>>    #endif
>>>>    		);
>>>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>>>> index 63311d1ff1ed..a11bef75483d 100644
>>>> --- a/block/bfq-wf2q.c
>>>> +++ b/block/bfq-wf2q.c
>>>> @@ -1012,7 +1012,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
>>>>    		entity->on_st = true;
>>>>    	}
>>>>    
>>>> -#ifdef BFQ_GROUP_IOSCHED_ENABLED
>>>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>>>    	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
>>>>    		struct bfq_group *bfqg =
>>>>    			container_of(entity, struct bfq_group, entity);
>>>>
>>>>
>>>
>>> Good catch! I run without group scheduling and therefore didn't notice these
>>> stray defines earlier. For 5.1 it should merge cleanly; adding this on top of
>>> the pending 5.2 BFQ patches required a small context fixup in hunk #1 due to
>>> "block, bfq: do not idle for lowest-weight queues".
>>
>> I'm hesitant to apply this, since the group scheduling stuff has obviously never
>> been tested.
> 
> This is simply a regression in 5.1 caused by 73d58118498b - nothing else,
> and as such this fix needs to go into 5.1 as well. I'm sure Paolo will agree.
> What you so ominously  call "the group scheduling stuff" has been there and
> shipping in mainline since day 1 of the BFQ merge, and it works fine in 5.0.

If that's the case (I didn't check how far back it went), then yes, it should
of course go into 5.1.

The ominous nature of my reply I'll chalk up to your interpretation

-- 
Jens Axboe


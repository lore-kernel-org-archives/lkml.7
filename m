Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5C6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81699218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 07:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWDfwo1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfC3H6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:58:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52070 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfC3H6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 03:58:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so4780432wmf.1;
        Sat, 30 Mar 2019 00:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCZI3GRmOYbCqRvIGi3XJe8r+zVw9MkB0uujbMoC2iU=;
        b=TWDfwo1qd0lNl8srnZdAhSqwVQPLNfD9kjFKljiRdJNP5QwuNVomgP+Ha0WigZ6FBY
         9PSIChWYARlnCElR87DkLi7DwvllVHwSR6E52RlG1+17hQPfnSOkPKb6lL5LdMbBeWe0
         ufl1jDvLm3M+M6efUxeeQdEooxnYVkXLDvedTonHsLRK5kT7tgVJnTPlvQXeKJrhduzT
         i4LCGGKNwrA0qwyTIr8zkqjV16dFP5brDGUxh4ZIsJ6lTZwKMIrLqjcOKZar9Kmv+9sc
         2U/kT9+rfx5UYoY0XH0cAU00BOsSHtPreHcatEqzM1ERluDUXeemUL8ytWDlkV4EJ3Vq
         wsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCZI3GRmOYbCqRvIGi3XJe8r+zVw9MkB0uujbMoC2iU=;
        b=tY2AXrxfxOY2q1tZsFPzHLCvOwvTCdemyyhMxQ2b01O1au5ZAp5jGNwmZRMOSqXh0z
         l9IumhcC9U4Qljb4gPYCXs6j7q5qYzcGmiFAgTVI6SqznTV5DuIN4481TaIqj+T1GQlC
         nxLaIxPH4T8nBNiE+TZ/OSoOqNmETRHp0cNKPdNfRZA03ejBwRIxtm5mLZiWBBExGO5w
         0Bz7BeAhdMMBFaLVYBiF/NOUjGyqyxhgRdBEMjctzqF/E7wqIrhoOAWQMvMTfzdGwD7m
         MzRTDRrhmBunsHXKTIMsd0d1l1xztDu9fTFIgvCOZtm4yH3NmiMRvXoNI0hFGRax79VF
         yxEg==
X-Gm-Message-State: APjAAAUZdboTMU5JWRrxHI2rRN5j7b5IE3reJucZIfo3LBZyx+IqBsdY
        y1gi8SwiWKeY1DTjrJ4z4sk=
X-Google-Smtp-Source: APXvYqyitWqbIwgEYbCNEbkJjGPux1Aox+7cr5mqQhdyZxi88EH9HplN0sso7ApSGmc8Zw8Ys+DRUQ==
X-Received: by 2002:a1c:208c:: with SMTP id g134mr437732wmg.70.1553932678876;
        Sat, 30 Mar 2019 00:57:58 -0700 (PDT)
Received: from [192.168.8.147] (58.85.136.77.rev.sfr.net. [77.136.85.58])
        by smtp.gmail.com with ESMTPSA id v16sm8545787wro.48.2019.03.30.00.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 00:57:58 -0700 (PDT)
Subject: Re: [PATCH net] ipv6: Fix dangling pointer when ipv6 fragment
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     hujunwei <hujunwei4@huawei.com>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mingfangsen@huawei.com, liuzhiqiang26@huawei.com,
        zhangwenhao8@huawei.com
References: <cbbedd1f-3e99-85f7-86d7-d02a86d59c29@huawei.com>
 <ee0fb75b-f976-02ae-31e3-c3f957f71923@gmail.com>
Message-ID: <a277b9c7-22e0-3763-89e5-504514d2e9b0@gmail.com>
Date:   Sat, 30 Mar 2019 00:57:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ee0fb75b-f976-02ae-31e3-c3f957f71923@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/30/2019 12:48 AM, Eric Dumazet wrote:
> 
> 
> On 03/30/2019 12:29 AM, hujunwei wrote:
>> From: Junwei Hu <hujunwei4@huawei.com>
>>
>> At the beginning of ip6_fragment func, the prevhdr pointer is
>> obtained in the ip6_find_1stfragopt func.
>> However, all the pointers pointing into skb header may change
>> when calling skb_checksum_help func with
>> skb->ip_summed = CHECKSUM_PARTIAL condition.
>> The prevhdr pointe will be dangling if it is not reloaded after
>> calling __skb_linearize func in skb_checksum_help func.
>>
>> Here, I add a variable, nexthdr_offset, to evaluate the offset,
>> which does not changes even after calling __skb_linearize func.
>>

...

>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>> index edbd12067170..6db3c60b3b66 100644
>> --- a/net/ipv6/ip6_output.c
>> +++ b/net/ipv6/ip6_output.c
>> @@ -606,12 +606,14 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>>      __be32 frag_id;
>>      int ptr, offset = 0, err = 0;
>>      u8 *prevhdr, nexthdr = 0;
>> +    u8 nexthdr_offset;

Why u8 here ?

I would use "unsigned int" really.

>>  
>>      err = ip6_find_1stfragopt(skb, &prevhdr);
>>      if (err < 0)
>>          goto fail;
>>      hlen = err;
>>      nexthdr = *prevhdr;
>> +    nexthdr_offset = prevhdr - skb_network_header(skb);
>>  
>>      mtu = ip6_skb_dst_mtu(skb);
>>  
>> @@ -646,6 +648,8 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>>          (err = skb_checksum_help(skb)))
>>          goto fail;
>>  
>> +    prevhdr = skb_network_header(skb) + nexthdr_offset;
>> +
>>      hroom = LL_RESERVED_SPACE(rt->dst.dev);
>>      if (skb_has_frag_list(skb)) {
>>          unsigned int first_len = skb_pagelen(skb);
>>

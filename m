Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE5AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA452146F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ICIRHd/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbfCZRPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:15:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38904 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbfCZRPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:15:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id q14so11471038edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a0b+jEDaYUKFlK2xlIumFqar0A/dWTq/8tFGUIUTDzk=;
        b=ICIRHd/7tq+2lB1FJKzbUGHGSwwnT+136K1zVGRqMHaBQ7ajBVB/OyXqWAGlx8P20H
         UZCdAdmczaCnjqT7Z1MtLL1hB01Diku5RDwfVxISGMvKVOrmYnxKORZPCa8Mwbf97Ku/
         EvUPgNDmmvcphBDyDCuzeBEpwQtQRGeN14kg2JsuCHRLWTuk6xKWHJfJGMIjtVCE86Aq
         6oOXjwunhtwDLNabgVuj0hyRH70ilR+/2l8Ew5Ldt/2xbx1C3i0vgmvNWCnwO9jme80y
         C+PTR8pyeSYdt5i0PgqIuIaYG4eFZUyAwgFrJOhvbcHgRB1oWsKdaiF/4L7x4pHs0iJK
         oBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a0b+jEDaYUKFlK2xlIumFqar0A/dWTq/8tFGUIUTDzk=;
        b=Z6qTdsaj+SUujyiMtS7wlje75UsmH0kvMODCMvM+Gd2YZv5G1QrN1JZyp5rCqLHX+h
         +qnpLXOtp1uAlturhykJSZ47PgbHFkE7pAW4m4lumkgvFNUcsBxFvBmZUdga9KXPapSK
         gfI5bJfwb9NAR/iyFACAJn+EAyA5hxhcTMusBT7EwHim9RvvX5A02t6hdtrWZmma5g5k
         PuEzV/mpsov5P3AW0Sbo01zX0xu3m4KhWQhE++O9QCxOw8ZD/EpOE3rhXVy3vYlfD0Xk
         8L/+1nGt3KrWn93d3wzWfm4o4NV7MwUmcVK6XUSW12K9H1cI7Bh0+8Txt8/bLTg8AlEh
         xBwg==
X-Gm-Message-State: APjAAAUjWyR8jFryguiGFEWm6mA3g1wf8465rRWM3b4On7dYjWdZaOy6
        c0e1W7MpZJbP0LbxKFt4HfG2gQ==
X-Google-Smtp-Source: APXvYqx4HT9ghBfyed+pRTjfLRhuj/69mK4QchTMldAkT6rFrT6Dp1WzCSQgBXGtqIcIzOQzC4p01Q==
X-Received: by 2002:a17:906:678a:: with SMTP id q10mr17725031ejp.156.1553620547324;
        Tue, 26 Mar 2019 10:15:47 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z51sm6657709edb.9.2019.03.26.10.15.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:15:46 -0700 (PDT)
Subject: Re: [RFC 4/4] net/ipv4/fib: Don't synchronise_rcu() every 512Kb
To:     David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
References: <20190326153026.24493-1-dima@arista.com>
 <20190326153026.24493-5-dima@arista.com>
 <2f911647-f35f-13c2-8177-2fb93147b0fa@gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <bd638730-e23a-3d08-bd35-9c80af13692b@arista.com>
Date:   Tue, 26 Mar 2019 17:15:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <2f911647-f35f-13c2-8177-2fb93147b0fa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 3/26/19 3:39 PM, David Ahern wrote:
> On 3/26/19 9:30 AM, Dmitry Safonov wrote:
>> Fib trie has a hard-coded sync_pages limit to call synchronise_rcu().
>> The limit is 128 pages or 512Kb (considering common case with 4Kb
>> pages).
>>
>> Unfortunately, at Arista we have use-scenarios with full view software
>> forwarding. At the scale of 100K and more routes even on 2 core boxes
>> the hard-coded limit starts actively shooting in the leg: lockup
>> detector notices that rtnl_lock is held for seconds.
>> First reason is previously broken MAX_WORK, that didn't limit pending
>> balancing work. While fixing it, I've noticed that the bottle-neck is
>> actually in the number of synchronise_rcu() calls.
>>
>> I've tried to fix it with a patch to decrement number of tnodes in rcu
>> callback, but it hasn't much affected performance.
>>
>> One possible way to "fix" it - provide another sysctl to control
>> sync_pages, but in my POV it's nasty - exposing another realisation
>> detail into user-space.
> 
> well, that was accepted last week. ;-)
> 
> commit 9ab948a91b2c2abc8e82845c0e61f4b1683e3a4f
> Author: David Ahern <dsahern@gmail.com>
> Date:   Wed Mar 20 09:18:59 2019 -0700
> 
>     ipv4: Allow amount of dirty memory from fib resizing to be controllable
> 
> 
> Can you see how that change (should backport easily) affects your test
> case? From my perspective 16MB was the sweet spot.

Heh, I based on master, so haven't seen it yet.

I still wonder if it's good to expose it to userspace rather than
shrinker, but this probably should work for me - I'll test it in near days.

Thanks,
          Dmitry

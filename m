Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C6DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734E92087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="QKFMCMc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbfCZXOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:14:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34420 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732358AbfCZXOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:14:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id x14so9692124eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d84bwUp3ZXG6cl6ZofwM+Css3+fMaYMH7du3vY7BvhM=;
        b=QKFMCMc7n8aetBJRhJXlaatbe91KdUN+eWJQyASACRXx2HryyEKIxi9Flr5WSmda7M
         P0Ya4yyHuzLRhAnNIjOcXZkCUNyQ4IOdDZTK41kPyJV6TWvxmGRM81Fw/3UNCcw2no3F
         1rEaJs+TJC1srFqrK7vr2wMOKzbWikSenOR/fJQL+PJMKQZPFxOyIuEEjmx+JKuEbjkC
         CH4SPWOsqdNxKlE7lMvDlZzmGZyj2RbwxX9N5ylyUJmD+ZR7m3Es1ESuPFFDtobvR7qm
         o7X5993WiFEz/5RF3s2ylhcalFMx5FCUZmCNnWzBmFXimkXfvmzady6EftqskA7TvxSE
         tIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d84bwUp3ZXG6cl6ZofwM+Css3+fMaYMH7du3vY7BvhM=;
        b=a89PKHb1tNnqrKuCyMtrAJe1JC6cRcap0Tx9gBTz47+6d/GIjrTIQyBbetWoetqmmt
         3cxDf0bf1t2gwq9ERme9a53Mv8wTKFeJDDTqSG9MEyfCBdMPJdr1kBObGkYqw+w5Sd/i
         /r6K1hmXiMvPo9L2gokOv59dtmXTOokh9Sg9ZeUwLXtTAwNboolsnihULtKl4rrOkUXI
         u/sJwk+SWy4LPcC2kFZyP10mpmfiHOZZwTuomoeIeO/Usn18mjvwkzJhy6dUZ9PDJi5x
         JayMGg6zaorgJlIJJbDG5SHuK7N2FR1pYvvPkSkMeR5fZWIBFZbcrHtDAtEjNZd4vfVh
         jxgA==
X-Gm-Message-State: APjAAAU2J5Evv1KapwjspGTbSG9SqVaiGmCYroI5ajeH+t7Bwyy8UZEN
        UkUElKOGi+n/3PiBqyyaSF2ZeA==
X-Google-Smtp-Source: APXvYqzWSvomHNbLNmc/+ajcySkMQ8qQlLkWl+v1JoB8I8Jg4CNVWW0LPYI4IL1ccR3VMQSj758QJQ==
X-Received: by 2002:a17:906:5a94:: with SMTP id l20mr6314002ejq.131.1553642085782;
        Tue, 26 Mar 2019 16:14:45 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm3183114ejb.48.2019.03.26.16.14.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 16:14:45 -0700 (PDT)
Subject: Re: [RFC 4/4] net/ipv4/fib: Don't synchronise_rcu() every 512Kb
To:     David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
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
Message-ID: <d77c86d7-23da-c301-4443-08e9988ac801@arista.com>
Date:   Tue, 26 Mar 2019 23:14:43 +0000
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

FWIW, I would like to +Cc Paul here.

TLDR; we're looking with David into ways to improve a hardcoded limit
tnode_free_size at net/ipv4/fib_trie.c: currently it's way too low
(512Kb). David created a patch to provide sysctl that controls the limit
and it would solve a problem for both of us. In parallel, I thought that
exposing this to userspace is not much fun and added a shrinker with
synchronize_rcu(). I'm not any sure that the latter is actually a sane
solution..
Is there any guarantee that memory to-be freed by call_rcu() will get
freed in OOM conditions? Might there be a chance that we don't need any
limit here at all?

Worth to mention that I don't argue David's patch as I pointed that it
would (will) solve the problem for us both, but with good intentions
wondering if we can do something here rather a new sysctl knob.

Thanks,
          Dmitry

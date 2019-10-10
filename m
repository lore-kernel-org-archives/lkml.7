Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC11C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54D220673
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="rSmaGNAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbfJJMNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:13:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43233 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfJJMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:13:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id j18so7578946wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 05:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6Ckrng1slxxgw7k9+g6ZDnyjO/oujkV3iG+tQzlzzEw=;
        b=rSmaGNAcBx9tQMAeBLNdW+AAF/xnZwnH8TfhPR0yX2IkfK+k3uHA5qaBKRO6tLUWzR
         ekRzQRWrOWOw+rdYv7zlqBuIKMoKV6u4RvXjQ3Y56do4ZeivYBoFHirpWjQ+y39YFsuV
         nNMmtNphD5sHMUQV1C47RX+DwPLefu8w+e4A18ow7y5lu3saC2uUljrKR2CQr80LESgk
         j28X7UBmHWYYbfr+OTWkd8TDt3YIbn+xb2PYgCD7oWwwNrWI5skRk8Vgy8wqdBeW8Etn
         erHIWKsWHeyw8pgmeMJvGWBGkN8C+O1tY/jj7Qn0tK1Qk/U71Vnu0owUH3EDlAAseetg
         fvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6Ckrng1slxxgw7k9+g6ZDnyjO/oujkV3iG+tQzlzzEw=;
        b=MsQiIbts6oJ+p6kvieiaEno0Pn7YPxtF8B+x15P16blhqiJSBLrEW1Yiv5jM5UrMaK
         /cNwk4dH4fU3Z21vyvn3th/Ze796G2Go1At8ARsrjwe/LBlcbW7OD1qG3X1/0JgxrBzf
         AY2ffgE8MGnZBiRU4X1W+ju3ItFd7dzK84+AW4la4yHLsfAh35Xpah8vofZwnobBfzHJ
         AucHnVC1lGWMgmWnm8xY2mlX46KWu92advg5xnWgqsWKdfVpjYywhGCz35CtB8z25oZK
         f9ypEYTDA+hqeeYD1vayayFDBi261yT3bbuCXXAfgprjdOhCYb3QppivsZx96ppU3jlO
         WXYA==
X-Gm-Message-State: APjAAAUN++SdOknennzUBiTtsyMMddnpFQYJyicj1z8EPDOoqZ8UbYwU
        5DZhLqB7CKbNG0mAbl1cP3Ajtr4ObyM=
X-Google-Smtp-Source: APXvYqyph73mdjjj0ea5M4gItxQTL18i7o5j9sKQRSlphECLkfHpdLNbYbTO4ebUhN8e0lvy8Vq7sQ==
X-Received: by 2002:adf:ff8e:: with SMTP id j14mr8418168wrr.178.1570709628716;
        Thu, 10 Oct 2019 05:13:48 -0700 (PDT)
Received: from linux.fritz.box (p200300D99706140077538680B964812D.dip0.t-ipconnect.de. [2003:d9:9706:1400:7753:8680:b964:812d])
        by smtp.googlemail.com with ESMTPSA id x2sm6359495wrn.81.2019.10.10.05.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 05:13:47 -0700 (PDT)
Subject: Re: wake_q memory ordering
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        1vier1@web.de, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <990690aa-8281-41da-4a46-99bb8f9fec31@colorfullife.com>
 <20191010114244.GS2311@hirez.programming.kicks-ass.net>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <7af22b09-2ab9-78c9-3027-8281f020e2e8@colorfullife.com>
Date:   Thu, 10 Oct 2019 14:13:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191010114244.GS2311@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/10/19 1:42 PM, Peter Zijlstra wrote:
> On Thu, Oct 10, 2019 at 12:41:11PM +0200, Manfred Spraul wrote:
>> Hi,
>>
>> Waiman Long noticed that the memory barriers in sem_lock() are not really
>> documented, and while adding documentation, I ended up with one case where
>> I'm not certain about the wake_q code:
>>
>> Questions:
>> - Does smp_mb__before_atomic() + a (failed) cmpxchg_relaxed provide an
>>    ordering guarantee?
> Yep. Either the atomic instruction implies ordering (eg. x86 LOCK
> prefix) or it doesn't (most RISC LL/SC), if it does,
> smp_mb__{before,after}_atomic() are a NO-OP and the ordering is
> unconditinoal, if it does not, then smp_mb__{before,after}_atomic() are
> unconditional barriers.

And _relaxed() differs from "normal" cmpxchg only for LL/SC 
architectures, correct?

Therefore smp_mb__{before,after}_atomic() may be combined with 
cmpxchg_relaxed, to form a full memory barrier, on all archs.

[...]


>> - Is it ok that wake_up_q just writes wake_q->next, shouldn't
>>    smp_store_acquire() be used? I.e.: guarantee that wake_up_process()
>>    happens after cmpxchg_relaxed(), assuming that a failed cmpxchg_relaxed
>>    provides any ordering.
> There is no such thing as store_acquire, it is either load_acquire or
> store_release. But just like how we can write load-aquire like
> load+smp_mb(), so too I suppose we could write store-acquire like
> store+smp_mb(), and that is exactly what is there (through the implied
> barrier of wake_up_process()).

Thanks for confirming my assumption:
The code is correct, due to the implied barrier inside wake_up_process().

[...]
>> rewritten:
>>
>> start condition: A = 1; B = 0;
>>
>> CPU1:
>>      B = 1;
>>      RELEASE, unlock LockX;
>>
>> CPU2:
>>      lock LockX, ACQUIRE
>>      if (LOAD A == 1) return; /* using cmp_xchg_relaxed */
>>
>> CPU2:
>>      A = 0;
>>      ACQUIRE, lock LockY
>>      smp_mb__after_spinlock();
>>      READ B
>>
>> Question: is A = 1, B = 0 possible?
> Your example is incomplete (there is no A=1 assignment for example), but
> I'm thinking I can guess where that should go given the earlier text.

A=1 is listed as start condition. Way before, someone did wake_q_add().


> I don't think this is broken.

Thanks.

--

     Manfred


Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACB8C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864F720854
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDgJNdqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfDTOu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 10:50:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45381 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfDTOuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 10:50:25 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so3835106plb.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 07:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7s5itnY6mOuvJWl4u4VhapM21N3eVJpheX2Q1kgGAZY=;
        b=VDgJNdqMWeMbrJPASbO4WUpnb97RjVhFev54fDMhvL7ex/s0YQZ1mzhAz3XpQ5sd1L
         L5CfosPWdovJIss/LtHVOhRNj5P1zNdpRjtEwdjgth9Hb93OEuJdP2SP8kCrYiZ608GC
         ZYhCMvm00V87FtUKfg0v66DR8etSJhAFEBoArB1BHyc5oIh6tX6JvZyMxlVZE41X1BYl
         /3HDBcXYDWpQmTYOUavh6hm8Gs1UL5SOqctvKivi/zdW4NICkijew+GYneARGAoLVTEX
         2gw9dNrwlzFXrDZkWJ9dcaxzsQsaVVls8Bm/0NoJ8MrH+Rd/ylH6AD/6J0QU5iqO/Nes
         af1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7s5itnY6mOuvJWl4u4VhapM21N3eVJpheX2Q1kgGAZY=;
        b=Z18p+hVl022L2alSy6Cuxqh7sHbvU5SMZ7JD/zrhFisHnCR+mQpTofgye/2pUXcXL2
         RBMm+gxSajkRt9kBfxNdEH6T3L4ZWP3ecqNy+kr+0zNRQdJ8Lx9nOTKfO5d8Akt3q+vI
         11Q2BUALdMeD/qaF6gTPiNpQr/k+U/f1kkVK8Q/jT534YsBIj0YrUhd0LurY2c4PI6iT
         QftevdwCj6d9SH2dH6xuBbGoUUM097gpcS44lIggLvhfmGiCxa4RAGt/MFY8XK0yO+/0
         DXnN/yKyXAXryIgCmp/PVfy7WQvkU4fX72stAIKe0nwcDJwxKCkBT5VEy2hOy/13On4D
         1qhA==
X-Gm-Message-State: APjAAAUCtOE7Nl5XbxzDfvSXRMqG9xQwC4kt0myn3G55TkaZQtRyT9Q6
        fmxcfx1Tb9iI9Rh3vELgBwM=
X-Google-Smtp-Source: APXvYqxRp9TSDboAVQI8xznkLrmz8NXDATrYaB962SjRKBX8p9bI201OVcEOptVdbpBFVTDYEwQv/w==
X-Received: by 2002:a17:902:e48c:: with SMTP id cj12mr9673090plb.93.1555771824762;
        Sat, 20 Apr 2019 07:50:24 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i2sm11575508pfo.9.2019.04.20.07.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 07:50:23 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: Adding plain accesses and detecting data races in the LKMM
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Kroening <kroening@cs.ox.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20190418125412.GA10817@andrea>
 <Pine.LNX.4.44L0.1904181324420.1303-100000@iolanthe.rowland.org>
 <20190419005302.GA5311@andrea> <20190419124720.GU14111@linux.ibm.com>
 <2827195a-f203-b9cd-444d-cf6425cef06f@gmail.com>
 <20190419180641.GD14111@linux.ibm.com>
Message-ID: <516794a4-7a3c-4a82-6e45-de650a02a1de@gmail.com>
Date:   Sat, 20 Apr 2019 23:50:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419180641.GD14111@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 11:06:41 -0700, Paul E. McKenney wrote:
> On Sat, Apr 20, 2019 at 12:06:58AM +0900, Akira Yokosawa wrote:
>> Hi Paul,
>>
[...]
> 
>>> +     (1) The compiler can reorder the load from a to precede the
>>> +     atomic_dec(), (2) Because x86 smp_mb__before_atomic() is only a
>>> +     compiler barrier, the CPU can reorder the preceding store to
>>> +     obj->dead with the later load from a.
>>> +
>>> +     This could be avoided by using READ_ONCE(), which would prevent the
>>> +     compiler from reordering due to both atomic_dec() and READ_ONCE()
>>> +     being volatile accesses, and is usually preferable for loads from
>>> +     shared variables.  However, weakly ordered CPUs would still be
>>> +     free to reorder the atomic_dec() with the load from a, so a more
>>> +     readable option is to also use smp_mb__after_atomic() as follows:
>>
>> The point here is not just "readability", but also the portability of the
>> code, isn't it?
> 
> As Andrea noted, in this particular case, the guarantee that the
> store to obj->dead precedes the load from x is portable.  Either the
> smp_mb__before_atomic() or the atomic_dec() must provide the ordering.

I think I understood this. What I wanted to say was the code for x86 implied
in the subjunctive sentence:

	obj->dead = 1;
	smp_mb__before_atomic();
	atomic_dec(&obj->ref_count);
	r1 = READ_ONCE(x);

, which was not spelled out, is not portable if we expect the ordering of
atomic_dec() with READ_ONCE().

> However, you are right that there is some non-portability.  But this
> non-portability involves the order of the atomic_dec() and the store to x.

Yes, you've guessed it right.

> 
> So what I did was ...
> 
>>         Thanks, Akira
>>
>>> +
>>> +	WRITE_ONCE(obj->dead, 1);
>>> +	smp_mb__before_atomic();
>>> +	atomic_dec(&obj->ref_count);
>>> +	smp_mb__after_atomic();
>>> +	r1 = READ_ONCE(a);
>>> +
>>> +     This orders all three accesses against each other, and also makes
>>> +     the intent quite clear.
> 
> ... change the above paragraph to read as follows:
> 
>      In addition, the example without the smp_mb__after_atomic() does
>      not necessarily order the atomic_dec() with the load from x.
>      In contrast, the example with both smp_mb__before_atomic() and
>      smp_mb__after_atomic() orders all three accesses against each other,
>      and also makes the intent quite clear.
> 
> Does that help?

This looks a little bit redundant to me. The original one is clear
enough.

How about editing the leading sentence above:

>>> +     shared variables.  However, weakly ordered CPUs would still be
>>> +     free to reorder the atomic_dec() with the load from a, so a more
>>> +     readable option is to also use smp_mb__after_atomic() as follows:

to read as follows?

     shared variables.  However, weakly ordered CPUs would still be
     free to reorder the atomic_dec() with the load from x, so a
     portable and more readable option is to also use
     smp_mb__after_atomic() as follows:

Obviously, the interesting discussion going on in another thread will
surely affect this patch.

        Thanks, Akira

> 
> 							Thanx, Paul
> 
>>>       See Documentation/atomic_{t,bitops}.txt for more information.
>>>  
>>> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
>>> index 8dcb37835b61..b6866f93abb8 100644
>>> --- a/tools/memory-model/linux-kernel.cat
>>> +++ b/tools/memory-model/linux-kernel.cat
>>> @@ -28,8 +28,8 @@ include "lock.cat"
>>>  let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
>>>  let wmb = [W] ; fencerel(Wmb) ; [W]
>>>  let mb = ([M] ; fencerel(Mb) ; [M]) |
>>> -	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
>>> -	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
>>> +	([M] ; fencerel(Before-atomic) ; [RMW]) |
>>> +	([RMW] ; fencerel(After-atomic) ; [M]) |
>>>  	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
>>>  	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
>>>  		fencerel(After-unlock-lock) ; [M])
>>>
>>
> 


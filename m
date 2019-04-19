Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFB0C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D18120693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7CpAlSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfDSTXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:23:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39123 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfDSTXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:23:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id l18so2904153pgj.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q1XRVA4nLkhNb8zUiVD2/rCzk+v6r90PnPMQLr5/wys=;
        b=o7CpAlSnFRpI6mH9Q3yHc2iQrXLjlKwKyAwY3T8ncm5tVTu4dLOFlCdgIdxA6owgTw
         YWy/fGUWUsbc1ORWx4E9QbHIvA62z8vvsgyf6+SAt2wnKr7uQfn3pPYYTUmM2RvH2CoN
         Lm/PXRXq4kAr6Azvk4qd9O7GPIti8a58sud4pH21uiFcVCshsf0ENibZhPovFzZqP/5n
         O0E5tzEX6KJrvLN6TK4qfa2V2zZnz7JKvGhnu7lGh570fzYNiFCuYvriGLZa+FbzEjhc
         DDTJXsStXheex+YzxkFT+5ElkMy+RIT3DExIV7AbCxnY6jbUgWh5pIzkeS8sQOA5u6f/
         uzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q1XRVA4nLkhNb8zUiVD2/rCzk+v6r90PnPMQLr5/wys=;
        b=F0U6V36ATSHewTVul44aNDD1lcUPWX4if+YZs6PbNW5+JCDrw6Pdqgrvipg/5CC8Lf
         An5oDDCZPASoNzYJwgtY9CqRHWybut8V5GjgI7NZ9UMsvb/eIqzKW8KsRYCzA41MDEZq
         smhWBv2HwJzZWjij3MQefqq7+oA4jIl2czs+1qHgfRqtmB9GC3s8cT8Arm9/gdBz4P8N
         /Rg8lCeMDrpiYUO98LrZLBhnPl86AD30XYk5FwpgH0O0sSzizyvYnayftjNi/sKdP8sw
         y4XMkxggTr9p/hTg0is8GsKskrPEqt40ZT3Z+IPflNx6CrOs6tX47uDzegLu/c7+Rli/
         kflA==
X-Gm-Message-State: APjAAAVswa6625x4NuhWArQyekmV1EDRe/mi8ruuAuF2EAQJu146iKZ7
        XLEsi0R6TYaspDEjYrXVE0ZyD1ot
X-Google-Smtp-Source: APXvYqyjSkDdkTrWFVBwmDZ/D6DpdJXRctXrVQLe2rr241QlXe8wDjoFno4jRitxunqxqdD0nihFew==
X-Received: by 2002:aa7:8b4c:: with SMTP id i12mr4400901pfd.189.1555686427023;
        Fri, 19 Apr 2019 08:07:07 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l74sm9906273pfi.174.2019.04.19.08.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 08:07:06 -0700 (PDT)
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
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <2827195a-f203-b9cd-444d-cf6425cef06f@gmail.com>
Date:   Sat, 20 Apr 2019 00:06:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419124720.GU14111@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Please find inline comments below.

On Fri, 19 Apr 2019 05:47:20 -0700, Paul E. McKenney wrote:
> On Fri, Apr 19, 2019 at 02:53:02AM +0200, Andrea Parri wrote:
>>> Are you saying that on x86, atomic_inc() acts as a full memory barrier 
>>> but not as a compiler barrier, and vice versa for 
>>> smp_mb__after_atomic()?  Or that neither atomic_inc() nor 
>>> smp_mb__after_atomic() implements a full memory barrier?
>>
>> I'd say the former; AFAICT, these boil down to:
>>
>>   https://elixir.bootlin.com/linux/v5.1-rc5/source/arch/x86/include/asm/atomic.h#L95
>>   https://elixir.bootlin.com/linux/v5.1-rc5/source/arch/x86/include/asm/barrier.h#L84
> 
> OK, how about the following?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 19d166dadc4e1bba4b248fb46d32ca4f2d10896b
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Fri Apr 19 05:20:30 2019 -0700
> 
>     tools/memory-model: Make smp_mb__{before,after}_atomic() match x86
>     
>     Read-modify-write atomic operations that do not return values need not
>     provide any ordering guarantees, and this means that both the compiler
>     and the CPU are free to reorder accesses across things like atomic_inc()
>     and atomic_dec().  The stronger systems such as x86 allow the compiler
>     to do the reordering, but prevent the CPU from so doing, and these
>     systems implement smp_mb__{before,after}_atomic() as compiler barriers.
>     The weaker systems such as Power allow both the compiler and the CPU
>     to reorder accesses across things like atomic_inc() and atomic_dec(),
>     and implement smp_mb__{before,after}_atomic() as full memory barriers.
>     
>     This means that smp_mb__before_atomic() only orders the atomic operation
>     itself with accesses preceding the smp_mb__before_atomic(), and does
>     not necessarily provide any ordering whatsoever against accesses
>     folowing the atomic operation.  Similarly, smp_mb__after_atomic()

s/folowing/following/

>     only orders the atomic operation itself with accesses following the
>     smp_mb__after_atomic(), and does not necessarily provide any ordering
>     whatsoever against accesses preceding the atomic operation.  Full ordering
>     therefore requires both an smp_mb__before_atomic() before the atomic
>     operation and an smp_mb__after_atomic() after the atomic operation.
>     
>     Therefore, linux-kernel.cat's current model of Before-atomic
>     and After-atomic is too strong, as it guarantees ordering of
>     accesses on the other side of the atomic operation from the
>     smp_mb__{before,after}_atomic().  This commit therefore weakens
>     the guarantee to match the semantics called out above.
>     
>     Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
>     Suggested-by: Alan Stern <stern@rowland.harvard.edu>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 169d938c0b53..e5b97c3e8e39 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1888,7 +1888,37 @@ There are some more advanced barrier functions:
>  	atomic_dec(&obj->ref_count);
>  
>       This makes sure that the death mark on the object is perceived to be set
> -     *before* the reference counter is decremented.
> +     *before* the reference counter is decremented.  However, please note
> +     that smp_mb__before_atomic()'s ordering guarantee does not necessarily
> +     extend beyond the atomic operation.  For example:
> +
> +	obj->dead = 1;
> +	smp_mb__before_atomic();
> +	atomic_dec(&obj->ref_count);
> +	r1 = a;
> +
> +     Here the store to obj->dead is not guaranteed to be ordered with
> +     with the load from a.  This reordering can happen on x86 as follows:

s/with//

And I beg you to avoid using the single letter variable "a".
It's confusing.

> +     (1) The compiler can reorder the load from a to precede the
> +     atomic_dec(), (2) Because x86 smp_mb__before_atomic() is only a
> +     compiler barrier, the CPU can reorder the preceding store to
> +     obj->dead with the later load from a.
> +
> +     This could be avoided by using READ_ONCE(), which would prevent the
> +     compiler from reordering due to both atomic_dec() and READ_ONCE()
> +     being volatile accesses, and is usually preferable for loads from
> +     shared variables.  However, weakly ordered CPUs would still be
> +     free to reorder the atomic_dec() with the load from a, so a more
> +     readable option is to also use smp_mb__after_atomic() as follows:

The point here is not just "readability", but also the portability of the
code, isn't it?

        Thanks, Akira

> +
> +	WRITE_ONCE(obj->dead, 1);
> +	smp_mb__before_atomic();
> +	atomic_dec(&obj->ref_count);
> +	smp_mb__after_atomic();
> +	r1 = READ_ONCE(a);
> +
> +     This orders all three accesses against each other, and also makes
> +     the intent quite clear.
>  
>       See Documentation/atomic_{t,bitops}.txt for more information.
>  
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 8dcb37835b61..b6866f93abb8 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -28,8 +28,8 @@ include "lock.cat"
>  let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
>  let wmb = [W] ; fencerel(Wmb) ; [W]
>  let mb = ([M] ; fencerel(Mb) ; [M]) |
> -	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> -	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> +	([M] ; fencerel(Before-atomic) ; [RMW]) |
> +	([RMW] ; fencerel(After-atomic) ; [M]) |
>  	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
>  	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
>  		fencerel(After-unlock-lock) ; [M])
> 


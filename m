Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7621DC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E030217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NicpxoL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfJNND2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:03:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56810 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfJNND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Tts3svB4M+OVZolTe//0r1xVhHKZwHlzhehV087qh4=; b=NicpxoL9+3EbUsIPy4VCG7tHN
        ha2jWRIsIH92DmCJg2X1xvrgY2fwA39qlK9HJansNbKtSUSb01vxhYEeWzh57GXqGeP9OCsWyId7L
        1Ii19wYbnJ9wsiLscRI4sPFsu4PYJu91SWg7ISnGuOU2+M6hn9FiNVYh/tBDOSLMe6OtZSia2SiWt
        kZEzvX3hLXtTk6sK/257fBydEO5Wgg5MgEp8tt3LRWrPCA/Z+t8B+vOCGImsC4D2nuTfdDMq4ripL
        3S81kJ7vfh8EuJDsTBsXr+UeGnWLLx4ZsjvFUN+QUdi1zy5M6DRQB9oAJ9JQUIqvwL39tpFUVaeQd
        SdLcHx2sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iK00R-0000aA-2u; Mon, 14 Oct 2019 13:03:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 461E430018A;
        Mon, 14 Oct 2019 15:02:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D7DA2829A4C9; Mon, 14 Oct 2019 15:03:21 +0200 (CEST)
Date:   Mon, 14 Oct 2019 15:03:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 6/6] Documentation/memory-barriers.txt: Clarify cmpxchg()
Message-ID: <20191014130321.GG2328@hirez.programming.kicks-ass.net>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-7-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012054958.3624-7-manfred@colorfullife.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 07:49:58AM +0200, Manfred Spraul wrote:
> The documentation in memory-barriers.txt claims that
> smp_mb__{before,after}_atomic() are for atomic ops that do not return a
> value.
> 
> This is misleading and doesn't match the example in atomic_t.txt,
> and e.g. smp_mb__before_atomic() may and is used together with
> cmpxchg_relaxed() in the wake_q code.
> 
> The purpose of e.g. smp_mb__before_atomic() is to "upgrade" a following
> RMW atomic operation to a full memory barrier.
> The return code of the atomic operation has no impact, so all of the
> following examples are valid:

The value return of atomic ops is relevant in so far that
(traditionally) all value returning atomic ops already implied full
barriers. That of course changed when we added
_release/_acquire/_relaxed variants.

> 
> 1)
> 	smp_mb__before_atomic();
> 	atomic_add();
> 
> 2)
> 	smp_mb__before_atomic();
> 	atomic_xchg_relaxed();
> 
> 3)
> 	smp_mb__before_atomic();
> 	atomic_fetch_add_relaxed();
> 
> Invalid would be:
> 	smp_mb__before_atomic();
> 	atomic_set();
> 
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  Documentation/memory-barriers.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 1adbb8a371c7..52076b057400 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1873,12 +1873,13 @@ There are some more advanced barrier functions:
>   (*) smp_mb__before_atomic();
>   (*) smp_mb__after_atomic();
>  
> -     These are for use with atomic (such as add, subtract, increment and
> -     decrement) functions that don't return a value, especially when used for
> -     reference counting.  These functions do not imply memory barriers.
> +     These are for use with atomic RMW functions (such as add, subtract,
> +     increment, decrement, failed conditional operations, ...) that do
> +     not imply memory barriers, but where the code needs a memory barrier,
> +     for example when used for reference counting.
>  
> -     These are also used for atomic bitop functions that do not return a
> -     value (such as set_bit and clear_bit).
> +     These are also used for atomic RMW bitop functions that do imply a full

s/do/do not/ ?

> +     memory barrier (such as set_bit and clear_bit).



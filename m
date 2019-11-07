Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128BEC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4F221882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573125729;
	bh=+CIQPZ+/8fpJy1L09YhNePzp1OmY7Y7silMp+Oka410=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xivTitEEzKtt+R9V9SfKnmvfcS4VALJyBn2FkyNFUx1hsUtbJrTGVNlFziX7o/fPm
	 dWGjm6W+hiz99ZzCQ8mFq2JVIM8CnZntxB5O4jchm2UwFkS4iM0dxH60ddfXPYAf9N
	 yENqGgxkyBiU7xY3UcBGN3d4L+LmRSDlxnabei/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388449AbfKGLWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388412AbfKGLWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:22:08 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2353D207FA;
        Thu,  7 Nov 2019 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573125726;
        bh=+CIQPZ+/8fpJy1L09YhNePzp1OmY7Y7silMp+Oka410=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAwmlkg+C1uqfpT4oaZ7vzWSd9xyvz0Bxo+zUKBL2Zrns5QwhTlbQvGPtAnKaSTcD
         45jomg5haOVkPswa/+YSyM9Gom9rA+S7X2+q6BS43sx86egC5HVpnscjGEkBD4SNdw
         Ftqww3kdxYvyK0M+2MLO/SOLEGqKgMiKvELJlT0g=
Date:   Thu, 7 Nov 2019 11:22:01 +0000
From:   Will Deacon <will@kernel.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/5] smp_mb__{before,after}_atomic(): Update Documentation
Message-ID: <20191107112200.GA11587@willie-the-truck>
References: <20191020123305.14715-1-manfred@colorfullife.com>
 <20191020123305.14715-2-manfred@colorfullife.com>
 <20191101164948.GD3603@willie-the-truck>
 <65a187c2-80de-2c6f-5f80-48c51f973d08@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a187c2-80de-2c6f-5f80-48c51f973d08@colorfullife.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred,

On Wed, Nov 06, 2019 at 08:23:03PM +0100, Manfred Spraul wrote:
> From 8d2b219794221e3ef1a1ec90e0f4fe344af9a55d Mon Sep 17 00:00:00 2001
> From: Manfred Spraul <manfred@colorfullife.com>
> Date: Fri, 11 Oct 2019 10:33:26 +0200
> Subject: [PATCH 1/5] smp_mb__{before,after}_atomic(): Update Documentation
> 
> When adding the _{acquire|release|relaxed}() variants of some atomic
> operations, it was forgotten to update Documentation/memory_barrier.txt:
> 
> smp_mb__before_atomic and smp_mb__after_atomic can be combined with
> all RMW operations that do not imply memory barriers.
> 
> In order to avoid that this happens again:
> Remove the paragraph from Documentation/memory_barrier.txt, the functions
> are sufficiently documented in Documentation/atomic_{t,bitops}.txt
> 
> Fixes: 654672d4ba1a ("locking/atomics: Add _{acquire|release|relaxed}() variants of some atomic operations")
> 
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> Acked-by: Waiman Long <longman@redhat.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  Documentation/memory-barriers.txt | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 1adbb8a371c7..16dfb4cde1e1 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1873,25 +1873,7 @@ There are some more advanced barrier functions:
>   (*) smp_mb__before_atomic();
>   (*) smp_mb__after_atomic();
>  
> -     These are for use with atomic (such as add, subtract, increment and
> -     decrement) functions that don't return a value, especially when used for
> -     reference counting.  These functions do not imply memory barriers.
> -
> -     These are also used for atomic bitop functions that do not return a
> -     value (such as set_bit and clear_bit).
> -
> -     As an example, consider a piece of code that marks an object as being dead
> -     and then decrements the object's reference count:
> -
> -	obj->dead = 1;
> -	smp_mb__before_atomic();
> -	atomic_dec(&obj->ref_count);
> -
> -     This makes sure that the death mark on the object is perceived to be set
> -     *before* the reference counter is decremented.
> -
> -     See Documentation/atomic_{t,bitops}.txt for more information.
> -
> +     See Documentation/atomic_{t,bitops}.txt for information.
>  
>   (*) dma_wmb();
>   (*) dma_rmb();

Thanks, I much prefer this approach:

Acked-by: Will Deacon <will@kernel.org>

Will

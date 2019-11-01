Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C09CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7778217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572626995;
	bh=iB6sy46ugFcR/o9rMmAUZWtn+byZEK47KCMWfmwmiJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ezP/kduE7cRxXGPoYImlb4orrNgbeoa4xIkuvELP4DjLMoBAI7iXSYeq5Sr5juSjY
	 cxHC1QDpo2e/km/bPc3RuSDbbaD5vcC7O8hdBsGzD2yBAfyIZ53hjyTv+QBAfbisuQ
	 AZKcXZcNgN4vEyXcpIHkcWluZeS07rgW24L7wTJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfKAQty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfKAQty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:49:54 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 324BE2080F;
        Fri,  1 Nov 2019 16:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572626993;
        bh=iB6sy46ugFcR/o9rMmAUZWtn+byZEK47KCMWfmwmiJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZqOUUt9Mx5t8eodwpfxlZrHgy3kloTHGILFKF3knQlTuMBFv78K1t9oC1T4ElZqk1
         HUb/uBUZxyF5iD3SUme8aD96WmUqj6XRaWJQI1m5jTne/zw4KcMtuJ4qIFnBos2CTl
         g0lIk3xFNTsLjtbJ/7GyVrQiZxlI0sySdpHs2QM4=
Date:   Fri, 1 Nov 2019 16:49:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/5] smp_mb__{before,after}_atomic(): Update Documentation
Message-ID: <20191101164948.GD3603@willie-the-truck>
References: <20191020123305.14715-1-manfred@colorfullife.com>
 <20191020123305.14715-2-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020123305.14715-2-manfred@colorfullife.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred,

On Sun, Oct 20, 2019 at 02:33:01PM +0200, Manfred Spraul wrote:
> When adding the _{acquire|release|relaxed}() variants of some atomic
> operations, it was forgotten to update Documentation/memory_barrier.txt:
> 
> smp_mb__{before,after}_atomic() is now intended for all RMW operations
> that do not imply a memory barrier.

[...]

>  Documentation/memory-barriers.txt | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 1adbb8a371c7..fe43f4b30907 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1873,12 +1873,16 @@ There are some more advanced barrier functions:
>   (*) smp_mb__before_atomic();
>   (*) smp_mb__after_atomic();
>  
> -     These are for use with atomic (such as add, subtract, increment and
> -     decrement) functions that don't return a value, especially when used for
> -     reference counting.  These functions do not imply memory barriers.
> -
> -     These are also used for atomic bitop functions that do not return a
> -     value (such as set_bit and clear_bit).
> +     These are for use with atomic RMW functions that do not imply memory
> +     barriers, but where the code needs a memory barrier. Examples for atomic
> +     RMW functions that do not imply are memory barrier are e.g. add,

typo: "are memory barrier"

> +     subtract, (failed) conditional operations, _relaxed functions,
> +     but not atomic_read or atomic_set. A common example where a memory
> +     barrier may be required is when atomic ops are used for reference
> +     counting.
> +
> +     These are also used for atomic RMW bitop functions that do not imply a
> +     memory barrier (such as set_bit and clear_bit).

Although I think this is correct, I really think we should instead refer to
Documentation/atomic_t.txt and get rid of this out of memory-barriers.txt
entirely. It's just duplication and is out of date.

Will

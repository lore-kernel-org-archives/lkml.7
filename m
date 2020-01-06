Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF7EC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CA3207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgAFVHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:07:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:33764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgAFVHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:07:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AE7CCADAD;
        Mon,  6 Jan 2020 21:07:49 +0000 (UTC)
Date:   Mon, 6 Jan 2020 13:01:04 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jason Baron <jbaron@akamai.com>
Cc:     rpenyaev@suse.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, normalperson@yhbt.net,
        viro@zeniv.linux.org.uk, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fs/epoll: rework safewake for CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <20200106210104.4hqlgpujqujcbeg7@linux-p48b>
References: <76f656dc7ac92f92682641e22e1c44c4@suse.de>
 <20200106193830.27224-1-dave@stgolabs.net>
 <9f9763eb-d326-1ea0-5d50-1f5f481f2dc5@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9f9763eb-d326-1ea0-5d50-1f5f481f2dc5@akamai.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jan 2020, Jason Baron wrote:
>> For one this does not play nice with preempt_rt as disabling irq and
>> then taking a spinlock_t is a no no; the critical region becomes
>> preemptible. This is particularly important as -rt is being mainlined.
>>
>
>hmmm, but before the spinlock is taken there is a preempt_disable() call.

Yes, this is illegal in -rt as well.

>
>> Secondly, it is really ugly compared to what we had before - albeit not
>> having to deal with all the ep_call_nested() checks, but I doubt this
>> overhead matters at all with CONFIG_DEBUG_LOCK_ALLOC.
>>
>
>Yes, the main point of the patch is to continue to remove dependencies
>on ep_call_nested(), and then eventually to remove it completely.

I've also thought about this.

>> While the current logic avoids nesting by disabling irq during the whole
>> path, this seems like an overkill under debug. This patch proposes using
>> this_cpu_inc_return() then taking the irq-safe lock - albeit a possible
>> irq coming in the middle between these operations and messing up the
>> subclass. If this is unacceptable, we could always revert the patch,
>> as this was never a problem in the first place.
>
>I personally don't want to introduce false positives. But I'm not quite
>sore on that point - the subclass will still I think always increase on
>nested calls it just may skip some numbers. I'm not sure offhand if that
>messes up lockdep. perhaps not?

Yes I agree that this will only cause numbers to be skipped, but as mentioned
it's not very tested. I'll go see what comes out with more testing, of course
it means very little unless I can actually reproduce spurious irqs. Maybe I
can hack something up that bumps the subclass intentionally and see what happens
as well.

Thanks,
Davidlohr

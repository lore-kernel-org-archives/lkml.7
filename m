Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A195ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094012086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfJOQ1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:27:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728554AbfJOQ1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:27:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BADC6B139;
        Tue, 15 Oct 2019 16:27:34 +0000 (UTC)
Date:   Tue, 15 Oct 2019 09:26:18 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, parri.andrea@gmail.com
Subject: Re: [PATCH 6/6] Documentation/memory-barriers.txt: Clarify cmpxchg()
Message-ID: <20191015162618.prubsbu7xpou5n27@linux-p48b>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-7-manfred@colorfullife.com>
 <20191015012604.eonteqarhvgmrzuc@linux-p48b>
 <20191015071959.GA2311@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191015071959.GA2311@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2019, Peter Zijlstra wrote:

>On Mon, Oct 14, 2019 at 06:26:04PM -0700, Davidlohr Bueso wrote:
>> On Sat, 12 Oct 2019, Manfred Spraul wrote:
>> > Invalid would be:
>> > 	smp_mb__before_atomic();
>> > 	atomic_set();
>>
>> fyi I've caught a couple of naughty users:
>>
>>   drivers/crypto/cavium/nitrox/nitrox_main.c
>>   drivers/gpu/drm/msm/adreno/a5xx_preempt.c
>
>Yes, there's still some of that. Andrea went and killed a buch a while
>ago I think.

I sent these, which just does smp_mb():

https://lore.kernel.org/lkml/20191015161657.10760-1-dave@stgolabs.net
https://lore.kernel.org/lkml/20191015162144.fuyc25tdwvc6ddu3@linux-p48b

Similarly, I was doing some barrier auditing in btrfs code recently
(completely unrelated to these topics) and noted that there are some
cases where we can inverse this exercise. Iow, callers doing atomic
Rmw along with smp_mb(), which we can replace with these upgradable
calls and benefit, for example in x86.

Thanks,
Davidlohr

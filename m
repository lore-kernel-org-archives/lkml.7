Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CFAC31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 02:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C5D206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 02:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfHMCYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 22:24:46 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:37871 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbfHMCYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 22:24:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TZM28tV_1565663077;
Received: from 30.17.232.235(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TZM28tV_1565663077)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 13 Aug 2019 10:24:38 +0800
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com>
 <20190806032418.GA54717@aaronlu>
 <e1c4a7ed-822e-93cb-ff1d-6a0842db115f@linux.intel.com>
 <20190806171241.GQ2349@hirez.programming.kicks-ass.net>
 <21933a50-f796-3d28-664c-030cb7c98431@linux.intel.com>
 <20190808064731.GA5121@aaronlu>
 <70d1ff90-9be9-7b05-f1ff-e751f266183b@linux.intel.com>
 <b7a83fcb-5c34-9794-5688-55c52697fd84@linux.intel.com>
 <20190810141556.GA73644@aaronlu>
 <CANaguZDEq4=5Q9pnFyWx0-Gfkoq-WxUXBYgiG6WKLTO5njAHUA@mail.gmail.com>
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
Message-ID: <bae71ff6-e5a3-27bc-c32c-17a096a5c836@linux.alibaba.com>
Date:   Tue, 13 Aug 2019 10:24:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANaguZDEq4=5Q9pnFyWx0-Gfkoq-WxUXBYgiG6WKLTO5njAHUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/12 23:38, Vineeth Remanan Pillai wrote:
>> I have two other small changes that I think are worth sending out.
>>
>> The first simplify logic in pick_task() and the 2nd avoid task pick all
>> over again when max is preempted. I also refined the previous hack patch to
>> make schedule always happen only for root cfs rq. Please see below for
>> details, thanks.
>>
> I see a potential issue here. With the simplification in pick_task,
> you might introduce a livelock where the match logic spins for ever.
> But you avoid that with the patch 2, by removing the loop if a pick
> preempts max. The potential problem is that, you miss a case where
> the newly picked task might have a match in the sibling on which max
> was selected before. By selecting idle, you ignore the potential match.

Oh that's right, I missed this.

> As of now, the potential match check does not really work because,
> sched_core_find will always return the same task and we do not check
> the whole core_tree for a next match. This is in my TODO list to have
> sched_core_find to return the best next match, if match was preempted.
> But its a bit complex and needs more thought.

Sounds worth to do :-)

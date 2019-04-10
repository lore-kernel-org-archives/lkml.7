Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94933C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EE620818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388078AbfDJQuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:50:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:50526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388065AbfDJQuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:50:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99FAEAD5E;
        Wed, 10 Apr 2019 16:50:21 +0000 (UTC)
Date:   Wed, 10 Apr 2019 09:50:13 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip v2 06/12] locking/rwsem: Wake up almost all readers
 in wait queue
Message-ID: <20190410165013.njy5bg32pxq6syyr@linux-r8p5>
References: <20190405192115.17416-1-longman@redhat.com>
 <20190405192115.17416-7-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190405192115.17416-7-longman@redhat.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Apr 2019, Waiman Long wrote:

>When the front of the wait queue is a reader, other readers
>immediately following the first reader will also be woken up at the
>same time. However, if there is a writer in between. Those readers
>behind the writer will not be woken up.
>
>Because of optimistic spinning, the lock acquisition order is not FIFO
>anyway. The lock handoff mechanism will ensure that lock starvation
>will not happen.
>
>Assuming that the lock hold times of the other readers still in the
>queue will be about the same as the readers that are being woken up,
>there is really not much additional cost other than the additional
>latency due to the wakeup of additional tasks by the waker. Therefore
>all the readers up to a maximum of 256 in the queue are woken up when
>the first waiter is a reader to improve reader throughput.

Before we stopped waking readers when a writer was encountered but
would otherwise wakeup _all_ readers. I don't understand why you want
to limit this to MAX_READERS_WAKEUP, otherwise I agree it's nice to
skip the writer and continue waking readers in the queue (with the handoff
guarantees obviously).

Would it not be better to do the MAX_READERS_WAKEUP limit only when
a writer is found?

Thanks,
Davidlohr

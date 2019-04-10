Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30117C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA7C2082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfDJSiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:38:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:38110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728731AbfDJSiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:38:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02F76AC3B;
        Wed, 10 Apr 2019 18:38:20 +0000 (UTC)
Date:   Wed, 10 Apr 2019 11:38:13 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip v2 03/12] locking/rwsem: Remove rwsem_wake() wakeup
 optimization
Message-ID: <20190410183813.n4sybugomkn53gvu@linux-r8p5>
References: <20190405192115.17416-1-longman@redhat.com>
 <20190405192115.17416-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190405192115.17416-4-longman@redhat.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Apr 2019, Waiman Long wrote:

>With the commit 59aabfc7e959 ("locking/rwsem: Reduce spinlock contention
>in wakeup after up_read()/up_write()"), the rwsem_wake() forgoes doing
>a wakeup if the wait_lock cannot be directly acquired and an optimistic
>spinning locker is present.  This can help performance by avoiding
>spinning on the wait_lock when it is contended.
>
>With the later commit 133e89ef5ef3 ("locking/rwsem: Enable lockless
>waiter wakeup(s)"), the performance advantage of the above optimization
>diminishes as the average wait_lock hold time become much shorter.
>
>By supporting rwsem lock handoff, we can no longer relies on the fact
>that the presence of an optimistic spinning locker will ensure that the
>lock will be acquired by a task soon. This can lead to missed wakeup
>and application hang. So the commit 59aabfc7e959 ("locking/rwsem:
>Reduce spinlock contention in wakeup after up_read()/up_write()")
>will have to be reverted.
>
>Signed-off-by: Waiman Long <longman@redhat.com>
>---
> kernel/locking/rwsem-xadd.c | 74 -------------------------------------

I very much like removing this code. It was rather crazy.

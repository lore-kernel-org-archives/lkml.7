Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29637C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D4F2082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfDJRXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:23:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:55420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729111AbfDJRXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:23:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19D4EAEA3;
        Wed, 10 Apr 2019 17:23:01 +0000 (UTC)
Date:   Wed, 10 Apr 2019 10:22:54 -0700
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
Message-ID: <20190410172254.ivgcgehjhqgwjtda@linux-r8p5>
References: <20190405192115.17416-1-longman@redhat.com>
 <20190405192115.17416-7-longman@redhat.com>
 <20190410165013.njy5bg32pxq6syyr@linux-r8p5>
 <114e3bc3-3b66-4a50-d422-6a477d85fa72@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <114e3bc3-3b66-4a50-d422-6a477d85fa72@redhat.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019, Waiman Long wrote:
>There are 2 major reasons why there is a limit.
>
>1) It will be unfair to the task that needs to spend so much of its own
>CPU time to wake up too many readers.

This has never been a problem before.

>2) I want to avoid the extreme case that there are more than 32k readers
>in the wait queue and make the count overflow.

But in this case the readers are already on the queue.

Thanks,
Davidlohr

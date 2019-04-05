Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1380C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7897521850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CcWlS6Al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfDELVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:21:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfDELVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q1yERBIvluy/qY+kZZLvmWeucgi3YUml4bxIcX5keJI=; b=CcWlS6AlRc8DZCM8QgYCPEdoT
        W3CXHlB2MryKy3VNalwBu+YOne628249PXmJvEp71feo+9ujHzTfFxq0oUQnMzibhvyG0+Ix7Uj38
        4rHwgOLQoi/Q0kLRdNpKr+PPGm/mv/+XYIpbzWv0fgJ2BTu5BVux4dyE6ZubLpqsO2XvRMQur89up
        5oceoICv62PhttMvpG/L8UOihZyVNGPPGcb7MemhWoQeO89ZVgiVlnYmvd47uePsxwZ9ZaPLMIcVP
        vuS6Nd4KUfnCyQdRAZWjX+YSwVZKonOcfXgyxc7YN6Vf8KyYLtAcKdWbJxXZrzzNySoyDTw1AobMv
        6AqAAcQ5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCMuR-00013G-1v; Fri, 05 Apr 2019 11:21:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6444429AA72B7; Fri,  5 Apr 2019 13:21:21 +0200 (CEST)
Date:   Fri, 5 Apr 2019 13:21:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip v4 00/11] locking/rwsem: Rwsem rearchitecture part 1
Message-ID: <20190405112121.GE4038@hirez.programming.kicks-ass.net>
References: <20190404174320.22416-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404174320.22416-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 01:43:09PM -0400, Waiman Long wrote:
> Waiman Long (11):
>   locking/rwsem: Relocate rwsem_down_read_failed()
>   locking/rwsem: Move owner setting code from rwsem.c to rwsem.h
>   locking/rwsem: Move rwsem internal function declarations to
>     rwsem-xadd.h
>   locking/rwsem: Micro-optimize rwsem_try_read_lock_unqueued()
>   locking/rwsem: Add debug check for __down_read*()
>   locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro
>   locking/qspinlock_stat: Introduce a generic lockevent counting APIs
>   locking/lock_events: Make lock_events available for all archs & other
>     locks
>   locking/lock_events: Don't show pvqspinlock events on bare metal
>   locking/rwsem: Enable lock event counting
>   locking/rwsem: Optimize rwsem structure for uncontended lock
>     acquisition

Thanks!

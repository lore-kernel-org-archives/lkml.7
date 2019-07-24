Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BA0C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8673B227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563944174;
	bh=ZoHFk+7eW3wUtd1iGaeaxMn75tdBZ6U9faZvCVKRxmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DPnf1itmrqFHoUrseXc5+2ZDATrBlgeCzDAcab25T/AD5vwLSAybrAbVIeC440I7G
	 3oS+ua7HPE2phHJF04oAwJu7uoseaNMQuXUXR9cTctZ3U+V4RA4YKORClvWDAykjpS
	 B9oASONTCUC2lz2j//W2P4ImjRNNFVtGk2huvR40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfGXE4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 00:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfGXE4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 00:56:13 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB82A218DA;
        Wed, 24 Jul 2019 04:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563944171;
        bh=ZoHFk+7eW3wUtd1iGaeaxMn75tdBZ6U9faZvCVKRxmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRToJaECyjM9QKxZGg6bEFMn2M5wXhKMBaQxlAJeOu54vduUkksxqc4+os0OBV2Ag
         TkwZ6BX85mhfepXAddX26JJVNFAxPIqR9jhH0mSCQqpqqobG3Tsw0JsMjJQJHkBA2M
         iyWCkURg0X+2wt8p6pGxKQk4buvMOK7N7oSoFgkQ=
Date:   Tue, 23 Jul 2019 21:56:10 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Yuyang Du <duyuyang@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/4] locking/lockdep: Reduce space occupied by stack
 traces
Message-ID: <20190724045610.GC643@sol.localdomain>
Mail-Followup-To: Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, Yuyang Du <duyuyang@gmail.com>,
        Waiman Long <longman@redhat.com>
References: <20190722182443.216015-1-bvanassche@acm.org>
 <20190722182443.216015-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722182443.216015-4-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:24:42AM -0700, Bart Van Assche wrote:
> Although commit 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys
> for workqueues") unregisters dynamic lockdep keys when a workqueue is
> destroyed, a side effect of that commit is that all stack traces
> associated with the lockdep key are leaked when a workqueue is destroyed.
> Fix this by storing each unique stack trace once. Other changes in this
> patch are:
> - Use NULL instead of { .nr_entries = 0 } to represent 'no trace'.
> - Store a pointer to a stack trace in struct lock_class and struct
>   lock_list instead of storing 'nr_entries' and 'offset'.
> 
> This patch avoids that the following program triggers the "BUG:
> MAX_STACK_TRACE_ENTRIES too low!" complaint:


Does this also fix any of the other bugs listed at
https://lore.kernel.org/lkml/20190710055838.GC2152@sol.localdomain/
?

BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
BUG: MAX_LOCKDEP_CHAINS too low!
BUG: MAX_LOCK_DEPTH too low! (2)
BUG: MAX_LOCKDEP_ENTRIES too low!

> 
> 	#include <fcntl.h>
> 	#include <unistd.h>
> 
> 	int main()
> 	{
> 		for (;;) {
> 			int fd = open("/dev/infiniband/rdma_cm", O_RDWR);
> 			close(fd);
> 		}
> 	}
> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Yuyang Du <duyuyang@gmail.com>
> Cc: Waiman Long <longman@redhat.com>
> Reported-by: Eric Biggers <ebiggers@kernel.org>

Can you please add:

Reported-by: syzbot+6f39a9deb697359fe520@syzkaller.appspotmail.com

Thanks,

- Eric

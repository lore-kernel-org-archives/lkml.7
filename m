Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC255C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819CF20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pl3DCnZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbfHFMoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:44:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbfHFMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kxRmUtpU3+HLrQgPmGV9rVEzrVoidftkAjoSDfqIVDA=; b=pl3DCnZb0UFJnJD4nxR37Q664
        dAUIUBA3jyIeQlJqDdVMlVtcPa8hH5q/go+rIruEKs2wZRw4PDgOBI8bXeLLbDzXykCZQ2MzRXJ4F
        fGnss0JLnD66OrU3E2Mhzqj0KUG4uALNwF+fami8VB15xm5LQHyLhUMOm6p2EpWgfeaOkl7W5T/Tg
        nfoZBEA4DgVf+Sh0272Pwv0vXU73g2dYU9LBIby1bMDdvWuimrgjrodZBWuHCkynk9TL20uaMapbp
        WvD4NhKIvH7agvOB5ojtXlV01YDKK9Hi3IuzyNGTKq7/YzDFKmvcDpU4+138RDZROIFb4dDAQfIEB
        APuNDBlZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huypA-0006CP-3F; Tue, 06 Aug 2019 12:44:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B427305F65;
        Tue,  6 Aug 2019 14:43:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E6FA201B8614; Tue,  6 Aug 2019 14:44:17 +0200 (CEST)
Date:   Tue, 6 Aug 2019 14:44:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip] locking/rwsem: Make handoff writer optimistically
 spin on owner
Message-ID: <20190806124417.GN2349@hirez.programming.kicks-ass.net>
References: <20190625143913.24154-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625143913.24154-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:39:13AM -0400, Waiman Long wrote:
> When the handoff bit is set by a writer, no other tasks other than
> the setting writer itself is allowed to acquire the lock. If the
> to-be-handoff'ed writer goes to sleep, there will be a wakeup latency
> period where the lock is free, but no one can acquire it. That is less
> than ideal.
> 
> To reduce that latency, the handoff writer will now optimistically spin
> on the owner if it happens to be a on-cpu writer. It will spin until
> it releases the lock and the to-be-handoff'ed writer can then acquire
> the lock immediately without any delay. Of course, if the owner is not
> a on-cpu writer, the to-be-handoff'ed writer will have to sleep anyway.
> 
> The optimistic spinning code is also modified to not stop spinning
> when the handoff bit is set. This will prevent an occasional setting of
> handoff bit from causing a bunch of optimistic spinners from entering
> into the wait queue causing significant reduction in throughput.
> 
> On a 1-socket 22-core 44-thread Skylake system, the AIM7 shared_memory
> workload was run with 7000 users. The throughput (jobs/min) of the
> following kernels were as follows:
> 
>  1) 5.2-rc6
>     - 8,092,486
>  2) 5.2-rc6 + tip's rwsem patches
>     - 7,567,568
>  3) 5.2-rc6 + tip's rwsem patches + this patch
>     - 7,954,545
> 
> Using perf-record(1), the %cpu time used by rwsem_down_write_slowpath(),
> rwsem_down_write_failed() and their callees for the 3 kernels were 1.70%,
> 5.46% and 2.08% respectively.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Thanks.. sorry for taking so long.

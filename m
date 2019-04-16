Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBB4C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0965F20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qeZzZq7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfDPQPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:15:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfDPQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s58e9477Vpa8BH4ALET6UrlQumvou2S6SlLIFnQp46Q=; b=qeZzZq7OSQQEp4Ln4bnIMNeIo
        yfD0MyUDk8XNSCfamSTVzwgCqUzca+czyVrF0mD/zJqGVHWhcXWh8tWolLrXGOYeUsgNRBEgOfgBS
        FhVj9GDA6SF54cezLu221799xOferlSVAbBL8eOZHGxdx3n0SXSTF1Ef0OMWI7Z52a3lmbj7zFi72
        ep8xHV+lc4M2eEi7g5m3dORzhlJ+MxjlM+dHUlWF7xwbjJbo2QleUjOGOeuWoS3rCM8cAVDp8uzUY
        l+bcCndaZS8fioIdjBlREAUgF/95t4Xj4iU+76a4SoXJjgLJq0wrW8fHL+AASzPs9Ejb0aJeak2Qr
        KB+4L7IOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGQk1-0002bd-5A; Tue, 16 Apr 2019 16:15:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1AEF29AC163C; Tue, 16 Apr 2019 18:15:22 +0200 (CEST)
Date:   Tue, 16 Apr 2019 18:15:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 07/16] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Message-ID: <20190416161522.GR14281@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-8-longman@redhat.com>
 <20190416154937.GL12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416154937.GL12232@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 05:49:37PM +0200, Peter Zijlstra wrote:
> See, if you first write that function in the form:
> 
> 	long new;
> 
> 	do {
> 		new = count | RWSEM_WRITER_LOCKED;
> 
> 		if (count & RWSEM_LOCK_MASK)
> 			return false;
> 
> 		if (list_is_singular(&sem->wait_list))
> 			new &= ~RWSEM_FLAG_WAITERS;
> 
> 	} while (atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
> 
> 	rwsem_set_owner(sem);
> 	return true;
> 
> And then add the HANDOFF bits like:
> 
> 	long new;
> 
> 	do {
> +		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
> 
> +		new = (count | RWSEM_WRITER_LOCKED) & ~RWSEM_FLAG_HANDOFF;
> 
> 		if (count & RWSEM_LOCK_MASK) {
> +			if (has_handoff && wstate != WRITER_HANDOFF)
> +				return false;
> 			new |= RWSEM_FLAG_HANDOFF;
> 		}
> 
> +		if (has_handoff && wstate == WRITER_NOT_FIRST)
> +			return false;
> 
> 		if (list_is_singular(&sem->wait_list))
> 			new &= ~RWSEM_FLAG_WAITERS;
> 
> 	} while (atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));

obviously that should be !

> 
> 	rwsem_set_owner(sem);
> 	return true;
> 
> it almost looks like sensible code.

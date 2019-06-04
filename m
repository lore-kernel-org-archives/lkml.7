Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C69C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AB824BB7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jTueB4cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfFDJUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:20:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34594 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfFDJUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cibqJ1dnDlqZ3+hQXGtJ+xDjYoYAlhIacI35a4CJxN4=; b=jTueB4cy87l7jPC0WxweE9frk
        4UeEsxJZMyMkyUBlm1/d2gGEc3rW8A3mvVQ3gZiVx37qJ6ziz4MqSNoJ5cvdsxg7ltS1s6+aYWTeR
        F9OZ8Q/5vXOoRBlOUE8fqX6q7WyxSDkrmHV681U1JC0U/V/kPBgwx0mihxoi2G4xqxxgs2Nq2GZ6p
        1ZkFEYPMiVCj3C7FIVdRywCNMccdOqro7FJQ1Nr2XC01i4KZgZAfEdvtGw/nE+tXdnHPeHfUsdqbY
        sRlNCRl5p4PQFmAOSIOoMT8Jk7OOJ0MagFEDc4/QnH+Tk4L+Y3UPK8JmFK8Z0tlK+nNhDIwtZCeJP
        Xv4YUxegQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY5c1-0003AS-Pc; Tue, 04 Jun 2019 09:20:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F3D22083FE2A; Tue,  4 Jun 2019 11:20:08 +0200 (CEST)
Date:   Tue, 4 Jun 2019 11:20:08 +0200
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
Subject: Re: [PATCH v8 15/19] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
Message-ID: <20190604092008.GJ3402@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-16-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520205918.22251-16-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:59:14PM -0400, Waiman Long wrote:
> @@ -286,6 +325,7 @@ struct rwsem_waiter {
>  	struct task_struct *task;
>  	enum rwsem_waiter_type type;
>  	unsigned long timeout;
> +	long last_rowner;
>  };
>  #define rwsem_first_waiter(sem) \
>  	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)

> +static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
> +					      long last_rowner)

> +static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
> +					      unsigned long last_rowner)

> +	waiter.last_rowner = atomic_long_read(&sem->owner);

That's somewhat inconsistent wrt the type. I'll make it unsigned long,
as that is what makes most sense, given there's a pointer inside.

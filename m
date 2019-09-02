Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF08C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40B22339D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eCZRNKp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbfIBNx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:53:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfIBNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yb5zUoEnO3GNQPM3y18hRLQjrCGxX9+7yCoKShGebvI=; b=eCZRNKp+WhDMXxx0s114roIpM
        Q/B4MEL73oZTg++Jtr9RefuPldAkJjC3M33FRcQCpsH+F/cwi+guGnn0ju1WWXYGMSyIxnhurNPMw
        PUok2mYPLaP3nN9k3CUy1CdgjvpsvmDp3QPg+ZBvuah8+BlsKSzbK5Y1RZ4+PrhT5E8N/yD6HTeOR
        ekamRqv7s4F5kpRFltoYCD9Ot1m+6QUbELEBerlox+I41EQ+hFHjjlsgndpfUtCjAAHfTrHJMR9JN
        XC/8pVs5S++A5DqUN7JWr6KYLKS9ULtuk+M7hauHcWeD8sWOOwN79ir7faQDkctBaDM67/eEqpnu4
        2P4yhWYdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4mlh-0003An-U8; Mon, 02 Sep 2019 13:53:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3D14306024;
        Mon,  2 Sep 2019 15:52:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C3C320CD2B23; Mon,  2 Sep 2019 15:53:15 +0200 (CEST)
Date:   Mon, 2 Sep 2019 15:53:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
Message-ID: <20190902135315.GR2369@hirez.programming.kicks-ass.net>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
 <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902134003.GA14770@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 03:40:03PM +0200, Oleg Nesterov wrote:
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8dc1811..1f9b021 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1134,7 +1134,10 @@ struct task_struct {
>  
>  	struct tlbflush_unmap_batch	tlb_ubc;
>  
> -	struct rcu_head			rcu;
> +	union {
> +		bool			xxx;
> +		struct rcu_head		rcu;
> +	};
>  
>  	/* Cache last used pipe for splice(): */
>  	struct pipe_inode_info		*splice_pipe;
> diff --git a/kernel/exit.c b/kernel/exit.c
> index a75b6a7..baacfce 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -182,6 +182,11 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
>  	put_task_struct(tsk);
>  }
>  
> +void call_delayed_put_task_struct(struct task_struct *p)
> +{
> +	if (xchg(&p->xxx, 1))
> +		call_rcu(&p->rcu, delayed_put_task_struct);
> +}

I think this is the first usage of xchg() on _Bool, also not all archs
implement xchg8()


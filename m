Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CB8FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CC8222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xa3C8QvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfKHMwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:52:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfKHMwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ifyUUANAYIwzQyC3mPqGtoORaHR4Rd26DWOa5Yxhvh0=; b=Xa3C8QvATp7sI3o1vg7e+KD8a
        yLwAxk3QaCNvw61Uv1UeFdHW2FadHidaYDXoGCT+iaQGGUXXyTdqwHhXeqICvPzRa5cj24ibTSM4l
        VmnI8/aBA4wmrbZ+aquevTGYGxfh1WdZ5peHbd6rRGtr5GE2/glFXW9UKrWuSffRsR/D4QSbBJBHc
        qCJZAVuwRL9RKDlop/2Cjy1O+QIRN7PmT7VaXchyC2L+VPCHfMSjQOkWFirx+4OwWqUIWswxx1RG8
        GtUkq2Px3Xlhd69IE7/99Xmp7JLyD2EjDMJUK6JGXvWsuaYuZiDUQo0qFvbYRDRfvdf/kpU5vKPZi
        6O+izbQhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iT3kK-00005h-As; Fri, 08 Nov 2019 12:52:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0CAB6300489;
        Fri,  8 Nov 2019 13:51:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0D3D2026E904; Fri,  8 Nov 2019 13:52:09 +0100 (CET)
Date:   Fri, 8 Nov 2019 13:52:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191108125209.GR5671@hirez.programming.kicks-ass.net>
References: <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
 <20191107153848.GA31774@google.com>
 <20191107184356.GF4114@hirez.programming.kicks-ass.net>
 <20191107192907.GA30258@worktop.programming.kicks-ass.net>
 <20191108115557.GP5671@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108115557.GP5671@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 12:55:57PM +0100, Peter Zijlstra wrote:
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3929,13 +3929,14 @@ pick_next_task(struct rq *rq, struct tas
>  	}
>  
>  restart:
> -	/*
> -	 * Ensure that we put DL/RT tasks before the pick loop, such that they
> -	 * can PULL higher prio tasks when we lower the RQ 'priority'.
> -	 */
> -	prev->sched_class->put_prev_task(rq, prev, rf);
> -	if (!rq->nr_running)
> -		newidle_balance(rq, rf);
> +#ifdef CONFIG_SMP
	/*
	 * We must do the balancing pass before put_next_task(), such
	 * that when we release the rq->lock the task is in the same
	 * state as before we took rq->lock.
	 *
	 * We can terminate the balance pass as soon as we know there is
	 * a runnable task of @class priority or higher.
	 */
> +	for_class_range(class, prev->sched_class, &idle_sched_class) {
> +		if (class->balance(rq, prev, rf))
> +			break;
> +	}
> +#endif
> +
> +	put_prev_task(rq, prev);
>  
>  	for_each_class(class) {
>  		p = class->pick_next_task(rq, NULL, NULL);

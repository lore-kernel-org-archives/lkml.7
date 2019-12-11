Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CB0C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842BF206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeERaHUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfLKUqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:46:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726925AbfLKUqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576097166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RdRBEoYxRIkuYEuDHr3V4GvXlKW2Lf5ylOPLl+U6EFw=;
        b=JeERaHUwD4cdloIb60iZKQcRP/DhF9rYJAvhT0MYmN7hOip+6OSmzh4vVUNkX0jI7s3o2P
        noGp2YMr4kcl2bJxTyO7CdeoY7KjqcLni85/KVIyeHpMwDvArgpJUFAqdWMjcIDCM57t3x
        Sndyo50ztMJ4Eeoju3zKDs86XPIkd9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-kBsvBemiNpC3wBla7JKNyw-1; Wed, 11 Dec 2019 15:46:03 -0500
X-MC-Unique: kBsvBemiNpC3wBla7JKNyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BC1C1883534;
        Wed, 11 Dec 2019 20:46:02 +0000 (UTC)
Received: from ovpn-116-192.phx2.redhat.com (ovpn-116-192.phx2.redhat.com [10.3.116.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A1DA60BB1;
        Wed, 11 Dec 2019 20:46:01 +0000 (UTC)
Message-ID: <9a4db39373cf4acaf91ef6db92df116b74fef992.camel@redhat.com>
Subject: Re: [PATCH] timers/nohz: Update nohz load even if tick already
 stopped
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Dec 2019 14:46:01 -0600
In-Reply-To: <20191030133130.GY4097@hirez.programming.kicks-ass.net>
References: <20191028150716.22890-1-frederic@kernel.org>
         <20191029100506.GJ4114@hirez.programming.kicks-ass.net>
         <52d963553deda810113accd8d69b6dffdb37144f.camel@redhat.com>
         <20191030133130.GY4097@hirez.programming.kicks-ass.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-30 at 14:31 +0100, Peter Zijlstra wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index eb42b71faab9..d02d1b8f40af 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3660,21 +3660,17 @@ static void sched_tick_remote(struct work_struct
> *work)
>  	u64 delta;
>  	int os;
>  
> -	/*
> -	 * Handle the tick only if it appears the remote CPU is running in
> full
> -	 * dynticks mode. The check is racy by nature, but missing a tick or
> -	 * having one too much is no big deal because the scheduler tick
> updates
> -	 * statistics and checks timeslices in a time-independent way,
> regardless
> -	 * of when exactly it is running.
> -	 */
> -	if (idle_cpu(cpu) || !tick_nohz_tick_stopped_cpu(cpu))
> +	if (!tick_nohz_tick_stopped_cpu(cpu))
>  		goto out_requeue;
>  
>  	rq_lock_irq(rq, &rf);
> -	curr = rq->curr;
> -	if (is_idle_task(curr) || cpu_is_offline(cpu))
> +	/*
> +	 * We must not call calc_load_nohz_remote() when not in NOHZ mode.
> +	 */
> +	if (cpu_is_offline(cpu) || !tick_nohz_tick_stopped(cpu))
>  		goto out_unlock;

Is it really a problem if calc_load_nohz_remote() gets called in
non-NOHZ?  It won't race due to rq lock -- and we're already mixing
remote and non-remote updates because the normal tick timer can still be
run while "stopped".

-Scott


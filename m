Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69442C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EDA2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iMpBjv/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLQKpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:45:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfLQKp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZHZ7TBEeXkuhA3F2R3OEKoR+IziPIdZUdIWwAR5X4sE=; b=iMpBjv/yPSVy+aZBolLK0tvMl
        n6HKbJrko0vU9p+UiDRB2Lv5nB6VHOE4diOcpO6TBAmYgS04WOYf0tAwCyCs5QMY4IxNpOC8Gjr9z
        9YXTGqUhnsDPvmyvnTvAPksWVCwxXx5nsukmiv4v3fxWA8e5BX1Wzl+GMjhlgwz86nrN9H9vUyHG+
        WhJYkmvcCkCEmJ022HPaPAzm/Zsb1PZ545YQgOh8+93siyWxCYrmZwHjyDZ25oDW+UXzEtyXbPhxG
        lq7QKjUsRU/s9ofqvDnCvUcqMKEE6enkEB3ltUzB1zXpH9hl85ecY0vECBncstizbR87+47LxNGc1
        5/ILCL61g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihALx-0007fk-W9; Tue, 17 Dec 2019 10:45:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F3A6300F29;
        Tue, 17 Dec 2019 11:43:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E72FE29E718A0; Tue, 17 Dec 2019 11:45:19 +0100 (CET)
Date:   Tue, 17 Dec 2019 11:45:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, jack@suse.com
Subject: Re: [PATCH 5/5] locking/percpu-rwsem: Remove the embedded rwsem
Message-ID: <20191217104519.GD2844@hirez.programming.kicks-ass.net>
References: <20191113102115.116470462@infradead.org>
 <20191113102855.925208237@infradead.org>
 <20191118195304.b3d6fg4jmmj7kmfh@linux-p48b>
 <20191118231935.7wvkozof3ocubxej@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118231935.7wvkozof3ocubxej@linux-p48b>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 03:19:35PM -0800, Davidlohr Bueso wrote:
> Similarly, afaict we can get rid of __percpu_up_read() and put the
> slowpath all into percpu_up_read(). Also explicitly mention the
> single task nature of the writer (which is a better comment for
> the rcuwait_wake_up()).

> static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
> {
> @@ -103,10 +102,23 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
> 	/*
> 	 * Same as in percpu_down_read().
> 	 */
> +	if (likely(rcu_sync_is_idle(&sem->rss))) {
> 		__this_cpu_dec(*sem->read_count);
> +		goto done;
> +	}
> +
> +	/*
> +	 * slowpath; reader will only ever wake a single blocked writer.
> +	 */
> +	smp_mb(); /* B matches C */
> +	/*
> +	 * In other words, if they see our decrement (presumably to
> +	 * aggregate zero, as that is the only time it matters) they
> +	 * will also see our critical section.
> +	 */
> +	__this_cpu_dec(*sem->read_count);
> +	rcuwait_wake_up(&sem->writer);
> +done:
> 	preempt_enable();
> }

Let me write that as a normal if () { } else { }.

But yes, that's small enough I suppose.

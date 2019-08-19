Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543A4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29111206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566243150;
	bh=QtLvxRCy7KAgxrs7w6UODARNLtXWA3XoNk7iq0PQhD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h9wsMl26NfdPWAjqy6KVqJD+u2OcI7tBdwyg/ePhkn5tuYA1FTTixcXdGmWWWw4UN
	 c4IdPRLyDPogbe+1YH+FRw9maG2FjEVVJLZ5q49NHFGyeFgCh2McMxJOjgrPQNpUiv
	 OJbsRVFMdMItzQ6MzP06ZvMAilY/nTa+7w5i9V+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfHSTc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:32:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39717 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbfHSTc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:32:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so9889489wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G6wRxMn8KbZLgTFb9SoRWrIChyMv6NmCci5mPtTZ9ZA=;
        b=ZlU33pJvi63ls5WKi3Qq/PzasivUhaqLoaSGM+bYoOdBOQIp4aJl6U88OiLPNYiEe7
         KbEjfMnHX1DS0X0AWyi2r6jWSPu2AfP7WVjuXN72FpzuTYjtzMI3pmB+geTdbDTjrSzZ
         8YlZwFAz2P7I5ytbNzwVH1GO1jIMqNAbLUFx98hDnOK5IM9RMMbEvwwzRB76aoNtY/5V
         EpJLH/e8Mo53dqkfO3ZntAfUyamEGrkl4TXwONek5r6rHZ/0bGCluaS+6OJEf0atM5Hz
         72khHPJxdV2QxebPf4UW8nZG5s9xht/iWqidlULkwp3B0PZtpLnH9EZG5ni7JFzT+7DK
         lirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=G6wRxMn8KbZLgTFb9SoRWrIChyMv6NmCci5mPtTZ9ZA=;
        b=NLiDSjPp3gJeNAQPARFRGZ4zMbPVdfDHRhroqki7EcKpZWw5FfCCkDyj+Jyuqq7kPn
         T87ex3mqLiun5qm05Gya2u5tYtVpGJHK0m2WDUqo7BQpQWa3xcS8j2Movb09AZbTFc6+
         NfAzkS2h5Rz+yribCMIWvqatjvOSRZ76g6np6SeRQ/gMaBSr1gcap9NSXF7uZ+98bLMr
         ImGoNPhOkktu7tqDYnZNyTqLoKN56t/GHMa0kT9KFuAoipehI1wLoMuL5gyuFPByMHuk
         IYpHH89sSD6VSYvjIRNpuUhC/G11hPrr3zuafO4caZ2YWL8UB7i6698KXoMB6E70j72u
         kj8w==
X-Gm-Message-State: APjAAAVNWsfWSEl2eJqPOHDtENDHWxZWlrlRu+LJeNZ+mrD8wD/wD92i
        w+2F+LbwQ3rdecEkFVWg4WcPeN8e
X-Google-Smtp-Source: APXvYqzxocNLWKYvSYcczgaY584ECUokmXJnLtJh6U/5Lc3vegsMLBd6J8b3B0DGcE1dDZZvcN558w==
X-Received: by 2002:adf:e2cb:: with SMTP id d11mr29887846wrj.66.1566243147106;
        Mon, 19 Aug 2019 12:32:27 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 74sm28428276wma.15.2019.08.19.12.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 12:32:26 -0700 (PDT)
Date:   Mon, 19 Aug 2019 21:32:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 27/44] posix-cpu-timers: Provide array based access to
 expiry cache
Message-ID: <20190819193224.GD68079@gmail.com>
References: <20190819143141.221906747@linutronix.de>
 <20190819143803.961800814@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143803.961800814@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Using struct task_cputime for the expiry cache is a pretty odd choice and
> comes with magic defines to rename the fields for usage in the expiry
> cache.
> 
> struct task_cputime is basically a u64 array with 3 members, but it has
> distinct members.
> 
> The expiry cache content is different than the content of task_cputime
> because
> 
>   expiry[PROF]  = task_cputime.stime + task_cputime.utime
>   expiry[VIRT]  = task_cputime.utime
>   expiry[SCHED] = task_cputime.sum_exec_runtime
> 
> So there is no direct mapping between task_cputime and the expiry cache and
> the #define based remapping is just a horrible hack.

>  struct posix_cputimers {
> -	struct task_cputime	cputime_expires;
> -	struct list_head	cpu_timers[CPUCLOCK_MAX];
> +	/* Temporary union until all users are cleaned up */
> +	union {
> +		struct task_cputime	cputime_expires;
> +		u64			expiries[CPUCLOCK_MAX];
> +	};
> +	struct list_head		cpu_timers[CPUCLOCK_MAX];
>  };

Could we please name this first_expiry[] or such, to make it clear that 
this is cached value of the first expiry of all timers of this process, 
instead of the rather vague 'expiries[]' naming?

Also, while at it, after the above temporary transition union, the final 
structure becomes:

 struct posix_cputimers {
       u64                     expiries[CPUCLOCK_MAX];
       struct list_head        cpu_timers[CPUCLOCK_MAX];
 };

Wouldn't it be more natural and easier to read to have the list head and 
the expiry together:

	struct posix_cputimer_list {
		u64				first_expiry;
		struct list_head		list;
	};

	struct posix_cputimers {
		struct posix_cputimer_list	timers[CPUCLOCK_MAX];
	};

?

This makes the array structure rather clear and the first_expiry field 
mostly self-documenting.

Thanks,

	Ingo

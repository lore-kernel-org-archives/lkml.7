Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA4DC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F032020656
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUfvvAZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfEJFu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 01:50:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46579 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfEJFu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 01:50:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id t187so2430316pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 22:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7DNbQy+XeUwJNnsLrbsf7GgVt3vG1E1+vrBOysMv8YE=;
        b=pUfvvAZFqUVTiqjxv40mkHsNUmq7PBox1pFF166ZopvOvdfQGvbOVJnOm+aoJu5sEz
         DOggZuoz45ZIDa8GI90MV1/vdHaAAtQI9uW956G/4MxykZgBJ2dWMiXvBvfSHjOFwgFO
         /H0TseWHxGUXAS4l8bz4i3L4KVPE7Ts5JNHc7z4SLbLGzOGL7XDZuY3s+d85vDTOMcBO
         0KezU2gXMeA0eGAB4od6jTnHD0HZmFlH0OXeiTpfzy2NhQdcpFyHsUTxdOz8w2oL6U4o
         xXOdPK6D0yIW2TzK4KruW/bOPNR9VrQJG3ue4SDSTv3AHdmqAvYgCpT6pVAQyxERl4ge
         tf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7DNbQy+XeUwJNnsLrbsf7GgVt3vG1E1+vrBOysMv8YE=;
        b=S4MN/yLrtReVtkbwURAwJxXU5FaCMd8LLsOcJp5DL8bFscBjY/ZMTefY9JtlyHiRkv
         UO/xgcVpeyfBIUJV1x0SuN0T+s8xsaBx3dMCCbYFbAqvVo4SceSQQgjwBPWRVW5VYdnB
         +rQdKt7Bb0LzZs96SDYq61O0SaaTurbxwKViWl8bdSVmQG9eYgc72LZuAJRi4ljOsZap
         b8xpAq9x1qa7mCpdGUuFLWs0h6dNhoh91FBpr4uY0Ihonqwv7KCfOLPqj7BwlnUWwGdE
         m/HuaZoDRqnpM3W0Eho94ObYf9Lq59ZYgSZwNUQnmWdX1LkETDFqeImd/fd89iiokQfm
         9m2w==
X-Gm-Message-State: APjAAAXlOyzZxxZmubrEdTV/kV7rv9TNkuGrE1cW+nYeWUm71EK3o3to
        RShIININiHjZOdM5V/8Owko=
X-Google-Smtp-Source: APXvYqzoTTJJuY7emFpyseXgmhhtAkOmA0sg3IQDQa3Kp5WUeM/5FO2g9Cz09UPUzVof3g3O+Df1Sg==
X-Received: by 2002:a63:a55:: with SMTP id z21mr11336025pgk.440.1557467457679;
        Thu, 09 May 2019 22:50:57 -0700 (PDT)
Received: from localhost ([39.7.15.25])
        by smtp.gmail.com with ESMTPSA id i12sm4613535pgb.61.2019.05.09.22.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 22:50:56 -0700 (PDT)
Date:   Fri, 10 May 2019 14:50:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/locking/semaphore: use wake_q in up()
Message-ID: <20190510055053.GA9864@jagdpanzerIV>
References: <20190509120903.28939-1-daniel.vetter@ffwll.ch>
 <20190509200633.19678-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509200633.19678-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/09/19 22:06), Daniel Vetter wrote:
[..]
> +/* Functions for the contended case */
> +
> +struct semaphore_waiter {
> +	struct list_head list;
> +	struct task_struct *task;
> +	bool up;
> +};
> +
>  /**
>   * up - release the semaphore
>   * @sem: the semaphore to release
> @@ -179,24 +187,25 @@ EXPORT_SYMBOL(down_timeout);
>  void up(struct semaphore *sem)
>  {
>  	unsigned long flags;
> +	struct semaphore_waiter *waiter;
> +	DEFINE_WAKE_Q(wake_q);
>  
>  	raw_spin_lock_irqsave(&sem->lock, flags);
> -	if (likely(list_empty(&sem->wait_list)))
> +	if (likely(list_empty(&sem->wait_list))) {
>  		sem->count++;
> -	else
> -		__up(sem);
> +	} else {
> +		waiter =  list_first_entry(&sem->wait_list,
> +					   struct semaphore_waiter, list);
> +		list_del(&waiter->list);
> +		waiter->up = true;
> +		wake_q_add(&wake_q, waiter->task);
> +	}
>  	raw_spin_unlock_irqrestore(&sem->lock, flags);

So the new code still can printk/WARN under sem->lock in some buggy
cases.

E.g.
	wake_q_add()
	 get_task_struct()
	  refcount_inc_checked()
	   WARN_ONCE()

Are we fine with that?

	-ss

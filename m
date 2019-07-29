Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB118C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886402070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfG2I5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:57:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38671 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG2I5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:57:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so60895177wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 01:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GU8Bvnm5AE0VXkANPpUl4+WscmSB0FOHcgJpamxiC9E=;
        b=RePskPjAV87coQThHv98miwIh3GnjARnR62+EI2xArMFinOYDtLTUMKKorwT2/cWVt
         AKAufm5er6kHGprlfvHZqHji5/T447OqbhSppo96obi+SW93yJEzwQic38TZ2rfGpWS+
         RJFwNrCaQ24nmpz4iS1FpcYhDgvayznpVVbAy7QQCwM4Bo7JeIQzmRrW7Va8U3TvjMtH
         vhI1mTb3V8zPriz/EXaJqjfJ+K1+q8IBLAoJpDbvvKZ7Vx/ysWnOpsJ9XJCYmgFkzoAy
         rwpYDrBTTP5tYL35c3LRu3BTYMAGYCpettx/nxP6eODys0WYuKCjEynvgcXob93AL/7z
         T4Rg==
X-Gm-Message-State: APjAAAXaOUAt3riygh0iTjTTBU38OhIrw1wgp624j43Om5FGQc4tyeYE
        1RhAXJZVyE6MuzLkuuvLWj+dEA==
X-Google-Smtp-Source: APXvYqxMlgLy0o+hJvyxEmX2tJZjwuv5PqV8XMU567WW6hpg++Fqoqfz2NV9iO5OfIAZ1QQLvH//yQ==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr17604836wrw.178.1564390634485;
        Mon, 29 Jul 2019 01:57:14 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id 17sm52608965wmx.47.2019.07.29.01.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 01:57:13 -0700 (PDT)
Date:   Mon, 29 Jul 2019 10:57:11 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
Message-ID: <20190729085711.GQ25636@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.397880775@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726161357.397880775@infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/07/19 16:54, Peter Zijlstra wrote:
> 
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/sched/sysctl.h |    3 +++
>  kernel/sched/deadline.c      |   23 +++++++++++++++++++++--
>  kernel/sysctl.c              |   14 ++++++++++++++
>  3 files changed, 38 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -56,6 +56,9 @@ int sched_proc_update_handler(struct ctl
>  extern unsigned int sysctl_sched_rt_period;
>  extern int sysctl_sched_rt_runtime;
>  
> +extern unsigned int sysctl_sched_dl_period_max;
> +extern unsigned int sysctl_sched_dl_period_min;
> +
>  #ifdef CONFIG_UCLAMP_TASK
>  extern unsigned int sysctl_sched_uclamp_util_min;
>  extern unsigned int sysctl_sched_uclamp_util_max;
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2597,6 +2597,14 @@ void __getparam_dl(struct task_struct *p
>  }
>  
>  /*
> + * Default limits for DL period; on the top end we guard against small util
> + * tasks still getting rediculous long effective runtimes, on the bottom end we

s/rediculous/ridiculous/

> + * guard against timer DoS.
> + */
> +unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4 seconds */
> +unsigned int sysctl_sched_dl_period_min = 100;     /* 100 us */

These limits look sane to me. I've actually been experimenting with 10us
period tasks and throttling seemed to behave fine, but I guess 100us is
a saner default.

So, (with a few lines of changelog :)

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks for doing this.

Best,

Juri

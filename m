Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B32DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2877A2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfI0ILs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:11:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfI0ILq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:11:46 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E80C9CA38C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 08:11:45 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id m14so680609wru.17
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 01:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pPrTuKk2wLdZOfUDuO7yrMjO/e9382JtMmczzGLdwP4=;
        b=XpynXCmjMtFs/vIy4aI9C1j6gaI8rBSt1liGm5Uaii0vvyr+o44moCGL9H9alObIba
         qEcpFicd3rNt6BYf1GfdTiOmsptJPZFA/oeEY1MtDjfDG7tEjVF7+33iX2rfcsByBrV8
         XS6QWwOxfBGHxn62Kd9Ov9IyDnJfNmnrofkUoQmfyGKsHhwEunzQikXg0sYfd1LbdVKI
         IALlWfYu7lwcMIxyZ9tDWCW+dWCCXN9L5fUcA1c4F6fcwOg+cW26dNM7bxCsluW8MT/W
         oYKIQTpkugaeKJZws2SHb2T8I14UAbSIQ4EMlpfPXVmNEoZpBoz5KMUiSiwY4cUNJcWp
         i+oQ==
X-Gm-Message-State: APjAAAXVt2msnkxg/HfSCcXOL6ltc8zkR/sMZXoZeRG3xvdYBb4qwDP8
        wWKLgvNdWlTl8AT7Tqkfg/ifi2HbA+CqkwP6kLVS6KCiEUQKwxdgrOtlTIYo4yKXw4ko6Au4pYs
        fWyTKEHjfUrmq+4aE5Anyt+hX
X-Received: by 2002:a1c:7418:: with SMTP id p24mr5857440wmc.132.1569571904507;
        Fri, 27 Sep 2019 01:11:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAwxtJAN4HD53FB2NTvALXb2oR6uoMP4Tujox2rhYOh66Hcxkn+J2iVBsOgpM7gJWutAgtJg==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr5857414wmc.132.1569571904151;
        Fri, 27 Sep 2019 01:11:44 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.241])
        by smtp.gmail.com with ESMTPSA id q3sm1688984wrm.86.2019.09.27.01.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Sep 2019 01:11:43 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:11:41 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 5/8] sched/deadline: Reclaim cpuset bandwidth in
 .migrate_task_rq()
Message-ID: <20190927081141.GB31660@localhost.localdomain>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-6-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727055638.20443-6-swood@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

On 27/07/19 00:56, Scott Wood wrote:
> With the changes to migrate disabling, ->set_cpus_allowed() no longer
> gets deferred until migrate_enable().  To avoid releasing the bandwidth
> while the task may still be executing on the old CPU, move the subtraction
> to ->migrate_task_rq().
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/sched/deadline.c | 67 +++++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c18be51f7608..2f18d0cf1b56 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1606,14 +1606,42 @@ static void yield_task_dl(struct rq *rq)
>  	return cpu;
>  }
>  
> +static void free_old_cpuset_bw_dl(struct rq *rq, struct task_struct *p)
> +{
> +	struct root_domain *src_rd = rq->rd;
> +
> +	/*
> +	 * Migrating a SCHED_DEADLINE task between exclusive
> +	 * cpusets (different root_domains) entails a bandwidth
> +	 * update. We already made space for us in the destination
> +	 * domain (see cpuset_can_attach()).
> +	 */
> +	if (!cpumask_intersects(src_rd->span, p->cpus_ptr)) {
> +		struct dl_bw *src_dl_b;
> +
> +		src_dl_b = dl_bw_of(cpu_of(rq));
> +		/*
> +		 * We now free resources of the root_domain we are migrating
> +		 * off. In the worst case, sched_setattr() may temporary fail
> +		 * until we complete the update.
> +		 */
> +		raw_spin_lock(&src_dl_b->lock);
> +		__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
> +		raw_spin_unlock(&src_dl_b->lock);
> +	}
> +}
> +
>  static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
>  {
>  	struct rq *rq;
>  
> -	if (p->state != TASK_WAKING)
> +	rq = task_rq(p);
> +
> +	if (p->state != TASK_WAKING) {
> +		free_old_cpuset_bw_dl(rq, p);

What happens if a DEADLINE task is moved between cpusets while it was
sleeping? Don't we miss removing from the old cpuset if the task gets
migrated on wakeup?

Thanks,

Juri

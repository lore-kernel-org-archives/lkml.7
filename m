Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C2FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAED120644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLwXX0id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfEHHoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:44:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44077 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfEHHoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:44:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so5484169plj.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t80PqPxL5SXwBZR4z2Cp1FO/rGd8hfnknFlQn+mAx7Q=;
        b=dLwXX0idD9lCs/qVE7sjTvQveBUcNyKoLV+y4Z8HPpDrcAqjSqUYhPhdTpWxo6R+IY
         uYUIyNHoYDCTmlcDdaC6VM2oZqMsISaw4MmL4+O1toG1ZUipTASZpt8SxHLCnMwhhnfR
         H7s9rqzEgDz4Y1yPplptZeINxTVu1YzizY21Skdkfi5JpNUfIeCPkUhGbKsoYwqh3D2z
         ps1LcOKPZCSxbh7qiT83ZoeBkODuPVuZlIPwH5ufp9aW9vnW4u71BhVkNccANBCZO+3x
         W2+lsR2oZkumAfM4p+9qhN2uHJtqjpUpuLpcjdPYHXfHRP+GmNnV3IvrRAcJXcZfraaw
         ccng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t80PqPxL5SXwBZR4z2Cp1FO/rGd8hfnknFlQn+mAx7Q=;
        b=cWL6wo9fvBVl/OIJCNw7OXOZNx61Z9ReiAeQu7AMPlh3/n3/zbGgA8EqXVGGaA3a+U
         C7Sh6VoiQ7+MdbSpuySbwXtBs666mqJKGM/IL17SAWITrthSeL3ZqABtRqx/uDXmaW0g
         Wl/tWLfN0jm8hQLL6okWF5Z0nVx/Mi3bzWWIYQSvSb2rfw0z6p7fWlhtDTf6ZV3euCvc
         IbtVii28OqS03KkblbODJKoAADwTOXcw4uWurecIg1B/L63/6ZSiUhhCxyh3yL2MRnpc
         PGKjWIivBzlHCQEdlLkXtXBVKmYkEXVrvQu2ixm+AcmEzbuK4AzpzyVKINv07UZOoN+I
         S5zQ==
X-Gm-Message-State: APjAAAWargPOtPfkSl6lOhPdnmMgwGk391ParQ6yCTkJ+ruN4AXn9wVJ
        2OmMMjpPAZjr69oMZTornS0=
X-Google-Smtp-Source: APXvYqxcME1oVZjtW+nCiWuli098ONKaXJvu5AqLaXfoYbyopBFcLqfHsgLE+0N+N+OLJJ9VHWCQeQ==
X-Received: by 2002:a17:902:5c5:: with SMTP id f63mr44261175plf.327.1557301464646;
        Wed, 08 May 2019 00:44:24 -0700 (PDT)
Received: from localhost ([175.223.21.172])
        by smtp.gmail.com with ESMTPSA id m11sm21390465pgd.12.2019.05.08.00.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 00:44:23 -0700 (PDT)
Date:   Wed, 8 May 2019 16:44:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] RFC: x86/smp: use printk_deferred in
 native_smp_send_reschedule
Message-ID: <20190508074420.GB15704@jagdpanzerIV>
References: <20190507173329.17031-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507173329.17031-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/07/19 19:33), Daniel Vetter wrote:
[..]
> - make the console_trylock trylock also the spinlock. This works in
>   the limited case of the console_lock use-case, but doesn't fix the
>   same semaphore.lock acquisition in the up() path in console_unlock,
>   which we can't avoid with a trylock.
> 
> - move the wake_up_process in up() out from under the semaphore.lock
>   spinlock critical section. Again this works for the limited case of
>   the console_lock, and does fully break the cycle for this lock.
>   Unfortunately there's still plenty of scheduler related locks that
>   wake_up_process needs, so the loop is still there, just with a few
>   less locks involved.
> 
> Hence now third attempt, trying to fix this by using printk_deferred()
> instead of the normal printk that WARN() uses.
> native_smp_send_reschedule is only called from scheduler related code,
> which has to use printk_deferred due to this locking recursion, so
> this seems consistent.
> 
> It has the unfortunate downside that we're losing the backtrace though
> (I didn't find a printk_deferred version of WARN, and I'm not sure
> it's a bright idea to dump that much using printk_deferred.)

I'm catching up with the emails now (was offline for almost 2 weeks),
so I haven't seen [yet] all of the previous patches/discussions.

[..]
>  static void native_smp_send_reschedule(int cpu)
>  {
>  	if (unlikely(cpu_is_offline(cpu))) {
> -		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
> +		printk_deferred(KERN_WARNING
> +				"sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
>  		return;
>  	}
>  	apic->send_IPI(cpu, RESCHEDULE_VECTOR);

Hmm,
One thing to notice here is that the CPU in question is offline-ed,
and printk_deferred() is a per-CPU type of deferred printk(). So the
following thing

	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));

might not print anything at all. In this particular case we always
need another CPU to do console_unlock(), since this_cpu() is not
really expected to do wake_up_klogd_work_func()->console_unlock().

	-ss

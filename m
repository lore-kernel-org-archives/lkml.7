Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4F2C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58FD214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfFZWnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:43:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50671 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFZWnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:43:10 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgGd5-0000mK-Nx; Thu, 27 Jun 2019 00:43:04 +0200
Date:   Thu, 27 Jun 2019 00:43:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] timer: document TIMER_PINNED
In-Reply-To: <20190618004356.10357-1-peterx@redhat.com>
Message-ID: <alpine.DEB.2.21.1906270034520.32342@nanos.tec.linutronix.de>
References: <20190618004356.10357-1-peterx@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Tue, 18 Jun 2019, Peter Xu wrote:
> -/*
> - * A deferrable timer will work normally when the system is busy, but
> - * will not cause a CPU to come out of idle just to service it; instead,
> - * the timer will be serviced when the CPU eventually wakes up with a
> - * subsequent non-deferrable timer.
> +/**
> + * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
> + * system is busy, but will not cause a CPU to come out of idle just
> + * to service it; instead, the timer will be serviced when the CPU
> + * eventually wakes up with a subsequent non-deferrable timer.
>   *
> - * An irqsafe timer is executed with IRQ disabled and it's safe to wait for
> - * the completion of the running instance from IRQ handlers, for example,
> - * by calling del_timer_sync().
> + * @TIMER_IRQSAFE: An irqsafe timer is executed with IRQ disabled and
> + * it's safe to wait for the completion of the running instance from
> + * IRQ handlers, for example, by calling del_timer_sync().
>   *
>   * Note: The irq disabled callback execution is a special case for
>   * workqueue locking issues. It's not meant for executing random crap
>   * with interrupts disabled. Abuse is monitored!
> + *
> + * @TIMER_PINNED: A pinned timer will not be affected by timer
> + * migration so it will always be run on a static cpu that was
> + * specified.

That's a bit misleading.

The timer pinned flag prevents the MOHZ timer placement heuristics to take
effect. That means that the timer is enqueued on the CPU on which the
enqueue function is invoked. 

> + * Note: neither timer_setup() nor mod_timer() will
> + * guarantee correct pinning of timers.  One should always use
> + * add_timer_on() when arm the timer to guarantee that the timer will
> + * be pinned to the target CPU correctly.

I'd rather say:

    That means that pinned timers are not guaranteed to stay on the
    initialy selected CPU. They move to the CPU on which the enqueue
    function is invoked via mod_timer() or add_timer().

    If the timer should be placed on a particular CPU then add_timer_on()
    has to be used.

Or something like that. Too tired to think about it right now, but you get
the idea.

Thanks,

	tglx

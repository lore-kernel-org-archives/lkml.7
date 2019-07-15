Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD753C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F7820659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCcm9G8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbfGOTrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:47:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55855 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbfGOTrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:47:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so16349180wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=oaprakcM0ZsBLgl1WvEc7yTP7kJj1QYuRyXuOP6H0s0=;
        b=UCcm9G8ClQRhN9otlsYaHWolKg9WD7Bd8Gnz7UUuvOw8AUf3+eza2zLYq1vq938kVB
         TCcafyovNuIiIdZfemn+yPWhI6mCqPu7GDZre892ubSvc98YV4hgWP7cB29zzJAfI9Ad
         mXfT2nYbqpw2hIy03yXiiipTWGlZ+3ZCmphI453L4OvyGju0EIAJg9W6ToYI2JLQSgf6
         vON8JF7AdmqTlBgdng2ZrVFtsZyHeJbGO5U4yLjqrm6dKnk41z4GOt+PmsgPddb8ulN0
         GM1+VigBvP7C4WIG0mEbWXiukWTEC1X/jmkOiGqqBV2I+z5DyrBlVB0S9gGu/BmC1TuJ
         4SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=oaprakcM0ZsBLgl1WvEc7yTP7kJj1QYuRyXuOP6H0s0=;
        b=KCGS6O1BSvq98350KFVrFnnUkIFqnfiOo6XNdm9Um0dvzHBySc4b//J5NzMrMZNQat
         pFlXz7LNnTFhQPTZ+7chxLzMAXU2v/JsWzXJ2/hWEriIkZ3rPuIR0HXwaVHqFY3z/k7f
         O57/IbGTTam6HxRJvWheds8WNX9HvAh31MqrUdNUQoiChoXIepGR9qWb1o/E/CaqRhpg
         tVG7irgLSPD4AEj5qN42KhqRw7Vz//tqysepOq6psQDG0umZgk2eSwBvCsmJyfrQoSKk
         f12NMVYgAybeb0zXEhu6YgnSDE+4jFTW0splaE6GjWnSC6Fz8qVGlyqMJWbGKNzeXYse
         Ixjg==
X-Gm-Message-State: APjAAAVtBwEXqcR9Ar5zcbEKqJC2O9RFR5NQIMg4SafIanlXR6dcJ2j0
        aK+A+YDi08a1LJty+KlZE+E=
X-Google-Smtp-Source: APXvYqycAln9pjBfy0nKk7M4yHfbZosdZAVfzy9a0t6b6joYjqdl9mv5ofnAcvjYD4jtFKDs2FTQAg==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr26794614wmg.6.1563220049215;
        Mon, 15 Jul 2019 12:47:29 -0700 (PDT)
Received: from felia ([2001:16b8:2dc5:2000:cd36:d602:4f2d:7917])
        by smtp.gmail.com with ESMTPSA id q1sm15229393wmq.25.2019.07.15.12.47.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 12:47:28 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 15 Jul 2019 21:47:27 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <clark.williams@gmail.com>,
        Julia Cartwright <julia@ni.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 1/1] Kconfig: Introduce CONFIG_PREEMPT_RT
In-Reply-To: <20190715150601.205143057@linutronix.de>
Message-ID: <alpine.DEB.2.21.1907152144010.2564@felia>
References: <20190715150402.798499167@linutronix.de> <20190715150601.205143057@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Jul 2019, Thomas Gleixner wrote:

> Add a new entry to the preemption menu which enables the real-time support
> for the kernel. The choice is only enabled when an architecture supports
> it.
> 
> It selects PREEMPT as the RT features depend on it. To achieve that the
> existing PREEMPT choice is renamed to PREEMPT_LL which select PREEMPT as
> well.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/Kconfig           |    3 +++
>  kernel/Kconfig.preempt |   25 +++++++++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -809,6 +809,9 @@ config ARCH_NO_COHERENT_DMA_MMAP
>  config ARCH_NO_PREEMPT
>  	bool
>  
> +config ARCH_SUPPORTS_RT
> +	bool
> +
>  config CPU_NO_EFFICIENT_FFS
>  	def_bool n
>  
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -35,10 +35,10 @@ config PREEMPT_VOLUNTARY
>  
>  	  Select this if you are building a kernel for a desktop system.
>  
> -config PREEMPT
> +config PREEMPT_LL
>  	bool "Preemptible Kernel (Low-Latency Desktop)"
>  	depends on !ARCH_NO_PREEMPT
> -	select PREEMPT_COUNT
> +	select PREEMPT
>  	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
>  	help
>  	  This option reduces the latency of the kernel by making
> @@ -55,7 +55,28 @@ config PREEMPT
>  	  embedded system with latency requirements in the milliseconds
>  	  range.
>  
> +config PREEMPT_RT
> +	bool "Fully Preemptible Kernel (Real-Time)"
> +	depends on EXPERT && ARCH_SUPPORTS_RT
> +	select PREEMPT
> +	help
> +	  This option turns the kernel into a real-time kernel by replacing
> +	  various locking primitives (spinlocks, rwlocks, etc) with
> +	  preemptible priority-inheritance aware variants, enforcing
> +	  interrupt threading and introducing mechanisms to break up long
> +	  non-preemtible sections. This makes the kernel, except for very

Here is a typo:

s/non-preemtible/non-preemptible/

Nice to see this feature finally getting very close to being merged :)

Lukas

> +	  low level and critical code pathes (entry code, scheduler, low
> +	  level interrupt handling) fully preemtible and brings most
> +	  execution contexts under scheduler control.
> +
> +	  Select this if you are building a kernel for systems which
> +	  require real-time guarantees.
> +
>  endchoice
>  
>  config PREEMPT_COUNT
>         bool
> +
> +config PREEMPT
> +       bool
> +       select PREEMPT_COUNT
> 
> 
> 

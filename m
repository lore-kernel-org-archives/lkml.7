Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A303C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5882064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563317896;
	bh=d1OeQPUJdeASxkXJhbuVtavZaIFUc48bnqlVnewI5kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yzfb67aXD8YdYau3hlMR2EWGX09VduKh9lDyqHZaXbjXbRypmwQR4b5+VuddOt9zr
	 gsPSRp7LJGxdQPYBsfXl2K/JYUA4JW4lMsd/12PhCdKwbow6s03tYEtETtWPwLrVmm
	 FopVt3rcedfGCegmNiMsqaUi7N4O2vbtuXtrz4iM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388925AbfGPW6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:58:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36412 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbfGPW6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:58:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so16092849wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 15:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DnTaPvcy0KH7cH1iTW8cw8f8cSszGtQ1CMxkqbquSDQ=;
        b=JcTtUh3UyN0H1+1xtHih7oZdy0jeBMQDuwMRgHxAJ0Az+HckuhrGL+0KsBCQ8CBnrr
         E2dLU7l3yhZAO02n/0osX8p29AWcdPqFfmjqgCg3QJj3Dw/57WSeveEmcJoZuuLzZvgb
         r50XK9Pm64rZhbNkdYbT8JpnS1P5oJx/I7rSmy8CyfSS7XyTbczD0l96/XcTRAxHQZoV
         03cE/AgRuOXE9AsASBh+Jx/aSYvH2dd5YI77PqL9ObTfaeVxfFAxg+sist6elsYWZkVC
         l0fAvXkAfaDeWkOsIwleRw1VBrcIgjo10xzIlbSyOprghtLspVbZXQ1dzR+Z3png82oL
         RcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DnTaPvcy0KH7cH1iTW8cw8f8cSszGtQ1CMxkqbquSDQ=;
        b=D+m/0LR9HSesoP3DWsRH89K0qdlOh+Cs1PpLAt8LI5VNXk6WsFg2QldOewvfhxJlFF
         XOlKRpDZ1FlBQhHWTLYCFsxlmBq95ge8Yh4FgDhaiawware8oN/ssNoKvLPTFpUL0Zc1
         fK3t1U3bKC/sdarwIbJRWCcHK8RVPXAIknD8r+hZQTwpoiB1LraxrUspNS54u31MQiJz
         MGf3vYyi9H+BGG1kmVL9ZmmdroB3OwxmVXgo8zuEThIdTHMyQOtjhEttrotZWx7x1ORQ
         B1RNcs17FDJR+Yx3pFIDV2jMggIEjWA1RBTL3gAt1E1941AjNKz8c/uEC8uhMrHeQmum
         yISg==
X-Gm-Message-State: APjAAAXAUxxrFNFWbcGXzEAHNGBfWPf57+2sR7EN5N3XFPy+VE8XQZNf
        y5MPdceQti9p3/J0euqGbA7TJaCM
X-Google-Smtp-Source: APXvYqyTAbi/PI1AfOMly+pE6fA0FLxhsNEKujDD8AbQa12uw+wAVxsDogo6v7LYRBl3VsdpNXqfWA==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr32543226wmi.38.1563317892239;
        Tue, 16 Jul 2019 15:58:12 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e19sm30406864wra.71.2019.07.16.15.58.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:58:11 -0700 (PDT)
Date:   Wed, 17 Jul 2019 00:58:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20190716225809.GA50617@gmail.com>
References: <20190715150402.798499167@linutronix.de>
 <20190715150601.205143057@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715150601.205143057@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

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

s/etc/etc.

> +	  preemptible priority-inheritance aware variants, enforcing
> +	  interrupt threading and introducing mechanisms to break up long
> +	  non-preemtible sections. This makes the kernel, except for very

s/preemtible/preemptible

> +	  low level and critical code pathes (entry code, scheduler, low
> +	  level interrupt handling) fully preemtible and brings most

s/preemtible/preemptible

> +	  execution contexts under scheduler control.
> +
> +	  Select this if you are building a kernel for systems which
> +	  require real-time guarantees.

Nice to see this getting started! :-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

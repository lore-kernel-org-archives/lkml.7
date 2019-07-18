Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDC4C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358CB21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563477819;
	bh=cl4chmJfGrtFs/C/yZpzQPOkVkMTOGa0056pV1iOO1k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=EmYxc/B/SdPqovEjrLVaYH0WlfB5Pz+iKMlwrucsyHUQUXHuZ7jPUdxbeHtieuC6i
	 CAO5mL7nwB539xJNeXNGxi5JlxhLv17YjQjmgHBcVJmtlR4MdoufhbiAWioSGLFJXe
	 Z6oCI8X8zrZGkgbI0+z0C+J9Xc+AosYjhbfBcZb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403777AbfGRTXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390241AbfGRTXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:23:37 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13822173B;
        Thu, 18 Jul 2019 19:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563477816;
        bh=cl4chmJfGrtFs/C/yZpzQPOkVkMTOGa0056pV1iOO1k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=0/hb4gbeIlZ19nkcWheImfrWFozPP01Talol7g7GAt/zpJ0Np79KRVq+ihUbIHdxo
         oiwyLZJgDHSEPCyXPDAmNdI9PDfuUfNoNpJZKaK56S7UDDu3jPgwbC0b9YsOabU6+k
         KBydBU1KWFzO9jTL6NCCL200h+ZMCe6SJfvQQJdE=
Message-ID: <1563477813.12300.2.camel@kernel.org>
Subject: Re: [patch V2 1/1] Kconfig: Introduce CONFIG_PREEMPT_RT
From:   Tom Zanussi <zanussi@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        Frederic Weisbecker <frederic@kernel.org>,
        Gratian Crisan <gratian.crisan@ni.com>
Date:   Thu, 18 Jul 2019 14:23:33 -0500
In-Reply-To: <alpine.DEB.2.21.1907172200190.1778@nanos.tec.linutronix.de>
References: <20190715150402.798499167@linutronix.de>
         <20190715150601.205143057@linutronix.de>
         <alpine.DEB.2.21.1907172200190.1778@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2019-07-17 at 22:01 +0200, Thomas Gleixner wrote:
> Add a new entry to the preemption menu which enables the real-time
> support
> for the kernel. The choice is only enabled when an architecture
> supports
> it.
> 
> It selects PREEMPT as the RT features depend on it. To achieve that
> the
> existing PREEMPT choice is renamed to PREEMPT_LL which select PREEMPT
> as
> well.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Acked-by: Clark Williams <williams@redhat.com>
> Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Daniel Wagner <wagi@monom.org>
> ---

As one of the stable-rt maintainers, I'd obviously be very happy to see
this finally go in.  :-)

And will be happy to do what I can to help with the remaining 311...

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>


> V2: Fix typos in help text, collect acks
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
>  	  Select this if you are building a kernel for a desktop
> system.
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
>  	  embedded system with latency requirements in the
> milliseconds
>  	  range.
>  
> +config PREEMPT_RT
> +	bool "Fully Preemptible Kernel (Real-Time)"
> +	depends on EXPERT && ARCH_SUPPORTS_RT
> +	select PREEMPT
> +	help
> +	  This option turns the kernel into a real-time kernel by
> replacing
> +	  various locking primitives (spinlocks, rwlocks, etc.) with
> +	  preemptible priority-inheritance aware variants, enforcing
> +	  interrupt threading and introducing mechanisms to break up
> long
> +	  non-preemptible sections. This makes the kernel, except
> for very
> +	  low level and critical code pathes (entry code, scheduler,
> low
> +	  level interrupt handling) fully preemptible and brings
> most
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

Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93208C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715CC2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbfGPUKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:10:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbfGPUKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:10:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 361C13082B6D;
        Tue, 16 Jul 2019 20:10:48 +0000 (UTC)
Received: from torg (ovpn-122-28.rdu2.redhat.com [10.10.122.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76D2C60C44;
        Tue, 16 Jul 2019 20:10:42 +0000 (UTC)
Date:   Tue, 16 Jul 2019 15:10:40 -0500
From:   Clark Williams <williams@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
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
Message-ID: <20190716151040.04ef9122@torg>
In-Reply-To: <20190715150601.205143057@linutronix.de>
References: <20190715150402.798499167@linutronix.de>
        <20190715150601.205143057@linutronix.de>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 16 Jul 2019 20:10:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019 17:04:03 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

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

Excited to see this Thomas. Now I can start planning to build from a single tree
rather than an RT tree off to the side of RHEL :)

Acked-by: Clark Williams <williams@redhat.com>

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


-- 
The United States Coast Guard
Ruining Natural Selection since 1790

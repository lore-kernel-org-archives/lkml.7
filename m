Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F089C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB29A2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfF1H7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:59:07 -0400
Received: from foss.arm.com ([217.140.110.172]:42262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF1H7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:59:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 740C8344;
        Fri, 28 Jun 2019 00:59:05 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 463993F706;
        Fri, 28 Jun 2019 00:59:04 -0700 (PDT)
Subject: Re: [patch 2/5] genirq: Add optional hardware synchronization for
 shutdown
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Robert Hodaszi <Robert.Hodaszi@digi.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
References: <20190625111353.863718167@linutronix.de>
 <20190625112405.666964552@linutronix.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
 Z46HaNmN2hZS/oJ69c1DI5Rcww==
Organization: ARM Ltd
Message-ID: <dbcd11d3-c967-a0a0-02a6-86d162f93a56@arm.com>
Date:   Fri, 28 Jun 2019 08:59:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190625112405.666964552@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2019 12:13, Thomas Gleixner wrote:
> free_irq() ensures that no hardware interrupt handler is executing on a
> different CPU before actually releasing resources and deactivating the
> interrupt completely in a domain hierarchy.
> 
> But that does not catch the case where the interrupt is on flight at the
> hardware level but not yet serviced by the target CPU. That creates an
> interesing race condition:
> 
>    CPU 0                  CPU 1               IRQ CHIP
> 
>                                               interrupt is raised
>                                               sent to CPU1
> 			  Unable to handle
> 			  immediately
> 			  (interrupts off,
> 			   deep idle delay)
>    mask()
>    ...
>    free()
>      shutdown()
>      synchronize_irq()
>      release_resources()
>                           do_IRQ()
>                             -> resources are not available
> 
> That might be harmless and just trigger a spurious interrupt warning, but
> some interrupt chips might get into a wedged state.
> 
> Provide infrastructure for interrupt chips to provide an optional
> irq_inflight() callback and use it for the synchronization in free_irq().
> 
> synchronize_[hard]irq() are not using this mechanism as it might actually
> deadlock unter certain conditions.
> 
> Fixes: 464d12309e1b ("x86/vector: Switch IOAPIC to global reservation mode")
> Reported-by: Robert Hodaszi <Robert.Hodaszi@digi.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/irq.h |    2 ++
>  kernel/irq/manage.c |   29 ++++++++++++++++++++++++-----
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -418,6 +418,7 @@ static inline irq_hw_number_t irqd_to_hw
>   *			required. This is used for CPU hotplug where the
>   *			target CPU is not yet set in the cpu_online_mask.
>   * @irq_retrigger:	resend an IRQ to the CPU
> + * @irq_inflight:	chip level detection of interrupts in flight (optional)
>   * @irq_set_type:	set the flow type (IRQ_TYPE_LEVEL/etc.) of an IRQ
>   * @irq_set_wake:	enable/disable power-management wake-on of an IRQ
>   * @irq_bus_lock:	function to lock access to slow bus (i2c) chips
> @@ -462,6 +463,7 @@ struct irq_chip {
>  
>  	int		(*irq_set_affinity)(struct irq_data *data, const struct cpumask *dest, bool force);
>  	int		(*irq_retrigger)(struct irq_data *data);
> +	int		(*irq_inflight)(struct irq_data *data);

I wonder how different this irq_inflight() is from the irq_get_irqchip_state()
that can already report a number of states from the HW.

It is also unclear to me how "in flight" maps to the internal state of
the interrupt controller: Is it pending? Acked? If the interrupt has been
masked already, pending should be harmless (the interrupt won't fire anymore).
But seeing it in the acked would probably mean that it is on its way to being
handled, with a potential splat.

>  	int		(*irq_set_type)(struct irq_data *data, unsigned int flow_type);
>  	int		(*irq_set_wake)(struct irq_data *data, unsigned int on);
>  
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -35,8 +35,10 @@ static int __init setup_forced_irqthread
>  early_param("threadirqs", setup_forced_irqthreads);
>  #endif
>  
> -static void __synchronize_hardirq(struct irq_desc *desc)
> +static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
>  {
> +	struct irq_data *irqd = irq_desc_get_irq_data(desc);
> +	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
>  	bool inprogress;
>  
>  	do {
> @@ -52,6 +54,13 @@ static void __synchronize_hardirq(struct
>  		/* Ok, that indicated we're done: double-check carefully. */
>  		raw_spin_lock_irqsave(&desc->lock, flags);
>  		inprogress = irqd_irq_inprogress(&desc->irq_data);
> +
> +		/*
> +		 * If requested and supported, check at the chip whether it
> +		 * is in flight at the hardware level:
> +		 */
> +		if (!inprogress && sync_chip && chip && chip->irq_inflight)
> +			inprogress = chip->irq_inflight(irqd);

To expand on what I was trying to exptree above, I wonder if that would 
be similar to in effect to:

		if (!inprogress && sync_chip && chip && chip->irq_get_irqchip_state)
			chip->irq_get_irqchip_state(irqd, IRQCHIP_STATE_ACTIVE, &inprogress);
				

>  		raw_spin_unlock_irqrestore(&desc->lock, flags);
>  
>  		/* Oops, that failed? */
> @@ -74,13 +83,16 @@ static void __synchronize_hardirq(struct
>   *	Returns: false if a threaded handler is active.
>   *
>   *	This function may be called - with care - from IRQ context.
> + *
> + *	It does not check whether there is an interrupt on flight at the
> + *	hardware level, but not serviced yet, as this might deadlock.
>   */
>  bool synchronize_hardirq(unsigned int irq)
>  {
>  	struct irq_desc *desc = irq_to_desc(irq);
>  
>  	if (desc) {
> -		__synchronize_hardirq(desc);
> +		__synchronize_hardirq(desc, false);
>  		return !atomic_read(&desc->threads_active);
>  	}
>  
> @@ -97,13 +109,16 @@ EXPORT_SYMBOL(synchronize_hardirq);
>   *	holding a resource the IRQ handler may need you will deadlock.
>   *
>   *	This function may be called - with care - from IRQ context.
> + *
> + *	It does not check whether there is an interrupt on flight at the
> + *	hardware level, but not serviced yet, as this might deadlock.
>   */
>  void synchronize_irq(unsigned int irq)
>  {
>  	struct irq_desc *desc = irq_to_desc(irq);
>  
>  	if (desc) {
> -		__synchronize_hardirq(desc);
> +		__synchronize_hardirq(desc, false);
>  		/*
>  		 * We made sure that no hardirq handler is
>  		 * running. Now verify that no threaded handlers are
> @@ -1729,8 +1744,12 @@ static struct irqaction *__free_irq(stru
>  
>  	unregister_handler_proc(irq, action);
>  
> -	/* Make sure it's not being used on another CPU: */
> -	synchronize_hardirq(irq);
> +	/*
> +	 * Make sure it's not being used on another CPU and if the chip
> +	 * supports it also make sure that there is no (not yet serviced)
> +	 * interrupt on flight at the hardware level.
> +	 */
> +	__synchronize_hardirq(desc, true);
>  
>  #ifdef CONFIG_DEBUG_SHIRQ
>  	/*
> 
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

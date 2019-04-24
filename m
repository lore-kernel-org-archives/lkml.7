Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F5CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC302183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfDXUqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:46:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55739 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfDXUqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:46:06 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJOmB-0006LW-96; Wed, 24 Apr 2019 22:45:55 +0200
Date:   Wed, 24 Apr 2019 22:45:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Drake <drake@endlessm.com>
cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael.j.wysocki@intel.com, linux@endlessm.com, hdegoede@redhat.com
Subject: Re: [PATCH 1/2] x86/time: check usability of IRQ0 PIT timer
In-Reply-To: <20190423050354.8025-1-drake@endlessm.com>
Message-ID: <alpine.DEB.2.21.1904242114380.1762@nanos.tec.linutronix.de>
References: <20190423050354.8025-1-drake@endlessm.com>
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

On Tue, 23 Apr 2019, Daniel Drake wrote:
>  /* Default timer init function */
>  void __init hpet_time_init(void)
>  {
> -	if (!hpet_enable())
> -		setup_pit_timer();
> +	if (hpet_enable()) {
> +		setup_default_timer_irq();
> +		return;
> +	}
> +
> +	/* Fall back on legacy 8253 PIT */
> +	setup_pit_timer();
>  	setup_default_timer_irq();
> +
> +	/*
> +	 * Intel SoCs like ApolloLake, Skylake and newer can have
> +	 * their PIT "gated" by the BIOS such that IRQ0 does not
> +	 * tick. Check for that situation here.
> +	 */
> +	if (!irq0_timer_works()) {

So you rely on the fact that the legacy PIC delivery is working
here. That's fragile at best especially when this is a boot of a crash
kernel.

> +		pr_info("HPET is not available, and 8253 timer is not working. "
> +			"Continuing without IRQ0 timer.\n");
> +		remove_default_timer_irq();
> +		remove_pit_timer();
> +	}
> +
> +void __init clockevent_i8253_exit(void)
> +{
> +	clockevents_switch_state(&i8253_clockevent, CLOCK_EVT_STATE_DETACHED);

Smart, but broken. The PIT clockevent is still referenced in the
clockevents core code after the unbind. The unbind logic is there for a
reason and just because the above duct tape does not explode in your face
does not make it more correct. :)

> +	clockevents_unbind_device(&i8253_clockevent, smp_processor_id());

We really want to avoid the whole register and whatever dance at all for
these devices. Let me think about it some more.

Thanks,

	tglx

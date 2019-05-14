Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8272EC04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BB421473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GGnQupwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENOYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:24:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37214 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENOYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hm1UM2Dyzmm4/2VGkCewdkXEur4+eXaud+hFBkvm8Qk=; b=GGnQupwE3Eiry8hhOS4ygjiNFF
        vi4kfYjg7Cwb4Mes22cPrJqw4PhtWwlQhWCgQjKvqMV5BEYulbSQtv578dbW160VOiS0C7n3k1gRJ
        rB7t30DZfC2Qm+RybYTvzpKk9Ph+mdmInmdshJmnoEGuZCExchR0e9APwDvBRi9wf82GpRSvj4SBe
        vfjv/XFfyluXSXsn6l1tUOT0kQZ2Eo1zch0FKRHtdTFzkAqXBinTqleGwenOPTMmKLW99OOImEnge
        BXF41RqpZRAHZA0WZzK8dnbTqR3HKvHzfRrG3aNtgg3sOHWTFyg1lcLPGXZeAaLhFVzxF/0E1jZc1
        mqNZptqQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQYME-0008KZ-5i; Tue, 14 May 2019 14:24:42 +0000
Subject: Re: [RFC PATCH v3 04/21] x86/hpet: Add hpet_set_comparator() for
 periodic and one-shot modes
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
References: <1557842534-4266-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1557842534-4266-5-git-send-email-ricardo.neri-calderon@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3c82f3e0-999c-b389-aa9b-f06919800bb4@infradead.org>
Date:   Tue, 14 May 2019 07:24:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557842534-4266-5-git-send-email-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/19 7:01 AM, Ricardo Neri wrote:
> Instead of setting the timer period directly in hpet_set_periodic(), add a
> new helper function hpet_set_comparator() that only sets the accumulator
> and comparator. hpet_set_periodic() will only prepare the timer for
> periodic mode and leave the expiration programming to
> hpet_set_comparator().
> 
> This new function can also be used by other components (e.g., the HPET-
> based hardlockup detector) which also need to configure HPET timers. Thus,
> add its declaration into the hpet header file.
> 
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Andi Kleen <andi.kleen@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: x86@kernel.org
> Originally-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  arch/x86/include/asm/hpet.h |  1 +
>  arch/x86/kernel/hpet.c      | 57 ++++++++++++++++++++++++++++---------
>  2 files changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
> index f132fbf984d4..e7098740f5ee 100644
> --- a/arch/x86/include/asm/hpet.h
> +++ b/arch/x86/include/asm/hpet.h
> @@ -102,6 +102,7 @@ extern int hpet_rtc_timer_init(void);
>  extern irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id);
>  extern int hpet_register_irq_handler(rtc_irq_handler handler);
>  extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
> +extern void hpet_set_comparator(int num, unsigned int cmp, unsigned int period);
>  
>  #endif /* CONFIG_HPET_EMULATE_RTC */
>  
> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> index 560fc28e1d13..c5c5fc150193 100644
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -289,6 +289,46 @@ static void hpet_legacy_clockevent_register(void)
>  	printk(KERN_DEBUG "hpet clockevent registered\n");
>  }
>  
> +/**
> + * hpet_set_comparator() - Helper function for setting comparator register
> + * @num:	The timer ID
> + * @cmp:	The value to be written to the comparator/accumulator
> + * @period:	The value to be written to the period (0 = oneshot mode)
> + *
> + * Helper function for updating comparator, accumulator and period values.
> + *
> + * In periodic mode, HPET needs HPET_TN_SETVAL to be set before writing
> + * to the Tn_CMP to update the accumulator. Then, HPET needs a second
> + * write (with HPET_TN_SETVAL cleared) to Tn_CMP to set the period.
> + * The HPET_TN_SETVAL bit is automatically cleared after the first write.
> + *
> + * For one-shot mode, HPET_TN_SETVAL does not need to be set.
> + *
> + * See the following documents:
> + *   - Intel IA-PC HPET (High Precision Event Timers) Specification
> + *   - AMD-8111 HyperTransport I/O Hub Data Sheet, Publication # 24674
> + */
> +void hpet_set_comparator(int num, unsigned int cmp, unsigned int period)
> +{
> +	if (period) {
> +		unsigned int v = hpet_readl(HPET_Tn_CFG(num));
> +
> +		hpet_writel(v | HPET_TN_SETVAL, HPET_Tn_CFG(num));
> +	}
> +
> +	hpet_writel(cmp, HPET_Tn_CMP(num));
> +
> +	if (!period)
> +		return;
> +
> +	/* This delay is seldom used: never in one-shot mode and in periodic
> +	 * only when reprogramming the timer.
> +	 */

comment style warning ;)

> +	udelay(1);
> +	hpet_writel(period, HPET_Tn_CMP(num));
> +}
> +EXPORT_SYMBOL_GPL(hpet_set_comparator);
> +
>  static int hpet_set_periodic(struct clock_event_device *evt, int timer)
>  {
>  	unsigned int cfg, cmp, now;
> @@ -300,19 +340,10 @@ static int hpet_set_periodic(struct clock_event_device *evt, int timer)
>  	now = hpet_readl(HPET_COUNTER);
>  	cmp = now + (unsigned int)delta;
>  	cfg = hpet_readl(HPET_Tn_CFG(timer));
> -	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
> -	       HPET_TN_32BIT;
> -	hpet_writel(cfg, HPET_Tn_CFG(timer));
> -	hpet_writel(cmp, HPET_Tn_CMP(timer));
> -	udelay(1);
> -	/*
> -	 * HPET on AMD 81xx needs a second write (with HPET_TN_SETVAL
> -	 * cleared) to T0_CMP to set the period. The HPET_TN_SETVAL
> -	 * bit is automatically cleared after the first write.
> -	 * (See AMD-8111 HyperTransport I/O Hub Data Sheet,
> -	 * Publication # 24674)
> -	 */
> -	hpet_writel((unsigned int)delta, HPET_Tn_CMP(timer));
> +	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_32BIT;
> +
> +	hpet_set_comparator(timer, cmp, (unsigned int)delta);
> +
>  	hpet_start_counter();
>  	hpet_print_config();
>  
> 


-- 
~Randy

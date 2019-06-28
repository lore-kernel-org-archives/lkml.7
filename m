Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B596AC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBD0214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfF1HmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:42:12 -0400
Received: from foss.arm.com ([217.140.110.172]:42084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF1HmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:42:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1BE6344;
        Fri, 28 Jun 2019 00:42:09 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FAA33F706;
        Fri, 28 Jun 2019 00:43:59 -0700 (PDT)
Subject: Re: [patch 1/5] genirq: Delay deactivation in free_irq()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Robert Hodaszi <Robert.Hodaszi@digi.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
References: <20190625111353.863718167@linutronix.de>
 <20190625112405.573914765@linutronix.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
 Z46HaNmN2hZS/oJ69c1DI5Rcww==
Organization: ARM Ltd
Message-ID: <0bb6aae3-744b-7752-04ec-9a0e68fb86e6@arm.com>
Date:   Fri, 28 Jun 2019 08:42:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190625112405.573914765@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 25/06/2019 12:13, Thomas Gleixner wrote:
> When interrupts are shutdown, they are immediately deactivated in the
> irqdomain hierarchy. While this looks obviously correct there is a subtle
> issue:
> 
> There might be an interrupt in flight when free_irq() is invoking the
> shutdown. This is properly handled at the irq descriptor / primary handler
> level, but the deactivation might completely disable resources which are
> required to acknowledge the interrupt.
> 
> Split the shutdown code and deactivate the interrupt after synchronization
> in free_irq(). Fixup all other usage sites where this is not an issue to
> invoke the combined shutdown_and_deactivate() function instead.
> 
> This still might be an issue if the interrupt in flight servicing is
> delayed on a remote CPU beyond the invocation of synchronize_irq(), but
> that cannot be handled at that level and needs to be handled in the
> synchronize_irq() context.
> 
> Fixes: f8264e34965a ("irqdomain: Introduce new interfaces to support hierarchy irqdomains")
> Reported-by: Robert Hodaszi <Robert.Hodaszi@digi.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/irq/autoprobe.c  |    6 +++---
>  kernel/irq/chip.c       |    6 ++++++
>  kernel/irq/cpuhotplug.c |    2 +-
>  kernel/irq/internals.h  |    1 +
>  kernel/irq/manage.c     |   12 +++++++++++-
>  5 files changed, 22 insertions(+), 5 deletions(-)
> 
> --- a/kernel/irq/autoprobe.c
> +++ b/kernel/irq/autoprobe.c
> @@ -90,7 +90,7 @@ unsigned long probe_irq_on(void)
>  			/* It triggered already - consider it spurious. */
>  			if (!(desc->istate & IRQS_WAITING)) {
>  				desc->istate &= ~IRQS_AUTODETECT;
> -				irq_shutdown(desc);
> +				irq_shutdown_and_deactivate(desc);
>  			} else
>  				if (i < 32)
>  					mask |= 1 << i;
> @@ -127,7 +127,7 @@ unsigned int probe_irq_mask(unsigned lon
>  				mask |= 1 << i;
>  
>  			desc->istate &= ~IRQS_AUTODETECT;
> -			irq_shutdown(desc);
> +			irq_shutdown_and_deactivate(desc);
>  		}
>  		raw_spin_unlock_irq(&desc->lock);
>  	}
> @@ -169,7 +169,7 @@ int probe_irq_off(unsigned long val)
>  				nr_of_irqs++;
>  			}
>  			desc->istate &= ~IRQS_AUTODETECT;
> -			irq_shutdown(desc);
> +			irq_shutdown_and_deactivate(desc);
>  		}
>  		raw_spin_unlock_irq(&desc->lock);
>  	}
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -314,6 +314,12 @@ void irq_shutdown(struct irq_desc *desc)
>  		}
>  		irq_state_clr_started(desc);
>  	}
> +}
> +
> +
> +void irq_shutdown_and_deactivate(struct irq_desc *desc)
> +{
> +	irq_shutdown(desc);
>  	/*
>  	 * This must be called even if the interrupt was never started up,
>  	 * because the activation can happen before the interrupt is
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -116,7 +116,7 @@ static bool migrate_one_irq(struct irq_d
>  		 */
>  		if (irqd_affinity_is_managed(d)) {
>  			irqd_set_managed_shutdown(d);
> -			irq_shutdown(desc);
> +			irq_shutdown_and_deactivate(desc);
>  			return false;
>  		}
>  		affinity = cpu_online_mask;
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -82,6 +82,7 @@ extern int irq_activate_and_startup(stru
>  extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
>  
>  extern void irq_shutdown(struct irq_desc *desc);
> +extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
>  extern void irq_enable(struct irq_desc *desc);
>  extern void irq_disable(struct irq_desc *desc);
>  extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/random.h>
>  #include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/sched/rt.h>
> @@ -1699,6 +1700,7 @@ static struct irqaction *__free_irq(stru
>  	/* If this was the last handler, shut down the IRQ line: */
>  	if (!desc->action) {
>  		irq_settings_clr_disable_unlazy(desc);
> +		/* Only shutdown. Deactivate after synchronize_irq() */

synchronize_hardirq()

>  		irq_shutdown(desc);
>  	}
>  
> @@ -1768,6 +1770,14 @@ static struct irqaction *__free_irq(stru
>  		 * require it to deallocate resources over the slow bus.
>  		 */
>  		chip_bus_lock(desc);
> +		/*
> +		 * There is no interrupt on the fly anymore. Deactivate it
> +		 * completely.
> +		 */
> +		raw_spin_lock_irqsave(&desc->lock, flags);
> +		irq_domain_deactivate_irq(&desc->irq_data);
> +		raw_spin_unlock_irqrestore(&desc->lock, flags);
> +
>  		irq_release_resources(desc);
>  		chip_bus_sync_unlock(desc);
>  		irq_remove_timings(desc);
> @@ -1855,7 +1865,7 @@ static const void *__cleanup_nmi(unsigne
>  	}
>  
>  	irq_settings_clr_disable_unlazy(desc);
> -	irq_shutdown(desc);
> +	irq_shutdown_and_deactivate(desc);
>  
>  	irq_release_resources(desc);
The patch makes complete sense, so this comment is only a nit, feel free 
to ignore me: I find it a bit odd that irq_shutdown() doesn't do the 
full thing anymore, given that it is the "canonical" function, and that 
__free_irq is the only one that has special needs. Suggestion below.

Irrespective of which version you prefer:

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 29d6c7d070b4..aeab853fcc10 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -301,7 +301,7 @@ int irq_activate_and_startup(struct irq_desc *desc, bool resend)
 
 static void __irq_disable(struct irq_desc *desc, bool mask);
 
-void irq_shutdown(struct irq_desc *desc)
+void __irq_shutdown(struct irq_desc *desc)
 {
 	if (irqd_is_started(&desc->irq_data)) {
 		desc->depth = 1;
@@ -314,6 +314,11 @@ void irq_shutdown(struct irq_desc *desc)
 		}
 		irq_state_clr_started(desc);
 	}
+}
+
+void irq_shutdown(struct irq_desc *desc)
+{
+	__irq_shutdown(desc);
 	/*
 	 * This must be called even if the interrupt was never started up,
 	 * because the activation can happen before the interrupt is
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 70c3053bc1f6..107f7d342e3d 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -81,6 +81,7 @@ extern int irq_activate(struct irq_desc *desc);
 extern int irq_activate_and_startup(struct irq_desc *desc, bool resend);
 extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
 
+extern void __irq_shutdown(struct irq_desc *desc);
 extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 78f3ddeb7fe4..f19e3589989e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
@@ -1699,7 +1700,8 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	/* If this was the last handler, shut down the IRQ line: */
 	if (!desc->action) {
 		irq_settings_clr_disable_unlazy(desc);
-		irq_shutdown(desc);
+		/* Only shutdown. Deactivate after synchronize_hardirq() */
+		__irq_shutdown(desc);
 	}
 
 #ifdef CONFIG_SMP
@@ -1768,6 +1770,14 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 		 * require it to deallocate resources over the slow bus.
 		 */
 		chip_bus_lock(desc);
+		/*
+		 * There is no interrupt on the fly anymore. Deactivate it
+		 * completely.
+		 */
+		raw_spin_lock_irqsave(&desc->lock, flags);
+		irq_domain_deactivate_irq(&desc->irq_data);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+
 		irq_release_resources(desc);
 		chip_bus_sync_unlock(desc);
 		irq_remove_timings(desc);

-- 
Jazz is not dead. It just smells funny...

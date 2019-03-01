Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13E7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B360320851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbfCAL3V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:29:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58777 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfCAL3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:29:21 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gzgLs-0000cu-4Y; Fri, 01 Mar 2019 12:29:16 +0100
Date:   Fri, 1 Mar 2019 12:29:15 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 20/37] softirq: Introduce disabled softirq vectors bits
Message-ID: <20190301112915.piheydl6pkzc6gde@linutronix.de>
References: <20190228171242.32144-1-frederic@kernel.org>
 <20190228171242.32144-21-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190228171242.32144-21-frederic@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-28 18:12:25 [+0100], Frederic Weisbecker wrote:
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -474,17 +474,62 @@ enum
…
> +static inline unsigned int local_softirq_pending(void)
> +{
> +	return local_softirq_data() & SOFTIRQ_PENDING_MASK;
> +}
…

I'm still digesting but…

> +static inline void softirq_enabled_set(unsigned int enabled)
> +{
> +	unsigned int data;
> +
> +	data = enabled << SOFTIRQ_ENABLED_SHIFT;
> +	data |= local_softirq_pending();

if an interrupt occurs at this point and invokes
	raise_softirq_irqof() => softirq_pending_set_mask()
	
then we lose the pending bits, correct? This may be invoked from
	local_bh_enable() => local_bh_enable_ip_mask() =>
	local_bh_enable_common() => softirq_enabled_set()

and as far as I can, interrupts are only disabled in the tracing case.

> +	__this_cpu_write(local_softirq_data_ref, data);
> +}

Sebastian

Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D64C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DB92148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfCXRoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:44:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43894 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbfCXRoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:44:46 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h87An-0004p2-UV; Sun, 24 Mar 2019 18:44:42 +0100
Date:   Sun, 24 Mar 2019 18:44:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
cc:     rjw@rjwysocki.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] genirq/timings: Add array suffix computation code
In-Reply-To: <20190308212047.28767-3-daniel.lezcano@linaro.org>
Message-ID: <alpine.DEB.2.21.1903241825210.1798@nanos.tec.linutronix.de>
References: <20190308212047.28767-1-daniel.lezcano@linaro.org> <20190308212047.28767-3-daniel.lezcano@linaro.org>
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

Daniel,

On Fri, 8 Mar 2019, Daniel Lezcano wrote:

> The previous variance was discarding values from the timings when they
> were considered as anomalies as stated by the normal law statistical
> model.
> 
> However in the interrupt life, we can have multiple anomalies due to
> the nature of the device generating the interrupts, and most of the
> time we can observe a repeating pattern, that is particulary true for
> network, console, MMC or SSD devices.
> 
> With the variance approach, we miss the patterns and we can only deal with the
> interrupt coming in regular intervals.
> 
> After a long investigation, this patch provides the array suffixes
> derived algorithm where we can detect regular and repeating patterns
> interrupt events.

'This patch', 'we' .... Documentation/process/submitting-patches.rst :)

> +#define EMA_ALPHA_VAL		64
> +#define EMA_ALPHA_SHIFT		7
> +
> +#define PREDICTION_PERIOD_MIN	2
> +#define PREDICTION_PERIOD_MAX	5
> +#define PREDICTION_FACTOR	4
> +#define PREDICTION_MAX		10 /* 2 ^ PREDICTION_MAX useconds */
> +#define PREDICTION_BUFFER_SIZE	16 /* slots for EMAs, hardly more than 16 */
> +
> +struct irqt_stat {
> +	u64	last_ts;
> +	int	ema_time[PREDICTION_BUFFER_SIZE];
> +	int	timings[IRQ_TIMINGS_SIZE];
> +	int	circ_timings[IRQ_TIMINGS_SIZE];
> +	int	count;
> +};
> +
> +/*
> + * Exponential moving average computation
> + */
> +static int irq_timings_ema_new(s64 value, s64 ema_old)

There is a mixed bag of s64/u64 all over this code. Please stay
consistent. We had enough sign confusion bugs in the past.

> +{
> +	if (likely(ema_old))
> +		return ema_old + (((value - ema_old) * EMA_ALPHA_VAL) >>
> +				  EMA_ALPHA_SHIFT);

Eew. really.

> +	return value;

What's wrong with doing:

	if (unlikely(!ema_old))
		return value;

	value = (value - ema_old) * EMA_ALPHA_VAL;
	return ema_old + value >> EMA_ALPHA_SHIFT;

Hmm? Becomes too readable, right?

> +}
> +
> +static int irq_timings_next_event_index(int *buffer, size_t len, int period_max)
> +{
> +	int i;
> +
> +	for (i = period_max; i >= PREDICTION_PERIOD_MIN ; i--) {
> +
> +		int *begin = &buffer[len - (i * 3)];
> +		int *ptr = begin;
> +
> +		while (!memcmp(ptr, begin, i * sizeof(*ptr))) {
> +			ptr += i;
> +			if (ptr >= &buffer[len])
> +				return begin[((i * 3) % i)];
> +		}

Some comment for these magic loops might be helpful.

> +	}
> +
> +	return -1;
> +}
> +
> +static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
> +{
> +	int index, i;
> +	int period_max;
> +	int count, start;
> +	int min = INT_MAX;

Please coalesce same type variables in one line.

> +
> +	if ((now - irqs->last_ts) >= NSEC_PER_SEC) {
> +		irqs->count = irqs->last_ts = 0;
> +		return U64_MAX;
> +	}
> +
> +	period_max = irqs->count > (3 * PREDICTION_PERIOD_MAX) ?
> +		PREDICTION_PERIOD_MAX : irqs->count / 3;
> +
> +	if (period_max <= PREDICTION_PERIOD_MIN)
> +		return U64_MAX;

The above lacks a comment as it's confusing the casual reader.

> +
> +	/*
> +	 * 'count' will depends if the circular buffer wrapped or not
> +	 */
> +	count = irqs->count < IRQ_TIMINGS_SIZE ?
> +		irqs->count : IRQ_TIMINGS_SIZE;
> +
> +	start = irqs->count < IRQ_TIMINGS_SIZE ?
> +		0 : (irqs->count & IRQ_TIMINGS_MASK);
> +
> +	/*
> +	 * Copy the content of the circular buffer into another buffer
> +	 * in order to linearize the buffer instead of dealing with
> +	 * wrapping indexes and shifted array which will be prone to
> +	 * error and extremelly difficult to debug.
> +	 */
> +	for (i = 0; i < count; i++) {
> +		irqs->timings[i] = irqs->circ_timings[(start + i) &
> +						      IRQ_TIMINGS_MASK];

Using helper variables increases readability by avoiding the ugly line
breaks.

> +		min = min_t(int, irqs->timings[i], min);
> +	}
> +
> +	index = irq_timings_next_event_index(irqs->timings, count, period_max);
> +	if (index < 0)
> +		return irqs->last_ts + min;

Again type mismatch. return u64 + int 

> +
> +	return irqs->last_ts + irqs->ema_time[index];
> +}
> +
>  /**
>   * irq_timings_next_event - Return when the next event is supposed to arrive
>   *
> @@ -61,6 +434,12 @@ void irq_timings_disable(void)
>   */
>  u64 irq_timings_next_event(u64 now)
>  {
> +	struct irq_timings *irqts = this_cpu_ptr(&irq_timings);
> +	struct irqt_stat *irqs;
> +	struct irqt_stat __percpu *s;
> +	u64 ts, next_evt = U64_MAX;
> +	int i, irq = 0;
> +
>  	/*
>  	 * This function must be called with the local irq disabled in
>  	 * order to prevent the timings circular buffer to be updated
> @@ -68,7 +447,50 @@ u64 irq_timings_next_event(u64 now)
>  	 */
>  	lockdep_assert_irqs_disabled();
>  
> -	return 0;
> +	if (!irqts->count)
> +		return next_evt;
> +
> +	/*
> +	 * Number of elements in the circular buffer: If it happens it
> +	 * was flushed before, then the number of elements could be
> +	 * smaller than IRQ_TIMINGS_SIZE, so the count is used,
> +	 * otherwise the array size is used as we wrapped. The index
> +	 * begins from zero when we did not wrap. That could be done
> +	 * in a nicer way with the proper circular array structure
> +	 * type but with the cost of extra computation in the
> +	 * interrupt handler hot path. We choose efficiency.
> +	 *
> +	 * Inject measured irq/timestamp to the pattern prediction
> +	 * model while decrementing the counter because we consume the
> +	 * data from our circular buffer.
> +	 */
> +	for (i = (irqts->count & IRQ_TIMINGS_MASK) - 1,
> +		     irqts->count = min(IRQ_TIMINGS_SIZE, irqts->count);
> +	     irqts->count > 0; irqts->count--, i = (i + 1) & IRQ_TIMINGS_MASK) {

Uuurgh, this is unparseable. The initialization of i and irqts->coint can
move before the loop and then the rest becomes readable.

> +
> +		irq = irq_timing_decode(irqts->values[i], &ts);
> +		s = idr_find(&irqt_stats, irq);
> +		if (s)
> +			irq_timings_store(irq, this_cpu_ptr(s), ts);
> +	}

Other than that this looks good to me. Nice work!

Thanks,

	tglx

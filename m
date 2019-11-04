Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51A8CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DF020848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKDTFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:05:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38332 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDTFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:05:32 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iRhfE-0003cU-49; Mon, 04 Nov 2019 20:05:20 +0100
Date:   Mon, 4 Nov 2019 20:05:18 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clocksource/drivers/timer-microchip-pit64b: add
 Microchip PIT64B support
In-Reply-To: <1572880204-4514-3-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <alpine.DEB.2.21.1911041851230.17054@nanos.tec.linutronix.de>
References: <1572880204-4514-1-git-send-email-claudiu.beznea@microchip.com> <1572880204-4514-3-git-send-email-claudiu.beznea@microchip.com>
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

On Mon, 4 Nov 2019, Claudiu Beznea wrote:
> +struct mchp_pit64b_common_data {
> +	void __iomem *base;
> +	struct clk *pclk;
> +	struct clk *gclk;
> +	u64 cycles;
> +	u8 pres;

Can you please make the members tabular for readability sake in all the
structs?

struct mchp_pit64b_common_data {
	void __iomem	*base;
	struct clk	*pclk;
	struct clk	*gclk;
	u64		cycles;
	u8		pres;
};


> +static struct mchp_pit64b_data {
> +	struct mchp_pit64b_clksrc_data *csd;
> +	struct mchp_pit64b_clkevt_data *ced;
> +} data;

This is suboptimal style for two reasons:

     1) Having a seperate struct and instance declaration is way simpler to
     	parse.

     2) Naming a global variable with a generic name is unintuitive and is
     	too easily confused with local variable names. See below.

> +static inline u64 mchp_pit64b_get_period(void __iomem *base)
> +{
> +	u32 lsb, msb;

lsb and msb are not really correct here. They stand for Least/Most
Significant Bit (Byte).

lsw/msw would be more correct, but 'high/low' would be sufficiently self
explaining as well.

      /*
       * Please use proper multi-line comments and not the network style.
       * below. Can you spot the difference?
       */

> +	/* LSB must be read first to guarantee an atomic read of the 64 bit
> +	 * timer.
> +	 */

Does that mean that the hardware latches the upper 32bit when the lower
32bit are read? If so, please write it out.

But aside of that this is fundamentally broken not only on SMP, but also on
UP because the clocksource read function can be called in preemptible
and/or interruptible context.

   thread()
     ktime_get))
       t = clocksource->read()
          low = read(LSW); <- Latches MSW

---> interrupt or preemption

       ktime_get))
         t = clocksource->read()
            low = read(LSW);    <- Latches MSW
	    high = read(MSW);   <- Reads correct MSW

<--- interrupt or preemption ends

          high = read(MSW);     <- Read incorrect MSW

On SMP the same issue exists between two CPUs....

> +	lsb = mchp_pit64b_read(base, MCHP_PIT64B_TLSBR);
> +	msb = mchp_pit64b_read(base, MCHP_PIT64B_TMSBR);

> +static inline void mchp_pit64b_set_period(void __iomem *base, u64 cycles)
> +{
> +	u32 lsb, msb;
> +
> +	lsb = cycles & MCHP_PIT64B_LSBMASK;
> +	msb = cycles >> 32;
> +
> +	/* LSB must be write last to guarantee an atomic update of the timer

s/write/written/

> +	 * even when SMOD=1.
> +	 */
> +	mchp_pit64b_write(base, MCHP_PIT64B_MSB_PR, msb);
> +	mchp_pit64b_write(base, MCHP_PIT64B_LSB_PR, lsb);
> +}
> +
> +static inline void mchp_pit64b_reset(struct mchp_pit64b_common_data *data,

And this is exactly the issue I mentioned above. You have a local argument
name which shadows a global variable name. Bah.

> +				     u32 mode, bool irq_ena)
> +{
> +	mode |= MCHP_PIT64B_PRESCALER(data->pres);
> +	if (data->gclk)
> +		mode |= MCHP_PIT64B_MR_SGCLK;
> +
> +	mchp_pit64b_write(data->base, MCHP_PIT64B_CR, MCHP_PIT64B_CR_SWRST);
> +	mchp_pit64b_write(data->base, MCHP_PIT64B_MR, mode);
> +	mchp_pit64b_set_period(data->base, data->cycles);
> +	if (irq_ena)
> +		mchp_pit64b_write(data->base, MCHP_PIT64B_IER,
> +				  MCHP_PIT64B_IER_PERIOD);

This lacks brackets as after the condition follows a multi-line statement.
It's techincally a single line, but visually a multi-line statement due to
the line break.

> +	mchp_pit64b_write(data->base, MCHP_PIT64B_CR, MCHP_PIT64B_CR_START);
> +}
> +
> +static u64 mchp_pit64b_read_clk(struct clocksource *cs)
> +{
> +	return mchp_pit64b_get_period(data.csd->cd->base);

Lot of indirection here in the hotpath. You surely could avoid touching
multiple cache-lines here by restructuring your data layout so that you
have the only interesting element of 'common data', i.e. base, in the
structure which encapsulates the 'clocksource'.

struct mchp_cs {
	void __iomem		*base;
	struct clocksource 	cs;
};

And then your read function becomes either:
{
    struct mchp_cs *mcs = container_of(cs, struct mchp_cs, cs);

    return read_cs(mcs->base);
}

or if you have he clocksource statically allocated, i.e.:

struct mchp_cs mchp_clksource = { /* init here */ };

{
	return read_cs(mchp_clksource.base);
}
	
> +static u64 mchp_sched_read_clk(void)
> +{
> +	return mchp_pit64b_get_period(data.csd->cd->base);

Ditto

> +
> +static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
> +					     struct clock_event_device *cedev)
> +{
> +	mchp_pit64b_set_period(data.ced->cd->base, evt);
> +	mchp_pit64b_write(data.ced->cd->base, MCHP_PIT64B_CR,
> +			  MCHP_PIT64B_CR_START);

Same issue here.

> +static irqreturn_t mchp_pit64b_interrupt(int irq, void *dev_id)
> +{
> +	struct mchp_pit64b_clkevt_data *irq_data = dev_id;
> +
> +	if (data.ced != irq_data)
> +		return IRQ_NONE;

How is this supposed to happen?

> +
> +	if (mchp_pit64b_read(irq_data->cd->base, MCHP_PIT64B_ISR) &
> +	    MCHP_PIT64B_ISR_PERIOD) {

Why are you reading this from the device and not from the mode information
of the clockevent which would be faster obviously?

> +static int __init mchp_pit64b_pres_compute(u32 *pres, u32 clk_rate,
> +					   u32 max_rate)
> +{
> +	u32 tmp;
> +
> +	for (*pres = 0; *pres < MCHP_PIT64B_PRES_MAX; (*pres)++) {
> +		tmp = clk_rate / (*pres + 1);
> +		if (tmp <= max_rate)
> +			break;
> +	}
> +
> +	if (*pres == MCHP_PIT64B_PRES_MAX)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int __init mchp_pit64b_pres_prepare(struct mchp_pit64b_common_data *cd,
> +					   unsigned long max_rate)
> +{
> +	unsigned long pclk_rate, diff = 0, best_diff = ULONG_MAX;
> +	long gclk_round = 0;
> +	u32 pres, best_pres = 0;
> +	int ret = 0;
> +
> +	pclk_rate = clk_get_rate(cd->pclk);
> +	if (!pclk_rate)
> +		return -EINVAL;
> +
> +	if (cd->gclk) {
> +		gclk_round = clk_round_rate(cd->gclk, max_rate);
> +		if (gclk_round < 0)
> +			goto pclk;
> +
> +		if (pclk_rate / gclk_round < 3)
> +			goto pclk;
> +
> +		ret = mchp_pit64b_pres_compute(&pres, gclk_round, max_rate);
> +		if (ret)
> +			best_diff = abs(gclk_round - max_rate);
> +		else
> +			best_diff = abs(gclk_round / (pres + 1) - max_rate);
> +		best_pres = pres;
> +	}
> +
> +pclk:
> +	/* Check if requested rate could be obtained using PCLK. */
> +	ret = mchp_pit64b_pres_compute(&pres, pclk_rate, max_rate);
> +	if (ret)
> +		diff = abs(pclk_rate - max_rate);
> +	else
> +		diff = abs(pclk_rate / (pres + 1) - max_rate);
> +
> +	if (best_diff > diff) {
> +		/* Use PCLK. */
> +		cd->gclk = NULL;
> +		best_pres = pres;
> +	} else {
> +		clk_set_rate(cd->gclk, gclk_round);
> +	}
> +
> +	cd->pres = best_pres;
> +
> +	pr_info("PIT64B: using clk=%s with prescaler %u, freq=%lu [Hz]\n",
> +		cd->gclk ? "gclk" : "pclk", cd->pres,
> +		cd->gclk ? gclk_round / (cd->pres + 1)
> +			 : pclk_rate / (cd->pres + 1));
> +
> +	return 0;

Lots of undocumented functionality which open codes stuff which exists
already in the clk framework AFAICT.

Why are you not simply implementing this as clk framework components?


            |-----|
  gclk ---->|     |    |---------|
            | MUX |--->| Divider |->
  pclk ---->|     |    |---------|
            |-----|

which is exaxtly how your hardware looks like. The clk framework has all
the selection mechanisms in place and all this conditional clock stuff can
be removed all over the place simply because you just ask for the desired
frequency on init. Also suspend/resume and all the other stuff just works
without all the mess involved.

> +free:
> +	kfree(csd);
> +	data.csd = NULL;

It does not matter here, but for correctness sake this is the wrong
order and triggers my built-in UAF-race detector.

You need to NULL the pointer _before_ freeing the underlying memory.

> +static int __init mchp_pit64b_dt_init(struct device_node *node)
> +{
> +	struct mchp_pit64b_common_data *cd;
> +	u32 irq;
> +	int ret;
> +
> +	if (data.csd && data.ced)
> +		return -EBUSY;

Huch?

> +	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
> +	if (!cd)
> +		return -ENOMEM;

If either data.csd or data.ced exists then the common data exists as
well. Why would you allocate another instance?

> +
> +	cd->pclk = of_clk_get_by_name(node, "pclk");
> +	if (IS_ERR(cd->pclk)) {
> +		ret = PTR_ERR(cd->pclk);
> +		goto free;
> +	}

....

> +	if (!data.ced) {

And here you actually have a conditional which is confusing at best.

> +		irq = irq_of_parse_and_map(node, 0);
> +		if (!irq) {
> +			pr_debug("%s: Failed to get PIT64B clockevent IRQ!\n",
> +				 MCHP_PIT64B_NAME);
> +			ret = -ENODEV;
> +			goto gclk_unprepare;
> +		}
> +		ret = mchp_pit64b_dt_init_clkevt(cd, irq);
> +		if (ret)
> +			goto irq_unmap;
> +	} else {
> +		ret = mchp_pit64b_dt_init_clksrc(cd);
> +		if (ret)
> +			goto gclk_unprepare;
> +	}

So the first invocation of this init function is supposed to init the clock
event device and the second one inits the clock source. And both allocate
common data. How is that common?

Thanks,

	tglx

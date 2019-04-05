Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA88C282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620D821726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDEWMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:12:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50023 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfDEWMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:12:22 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCX4L-0005qK-38; Sat, 06 Apr 2019 00:12:17 +0200
Date:   Sat, 6 Apr 2019 00:12:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jacky Bai <ping.bai@nxp.com>
cc:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 2/2] driver: clocksource: Add nxp system counter timer
 driver support
In-Reply-To: <1554287101-16189-2-git-send-email-ping.bai@nxp.com>
Message-ID: <alpine.DEB.2.21.1904060003140.1802@nanos.tec.linutronix.de>
References: <1554287101-16189-1-git-send-email-ping.bai@nxp.com> <1554287101-16189-2-git-send-email-ping.bai@nxp.com>
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

On Wed, 3 Apr 2019, Jacky Bai wrote:

> From: Bai Ping <ping.bai@nxp.com>
> 
> The system counter (sys_ctr) is a programmable system counter
> which provides a shared time base to the Cortex A15, A7, A53 etc cores.
> It is intended for use in applications where the counter is always
> powered on and supports multiple, unrelated clocks. The sys_ctr hardware
> supports:
>  - 56-bit counter width (roll-over time greater than 40 years)
>  - compare frame(64-bit compare value) contains programmable interrupt
>    generation

I hope that's a <= compare and not a == ....

> +static void sysctr_timer_enable(bool enable)
> +{
> +	u32 val;
> +
> +	val = readl(sys_ctr_base + CMPCR);
> +	val &= ~SYS_CTR_EN;
> +	if (enable)
> +		val |= SYS_CTR_EN;
> +
> +	writel(val, sys_ctr_base + CMPCR);

This read is really just overhead. Why aren't you caching the control
register value? It's not a self modifying register and I don't see
concurrency here either.

> +}
> +
> +static void sysctr_irq_acknowledge(void)
> +{
> +	/*
> +	 * clear the enable bit(EN =0) will clear
> +	 * the status bit(ISTAT = 0), then the interrupt
> +	 * signal will be negated(acknowledged).
> +	 */
> +	sysctr_timer_enable(false);
> +}
> +
> +static inline u64 sysctr_read_counter(void)
> +{
> +	u32 cnt_hi, tmp_hi, cnt_lo;
> +
> +	do {
> +		cnt_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
> +		cnt_lo = readl_relaxed(sys_ctr_base + CNTCV_LO);
> +		tmp_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
> +	} while (tmp_hi != cnt_hi);

When will hardware people finally get it? Is it so damned hard to make the
readout do:

	lo = read_lo()		-> internally latches HI in hardware
	hi = read_hi()		-> reads the latched value

It's not rocket science, but it would spare these horrible read loops. But
sure, performance happens in whitepapers and marketing slides ....

> +
> +	return  ((u64) cnt_hi << 32) | cnt_lo;
> +}
> +
> +static int sysctr_set_next_event(unsigned long delta,
> +				 struct clock_event_device *evt)
> +{
> +	u32 cmp_hi, cmp_lo;
> +	u64 next;
> +
> +	sysctr_timer_enable(false);
> +
> +	next = sysctr_read_counter();
> +
> +	next += delta;
> +
> +	cmp_hi = (next >> 32) & 0x00fffff;
> +	cmp_lo = next & 0xffffffff;
> +
> +	writel_relaxed(cmp_hi, sys_ctr_base + CMPCV_HI);
> +	writel_relaxed(cmp_lo, sys_ctr_base + CMPCV_LO);

Please document that this is a <= comparator. If that's not true then this
function is broken for small deltas and delays between read_counter() and
enable.

> +
> +	sysctr_timer_enable(true);
> +
> +	return 0;
> +}
> +
> +static int sysctr_set_state_oneshot(struct clock_event_device *evt)
> +{
> +	sysctr_timer_enable(true);

That's wrong. Why do you want to enable the timer here? When the state is
set to one shot then the next operation is set_next_event() but before that
nothing should ever come out of the timer.

Thanks,

	tglx

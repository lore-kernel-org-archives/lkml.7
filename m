Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CE2ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F152133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732825AbfJNO2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:28:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNO2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:28:40 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iK1Kr-0001WJ-Uc; Mon, 14 Oct 2019 16:28:34 +0200
Date:   Mon, 14 Oct 2019 16:28:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
cc:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] tick: check if broadcast device could really be
 stopped
In-Reply-To: <16f7e8e9-eefe-5973-a08a-3e1823d20034@st.com>
Message-ID: <alpine.DEB.2.21.1910141620100.2531@nanos.tec.linutronix.de>
References: <20191009160246.17898-1-benjamin.gaignard@st.com> <alpine.DEB.2.21.1910141441350.2531@nanos.tec.linutronix.de> <a4b4b785-c471-a3c2-2c41-01bd9865e479@st.com> <alpine.DEB.2.21.1910141535500.2531@nanos.tec.linutronix.de>
 <16f7e8e9-eefe-5973-a08a-3e1823d20034@st.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019, Benjamin GAIGNARD wrote:
> On 10/14/19 3:40 PM, Thomas Gleixner wrote:
> > I don't understand what you are trying to achieve here. If the tick device,
> > i.e. the comparator stops working in deep idle states, then the device has
> > rightfully the CLOCK_EVT_FEAT_C3STOP (mis)feature set. Which means that the
> > system needs a fallback device for the deep idle case. If there is no
> > physical fallback device then you should enable the hrtimer based broadcast
> > pseudo tick device.
> >
> > If the CPUs never go deep idle because there is no idle driver loaded or
> > the deep power state in which the comparator stops working is never
> > reached, then the broadcast hrtimer will never be used. It just eats a bit
> > of memory and a few extra instructions.
> 
> Since CPUs won't go in deep idle I don't want to get a broadcast timer
> but only an hrtimer to get accure latencies for the scheduler.

What's wrong with the broadcast timer if it is never utilized? It's there,
needs a few bytes of memory and that's it.

> When arch arm timer doesn't set CLOCK_EVT_FEAT_C3STOP flag, my system got
> a hrtimer and everything goes well.

Sure, but that's applicable to your particular system only and not a
generic solution. Neither your DT hack, nor the other one you posted.

> If arch arm timer set CLOCK_EVT_FEAT_C3STOP hrtimer disappear (except if
> I add an additional broadcast timer).

Right.

> What is the link between tick broadcast timer and hrtimer ? Does arch 
> arm timer could only implement them at the same time ?

If the clock event device is affected by deep power states, then the core
requires a fallback device, aka. broadcast timer, which makes sure that no
event is lost in case that the CPU goes into a deep power state. If no CPU
ever goes deep, the broadcast timer is there and unused.

Obviously the system cannot enable high resolution timers if the clock
event device is affected by power states.

Unless you have a solution which works under all circumstances (and the
current patch definitely does not) then you have to deal with the
requirement of the broadcast timer (either physical or software based).

"I don't want a broadcast timer falls" into the "I want a pony" realm.

Thanks,

	tglx


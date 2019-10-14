Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1897C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C11221721
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbfJNNk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:40:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38698 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJNNk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:40:29 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iK0aE-0000dA-EF; Mon, 14 Oct 2019 15:40:22 +0200
Date:   Mon, 14 Oct 2019 15:40:21 +0200 (CEST)
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
In-Reply-To: <a4b4b785-c471-a3c2-2c41-01bd9865e479@st.com>
Message-ID: <alpine.DEB.2.21.1910141535500.2531@nanos.tec.linutronix.de>
References: <20191009160246.17898-1-benjamin.gaignard@st.com> <alpine.DEB.2.21.1910141441350.2531@nanos.tec.linutronix.de> <a4b4b785-c471-a3c2-2c41-01bd9865e479@st.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019, Benjamin GAIGNARD wrote:
> On 10/14/19 2:56 PM, Thomas Gleixner wrote:
> > On Wed, 9 Oct 2019, Benjamin Gaignard wrote:
> >> @@ -78,7 +78,7 @@ static bool tick_check_broadcast_device(struct clock_event_device *curdev,
> >>   {
> >>   	if ((newdev->features & CLOCK_EVT_FEAT_DUMMY) ||
> >>   	    (newdev->features & CLOCK_EVT_FEAT_PERCPU) ||
> >> -	    (newdev->features & CLOCK_EVT_FEAT_C3STOP))
> >> +	    tick_broadcast_could_stop(newdev))
> > No. This might be called _before_ a cpuidle driver is available and then
> > when that driver is loaded and goes deep, everything goes south.
> 
> What could be the solution to let know to tick broadcast framework that 
> this device
> 
> will not be stopped (because CPU won't go in idle) ?
> 
> I have tried to put "always-on" property on DT but it was a NACK too:
> 
> https://lkml.org/lkml/2019/9/27/164
> 
> Do I have miss a flag somewhere ?

I don't understand what you are trying to achieve here. If the tick device,
i.e. the comparator stops working in deep idle states, then the device has
rightfully the CLOCK_EVT_FEAT_C3STOP (mis)feature set. Which means that the
system needs a fallback device for the deep idle case. If there is no
physical fallback device then you should enable the hrtimer based broadcast
pseudo tick device.

If the CPUs never go deep idle because there is no idle driver loaded or
the deep power state in which the comparator stops working is never
reached, then the broadcast hrtimer will never be used. It just eats a bit
of memory and a few extra instructions.

Thanks,

	tglx


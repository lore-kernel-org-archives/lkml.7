Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E36C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57E12070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfCZQEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:04:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48697 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZQEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:04:32 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8oYv-0000Zw-0u; Tue, 26 Mar 2019 17:04:29 +0100
Date:   Tue, 26 Mar 2019 17:04:28 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
cc:     rjw@rjwysocki.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] genirq/timings: Add array suffix computation code
In-Reply-To: <5ad6f7d7-3081-8eef-1adf-3ce705a1ba94@linaro.org>
Message-ID: <alpine.DEB.2.21.1903261702320.1789@nanos.tec.linutronix.de>
References: <20190308212047.28767-1-daniel.lezcano@linaro.org> <20190308212047.28767-3-daniel.lezcano@linaro.org> <alpine.DEB.2.21.1903241825210.1798@nanos.tec.linutronix.de> <5ad6f7d7-3081-8eef-1adf-3ce705a1ba94@linaro.org>
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

On Tue, 26 Mar 2019, Daniel Lezcano wrote:
> >> +/*
> >> + * Exponential moving average computation
> >> + */
> >> +static int irq_timings_ema_new(s64 value, s64 ema_old)
> > 
> > There is a mixed bag of s64/u64 all over this code. Please stay
> > consistent. We had enough sign confusion bugs in the past.
> 
> Right.
> 
> I have a question, ema_old and value will be always u64 type and the
> function irq_timings_ema_new() will return an u64 ...
> 
> > 	value = (value - ema_old) * EMA_ALPHA_VAL;
> > 	return ema_old + value >> EMA_ALPHA_SHIFT;
> 
> ... how can I deal with the operations above when value < ema_old ?
> 
> Shall I use an intermediate s64 ?
> 
> eg:
> 
> 	s64 aux = (value - ema_old) * EMA_ALPHA_VAL;
> 	return ema_old + aux >> EMA_ALPHA_SHIFT;
> ?

That should work if ema_old is not ever having the topmost bit set :)

Thanks,

	tglx

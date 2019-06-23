Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84284C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 10:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6361D2073F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 10:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfFWKqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 06:46:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33188 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWKqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 06:46:50 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf01B-0007hi-S8; Sun, 23 Jun 2019 12:46:42 +0200
Date:   Sun, 23 Jun 2019 12:46:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Anson.Huang@nxp.com
cc:     daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        abel.vesa@nxp.com, ccaione@baylibre.com, angus@akkea.ca,
        andrew.smirnov@gmail.com, agx@sigxcpu.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/3] clocksource/drivers/sysctr: Add an optional
 property
In-Reply-To: <20190621082838.12630-1-Anson.Huang@nxp.com>
Message-ID: <alpine.DEB.2.21.1906231232520.32342@nanos.tec.linutronix.de>
References: <20190621082838.12630-1-Anson.Huang@nxp.com>
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

Anson,

On Fri, 21 Jun 2019, Anson.Huang@nxp.com wrote:

> Subject : [PATCH 1/3] clocksource/drivers/sysctr: Add an optional property

That subject line is not really informative. From Documentation:

     The ``summary phrase`` in the email's Subject should concisely
     describe the patch which that email contains.

That means that it should tell which property it adds so it's immediately
clear what this is about. Something like:

 Subject: clocksource/drivers/sysctr: Add optional clock-frequency property

Hmm?

> From: Anson Huang <Anson.Huang@nxp.com>
> 
> This patch adds an optional property "clock-frequency" to pass

Please read Documentation/process/submitting-patches.rst and search for
'This patch'

> the system counter frequency value to kernel system counter
> driver and indicate the driver to skip of_clk operations, this
> is to support those platforms using platform driver model for
> clock driver.

That sentence does not parse. Please structure your changelog in the
following order:

   1) Context or problem

   2) Detailed analysis (if applicable and necessary)

   3) Short description of the solution (the rest is obvious from the patch
      itself).

So something like this (assumed I decoded the above correctly):

   Systems which use the system counter with the platform driver model
   require the clock frequency to be supplied via device tree.

   This is necessary as in the platform driver model the of_clk operations
   do not work correctly because LENGHTY EXPLANATION WHY ...

   Add the optinal clock-frequency to the device tree bindings of the NXP
   system counter so the frequency can be handed in and the of_clk
   operations can be skipped.

The important part is the missing LENGTHY EXPLANATION WHY. I can't fill
that in because you did not provide that information.

Thanks,

	tglx

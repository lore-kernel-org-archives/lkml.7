Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C370C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075A82067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfGOPZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:25:07 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:38097 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730785AbfGOPZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:25:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 329608368EF8;
        Mon, 15 Jul 2019 15:25:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boat47_2c25f66738a4c
X-Filterd-Recvd-Size: 3683
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Jul 2019 15:25:03 +0000 (UTC)
Message-ID: <f758b14c5d8343de778f9a6ccdcb29c43778d3f2.camel@perches.com>
Subject: Re: [PATCH] [v2] clocksource/drivers/npcm: fix GENMASK and timer
 operation
From:   Joe Perches <joe@perches.com>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 15 Jul 2019 08:25:01 -0700
In-Reply-To: <CAKKbWA5nwsa5kcZ8GCuC3WKJptb6RtZ65izFphd=KaALqeg+BA@mail.gmail.com>
References: <CAKKbWA6S7KotAFtLO=ow=XYnLL2Ny5Mz2kcgM1cs+j=5mHQNmw@mail.gmail.com>
         <CAKKbWA5nwsa5kcZ8GCuC3WKJptb6RtZ65izFphd=KaALqeg+BA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-15 at 18:19 +0300, Avi Fishman wrote:
> clocksource/drivers/npcm: fix GENMASK and timer operation
> 
> NPCM7XX_Tx_OPER GENMASK() changed from (27, 3) to (28, 27)
> 
> in npcm7xx_timer_oneshot() the original NPCM7XX_REG_TCSR0 register was
> read again after masking it with ~NPCM7XX_Tx_OPER so the masking didn't
> take effect.
> 
> npcm7xx_timer_periodic() was not wrong but it wrote to NPCM7XX_REG_TICR0
> in a middle of read modify write to NPCM7XX_REG_TCSR0 which is
> confusing.

You might mention how the original use of GENMASK(3, 27)
was defective or correct without effect.

> Signed-off-by: Avi Fishman <avifishman70@gmail.com>
> ---
>  drivers/clocksource/timer-npcm7xx.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-npcm7xx.c
> b/drivers/clocksource/timer-npcm7xx.c
> index 8a30da7f083b..9780ffd8010e 100644
> --- a/drivers/clocksource/timer-npcm7xx.c
> +++ b/drivers/clocksource/timer-npcm7xx.c
> @@ -32,7 +32,7 @@
>  #define NPCM7XX_Tx_INTEN               BIT(29)
>  #define NPCM7XX_Tx_COUNTEN             BIT(30)
>  #define NPCM7XX_Tx_ONESHOT             0x0
> -#define NPCM7XX_Tx_OPER                        GENMASK(27, 3)
> +#define NPCM7XX_Tx_OPER                        GENMASK(28, 27)
>  #define NPCM7XX_Tx_MIN_PRESCALE                0x1
>  #define NPCM7XX_Tx_TDR_MASK_BITS       24
>  #define NPCM7XX_Tx_MAX_CNT             0xFFFFFF
> @@ -84,8 +84,6 @@ static int npcm7xx_timer_oneshot(struct
> clock_event_device *evt)
> 
>         val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
>         val &= ~NPCM7XX_Tx_OPER;
> -
> -       val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
>         val |= NPCM7XX_START_ONESHOT_Tx;
>         writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
> 
> @@ -97,12 +95,11 @@ static int npcm7xx_timer_periodic(struct
> clock_event_device *evt)
>         struct timer_of *to = to_timer_of(evt);
>         u32 val;
> 
> +       writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
> +
>         val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
>         val &= ~NPCM7XX_Tx_OPER;
> -
> -       writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
>         val |= NPCM7XX_START_PERIODIC_Tx;
> -
>         writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
> 
>         return 0;
> 


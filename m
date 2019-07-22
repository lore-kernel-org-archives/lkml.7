Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2E6C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2DC21BF6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfGVJPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:15:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36042 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfGVJPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:15:23 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpUPe-0002hE-2R; Mon, 22 Jul 2019 11:15:18 +0200
Date:   Mon, 22 Jul 2019 11:15:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Avi Fishman <avifishman70@gmail.com>
cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v3] clocksource/drivers/npcm: fix GENMASK and timer
 operation
In-Reply-To: <CAKKbWA5AuDRDuczTd+tonhc7hi3L=nKX5MCjbspOvAPNR9odyg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907221111060.1782@nanos.tec.linutronix.de>
References: <CAKKbWA6S7KotAFtLO=ow=XYnLL2Ny5Mz2kcgM1cs+j=5mHQNmw@mail.gmail.com> <CAKKbWA5nwsa5kcZ8GCuC3WKJptb6RtZ65izFphd=KaALqeg+BA@mail.gmail.com> <CAKKbWA5AuDRDuczTd+tonhc7hi3L=nKX5MCjbspOvAPNR9odyg@mail.gmail.com>
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

On Mon, 15 Jul 2019, Avi Fishman wrote:

> clocksource/drivers/npcm: fix GENMASK and timer operation

Don't repeat the subject line please

> NPCM7XX_Tx_OPER GENMASK() changed from (27, 3) to (28, 27)

Please do not write down WHAT the patch does. That can be seen from the
patch itself. Tell why this is wrong and what's the potential problem.

> Since NPCM7XX_REG_TICR0 register reset value of those bits was 0,
> it did not cause an issue
> 
> in npcm7xx_timer_oneshot() the original NPCM7XX_REG_TCSR0 register was
> read again after masking it with ~NPCM7XX_Tx_OPER so the masking didn't
> take effect.
> 
> npcm7xx_timer_periodic() was not wrong but it wrote to NPCM7XX_REG_TICR0
> in a middle of read modify write to NPCM7XX_REG_TCSR0 which is
> confusing.
> 
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

Your mail client mangled the patch so it does not apply:

patching file drivers/clocksource/timer-npcm7xx.c
Hunk #1 FAILED at 32.
patch: **** malformed patch at line 49: clock_event_device *evt)

See Documentation/process for hints about sending patches with various mail
clients. Send the patch to yourself first and try to apply it yourself.

Thanks,

	tglx

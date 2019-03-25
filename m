Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F372EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D3820830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfCYNyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:54:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45918 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfCYNyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:54:15 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8Q3B-0005tv-T4; Mon, 25 Mar 2019 14:54:06 +0100
Date:   Mon, 25 Mar 2019 14:54:05 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chang-An Chen <chang-an.chen@mediatek.com>
cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        kuohong.wang@mediatek.com
Subject: Re: [PATCH 1/1] sched/clock: Prevent generic sched_clock wrap caused
 by tick_freeze()
In-Reply-To: <1553497460-24166-1-git-send-email-chang-an.chen@mediatek.com>
Message-ID: <alpine.DEB.2.21.1903251449580.1656@nanos.tec.linutronix.de>
References: <1553497460-24166-1-git-send-email-chang-an.chen@mediatek.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Chang-An Chen wrote:
> --- a/include/linux/sched_clock.h
> +++ b/include/linux/sched_clock.h
> @@ -13,6 +13,10 @@
>  
>  extern void sched_clock_register(u64 (*read)(void), int bits,
>  				 unsigned long rate);
> +
> +extern int sched_clock_suspend(void);
> +
> +extern void sched_clock_resume(void);
>  #else
>  static inline void generic_sched_clock_init(void) { }
>  
> @@ -20,6 +24,10 @@ static inline void sched_clock_register(u64 (*read)(void), int bits,
>  					unsigned long rate)
>  {
>  }
> +
> +static int sched_clock_suspend(void) { }

static inline ...

> +
> +static void sched_clock_resume(void) { }

Ditto

>  #endif

Please do not expose this in the global header. All of this is local to
kernel/time/. So adding this to kernel/time/timekeeping.h is sufficient.

Thanks,

	tglx

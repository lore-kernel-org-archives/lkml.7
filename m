Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F79C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1701E2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfFQHVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:21:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42624 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFQHVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:21:10 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hclwv-0007m4-9B; Mon, 17 Jun 2019 09:21:05 +0200
Date:   Mon, 17 Jun 2019 09:21:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Weikang shi <swkhack@gmail.com>
cc:     John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, swkhack@qq.com,
        Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: [PATCH] time: fix a assignment error in ntp module
In-Reply-To: <20190422093421.47896-1-swkhack@gmail.com>
Message-ID: <alpine.DEB.2.21.1906170814590.1760@nanos.tec.linutronix.de>
References: <20190422093421.47896-1-swkhack@gmail.com>
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

On Mon, 22 Apr 2019, Weikang shi wrote:

> From: swkhack <swkhack@gmail.com>
> 
> It is meanless to check a 64bit(txc->constant) value is postive 
> when the value has to be assigned to a 32 bit variable(*time_tai).
> So I make a temp type conversion before the compare.

What? Casting it to int makes it more negative, right?

That's just wrong:

       long long x = 0xFFFFFFFF00000000;
       int y = (int) x;

x is obviously negative, but y not. C type casting 101.

> Signed-off-by: swkhack <swkhack@gmail.com>
> ---
>  kernel/time/ntp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index 92a90014a..6b454eafc 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -690,7 +690,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
>  		time_constant = max(time_constant, 0l);
>  	}
>  
> -	if (txc->modes & ADJ_TAI && txc->constant > 0)
> +	if (txc->modes & ADJ_TAI && (int)txc->constant > 0)
>  		*time_tai = txc->constant;

The way more interesting question is whether txc->constant can be >
UINT_MAX. In that case the txc->constant would be truncated.

Miroslav?

Thanks,

	tglx



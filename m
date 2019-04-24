Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF1BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A832220835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbfDXUW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:22:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55705 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbfDXUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:22:58 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJOPs-00067V-SD; Wed, 24 Apr 2019 22:22:53 +0200
Date:   Wed, 24 Apr 2019 22:22:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Weikang shi <swkhack@gmail.com>
cc:     John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, swkhack@qq.com,
        Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: [PATCH] time: fix a assignment error in ntp module
In-Reply-To: <20190422093421.47896-1-swkhack@gmail.com>
Message-ID: <alpine.DEB.2.21.1904242207550.1762@nanos.tec.linutronix.de>
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

Errm no. This is missing a proper range check in the first place.

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
>  
>  	if (txc->modes & ADJ_OFFSET)
> -- 
> 2.17.1
> 
> 

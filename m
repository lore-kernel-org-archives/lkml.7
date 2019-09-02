Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7134C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 22:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DEF20828
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 22:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfIBWgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 18:36:54 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47755 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfIBWgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 18:36:54 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A57DF1BF207;
        Mon,  2 Sep 2019 22:36:50 +0000 (UTC)
Date:   Tue, 3 Sep 2019 00:36:50 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clocksource: atmel-st: Variable sr in
 at91rm9200_timer_interrupt() could be uninitialized
Message-ID: <20190902223650.GJ21922@piout.net>
References: <20190902222946.20548-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902222946.20548-1-yzhai003@ucr.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2019 15:29:46-0700, Yizhuo wrote:
> Inside function at91rm9200_timer_interrupt(), variable sr could
> be uninitialized if regmap_read() fails. However, sr is used

Could you elaborate on how this could fail?

> to decide the control flow later in the if statement, which is
> potentially unsafe. We could check the return value of
> regmap_read() and print an error here.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/clocksource/timer-atmel-st.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
> index ab0aabfae5f0..061a3f27847e 100644
> --- a/drivers/clocksource/timer-atmel-st.c
> +++ b/drivers/clocksource/timer-atmel-st.c
> @@ -48,8 +48,14 @@ static inline unsigned long read_CRTR(void)
>  static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
>  {
>  	u32 sr;
> +	int ret;
> +
> +	ret = regmap_read(regmap_st, AT91_ST_SR, &sr);
> +	if (ret) {
> +		pr_err("Fail to read AT91_ST_SR.\n");
> +		return ret;
> +	}
>  
> -	regmap_read(regmap_st, AT91_ST_SR, &sr);
>  	sr &= irqmask;
>  
>  	/*
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECEFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4931320880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfDOOWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:22:30 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60547 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOOW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:22:28 -0400
X-Originating-IP: 109.212.207.226
Received: from localhost (alyon-652-1-176-226.w109-212.abo.wanadoo.fr [109.212.207.226])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3F22B60008;
        Mon, 15 Apr 2019 14:22:24 +0000 (UTC)
Date:   Mon, 15 Apr 2019 16:22:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 03/12] misc: atmel_tclib: move definitions to header file
Message-ID: <20190415142223.GF3578@piout.net>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
 <20190403141120.32754-4-alexandre.belloni@bootlin.com>
 <63e25c2f-2e10-9c6e-9bfa-7b7220377bd8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63e25c2f-2e10-9c6e-9bfa-7b7220377bd8@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 17:00:26+0200, Daniel Lezcano wrote:
> On 03/04/2019 16:11, Alexandre Belloni wrote:
> > Move atmel_tc_divisors and atmel_tcb_dt_ids definitions to the header file
> > so they can be used without using tclib.
> 
> Why not kill those structure and use the TIMER_OF_DECLARE with the
> corresponding probe function which will initialize to 16 or 32 counter
> width?
> 

I'm dropping this patch and the structures but doing the differentiation
with TIMER_OF_DECLARE is not possible as this has to match
"atmel,tcb-timer" and the differentiation is done on the parent
compatible.

> 
> 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/misc/atmel_tclib.c   | 24 ------------------------
> >  include/soc/at91/atmel_tcb.h | 21 ++++++++++++++++++++-
> >  2 files changed, 20 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
> > index 3af27ce7e514..c79190525862 100644
> > --- a/drivers/misc/atmel_tclib.c
> > +++ b/drivers/misc/atmel_tclib.c
> > @@ -17,10 +17,6 @@
> >   * share individual timers between different drivers.
> >   */
> >  
> > -/* AT91 has these divide MCK */
> > -const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
> > -EXPORT_SYMBOL(atmel_tc_divisors);
> > -
> >  static DEFINE_SPINLOCK(tc_list_lock);
> >  static LIST_HEAD(tc_list);
> >  
> > @@ -72,26 +68,6 @@ void atmel_tc_free(struct atmel_tc *tc)
> >  EXPORT_SYMBOL_GPL(atmel_tc_free);
> >  
> >  #if defined(CONFIG_OF)
> > -static struct atmel_tcb_config tcb_rm9200_config = {
> > -	.counter_width = 16,
> > -};
> > -
> > -static struct atmel_tcb_config tcb_sam9x5_config = {
> > -	.counter_width = 32,
> > -};
> > -
> > -static const struct of_device_id atmel_tcb_dt_ids[] = {
> > -	{
> > -		.compatible = "atmel,at91rm9200-tcb",
> > -		.data = &tcb_rm9200_config,
> > -	}, {
> > -		.compatible = "atmel,at91sam9x5-tcb",
> > -		.data = &tcb_sam9x5_config,
> > -	}, {
> > -		/* sentinel */
> > -	}
> > -};
> > -
> >  MODULE_DEVICE_TABLE(of, atmel_tcb_dt_ids);
> >  #endif
> >  
> > diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> > index c3c7200ce151..cb0c5f53cd46 100644
> > --- a/include/soc/at91/atmel_tcb.h
> > +++ b/include/soc/at91/atmel_tcb.h
> > @@ -76,8 +76,27 @@ extern struct atmel_tc *atmel_tc_alloc(unsigned block);
> >  extern void atmel_tc_free(struct atmel_tc *tc);
> >  
> >  /* platform-specific ATMEL_TC_TIMER_CLOCKx divisors (0 means 32KiHz) */
> > -extern const u8 atmel_tc_divisors[5];
> > +static const u8 atmel_tc_divisors[] = { 2, 8, 32, 128, 0, };
> >  
> > +static const struct atmel_tcb_config tcb_rm9200_config = {
> > +	.counter_width = 16,
> > +};
> > +
> > +static const struct atmel_tcb_config tcb_sam9x5_config = {
> > +	.counter_width = 32,
> > +};
> > +
> > +static const struct of_device_id atmel_tcb_dt_ids[] = {
> > +	{
> > +		.compatible = "atmel,at91rm9200-tcb",
> > +		.data = &tcb_rm9200_config,
> > +	}, {
> > +		.compatible = "atmel,at91sam9x5-tcb",
> > +		.data = &tcb_sam9x5_config,
> > +	}, {
> > +		/* sentinel */
> > +	}
> > +};
> >  
> >  /*
> >   * Two registers have block-wide controls.  These are: configuring the three
> > 
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C76C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074A62075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfC0ILq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:11:46 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:54744 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfC0ILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:11:46 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990411AbfC0ILnRRv0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:11:43 +0100
Date:   Wed, 27 Mar 2019 09:11:42 +0100
From:   Ladislav Michl <ladis@linux-mips.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Remove
 omap_dm_timer_set_load_start
Message-ID: <20190327081142.GA11034@lenoch>
References: <20190327050126.12064-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327050126.12064-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nathan,

On Tue, Mar 26, 2019 at 10:01:27PM -0700, Nathan Chancellor wrote:
> Commit 008258d995a6 ("clocksource/drivers/timer-ti-dm: Make
> omap_dm_timer_set_load_start() static") made omap_dm_time_set_load_start
> static because its prototype was not defined in a header. Unfortunately,
> this causes a build warning on multi_v7_defconfig because this function
> is not used anywhere in this translation unit:
> 
> drivers/clocksource/timer-ti-dm.c:589:12: error: unused function
> 'omap_dm_timer_set_load_start' [-Werror,-Wunused-function]
> 
> In fact, omap_dm_timer_set_load_start hasn't been used anywhere since
> commit f190be7f39a5 ("staging: tidspbridge: remove driver") and the
> prototype was removed in commit 592ea6bd1fad ("clocksource: timer-ti-dm:
> Make unexported functions static"), which is probably where this should
> have happened.

Alternatively you might want to look at "clocksource: timer-ti-dm: Add event
capture": https://patchwork.kernel.org/patch/10237217/ (it makes use of
function being removed here). It is a part of an attempt to add event capture
for OMAP. Of course I would like this functionality to be implemented, but
as I do not have a time to continue, I cannot really object removing this
function.

Just in case you'd be interested in finishing this task ;-)

	ladis

> Fixes: 592ea6bd1fad ("clocksource: timer-ti-dm: Make unexported functions static")
> Fixes: 008258d995a6 ("clocksource/drivers/timer-ti-dm: Make omap_dm_timer_set_load_start() static")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> My apologies if this has already been sent, I didn't see anything in tip
> or on LKML.
> 
>  drivers/clocksource/timer-ti-dm.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
> index 3352da6ed61f..ee8ec5a8cb16 100644
> --- a/drivers/clocksource/timer-ti-dm.c
> +++ b/drivers/clocksource/timer-ti-dm.c
> @@ -585,34 +585,6 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
>  	return 0;
>  }
>  
> -/* Optimized set_load which removes costly spin wait in timer_start */
> -static int omap_dm_timer_set_load_start(struct omap_dm_timer *timer,
> -					int autoreload, unsigned int load)
> -{
> -	u32 l;
> -
> -	if (unlikely(!timer))
> -		return -EINVAL;
> -
> -	omap_dm_timer_enable(timer);
> -
> -	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> -	if (autoreload) {
> -		l |= OMAP_TIMER_CTRL_AR;
> -		omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
> -	} else {
> -		l &= ~OMAP_TIMER_CTRL_AR;
> -	}
> -	l |= OMAP_TIMER_CTRL_ST;
> -
> -	__omap_dm_timer_load_start(timer, l, load, timer->posted);
> -
> -	/* Save the context */
> -	timer->context.tclr = l;
> -	timer->context.tldr = load;
> -	timer->context.tcrr = load;
> -	return 0;
> -}
>  static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
>  

Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9987AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6598E20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfDASiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:38:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54167 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfDASix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:38:53 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hB1pY-00030r-69; Mon, 01 Apr 2019 20:38:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hB1pX-0007sB-Gf; Mon, 01 Apr 2019 20:38:47 +0200
Date:   Mon, 1 Apr 2019 20:38:47 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bichao.zheng@amlogic.com
Subject: Re: [PATCH 1/2] pwm: meson: consider 128 a valid pre-divider
Message-ID: <20190401183847.7xhlgff63cvlzz2h@pengutronix.de>
References: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
 <20190401181817.11999-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190401181817.11999-2-martin.blumenstingl@googlemail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

On Mon, Apr 01, 2019 at 08:18:16PM +0200, Martin Blumenstingl wrote:
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index f6e738ad7bd9..4b708c1fcb1d 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -188,7 +188,7 @@ static int meson_pwm_calc(struct meson_pwm *meson,
>  	do_div(fin_ps, fin_freq);
>  
>  	/* Calc pre_div with the period */
> -	for (pre_div = 0; pre_div < MISC_CLK_DIV_MASK; pre_div++) {
> +	for (pre_div = 0; pre_div <= MISC_CLK_DIV_MASK; pre_div++) {
>  		cnt = DIV_ROUND_CLOSEST_ULL((u64)period * 1000,
>  					    fin_ps * (pre_div + 1));
>  		dev_dbg(meson->chip.dev, "fin_ps=%llu pre_div=%u cnt=%u\n",

You could even calculate pre_div without the loop.

Something like:

	u64 pre_div = (u64)period * rate;
	do_div_round_up(pre_div, NSEC_PER_SEC * 0xffff);
	pre_div--;

(I didn't check rounding and maybe its off by one and ...) This would
also get rid of the strange 1000 that is currently used in the
calculation without a real benefit (unless I missed something).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

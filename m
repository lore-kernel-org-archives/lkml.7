Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D4DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5F220989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfEGIcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:32:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57173 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfEGIcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:32:19 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hNvWJ-0000Ck-8h; Tue, 07 May 2019 10:32:15 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hNvWI-0003SX-L7; Tue, 07 May 2019 10:32:14 +0200
Date:   Tue, 7 May 2019 10:32:14 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] Input: qt1050: fix less than zero comparison on an
 unsigned int
Message-ID: <20190507083214.rcew5cjfvlbwbov5@pengutronix.de>
References: <20190507082135.21538-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507082135.21538-1-colin.king@canonical.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:29:30 up 108 days, 13:11, 83 users,  load average: 0.00, 0.01,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 19-05-07 09:21, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the less than zero comparison of val is always false because
> val is an unsigned int. Fix this by making val a signed int.

Thanks for covering that, was an copy 'n' paste failure..
> 
> Addresses-Coverity: ("Unsigned compared against zero")
> Fixes: a33ff45923c8 ("Input: qt1050 - add Microchip AT42QT1050 support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/input/keyboard/qt1050.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1050.c
> index 6b1603cb7515..4debddb13972 100644
> --- a/drivers/input/keyboard/qt1050.c
> +++ b/drivers/input/keyboard/qt1050.c
> @@ -222,7 +222,7 @@ static struct regmap_config qt1050_regmap_config = {
>  
>  static bool qt1050_identify(struct qt1050_priv *ts)
>  {
> -	unsigned int val;
> +	int val;

I think the proper solution is to add a ret val, because this covers the
success/fail. I will send a patch to fix this.

Regards,
  Marco

>  	/* Read Chip ID */
>  	regmap_read(ts->regmap, QT1050_CHIP_ID, &val);
> -- 
> 2.20.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

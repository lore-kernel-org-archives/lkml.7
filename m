Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6EFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521122073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfLJUh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:37:27 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:47694 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfLJUhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:37:21 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 3FF1320066;
        Tue, 10 Dec 2019 21:37:18 +0100 (CET)
Date:   Tue, 10 Dec 2019 21:37:16 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, lee.jones@linaro.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mfd: atmel-hlcdc: return in case of error
Message-ID: <20191210203716.GC24756@ravnborg.org>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
 <1575984287-26787-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575984287-26787-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8
        a=kaM4bpze9TPPYBSW8_oA:9 a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu.

On Tue, Dec 10, 2019 at 03:24:45PM +0200, Claudiu Beznea wrote:
> For HLCDC timing engine configurations bit ATMEL_HLCDC_SIP of
> ATMEL_HLCDC_SR needs to checked if it is equal with zero before applying
> new configuration to timing engine. In case of timeout there is no
> indicator about this, so, return with error in case of timeout in
> regmap_atmel_hlcdc_reg_write() and also print a message about this.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/mfd/atmel-hlcdc.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
> index 64013c57a920..19f1dbeb8bcd 100644
> --- a/drivers/mfd/atmel-hlcdc.c
> +++ b/drivers/mfd/atmel-hlcdc.c
> @@ -39,10 +39,16 @@ static int regmap_atmel_hlcdc_reg_write(void *context, unsigned int reg,
>  
>  	if (reg <= ATMEL_HLCDC_DIS) {
>  		u32 status;
> -
> -		readl_poll_timeout_atomic(hregmap->regs + ATMEL_HLCDC_SR,
> -					  status, !(status & ATMEL_HLCDC_SIP),
> -					  1, 100);
> +		int ret;
> +
> +		ret = readl_poll_timeout_atomic(hregmap->regs + ATMEL_HLCDC_SR,
> +						status,
> +						!(status & ATMEL_HLCDC_SIP),
> +						1, 100);
> +		if (ret) {
> +			pr_err("Timeout waiting for ATMEL_HLCDC_SIP\n");
> +			return ret;
Consider adding device * to atmel_hlcdc_regmap - so you can use
dev_err() here. This makes it obvious what device this comes from.

	Sam

> +		}
>  	}
>  
>  	writel(val, hregmap->regs + reg);
> -- 
> 2.7.4

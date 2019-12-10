Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E226C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE3B206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfLJUSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:18:51 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:46084 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfLJUSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:18:51 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 25A422008B;
        Tue, 10 Dec 2019 21:18:46 +0100 (CET)
Date:   Tue, 10 Dec 2019 21:18:45 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, lee.jones@linaro.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] drm: atmel-hlcdc: enable clock before configuring
 timing engine
Message-ID: <20191210201845.GA24756@ravnborg.org>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
 <1575984287-26787-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575984287-26787-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8
        a=3T0gCXIu3ADAjCj7PMoA:9 a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu.

On Tue, Dec 10, 2019 at 03:24:44PM +0200, Claudiu Beznea wrote:
> Changing pixel clock source without having this clock source enabled
> will block the timing engine and the next operations after (in this case
> setting ATMEL_HLCDC_CFG(5) settings in atmel_hlcdc_crtc_mode_set_nofb()
> will fail). It is recomended (although in datasheet this is not present)
> to actually enabled pixel clock source before doing any changes on timing
> enginge (only SAM9X60 datasheet specifies that the peripheral clock and
> pixel clock must be enabled before using LCD controller).
> 
> Fixes: 1a396789f65a ("drm: add Atmel HLCDC Display Controller support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

We already had a remotely similar fix.
See 262d67e73f9a920a20bd75278761400404a82de0
("drm: atmel-hlcdc: enable sys_clk during initalization.")

In this patch sys_clk is only enabled if we have a fixed_clk.
Maybe we should do this unconditionally in
atmel_hlcdc_dc_load()?

Then we do not need this enable(disable in the mode_set_nofb
implementation.

Have you considered this way to fix it?

	Sam

> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 5040ed8d0871..721fa88bf71d 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -73,7 +73,11 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  	unsigned long prate;
>  	unsigned int mask = ATMEL_HLCDC_CLKDIV_MASK | ATMEL_HLCDC_CLKPOL;
>  	unsigned int cfg = 0;
> -	int div;
> +	int div, ret;
> +
> +	ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
> +	if (ret)
> +		return;
>  
>  	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
>  	vm.vback_porch = adj->crtc_vtotal - adj->crtc_vsync_end;
> @@ -147,6 +151,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  			   ATMEL_HLCDC_VSPSU | ATMEL_HLCDC_VSPHO |
>  			   ATMEL_HLCDC_GUARDTIME_MASK | ATMEL_HLCDC_MODE_MASK,
>  			   cfg);
> +
> +	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
>  }
>  
>  static enum drm_mode_status
> -- 
> 2.7.4

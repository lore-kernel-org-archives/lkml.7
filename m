Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8087C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB712077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ep9L46Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgAGWAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:00:33 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47420 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgAGWAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:00:33 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5D8E152F;
        Tue,  7 Jan 2020 23:00:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1578434431;
        bh=4rS/DzJoC9Up5wTZWqf2LP3WkrbP09g2YoVYgICXsqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ep9L46KuB1PfRgMEZWiYAkvy5r9Mwi64ugX+k46uy60Kqy9KJRCUABNrPiRReTLQf
         ZPRBe2LFiSmYXD2J745DCv8glAt8sI1irYVERQQRJ8rTJJ0hLcSDm9y8ElvyBnr5zi
         OLXStA3GVB8Qydp+aOzS0tuIj/PIAZ+BKOwtiWsc=
Date:   Wed, 8 Jan 2020 00:00:19 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: panel: fix excessive stack usage in
 td028ttec1_prepare
Message-ID: <20200107220019.GC7869@pendragon.ideasonboard.com>
References: <20200107212747.4182515-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107212747.4182515-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the patch.

On Tue, Jan 07, 2020 at 10:27:33PM +0100, Arnd Bergmann wrote:
> With gcc -O3, the compiler can inline very aggressively,
> leading to rather large stack usage:
> 
> drivers/gpu/drm/panel/panel-tpo-td028ttec1.c: In function 'td028ttec1_prepare':
> drivers/gpu/drm/panel/panel-tpo-td028ttec1.c:233:1: error: the frame size of 2768 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>  }
> 
> Marking jbt_reg_write_1() as noinline avoids the case where
> multiple instances of this function get inlined into the same
> stack frame and each one adds a copy of 'tx_buf'.
> 
> Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Isn't this something that should be fixed at the compiler level ?

> ---
>  drivers/gpu/drm/panel/panel-tpo-td028ttec1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
> index cf29405a2dbe..17ee5e87141f 100644
> --- a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
> +++ b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
> @@ -105,7 +105,7 @@ static int jbt_ret_write_0(struct td028ttec1_panel *lcd, u8 reg, int *err)
>  	return ret;
>  }
>  
> -static int jbt_reg_write_1(struct td028ttec1_panel *lcd,
> +static int noinline_for_stack jbt_reg_write_1(struct td028ttec1_panel *lcd,
>  			   u8 reg, u8 data, int *err)
>  {
>  	struct spi_device *spi = lcd->spi;

-- 
Regards,

Laurent Pinchart

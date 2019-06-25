Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7DFC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2200205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFYVY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:24:59 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:48120 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfFYVY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:24:59 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D67C980335;
        Tue, 25 Jun 2019 23:24:55 +0200 (CEST)
Date:   Tue, 25 Jun 2019 23:24:54 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>
Subject: Re: [PATCH 2/4] drm/panel: jh057n0090: Don't use magic constant
Message-ID: <20190625212454.GC20625@ravnborg.org>
References: <cover.1561482165.git.agx@sigxcpu.org>
 <ec1993368dba4e6ec1c72faa9c7bb25cf8ca95d3.1561482165.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec1993368dba4e6ec1c72faa9c7bb25cf8ca95d3.1561482165.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=ze386MxoAAAA:8
        a=7gkXJVJtAAAA:8 a=L8TcbOcJO7bzHK2hVygA:9 a=wPNLvfGTeEIA:10
        a=iBZjaW-pnkserzjvUTHh:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:05:17PM +0200, Guido Günther wrote:
> 0xBF isn't in any ST7703 data sheet so mark it as unknown. This avoids
> confusion on whether there is a missing command in that
> dsi_generic_write_seq() call.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> index 6dcb692c4701..b8a069055fbc 100644
> --- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> +++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> @@ -33,6 +33,7 @@
>  #define ST7703_CMD_SETEXTC	 0xB9
>  #define ST7703_CMD_SETMIPI	 0xBA
>  #define ST7703_CMD_SETVDC	 0xBC
> +#define ST7703_CMD_UNKNOWN0	 0xBF
>  #define ST7703_CMD_SETSCR	 0xC0
>  #define ST7703_CMD_SETPOWER	 0xC1
>  #define ST7703_CMD_SETPANEL	 0xCC
> @@ -94,7 +95,7 @@ static int jh057n_init_sequence(struct jh057n *ctx)
>  	msleep(20);
>  
>  	dsi_generic_write_seq(dsi, ST7703_CMD_SETVCOM, 0x3F, 0x3F);
> -	dsi_generic_write_seq(dsi, 0xBF, 0x02, 0x11, 0x00);
> +	dsi_generic_write_seq(dsi, ST7703_CMD_UNKNOWN0, 0x02, 0x11, 0x00);
>  	dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP1,
>  			      0x82, 0x10, 0x06, 0x05, 0x9E, 0x0A, 0xA5, 0x12,
>  			      0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
> -- 
> 2.20.1

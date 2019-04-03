Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D3AC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECF62082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfDCVHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:07:48 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:49164 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCVHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:07:47 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 59E3D20024;
        Wed,  3 Apr 2019 23:07:40 +0200 (CEST)
Date:   Wed, 3 Apr 2019 23:07:38 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Joe Perches <joe@perches.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] drm/panel: Support Rocktech jh057n00900 DSI panel
Message-ID: <20190403210738.GA9173@ravnborg.org>
References: <cover.1554114302.git.agx@sigxcpu.org>
 <20190403161735.GN5238@ulmo>
 <1ed5eb3af4df6b2dd1544c7b696e034ed5c94f06.camel@perches.com>
 <c2f6a9f0ea59dc1491a8429a51afe56e488dfb3c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2f6a9f0ea59dc1491a8429a51afe56e488dfb3c.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=Yu8JHHc4P6loC2uVNr8A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe.

Thanks for your patch.

> ---
>  drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 210 +++++++++++++--------
>  1 file changed, 136 insertions(+), 74 deletions(-)

Hmmm, add more lines than it deletes.

> 
> diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> index 158a6d548068..7862863db5f7 100644
> --- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> +++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> @@ -20,27 +20,6 @@
>  
>  #define DRV_NAME "panel-rocktech-jh057n00900"
>  
> -/* Manufacturer specific Commands send via DSI */
> -#define ST7703_CMD_ALL_PIXEL_OFF 0x22
> -#define ST7703_CMD_ALL_PIXEL_ON	 0x23
> -#define ST7703_CMD_SETDISP	 0xB2
> -#define ST7703_CMD_SETRGBIF	 0xB3
> -#define ST7703_CMD_SETCYC	 0xB4
> -#define ST7703_CMD_SETBGP	 0xB5
> -#define ST7703_CMD_SETVCOM	 0xB6
> -#define ST7703_CMD_SETOTP	 0xB7
> -#define ST7703_CMD_SETPOWER_EXT	 0xB8
> -#define ST7703_CMD_SETEXTC	 0xB9
> -#define ST7703_CMD_SETMIPI	 0xBA
> -#define ST7703_CMD_SETVDC	 0xBC
> -#define ST7703_CMD_SETSCR	 0xC0
> -#define ST7703_CMD_SETPOWER	 0xC1
> -#define ST7703_CMD_SETPANEL	 0xCC
> -#define ST7703_CMD_SETGAMMA	 0xE0
> -#define ST7703_CMD_SETEQ	 0xE3
> -#define ST7703_CMD_SETGIP1	 0xE9
> -#define ST7703_CMD_SETGIP2	 0xEA
> -
>  struct jh057n {
>  	struct device *dev;
>  	struct drm_panel panel;
> @@ -51,75 +30,153 @@ struct jh057n {
>  	struct dentry *debugfs;
>  };
>  
> +struct st7703_cmd {
> +	const size_t	size;
> +	const u8	data[];
> +};
> +
> +#define st7703_cmd_data(cmd, ...)					\
> +	.size = 1 + (sizeof((u8[]){__VA_ARGS__})/sizeof(u8)),		\
> +	.data = {cmd, __VA_ARGS__}
> +
> +/* Manufacturer specific Commands send via DSI */
> +static const struct st7703_cmd ST7703_CMD_ALL_PIXEL_OFF = {
> +	st7703_cmd_data(0x22)
> +};
> +static const struct st7703_cmd ST7703_CMD_ALL_PIXEL_ON = {
> +	st7703_cmd_data(0x23)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETDISP = {
> +	st7703_cmd_data(0xB2,
> +			0xF0, 0x12, 0x30)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETRGBIF = {
> +	st7703_cmd_data(0xB3,
> +			0x10, 0x10, 0x05, 0x05, 0x03, 0xFF, 0x00, 0x00,
> +			0x00, 0x00)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETCYC = {
> +	st7703_cmd_data(0xB4,
> +			0x80)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETBGP = {
> +	st7703_cmd_data(0xB5,
> +			0x08, 0x08)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETVCOM = {
> +	st7703_cmd_data(0xB6,
> +			0x3F, 0x3F)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETOTP = {
> +	st7703_cmd_data(0xB7)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETPOWER_EXT = {
> +	st7703_cmd_data(0xB8)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETEXTC = {
> +	st7703_cmd_data(0xB9,
> +			0xF1, 0x12, 0x83)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETMIPI = {
> +	st7703_cmd_data(0xBA)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETVDC = {
> +	st7703_cmd_data(0xBC,
> +			0x4E)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETSCR = {
> +	st7703_cmd_data(0xC0,
> +			0x73, 0x73, 0x50, 0x50, 0x00, 0x00, 0x08, 0x70,
> +			0x00)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETPOWER = {
> +	st7703_cmd_data(0xC1)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETPANEL = {
> +	st7703_cmd_data(0xCC,
> +			0x0B)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETGAMMA = {
> +	st7703_cmd_data(0xE0,
> +			0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41, 0x37,
> +			0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10, 0x11,
> +			0x18, 0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41,
> +			0x37, 0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10,
> +			0x11, 0x18)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETEQ = {
> +	st7703_cmd_data(0xE3,
> +			0x07, 0x07, 0x0B, 0x0B, 0x03, 0x0B, 0x00, 0x00,
> +			0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10)
> +};
> +static const struct st7703_cmd ST7703_CMD_SETGIP1 = {
> +	st7703_cmd_data(0xE9,
> +			0x82, 0x10, 0x06, 0x05, 0x9E, 0x0A, 0xA5, 0x12,
> +			0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
> +			0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
> +			0x03, 0x00, 0x00, 0x00, 0x75, 0x75, 0x31, 0x88,
> +			0x88, 0x88, 0x88, 0x88, 0x88, 0x13, 0x88, 0x64,
> +			0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
> +			0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
> +};
> +
> +static const struct st7703_cmd ST7703_CMD_SETGIP2 = {
> +	st7703_cmd_data(0xEA,
> +			0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +			0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
> +			0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
> +			0x57, 0x13, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
> +			0x75, 0x88, 0x23, 0x14, 0x00, 0x00, 0x02, 0x00,
> +			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x0A,
> +			0xA5, 0x00, 0x00, 0x00, 0x00)
> +};
> +
>  static inline struct jh057n *panel_to_jh057n(struct drm_panel *panel)
>  {
>  	return container_of(panel, struct jh057n, panel);
>  }
>  
> -#define dsi_generic_write_seq(dsi, seq...) do {				\
> -		static const u8 d[] = { seq };				\
> -		int ret;						\
> -		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
> -		if (ret < 0)						\
> -			return ret;					\
> -	} while (0)
The above macro was the one triggering this patch.
And frankly it looks nice and simple.

The old code is IMO more readable.
- We have all the commands listed in the order they
  are used and in a rahter compatch format.
- It is obvious when we need delays.
- We have traditional #defines for the constants we know

This macro:
> +#define st7703_cmd_data(cmd, ...)                                    \
> +     .size = 1 + (sizeof((u8[]){__VA_ARGS__})/sizeof(u8)),           \
> +     .data = {cmd, __VA_ARGS__}
is again IMO not easier to follow than the above.

This is all to some extent bikeshedding, but I suggest
to keep the current code.
It is simple and it is tested.

Thanks for trying to come up with a better solution.

	Sam

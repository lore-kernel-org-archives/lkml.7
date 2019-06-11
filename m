Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD01C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD282173E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hcIOtR0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406911AbfFKSLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:11:04 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36342 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406685AbfFKSLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:11:04 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F070F1030;
        Tue, 11 Jun 2019 20:11:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1560276662;
        bh=X5ba4hPanC2AN4ceWEVuMDO4nnB5xvvl9LT4UMu+zYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcIOtR0SSyWGNef99sUwB28gGA+lFi/F/FphmQuvgI0MTjARriXxO/K1eUH5m6o9/
         LVgI8p+IrMWyqRuwTIE0c1kXCNIGaSpiqrxgCPSkick5B2BaqeMqvBtiXBHLSSvnRZ
         1xi8CWzBevXuv4WcwNseLfRvqjRiubK0dRO9dPyQ=
Date:   Tue, 11 Jun 2019 21:10:46 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michael Drake <michael.drake@codethink.co.uk>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
Subject: Re: [PATCH v1 06/11] ti948: Reconfigure in the alive check when
 device returns
Message-ID: <20190611181046.GU5016@pendragon.ideasonboard.com>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
 <20190611140412.32151-7-michael.drake@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611140412.32151-7-michael.drake@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch.

On Tue, Jun 11, 2019 at 03:04:07PM +0100, Michael Drake wrote:
> If the alive check detects a transition to the alive state,
> the device configuration is rewritten.

This seems like a big hack. You will have at the very least to explain
why this is needed, and why you can't configure the device in response
to drm_bridge operation calls.

> Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
> Cc: Patrick Glaser <pglaser@tesla.com>
> Cc: Nate Case <ncase@tesla.com>
> ---
>  drivers/gpu/drm/bridge/ti948.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti948.c b/drivers/gpu/drm/bridge/ti948.c
> index 86daa3701b91..b5c766711c4b 100644
> --- a/drivers/gpu/drm/bridge/ti948.c
> +++ b/drivers/gpu/drm/bridge/ti948.c
> @@ -132,6 +132,8 @@ struct ti948_reg_val {
>   * @reg_names:   Array of regulator names, or NULL.
>   * @regs:        Array of regulators, or NULL.
>   * @reg_count:   Number of entries in reg_names and regs arrays.
> + * @alive_check: Context for the alive checking work item.
> + * @alive:       Whether the device is alive or not (alive_check).
>   */
>  struct ti948_ctx {
>  	struct i2c_client *i2c;
> @@ -141,6 +143,8 @@ struct ti948_ctx {
>  	const char **reg_names;
>  	struct regulator **regs;
>  	size_t reg_count;
> +	struct delayed_work alive_check;
> +	bool alive;
>  };
>  
>  static bool ti948_readable_reg(struct device *dev, unsigned int reg)
> @@ -346,6 +350,8 @@ static int ti948_power_on(struct ti948_ctx *ti948)
>  	if (ret != 0)
>  		return ret;
>  
> +	ti948->alive = true;
> +
>  	msleep(500);
>  
>  	return 0;
> @@ -356,6 +362,8 @@ static int ti948_power_off(struct ti948_ctx *ti948)
>  	int i;
>  	int ret;
>  
> +	ti948->alive = false;
> +
>  	for (i = ti948->reg_count; i > 0; i--) {
>  		dev_info(&ti948->i2c->dev, "Disabling %s regulator\n",
>  				ti948->reg_names[i - 1]);
> @@ -388,8 +396,17 @@ static void ti948_alive_check(struct work_struct *work)
>  {
>  	struct delayed_work *dwork = to_delayed_work(work);
>  	struct ti948_ctx *ti948 = delayed_work_to_ti948_ctx(dwork);
> +	int ret = ti948_device_check(ti948);
>  
> -	dev_info(&ti948->i2c->dev, "%s Alive check!\n", __func__);
> +	if (ti948->alive == false && ret == 0) {
> +		dev_info(&ti948->i2c->dev, "Device has come back to life!\n");
> +		ti948_write_config_seq(ti948);
> +		ti948->alive = true;
> +
> +	} else if (ti948->alive == true && ret != 0) {
> +		dev_info(&ti948->i2c->dev, "Device has stopped responding\n");
> +		ti948->alive = false;
> +	}
>  
>  	/* Reschedule ourself for the next check. */
>  	schedule_delayed_work(&ti948->alive_check, TI948_ALIVE_CHECK_DELAY);

-- 
Regards,

Laurent Pinchart

Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E567C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD82220896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BGo5QaYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406945AbfFKSMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:12:03 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36380 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406851AbfFKSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:12:01 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D91041031;
        Tue, 11 Jun 2019 20:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1560276720;
        bh=3URVGJMkojHdz0AK8/MsWlGeE84oCMlsn1bjeK37hp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGo5QaYfk/rE48eqvrFabjZ+rp8Vh2vmiTd2/+OaRiPdLF23veCE7jvUgtW6GBBGb
         xwH0L5OAn3w8ITiNa4Xzt9R+ZfvdxIfR8fmGnHuE0nYwDHdhfxz2qV22esm8gm88aT
         Ola/4bgITvHPvGgbN0TpuVKIsGIudAXpM5MtRW+8=
Date:   Tue, 11 Jun 2019 21:11:44 +0300
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
Subject: Re: [PATCH v1 07/11] ti948: Add sysfs node for alive attribute
Message-ID: <20190611181144.GV5016@pendragon.ideasonboard.com>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
 <20190611140412.32151-8-michael.drake@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611140412.32151-8-michael.drake@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch.

On Tue, Jun 11, 2019 at 03:04:08PM +0100, Michael Drake wrote:
> This may be used by userspace to determine the state
> of the device.

Why is this needed ? Userspace shouldn't even be aware that this device
exists.

> Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
> Cc: Patrick Glaser <pglaser@tesla.com>
> Cc: Nate Case <ncase@tesla.com>
> ---
>  drivers/gpu/drm/bridge/ti948.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti948.c b/drivers/gpu/drm/bridge/ti948.c
> index b5c766711c4b..b624eaeabb43 100644
> --- a/drivers/gpu/drm/bridge/ti948.c
> +++ b/drivers/gpu/drm/bridge/ti948.c
> @@ -412,6 +412,16 @@ static void ti948_alive_check(struct work_struct *work)
>  	schedule_delayed_work(&ti948->alive_check, TI948_ALIVE_CHECK_DELAY);
>  }
>  
> +static ssize_t alive_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct ti948_ctx *ti948 = ti948_ctx_from_dev(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%u\n", (unsigned int)ti948->alive);
> +}
> +
> +static DEVICE_ATTR_RO(alive);
> +
>  static int ti948_pm_resume(struct device *dev)
>  {
>  	struct ti948_ctx *ti948 = ti948_ctx_from_dev(dev);
> @@ -614,17 +624,31 @@ static int ti948_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, ti948);
>  
> +	ret = device_create_file(&client->dev, &dev_attr_alive);
> +	if (ret) {
> +		dev_err(&client->dev, "Could not create alive attr\n");
> +		return ret;
> +	}
> +
>  	ret = ti948_pm_resume(&client->dev);
> -	if (ret != 0)
> -		return -EPROBE_DEFER;
> +	if (ret != 0) {
> +		ret = -EPROBE_DEFER;
> +		goto error;
> +	}
>  
>  	dev_info(&ti948->i2c->dev, "End probe (addr: %x)\n", ti948->i2c->addr);
>  
>  	return 0;
> +
> +error:
> +	device_remove_file(&client->dev, &dev_attr_alive);
> +	return ret;
>  }
>  
>  static int ti948_remove(struct i2c_client *client)
>  {
> +	device_remove_file(&client->dev, &dev_attr_alive);
> +
>  	return ti948_pm_suspend(&client->dev);
>  }
>  

-- 
Regards,

Laurent Pinchart

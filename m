Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B04CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1370C214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jvjHe6OR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfKDRmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:42:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38639 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfKDRmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:42:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id v9so18142240wrq.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 09:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5ogVv9yu3iXpW756OAqxBZcAaxMrrDVeZyf4/i652TM=;
        b=jvjHe6OReDuWCuVv2+9UAh0oNSew20Cf90E08ulRCvHLHeXfSPKJ1HoefQFlUG7hM8
         cvxTxB0gdhOTdqmAYguK071cnJKBuGonRdGwubEbmvi30uVk49BVOBFvBbnXyV6fgY1B
         /GBBc6/JCDu4mXohl8A5LHq8adjS1+871lhRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5ogVv9yu3iXpW756OAqxBZcAaxMrrDVeZyf4/i652TM=;
        b=lLkqgQSsJibJwS8H2ErqM52vCb89JUyb/FyWiG6UO2XSPFQgw0AePT24OeuyhXd0PM
         MnVtEue2AVpt6H1lDIbivTLmEYs2PftnKCpb2JDHuJbqPPlox+g6ZNBsoAPqwVnDFjfW
         2I1VqM2gPVW+1FsfQoBp4Lv8c+Vh3oDQaa8GQi47blKdSgCmDQ7inO+JEx0yiw346omB
         4bi60nYh6HmeQTycxXYgVdjgkra2J4tPAzlOcz4cNHa3CKNSEkVsyVLSpqON0CK9teen
         Z0m1hVecHuyCKbBx3f7pzbvvEbpmtffX4dRJRY5yzE9Bv8/JoyWPXvisGYnZsZrMYuvo
         hAWg==
X-Gm-Message-State: APjAAAWartlgEUfWLcrCa8WLebyYVQcN9S5FCqPizhNayHTj0jvtKHGp
        FT0aYO80VDRqhbCAxlAsw++VTw==
X-Google-Smtp-Source: APXvYqyo30Cx3N9aLHROc1bhJ+WNVO3huy0tpFL+gtfZWVC0nSZZlSOaRK2D60u0zqloh6U7cb3wBA==
X-Received: by 2002:adf:e889:: with SMTP id d9mr26191161wrm.266.1572889341116;
        Mon, 04 Nov 2019 09:42:21 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id f13sm17424754wrq.96.2019.11.04.09.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 09:42:20 -0800 (PST)
Date:   Mon, 4 Nov 2019 18:42:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm: sun4i: Add support for suspending the display
 driver
Message-ID: <20191104174218.GL10326@phenom.ffwll.local>
Mail-Followup-To: Ondrej Jirman <megous@megous.com>,
        linux-sunxi@googlegroups.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191029112846.3604925-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029112846.3604925-1-megous@megous.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:28:46PM +0100, Ondrej Jirman wrote:
> Shut down the display engine during suspend.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
> Changes in v2:
> - spaces -> tabs
> 
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index a5757b11b730..c519d7cfcf43 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -346,6 +346,27 @@ static int sun4i_drv_add_endpoints(struct device *dev,
>  	return count;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int sun4i_drv_drm_sys_suspend(struct device *dev)
> +{
> +	struct drm_device *drm = dev_get_drvdata(dev);
> +
> +	return drm_mode_config_helper_suspend(drm);
> +}
> +
> +static int sun4i_drv_drm_sys_resume(struct device *dev)
> +{
> +	struct drm_device *drm = dev_get_drvdata(dev);
> +
> +	return drm_mode_config_helper_resume(drm);
> +}
> +#endif
> +
> +static const struct dev_pm_ops sun4i_drv_drm_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(sun4i_drv_drm_sys_suspend,
> +				sun4i_drv_drm_sys_resume)
> +};

I wonder whether we should have these as default helpers somewhere,
there's probably a few drivers that could use them? It's just a handful of
lines we're saving here, but we have enough kms drivers to justify this
kind of stuff nowadays ...
-Daniel

> +
>  static int sun4i_drv_probe(struct platform_device *pdev)
>  {
>  	struct component_match *match = NULL;
> @@ -418,6 +439,7 @@ static struct platform_driver sun4i_drv_platform_driver = {
>  	.driver		= {
>  		.name		= "sun4i-drm",
>  		.of_match_table	= sun4i_drv_of_table,
> +		.pm = &sun4i_drv_drm_pm_ops,
>  	},
>  };
>  module_platform_driver(sun4i_drv_platform_driver);
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B5ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629B021924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569967545;
	bh=DvMwVv51hpILqf200lznIQdnO291e+TJ0yyP7QLTa9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zG97enQZ4t22qJ7fseT3McxcXleRk7pz/ztLbUopbSXDjmTtpuxcdCVsmlaW5CFsi
	 6w/LBK4Tx0etqNQobdopO/0Usdkki9O0xmTVOCgLBoBn+ZZ2bSHdr3Njum1As/AOOn
	 4Aaz+U1uQqkd4i3yF9xuozweP8ye/xOo04PemtWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfJAWFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:05:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33130 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfJAWFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:05:44 -0400
Received: by mail-io1-f65.google.com with SMTP id z19so52265713ior.0;
        Tue, 01 Oct 2019 15:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a4R5YpRcyVsoUxlnqYfMJmbE5UoR9hlE6bltB+p1lTg=;
        b=Ryj7xUOmMRinf+6zeq0UqOaMCZSXVG2gKQ3FHqua2jImP6D4tru04QtKqkSONUyFkQ
         Mp/en/I1zuhYENXBUIKEOMTZgh9MIlkvd1WyykQ/+QlS/82IRedQEzAZWb2yrDW002fm
         nomt2/mrQX7Pxc6MLBG7ZXjtn1NHeJ1sWo12lYd7YcpiQlvDHi1T/MxwGXtIjtf0xpAB
         ZUr7JP5OS3VvC0GjVhKMYZlKI5asgKkMWm41DswSvXxHUf/q7rhNWXqhI8AHkgYGHRw8
         vjoBqXBUs3+3N+lKOCepjacoqc1OmEwycFbcmhMwHD2RlUdIhTSlkbviYXG29pehWyhk
         q2qw==
X-Gm-Message-State: APjAAAUeEiRigqgkl+NLy2PAukiVu5H0tABuaIRzMIwzUjwyVd7p2xr1
        ZvhtUwlxJD/3jT59JHKWBiYA0jM=
X-Google-Smtp-Source: APXvYqymwPNakkTYxVmuxb0uKOi/4Uu9KmwI8GUORV5WN9PpG24BioJqZplUpqKRDsxC4J02hvskFQ==
X-Received: by 2002:a92:1756:: with SMTP id u83mr342576ill.204.1569967543392;
        Tue, 01 Oct 2019 15:05:43 -0700 (PDT)
Received: from localhost ([2607:fb90:1780:6fbf:9c38:e932:436b:4079])
        by smtp.gmail.com with ESMTPSA id 17sm6634508ioo.21.2019.10.01.15.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:05:42 -0700 (PDT)
Date:   Tue, 1 Oct 2019 17:05:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        info@logictechno.com, j.bauer@endrich.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel: simple: add display timings for logic
 technologies displays
Message-ID: <20191001220539.GA16232@bogus>
References: <20190920075411.15735-1-marcel@ziswiler.com>
 <20190920075411.15735-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920075411.15735-2-marcel@ziswiler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 09:54:11AM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add display timings for the following 3 display panels manufactured by
> Logic Technologies Limited:
> 
> - LT161010-2NHC e.g. as found in the Toradex Capacitive Touch Display
>   7" Parallel [1]
> - LT161010-2NHR e.g. as found in the Toradex Resistive Touch Display 7"
>   Parallel [2]
> - LT170410-2WHC e.g. as found in the Toradex Capacitive Touch Display
>   10.1" LVDS [3]
> 
> Those panels may also be distributed by Endrich Bauelemente Vertriebs
> GmbH [4].
> 
> [1] https://docs.toradex.com/104497-7-inch-parallel-capacitive-touch-display-800x480-datasheet.pdf
> [2] https://docs.toradex.com/104498-7-inch-parallel-resistive-touch-display-800x480.pdf
> [3] https://docs.toradex.com/105952-10-1-inch-lvds-capacitive-touch-display-1280x800-datasheet.pdf
> [4] https://www.endrich.com/isi50_isi30_tft-displays/lt170410-1whc_isi30
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  drivers/gpu/drm/panel/panel-simple.c | 65 ++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 28fa6ba7b767..42bd0de25167 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2034,6 +2034,62 @@ static const struct panel_desc lg_lp129qe = {
>  	},
>  };
>  
> +static const struct display_timing logictechno_lt161010_2nh_timing = {
> +	.pixelclock = { 26400000, 33300000, 46800000 },
> +	.hactive = { 800, 800, 800 },
> +	.hfront_porch = { 16, 210, 354 },
> +	.hback_porch = { 46, 46, 46 },
> +	.hsync_len = { 1, 20, 40 },
> +	.vactive = { 480, 480, 480 },
> +	.vfront_porch = { 7, 22, 147 },
> +	.vback_porch = { 23, 23, 23 },
> +	.vsync_len = { 1, 10, 20 },
> +	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
> +		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
> +		 DISPLAY_FLAGS_SYNC_POSEDGE,
> +};
> +
> +static const struct panel_desc logictechno_lt161010_2nh = {
> +	.timings = &logictechno_lt161010_2nh_timing,
> +	.num_timings = 1,
> +	.size = {
> +		.width = 154,
> +		.height = 86,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
> +		     DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> +		     DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
> +};
> +
> +static const struct display_timing logictechno_lt170410_2whc_timing = {
> +	.pixelclock = { 68900000, 71100000, 7340000 },
> +	.hactive = { 1280, 1280, 1280 },
> +	.hfront_porch = { 23, 60, 71 },
> +	.hback_porch = { 23, 60, 71 },
> +	.hsync_len = { 15, 40, 47 },
> +	.vactive = { 800, 800, 800 },
> +	.vfront_porch = { 5, 7, 10 },
> +	.vback_porch = { 5, 7, 10 },
> +	.vsync_len = { 6, 9, 12 },
> +	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
> +		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
> +		 DISPLAY_FLAGS_SYNC_POSEDGE,
> +};
> +
> +static const struct panel_desc logictechno_lt170410_2whc = {
> +	.timings = &logictechno_lt170410_2whc_timing,
> +	.num_timings = 1,
> +	.size = {
> +		.width = 217,
> +		.height = 136,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
> +		     DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> +		     DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
> +};
> +
>  static const struct drm_display_mode mitsubishi_aa070mc01_mode = {
>  	.clock = 30400,
>  	.hdisplay = 800,
> @@ -3264,6 +3320,15 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "lg,lp129qe",
>  		.data = &lg_lp129qe,
> +	}, {
> +		.compatible = "logictechno,lt161010-2nhc",
> +		.data = &logictechno_lt161010_2nh,
> +	}, {
> +		.compatible = "logictechno,lt161010-2nhr",
> +		.data = &logictechno_lt161010_2nh,
> +	}, {
> +		.compatible = "logictechno,lt170410-2whc",
> +		.data = &logictechno_lt170410_2whc,

The vendor prefix wasn't documented, but the compatible string and rest 
already are?

Rob

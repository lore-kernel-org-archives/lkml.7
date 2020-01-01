Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F19C2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 20:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782452085B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 20:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="X9zH/dsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgAAUkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 15:40:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44920 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAAUkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 15:40:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so37608358wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 12:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=v7cr1kY2Lq9a8pmpvtgNvRRSj2Esi2GdGGct+/Bp2sY=;
        b=X9zH/dsLOxvqxgx1Abkb/3kolnT7NP+fICu0gW4gpjSjeCIeR5oDmiRa6icLcaQTCb
         bT1qmQ0EBZkIUP9BPPF3lXojVNT0f+9aD2nAXebkMd1nu/pnexMqHR4PZA/ClxtP0TrR
         RUR+up5tCvVs9LqDFrP9RrdAlcBoRKaiv5FjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=v7cr1kY2Lq9a8pmpvtgNvRRSj2Esi2GdGGct+/Bp2sY=;
        b=UAWwcOuxyuLPh889p8p2TyU6TRze1Z366OyaNudJwF7OstHQNi4/95Req0f+wwo4gq
         AT7KNGs7vlz/GbbxcbPWt2rgIiPaLsU6LU1Foaw2q/ANxQMuiqsDuli6oKPr0S1yt55K
         8ALhZeoDHXsOjmvXzs5BkrzuY5KbhkyDA2vXF5iZ1J5rzJIerycbewJ/2k4Oqpl/LdME
         NFUIguqyc0njPaeQXivOiCxQQQR8UF4WJwpDLcMWpMY5iliYh4b190S/Jm2W+O8SHmt/
         mCp9liIa+XTUSc5rrctaPSKwMjIvfSHESHBcQLZW5GWbDxsofdzMr4YE43bzkcI5Pp43
         1L9Q==
X-Gm-Message-State: APjAAAVRggx2gKY6SefKBJNfXHehJEFEl2PKZvXQ1sUyJXaiF6hCPi/7
        vGtj2fRxKeYAJtPfRmLSK23P5w==
X-Google-Smtp-Source: APXvYqwVuI5pnCU39vvfsIcyVkJd31it0JH7yCZ6vGmgY083JFly8IRIxIZzriskS1d9gxJiV0bjhg==
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr83084758wrr.74.1577911237198;
        Wed, 01 Jan 2020 12:40:37 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.125])
        by smtp.gmail.com with ESMTPSA id s1sm6682123wmc.23.2020.01.01.12.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 12:40:35 -0800 (PST)
Date:   Wed, 1 Jan 2020 21:40:31 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: declare variable as __be16
Message-ID: <20200101204031.GC3856@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Wambui Karuga <wambui.karugax@gmail.com>,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20191230195609.12386-1-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230195609.12386-1-wambui.karugax@gmail.com>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 5.2.11-200.fc30.x86_64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 10:56:09PM +0300, Wambui Karuga wrote:
> Declare the temp variable as __be16 to address the following sparse
> warning:
> drivers/gpu/drm/panel/panel-lg-lg4573.c:45:20: warning: incorrect type in initializer (different base types)
> drivers/gpu/drm/panel/panel-lg-lg4573.c:45:20:    expected unsigned short [unsigned] [usertype] temp
> drivers/gpu/drm/panel/panel-lg-lg4573.c:45:20:    got restricted __be16 [usertype] <noident>
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Applied to drm-misc-next, thanks for your patch!
-Daniel

> ---
>  drivers/gpu/drm/panel/panel-lg-lg4573.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lg-lg4573.c b/drivers/gpu/drm/panel/panel-lg-lg4573.c
> index 20235ff0bbc4..b262b53dbd85 100644
> --- a/drivers/gpu/drm/panel/panel-lg-lg4573.c
> +++ b/drivers/gpu/drm/panel/panel-lg-lg4573.c
> @@ -42,7 +42,7 @@ static int lg4573_spi_write_u16(struct lg4573 *ctx, u16 data)
>  	struct spi_transfer xfer = {
>  		.len = 2,
>  	};
> -	u16 temp = cpu_to_be16(data);
> +	__be16 temp = cpu_to_be16(data);
>  	struct spi_message msg;
>  
>  	dev_dbg(ctx->panel.dev, "writing data: %x\n", data);
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

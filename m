Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC9CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C595021A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3u6I6k9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfJCKCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:02:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33883 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbfJCKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:02:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id a11so2296907wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xbihRq/Slo3PYnJ3Dz7r1d50po3jOI3cDT0TFE0FHsY=;
        b=P3u6I6k9FG6wGcenAZdZUkqFpKCkLJ5BrfZdAQNV1t/3dHsDMQyM8r2XrM+wD6sgYK
         faa6vzUIukLSr1lEXgXbE6ovU+sLWZMq/C9uGiEL7uvb3ULew1rOoYLgvUAnVfHfKPT0
         gT4fThu51hUT4jGN5Fe+CQEcOpAjpUZR2rlU0a7BJF0h1tw36yytfE5SRyas8yy+/GnG
         bxsQv8nqpVvV5l+aZP2TqENOWdnwyQ+cqyGq2zqOYW06tb/Mmr1CQdtbmiX4wBh+r9Ly
         7RIIXb6ZOyk4xtXIDKP0HzMq5J8FgsMFMVlDhVd2zWfFlrO2jea9qrD9uiPxUbk3lS0w
         KNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xbihRq/Slo3PYnJ3Dz7r1d50po3jOI3cDT0TFE0FHsY=;
        b=NtkUXda93HDQ0O5RcnxmLCy16VETN1Hl9KHn52/pYNiD2GLgH2QJ/rrz0XtJ8YRSQ1
         PZAUvp+kITUBEKN9ncvep0WZ5YREtEaTm5eULsVWU9Ms2Gnw2thqEX0HIG2upuurqVsY
         m+kSZRCQ2M9ntf8km+BeSPeljJkiyjk7BStwr8zz3sf5VOQ0SmUQpeK3SuNFEm9Z9qm1
         VSACTee+adcD15EuDHYS/Ff7q5hrs6CDLDk6BVouGq3b0fme/Xlg4Fofnh43gaKGjsdz
         0ojIpJ3oXT6BewJrZI0Czna6297SapzjinBP7BFMRlwuayfg4TVgh5RnMeLSENiW/h6i
         ZqlQ==
X-Gm-Message-State: APjAAAUcGmxifs2lLbKKgLikh1WY9WUb0V1K5lufaagJLBEMGWj3yHcm
        dPB91Nz2Fbh4ykMhBjHcWuO+2g==
X-Google-Smtp-Source: APXvYqzXFwNjg21UC+vD/IXHxOJFRXUta5uNXiTTkdPFWBNH8Vus6TTdVG1q7oc8ZNLY0TQzsVeKTw==
X-Received: by 2002:adf:e60d:: with SMTP id p13mr5980140wrm.298.1570096929136;
        Thu, 03 Oct 2019 03:02:09 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v6sm1894952wrn.50.2019.10.03.03.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 03:02:08 -0700 (PDT)
Date:   Thu, 3 Oct 2019 11:02:06 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] backlight: pwm_bl: Don't assign levels table
 repeatedly
Message-ID: <20191003100206.ws35dbgifjwjicuv@holly.lan>
References: <20191002095541.v2.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002095541.v2.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 09:56:01AM -0700, Matthias Kaehlcke wrote:
> pwm_backlight_probe() re-assigns pb->levels for every brightness
> level. This is not needed and was likely not intended, since
> neither side of the assignment changes during the loop. Assign
> the field only once.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> 
> Changes in v2:
> - removed curly braces from for loop
> 
>  drivers/video/backlight/pwm_bl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 746eebc411df..05d3b3802658 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -564,18 +564,17 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	memset(&props, 0, sizeof(struct backlight_properties));
>  
>  	if (data->levels) {
> +		pb->levels = data->levels;
> +
>  		/*
>  		 * For the DT case, only when brightness levels is defined
>  		 * data->levels is filled. For the non-DT case, data->levels
>  		 * can come from platform data, however is not usual.
>  		 */
> -		for (i = 0; i <= data->max_brightness; i++) {
> +		for (i = 0; i <= data->max_brightness; i++)
>  			if (data->levels[i] > pb->scale)
>  				pb->scale = data->levels[i];
>  
> -			pb->levels = data->levels;
> -		}
> -
>  		if (pwm_backlight_is_linear(data))
>  			props.scale = BACKLIGHT_SCALE_LINEAR;
>  		else
> -- 
> 2.23.0.444.g18eeb5a265-goog
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

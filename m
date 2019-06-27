Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E12C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297922084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxjj862C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF0JY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:24:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39549 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF0JY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:24:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so1681260wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LDEo8sY3vpdehIJiLNOJb41+3SEg4OJB1McKdbsbLIA=;
        b=rxjj862CxQk8EcoCFKXxBXec7q2dUTnfV23dSWU3s6L44wRwVyzKQI9LaItmJJBCYr
         CCunUbf0DyHes+96gfl0uMFK7u1ofaigi6tzk8foroRtjW67UkxmOjGR6pS8kxcMHMQf
         gfDC+UhYjbyEUkiMyFnCXp19uDzY8x/EIFJkHM36kWk82KVh6kEh17ORV4Ap0dqDjQeP
         eodW+lpOR5ylkyFRmF441elJYxUkOm61ILlY1XXEY0Qjg+u0/dV1FxmGel1jFTcSljsA
         mWoLPSgxDbcZ1/DraVDtzbuYhHkXnZ+w/hbhz5oruBYDlQJrnauT9rMlNjkp6tmEGn5i
         i8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LDEo8sY3vpdehIJiLNOJb41+3SEg4OJB1McKdbsbLIA=;
        b=Kj4I4nxtu93LGjwbmy9r8JBLZlWlV4S5bQ5PtXIvHLsW488UeoimbrvcUCcY+P8ogY
         1rB/B9Apcf2Sn3ubxk84jjVLlZi+xG44pgLO2d7P8y18oT7zOmiLWlhBbRiRtLO0062F
         grcFKer/sSQ6UaPHR6XOhe5UAld7x11v59B4jowLdZ1k3HX7gcIr6ipJU3b3j/8APfQC
         TnlXuH56U8d6pRIkXEHKYcRetTmzTfti89QmgGtZMICK5di/y+bTcsTWPDFk1SFkcCep
         KpHeKvddat7cSbdsCw2yflO1E886XHl6t9h8qkEO/YAD/Qk11ovEww4h1GoBFzsTOpaR
         Is8A==
X-Gm-Message-State: APjAAAUc0tm79pa2QJblvyqcooA88XyfWA5wDg+hTgCM5kuCPdH3G+b7
        ZgYNs/M89GEZ+wi1dqFIUAxJYg==
X-Google-Smtp-Source: APXvYqwlvlqQ9PBpwP6Ua8UBVUJ+rHq8wSy378IO2LZ07NL/lYMF4gUKV993A67XO9U+QjopyAUeqg==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr2224711wrj.47.1561627496119;
        Thu, 27 Jun 2019 02:24:56 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id h84sm5790048wmf.43.2019.06.27.02.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 02:24:55 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:24:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 3/4] backlight: pwm_bl: Set scale type for CIE 1931 curves
Message-ID: <20190627092453.GB2000@dell>
References: <20190613194326.180889-1-mka@chromium.org>
 <20190613194326.180889-4-mka@chromium.org>
 <61ed137c-31bb-c695-4174-0484fe667d6c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61ed137c-31bb-c695-4174-0484fe667d6c@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Daniel Thompson wrote:

> On 13/06/2019 20:43, Matthias Kaehlcke wrote:
> > For backlight curves calculated with the CIE 1931 algorithm set
> > the brightness scale type property accordingly. This makes the
> > scale type available to userspace via the 'scale' sysfs attribute.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> I'd like to keep discussion on patch 2 open a bit longer (it's not part of
> the thread below patch 2 but Pavel had concerns about the sysfs interface)
> so this ack won't really push things forward but FWIW:
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Does this depend on patch 2, or is it orthogonal?

> > ---
> >   drivers/video/backlight/pwm_bl.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index fb45f866b923..f067fe7aa35d 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -553,6 +553,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >   		goto err_alloc;
> >   	}
> > +	memset(&props, 0, sizeof(struct backlight_properties));
> > +
> >   	if (data->levels) {
> >   		/*
> >   		 * For the DT case, only when brightness levels is defined
> > @@ -591,6 +593,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >   			pb->levels = data->levels;
> >   		}
> > +
> > +		props.scale = BACKLIGHT_SCALE_CIE1931;
> >   	} else {
> >   		/*
> >   		 * That only happens for the non-DT case, where platform data
> > @@ -601,7 +605,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >   	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
> > -	memset(&props, 0, sizeof(struct backlight_properties));
> >   	props.type = BACKLIGHT_RAW;
> >   	props.max_brightness = data->max_brightness;
> >   	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, pb,
> > 
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

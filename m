Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E05EC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756C624672
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sIs+fcti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgAGOdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:33:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39375 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgAGOdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:33:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so54177884wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 06:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B9kCZBzCa3OPKOxnRW9B6aJzv1zvRjaOSS6YO9GMesQ=;
        b=sIs+fctiAHDZvO1/J//nk3hf4t/k9VgDnBJ8fooiGvnZFm5IJz3/K8auAGQVsiKqRp
         bZwBxmWg/4kZUGed7vrb6mcIBEPFpUsmS8Puq0N1osWgGg45KyLx6ozVkA1YAel4Y7cN
         p5FRcwNTJjlzACZixiGRyO9PpSpyGr37HETuafnI2pP5+NRSbRebqYJKKEo7/8ULnYIA
         wtIn0vxX9sBlm9wuFaYH9QiUREBKE2MMuHmw2OnXOM+P66pYE63QNXCQPar20680vRVB
         hqrV04wl/YLDH7k2xt9HrsVIBI96XJapKHx8ln7dw+m57FzHpQfz9F4gDfZwIzrezF1M
         Y5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B9kCZBzCa3OPKOxnRW9B6aJzv1zvRjaOSS6YO9GMesQ=;
        b=aHmJrOTa86gJW3BrhlfoRHedtqk9vTctbxmqsLg/PnPOD9CyfQczMPsicggTS+qKv2
         VNOsHDOvVOL5gcizjKRS9W8WDKgqSNjAibmlfn8iCcumJd8ZeBihabcERNsDQwXj+G2c
         AhfLKFwRUTuQZMNngedIy9heAsIqSyuRZDRzrnd/Yf18IKpx3eY8l/D52151QY8J2Jb4
         p9lMbzBIoh4B1zrSomgqBqYnkEpLuCTxmpCowN/0tZ2qZQny3wITlcl3QcNURPN6d7L4
         dDpyTNIVD9mfLPMuQ9bcqch/LoCYSHR0ZLXh6/9j9qFr+u2ccHkD9a7igbeml5hkmPp6
         K/nw==
X-Gm-Message-State: APjAAAUiQd/uXHgP61OW+SZeyEL05YX8yR7PsARdvhVlavFtxe7cQoCd
        Mi576YlOQHIHM+NNbJTi5+dnaQ==
X-Google-Smtp-Source: APXvYqxLiq2Vxm7BymdTvGrcQbAasyqJYAawPBC+jse2yxXUYIok3KtmZ1vQbeEpibLG0Ldxa+sO6w==
X-Received: by 2002:adf:806e:: with SMTP id 101mr7682761wrk.300.1578407621321;
        Tue, 07 Jan 2020 06:33:41 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id b17sm36621wrx.15.2020.01.07.06.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:33:40 -0800 (PST)
Date:   Tue, 7 Jan 2020 14:33:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Tony Lindgren <tony@atomide.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        jacek.anaszewski@gmail.com, sre@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, daniel.thompson@linaro.org, dmurphy@ti.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com
Subject: Re: [PATCH v10 6/6] backlight: add led-backlight driver
Message-ID: <20200107143342.GP14821@dell>
References: <20191009085127.22843-1-jjhiblot@ti.com>
 <20191009085127.22843-7-jjhiblot@ti.com>
 <20191121181350.GN43123@atomide.com>
 <20200107102800.GG14821@dell>
 <20200107134540.x5tngzoslssesb2y@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107134540.x5tngzoslssesb2y@ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jan 2020, Pavel Machek wrote:

> Hi!
> 
> > > * Jean-Jacques Hiblot <jjhiblot@ti.com> [700101 00:00]:
> > > > From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > > 
> > > > This patch adds a led-backlight driver (led_bl), which is similar to
> > > > pwm_bl except the driver uses a LED class driver to adjust the
> > > > brightness in the HW. Multiple LEDs can be used for a single backlight.
> > > ...
> > > 
> > > > +	ret = of_property_read_u32(node, "default-brightness", &value);
> > > > +	if (!ret && value <= priv->max_brightness)
> > > > +		priv->default_brightness = value;
> > > > +	else if (!ret  && value > priv->max_brightness)
> > > > +		dev_warn(dev, "Invalid default brightness. Ignoring it\n");
> > > 
> > > Hmm so just wondering.. Are we using "default-brightness" instead of the
> > > usual "default-brightness-level" here?
> > 
> > Did this get answered?
> > 
> > > Please Cc me on the next patchset too :)
> > 
> > I've been waiting for v11.
> 
> I guess I could just remove it from a merge for now if there's no other
> fix.

What do you mean, sorry?

This patch should not be merged anywhere yet.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F6CC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400C622D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmZFwO7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfHUOQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:16:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40746 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfHUOQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:16:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id c3so2200209wrd.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cdtuJEJPiRHYBRkWLphaMlBKW6Qllc1jRrn7Evl95W0=;
        b=jmZFwO7aPbSPs4T3u6HFT7/UzQEynyx3CLoy6cPRt8GFo+A0DNBZKk7hz3rjw22uVC
         uJadNeGBW0V5GinSEgjuPf3kwqOUTeenRZvKcchdVxltfYwFSCRv0tWFoYws6SLI5hUf
         RUzh2AMZp4k+OkvBYlRTcvH/evX96Zb20+IupWV+atHwY9RS5NoM0+/03tP7MYVjfIMo
         0Af1Xka7SljkMAGPasYem64gsOBd+9foTNIpBUu2Duybs1OqZAosGxlUqHumHbYp9C3E
         NMx3eiNgPewmBOVXvNhD4WWzws5NHWBEP4KY8S/GVTWk3DdNPq9yLsLk67u3Z/u7vQpE
         Bdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cdtuJEJPiRHYBRkWLphaMlBKW6Qllc1jRrn7Evl95W0=;
        b=qIpSUqp4og7rUzv5/WOz80QkxMM1o/0X+hupZNIeybwDaolRRwMlLN2Uwshm5463l0
         +8tKh4X72ybUDGw114A5hDGUzWd78jh4pLW2OAk76v/XalBbTMn1HDwk6ZqVzZ8+yG6V
         F/UqQjf5MlNJvsXPCkFXB0g2aTcN2Y06wxUTTpgjh0ukb+B0GAt1F18kzB8kaoKeOnBI
         fpFi4CYloXvPG1rcMwq8HMTjj+qdLDxQ3zaFq7Y9BE7n+FkSxVGN2e1UhHRIvtHCnWbK
         SrIKMi9YFamjBd7LVbdHq1Cc/SEUebPucU7fJ2trLpomJn4kbRIHigyd7/IWabfzq4Yq
         kafA==
X-Gm-Message-State: APjAAAXPh4Z/VFx6eqBY4/tdiTPpujUpT19RxYIO6BZ2xQg28Fh/bM3z
        0s8WvacLXikPSKpXuh4C5HIdRw==
X-Google-Smtp-Source: APXvYqyWXU+FCJwHRqtC9ZXeDqIM9kre79CXAhUyQKtWQkywMQ1AtsuSunZHdIngi7gFPJHEJ0plDw==
X-Received: by 2002:adf:82d4:: with SMTP id 78mr38474896wrc.85.1566396980736;
        Wed, 21 Aug 2019 07:16:20 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g7sm203936wmg.8.2019.08.21.07.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:16:19 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:16:17 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through
 sysfs
Message-ID: <20190821141617.e5avfbyvooddixcd@holly.lan>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190816165148.7keg45fmlndr22fl@pengutronix.de>
 <20190816175157.GT250418@google.com>
 <20190816194754.ldzjqy2yjonfvaat@pengutronix.de>
 <20190816211051.GV250418@google.com>
 <20190819054628.asw3cxp46w3rpml7@pengutronix.de>
 <20190819095037.h3gig3quyhnzshm7@holly.lan>
 <CAKMK7uEJptKgoAwTO+OuN0HrBiMMG21w0QAdgD=pHBLoKLi38Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uEJptKgoAwTO+OuN0HrBiMMG21w0QAdgD=pHBLoKLi38Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 04:49:21PM +0200, Daniel Vetter wrote:
> On Mon, Aug 19, 2019 at 11:50 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > On Mon, Aug 19, 2019 at 07:46:28AM +0200, Uwe Kleine-König wrote:
> > > And the big upside is that in the end (i.e. when all kernel drivers and
> > > userspace applications are adapted to provide/consume the "correct"
> > > curve) the result is simpler.
> >
> > My view is that this convergence will eventually be achieved but it will
> > happen through the obsolescence of the backlight sysfs interface. The
> > sysfs interface has other flaws, in particular no integration with the
> > DRM connector API.
> >
> > Thus I would expect an alternative interface to emerge, most likely as
> > part of the DRM connector API. I'd expect such a new API to a
> > perceptual scale and to have a fixed max brightness with enough
> > steps to support animated backlight effects (IIRC 0..100 has been
> > proposed in the past)
> >
> > In the mean time getting the existing collection of backlight drivers
> > marked up as linear/logarithmic/etc will ease the introduction of that
> > API because, within the kernel, we might have gathered enough knowledge
> > to have some hope of correctly mapping each backlight onto a
> > standardized scale.
> 
> In case people wonder why the drm connector based backlight interface
> hasn't happened ages ago, some more context:
> 
> - userspace (well libbacklight) selects the right backlight, using
> some priority search. Plus blacklists in drivers to make sure they're
> not overriding the real backlight driver (e.g. acpi has higher
> priority in libbacklight, but on modern system it's not the backlight
> driver you want. If we move that into the kernel it's going to be
> somewhat a mess, since defacto you never know when loading is complete
> and you actually have the right backlight driver.
> 
> This isn't a problem on DT platforms, but really just for x86/acpi
> platforms. But if we don't fix them, then userspace adoption of these
> new interfaces will likely be too low to matter.
> 
> - second issue is that right now the kms client is supposed to handle
> backlight around modeset, like fbdev does through the fb notifier.
> Except for drivers which do handle the backlight across modesets, but
> maybe not the right backlight. If we move the backlight interface to
> drm connectors then the right thing would be for the drm driver to
> handle backlight enable/disable across modesets. But to make that
> work, userspace needs to stop touching it (otherwise userspace first
> disables, then the kernel and then on restore the two fight and
> usually black screen wins), and that's a bit a tricky uapi problem of
> not breaking existing userspace.
> 
> - finally there's some userspace which assumes the lowest backlight
> setting is actually off, and uses that to do fast modesets. This
> doesn't work on most ACPI backlights, so I think that problem isn't
> widespread.
> 
> Anyway from watching from afar, I think this clarification on what the
> backlight scale means internally should at least help us somewhat in
> the long term. But the long term solution itself needs someone with
> way too much time I fear, so lets not hold up anything on that.

Thanks for sharing your views on this.


Daniel.

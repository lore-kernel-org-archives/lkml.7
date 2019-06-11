Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFE4C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7BE20665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oIUVz20N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407687AbfFKViF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:38:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38691 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407675AbfFKViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:38:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so5671431plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 14:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c/V5azhQK0NKG3CgTrOQr2YdB5nv03TCL7KtVGmmTnE=;
        b=oIUVz20NxztwZIHdK3k65o0Fojj8X3TmNQgvsbpNbh+NJFEE9FTzcALPGexsN2u0lV
         R4N/0/VHL69lIgdJo/Mavd44QxzYFnGkGyNM5SqP5YDejiSLqcxh4/bWKonb2Q9Rk44g
         4lfQgqfTvNf3GlM1jKlbf4K51OOFbRZUH6njQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c/V5azhQK0NKG3CgTrOQr2YdB5nv03TCL7KtVGmmTnE=;
        b=SAPhLP/CZjTs7HAXJVDjhRZO9iLKG5bAxu2twGFVkHRFecw7QfYghjeuJXEbQI0xLh
         /mCnYtbXOn/rn+4ZI8ho1RSNUW0D2tpw203uE832YZzPL/IJyPp+bYk8JciXIzTfZvXd
         hdQoqwex/m54fEebkikkQYmTF5WTzSBEo7ByOkoXoTpeMeZpChZPHRMx67l0TzxLNmjl
         jx/Gjk8qX8qGIOBLsBmTeVVOShdUdZAJtrE3uK4cpOGUb6oEdA9GAe0GMd1XxnNricTX
         Xah20RbaPbUctjrTWTUBK3Oy9ekG+3EEN6nGgqnVzEbCEgC445SRbWeqqYfShosKRsBT
         nkvg==
X-Gm-Message-State: APjAAAU38KZ03fEdsyZoqr07MdVeoC6tfivMRou0cb/V+7I/0d+WGgsq
        7I+zHmqgJZ+GukgymHpLBUpCaQ==
X-Google-Smtp-Source: APXvYqw7YuxbYKqsmcBwdCJJBrsNVyyiE8CmkHa4T0LQVEl29ePKAtTry61J448brFzrtjCg2vAB6Q==
X-Received: by 2002:a17:902:d695:: with SMTP id v21mr62285877ply.342.1560289084363;
        Tue, 11 Jun 2019 14:38:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b128sm15771434pfa.165.2019.06.11.14.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 14:38:03 -0700 (PDT)
Date:   Tue, 11 Jun 2019 14:38:01 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm-backlight: Add 'max-brightness'
 property
Message-ID: <20190611213801.GE137143@google.com>
References: <20190610233739.29477-1-mka@chromium.org>
 <20190611102851.GA16611@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611102851.GA16611@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Tue, Jun 11, 2019 at 12:28:51PM +0200, Thierry Reding wrote:
> On Mon, Jun 10, 2019 at 04:37:38PM -0700, Matthias Kaehlcke wrote:
> > Add an optional 'max-brightness' property, which is used to specify
> > the number of brightness levels (max-brightness + 1) when the node
> > has no 'brightness-levels' table.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  .../devicetree/bindings/leds/backlight/pwm-backlight.txt       | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > index 64fa2fbd98c9..98f4ba626054 100644
> > --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > @@ -27,6 +27,9 @@ Optional properties:
> >                              resolution pwm duty cycle can be used without
> >                              having to list out every possible value in the
> >                              brightness-level array.
> > +  - max-brightness: Maximum brightness value. Used to specify the number of
> > +                    brightness levels (max-brightness + 1) when the node
> > +                    has no 'brightness-levels' table.
> 
> Back at the time when these bindings were defined we specifically didn't
> add this because it was deemed impractical. That is, no real hardware is
> actually capable of achieving useful results with a simplified
> description like this.
> 
> Besides, we already have the num-interpolated-steps property which
> should allow you to achieve the same thing:
> 
> 	brightness-levels = <0 255>;
> 	default-brightness-level = <1>;
> 	num-interpolated-steps = <255>;

It doesn't achieve the same. With this configuration the device would
have a table with 256 linearly increasing values, the intended use of
the property is to provide the number of brightness levels to be used
by the CIE 1931 algorithm to compute a brightness scale that is
perceived as linear by the human eye. We could possibly treat a
'brightness-levels' table with only two levels as special case and
get the number of levels from it.

In any case from the discussion on "backlight: pwm_bl: Get number of
brightness levels for CIE 1931 from the device tree" it might not be
necessary to specify the number of levels in the DT.

> Though given the original discussion that we had around how backlight
> hardware behaves, that doesn't seem like a good choice.



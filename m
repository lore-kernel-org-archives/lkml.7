Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4A3C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797232089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVUnEDJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391460AbfFKQzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:55:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42147 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390815AbfFKQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:55:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so12338812lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xh2IY7LpPfFuCqJ10WrTcz/y2fuRKJsYuYIzkRCHPGA=;
        b=vVUnEDJygjVhekQktjlLFhfyt/TULR2B1WfScNaOoGloNtpx2vfSiB+G/CX3eORLjT
         G7uF00KbXWKOgLrCKFt2ElbyKKBj7UGNgE3qSHyMqY1a5Pa6JO/asgQ3eA4cH2tjTbLT
         OnpX7Y6Nw5edKDsZjSnlBYS1OHSqLontrnYzE63pocD3JELJy7J5TX9sG+rAYqz6B7nH
         o31JpQJKjJ3i6cU94KGEX+LHAhEnu1SQbIJRdRL3AFvCLg6Fs9JqU3ncjsO/6Wj/3JJs
         8NebdMponYEqEN0JgIaeIZuEAsJNMsc0V5wQwraKtCbq1vonKbi6AjJIAE2oeW3Lo5OZ
         /Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xh2IY7LpPfFuCqJ10WrTcz/y2fuRKJsYuYIzkRCHPGA=;
        b=LzKqZsTgzBLf/KcLV0DSZDD6nnvv0nj7kyELp2apLB6gfBi08k7vG8YOkXLlUNm9Mu
         mZHY4mzZ4wlnqmB19bQmfh0sHLLqqYc6oewiEDGSF14N/ieRLtAZd3zTjSVDa2HeLDqg
         JwdPvQ8gWqKBcV/IBswV9ahcu7cj0RiR/rFUxWCSwcz71g2DS4Obx1L9/R3ThIuInAAJ
         nnoojFwvCSj2w9SSqGa32ergkGHbfVRa3QZbfVs+3FQB96CXiMyEuw3DzAh9qZY5IxrA
         xT1KFLbsJA56M1cs1/isMOsCKaNfizUpwn3T88eW96EhTPek4gA/9w3r2rZHxhNDFyzY
         e0UQ==
X-Gm-Message-State: APjAAAVlfbefRmbs7RRby8aGXskS5+DXphon+vaRim10ghEr9aKnGWp+
        c0nrmuViLsYMXiNqqE0TM/0OWvI6ahBYOnVIaojVdQ==
X-Google-Smtp-Source: APXvYqw34lPSRZEgkGFHqW2B5EX/1BVK1usgV7bVySIzKQ01HlDt6hTtvz7UkvAtJxHIArPRYUa8+lvbvTxpux61U8A=
X-Received: by 2002:a2e:2411:: with SMTP id k17mr11738029ljk.136.1560272142410;
 Tue, 11 Jun 2019 09:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180208113032.27810-1-enric.balletbo@collabora.com>
 <20180208113032.27810-4-enric.balletbo@collabora.com> <20190607220947.GR40515@google.com>
 <20190608210226.GB2359@xo-6d-61-c0.localdomain> <20190610205233.GB137143@google.com>
 <20190611104913.egsbwcedshjdy3m5@holly.lan>
In-Reply-To: <20190611104913.egsbwcedshjdy3m5@holly.lan>
From:   Brian Norris <briannorris@google.com>
Date:   Tue, 11 Jun 2019 09:55:30 -0700
Message-ID: <CA+ASDXOq7KQ+f4KMh0gaC9hvXaxBDdsbiJxiTbeOJ9ZVaeNJag@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] backlight: pwm_bl: compute brightness of LED
 linearly to human eye.
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Guenter Roeck <groeck@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 3:49 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> This is a long standing flaw in the backlight interfaces. AFAIK generic
> userspaces end up with a (flawed) heuristic.

Bingo! Would be nice if we could start to fix this long-standing flaw.

> Basically devices with a narrow range of choices can be assumed to be
> logarithmic

That's (almost, see below) exactly what we have.

(And this is what Matthias is fighting against, now that we're
implementing both "large number of data points" and "pre-curved" at
the same time. We will have to either adapt the heuristic, or else
adapt our device trees to fit the heuristic.)

> Systems are coming along that allow us to animate the change of
> brightness (part of the reason for interpolated tables is to
> permit smooth animation rather than because the user explicitly wants
> to set the brightness to exactly 1117).

Chrome OS has done this for a long time. So "coming along" is a bit late ;)

Also, I believe Chrome OS will do animation/smoothing for all tables
(small or large) where it can: even for the small tables.

> These systems are often
> logarithmic but with a wide range of values.

NB: Chrome OS happens to use a polynomial formula (exponent = 2 or
0.5, depending on how you look at it), not logarithmic. You can see it
in all its (non)glory here:

https://chromium.googlesource.com/chromiumos/platform2/+/ee015853b227cf265491bd80ccf096b188490529/power_manager/powerd/policy/internal_backlight_controller.cc#451

Regards,
Brian

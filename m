Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42720C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BE3215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtdbS5Yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKHPwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:52:38 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44116 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfKHPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:52:37 -0500
Received: by mail-vs1-f65.google.com with SMTP id j85so4065080vsd.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 07:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YXITSGLnneLKKdtVpM2UNV6rrznDz/ekZ9r9rBO9SI=;
        b=UtdbS5YypN2YH6FLlGOHdLiFf7VGVzCal+HYQyJOEHc1TplZS9lq7HNVcpCkHCgAfc
         pixK196haQ111JSUOpuODK4zRvu904VpaoLrIHPyPx9pZBjtchnP+VeUyg04oEayZVCK
         0ejE2kydJzubnSrnLLlLHh5mvDDBISkzJrdjwJCkbvtJxolKConD0YFyYU6eZQIm+F6o
         4y/kT4KIUjKOp6DOVgCump9suG6aURCPiDsr/sAIZ7BB84VivayAJIL/2G5bgDFixvub
         pWURjxrp2ud/QeUSUXh2QM0K8mJtO9bAQkdRpWxyvSS9zzEQGEY+9UGf74xRDNhEHudH
         8/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YXITSGLnneLKKdtVpM2UNV6rrznDz/ekZ9r9rBO9SI=;
        b=V9VbCSu6VC5LKcUANaSRnkz/mUBrC+MlmNhcFTboM9L4X8Mr/bKSgZJ3Ya1XYAgPOQ
         A8NNZ1GsJrNMEwJR1lTnO1KAKmJf8cLolyeEeJ9hTz/G4d5IuAAioj0MGxxWoxkKVYPx
         gY4vv8weDcWKoJEz+u7GjmiMfmyBO4sJzoavGKjJLDcot8M+LP4drzIoaTG9wtq2FM1h
         afVxlW1kdx3ELiN+MF+e60GzVgXR+qlVI8SMFUT30jfwVd28OhG7m3sIs/y18Z5943k5
         bWk3d/TcS4Iv4EWBu5xp5bNFYASWS70hvr6+JgVB53dkWpK8SGFLLMMzOC0S2w6fhV9J
         Th3A==
X-Gm-Message-State: APjAAAXnH2jUtrQRZaRUKTAYjmVkwSuKD9igirVH8zdc7v+4EbUSEZ9a
        lCoyXj1dQO5WgBuTTlon048gxvPqMKPRGVVVL+ysyEmqvJA=
X-Google-Smtp-Source: APXvYqyJwBX4nWIKSR4Vg+1DGbqzLNbIfIhzYdSqam6Gp5jSPrm/x1ZeX7CMad1CA6Abk9HXdJsBIUWpk9690aRO0qA=
X-Received: by 2002:a67:db9a:: with SMTP id f26mr8325450vsk.84.1573228356636;
 Fri, 08 Nov 2019 07:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20191106165835.2863-1-stephan@gerhold.net>
In-Reply-To: <20191106165835.2863-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Nov 2019 16:52:25 +0100
Message-ID: <CACRpkdarNDhZvks4AWOX_=rcjprd_tCiaYZ90_+krRwGpKgTtw@mail.gmail.com>
Subject: Re: [PATCH 0/7] drm/mcde: DSI video mode fixes
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 6:01 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> This is a collection of fixes to make DSI video mode work better
> using the MCDE driver. With these changes, MCDE appears to work
> properly for the video mode panel I have been testing with.
>
> Note: The patch that fixes the DSI link register setup for
> video mode [1] is still necessary; but we still need to finish it
> and actually make it initialize a panel correctly.
>
> This series contains only patches for the other parts in MCDE.
> I have tested it by disabling most of the register setup in the
> DSI driver, which makes it re-use the properly working DSI register
> set by the bootloader.
>
> [1]: https://lists.freedesktop.org/archives/dri-devel/2019-October/238175.html
>
> Stephan Gerhold (7):
>   drm/mcde: Provide vblank handling unconditionally
>   drm/mcde: Fix frame sync setup for video mode panels
>   drm/mcde: dsi: Make video mode errors more verbose
>   drm/mcde: dsi: Delay start of video stream generator
>   drm/mcde: dsi: Fix duplicated DSI connector
>   drm/mcde: dsi: Enable clocks in pre_enable() instead of mode_set()
>   drm/mcde: Handle pending vblank while disabling display

Tested all 7 on the Ux500 HREFv60plus with the command mode
panel without problems.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

I will apply and push to DRM misc for-next with my Tested-by tag.

Yours,
Linus Walleij

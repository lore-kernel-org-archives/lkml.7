Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A1DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F7A20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Al5l4E4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKTUdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:33:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41061 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKTUdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:33:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id m4so598139ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CX0sEQr8WI8l3jpI/Uek4j+yfhDbsc5jpx4UFAkfVWE=;
        b=Al5l4E4xtj1f2KYK87U5xnNVGqq/w2dR6lByuU/kC5Ei2FFFIYSwNIwjOlbn2txhoT
         0cVSOBBCUUtp5mOyBmAgZjM4WI3ARJ50syN8HiyPP1pGyjXvJjnGBOtpcxldOHolknQA
         D9+Jb8DDf+lfsB0ZYboaF5C33P7JRDm2EXE9pJr/SPpl+rGtcQ4ogA+5z5QfBA2/xpZM
         6JaH+/OWZiceK4KeCiernnuNovE8wT0LROenVUz8A/uGsoq2asW1L28HLiy7yOdVZ0V3
         bhH02oeCniDbNDueQEy6AQPdOdmCicRxgAURPF9fvzGdN56rPVrJPzXHVok7c0NLzPfb
         Ru2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CX0sEQr8WI8l3jpI/Uek4j+yfhDbsc5jpx4UFAkfVWE=;
        b=KnFzkGZthfpRlPqLH2vhHYS5aSRFPf+MZb4VXBaSEa3mWuMmnJg9kf8KjDEdXD5TyA
         nhy30lSoTiJDv1eHs6I2/gX8XYuUlnmVjDlcQPIWgcBPRh8lIyYhLMZlKPBwue5nEdC7
         kZXJxv4pEOoC4sNIO8Ki5wWRO9sYZ6KByG0a8jzMrqyF8WIv3iSIAghibrh57Ceylt/S
         +SBPMq6/ClSbLbnf5CLb5fv0aobcKqbiWf2L+zA8s7UOjlHOypSNqvmRwYLi/BZsFjXc
         gvbkiO6Pda3mM5Q4YVpYLk45jJAt1puTPd5+6Gi26i0GVIednmE5LyGn/nDHF4jhDism
         dhqQ==
X-Gm-Message-State: APjAAAW/6R990pwQiBuw43g/FXssXw+ddz0YWMZVL1DSkQ1fuxx2gO7l
        nxUKr57BJ8I6wdW6/waC1qarOEUyayEiekHO6/LmTom0ZY0=
X-Google-Smtp-Source: APXvYqz6nHxRAERTSyvWsOimSaGv8OyCawtOTBJu6+DmMpbJpE9YaYF2R2Gx9Rv2X6anQ15/5/vYhkbahOdYSMMgSp8=
X-Received: by 2002:a2e:161b:: with SMTP id w27mr4431575ljd.183.1574281983876;
 Wed, 20 Nov 2019 12:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20191118130252.170324-1-stephan@gerhold.net>
In-Reply-To: <20191118130252.170324-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Nov 2019 21:32:52 +0100
Message-ID: <CACRpkdZgeDtFdBLLiO2Kw9AKU-rbBoKCAccJvOP5GMG+NqS2GQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mcde: dsi: Fix invalid pointer dereference if panel
 cannot be found
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 2:04 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> The "panel" pointer is not reset to NULL if of_drm_find_panel()
> returns an error. Therefore we later assume that a panel was found,
> and try to dereference the error pointer, resulting in:
>
>     mcde-dsi a0351000.dsi: failed to find panel try bridge (4294966779)
>     Unable to handle kernel paging request at virtual address fffffe03
>     PC is at drm_panel_bridge_add.part.0+0x10/0x5c
>     LR is at mcde_dsi_bind+0x120/0x464
>     ...
>
> Reset "panel" to NULL to avoid this problem.
> Also change the format string of the error to %ld to print
> the negative errors correctly. The crash above then becomes:
>
>     mcde-dsi a0351000.dsi: failed to find panel try bridge (-517)
>     mcde-dsi a0351000.dsi: no panel or bridge
>     ...
>
> Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Patch applied and pushed to drm-misc-fixes, thanks!

Yours,
Linus Walleij

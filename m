Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815EACA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC6E21925
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391995AbfJWNaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:30:00 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40247 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389928AbfJWN37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:29:59 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MpDVx-1hf9jO1AyN-00qfjg; Wed, 23 Oct 2019 15:29:57 +0200
Received: by mail-qk1-f175.google.com with SMTP id 71so15857206qkl.0;
        Wed, 23 Oct 2019 06:29:57 -0700 (PDT)
X-Gm-Message-State: APjAAAUz1m/L03nkwFR64TEPwnvYj2SBot3Ce1SNhrefR9kc+30hO9Da
        kirG5qiC00YmM7D7X+yQ28U+cbJ4+Hg5GS3UTyw=
X-Google-Smtp-Source: APXvYqzGCvORTP+HJikmS9n+sLPhWUfQgJCCEYKmJ03DZvSC0gT0L7hZhZ7lqgzmTpFpBJ2WhE68gjxgaObVawX07k4=
X-Received: by 2002:a37:a50f:: with SMTP id o15mr7091533qke.3.1571837396079;
 Wed, 23 Oct 2019 06:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-21-arnd@arndb.de> <20191023125053.GF11048@pi3>
In-Reply-To: <20191023125053.GF11048@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 15:29:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3x1_eB4GT7qvhgVnq-sU8a=wkSf4FP18p7pVHmtrfWFA@mail.gmail.com>
Message-ID: <CAK8P3a3x1_eB4GT7qvhgVnq-sU8a=wkSf4FP18p7pVHmtrfWFA@mail.gmail.com>
Subject: Re: [PATCH 21/36] ARM: s3c: move iis pinctrl config into boards
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:45uo9k27IIpvoy/lowmX+iONkHFYeoQnOIQJAEa6ppYylVtzEXq
 kW2ac8i4htkGzKKk4ldFgDxmMg4155Pp4dYObmc1NuY/8vxlP7iKv4u2MHuAaGNcFrVqcCD
 B64z6UzDoNSGSudD7wVd7RDHcfMiMZj+1FInnORk014sBvIRncGhAISk782REyxXzhMPcsZ
 3Uh8qiTjRBYfx+1vPA85A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o21pk2LcCic=:GEQ5+tFm0A0qWIS7Vogk5M
 5EFViD+5FUVRSI3WOIKTN7UaBKTlfP4nEpN8TQ6fcd1YiKKQ0xt6rL0sg9sxfblyZQaPZ43iP
 yQqrRvTXyrWNuYJIOdSKChQAh8usEUSxM6GYJOHtBkjhH+AkKMq7SGogpXROLrAdQmU2IGd09
 jJDj3Xor8OBIw8WgZx/RBcnM5KuVGmjgyHacj+111XYMIML2sbNgpNlZsZMitpj1dYpzZHmIt
 WS6qk4xy3dTyr941IsiHOECW55WljVEvxjdUvzXFHxCjEGhOlkZD6TnZmcUEPOlKn0f1eznvl
 fXtC3usXJFSIMz/yPApySJrB6nXwpCeQi3m8w1EuEv+5ESdBc+323DT5zUJMfdEg3jaTmubYw
 fvWCNXMVCbLBFT0R1tvbNQC4o8Pz4gO0ONBMK+4b4kKgPJyjruugu59DCv3dTESBuXNYlf9XE
 nwNHNJC9mVza64vwu443gFdqK+zUuqrhfQyeMs9mNM6jQIb+FZYGNXJUXIq2yx9jegsFpgeT8
 CWIMocJAXGi6hvMgRyg0cKTSlRml39XENNZn4f5ii0Ln3jUC1mGaa3HgX9p8UIG25ppK6EsYU
 4eineBnRapCS9n9hjmvK/TEpG2QVHy9dkCxeKiLimDX03+YZ9zaX/JETObhTmqVjxjcZs1Aqo
 bjYLC8MrX3JqoHOJYWuHvOM0ZaGYYZMtRWp0UjpK1mQEsKyScu/F1/bnPdHRiK2xuD+rJ0sT9
 Qu2OIpOU1w2Vd6cuir0ch+wuwwg3rM6eJNf65RFeRXXfLd9q93xEczY8Lay5QDVRGv3fnO0w8
 ebma8iao+utzb31K61FuxqmFzGIr5yPwnKZ6Fbrp4wRQ0E1E255mamlJ/KmEofO3uGOIUqVYJ
 BDOlVYxNVEZGSD5uzr9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 2:51 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:30:05PM +0200, Arnd Bergmann wrote:
> > The s3c_gpio_cfgall_range() function is an internal interface of
> > the samsung gpio driver and should not be called directly by drivers,
> > so move the iis pin initialization into the boards.
> >
> > Note that the s3c2412-i2s driver has no boards using it in
> > mainline linux, the driver gets selected for the jive machine
> > but is never instantiated.

> This is not entirely equivalent move as before this was probe (so being
> executed also on rebinds) and now it is init. I guess it should not make
> any difference so let it be.

Right, I've added an explanation in the changelog text now:

 The s3c_gpio_cfgall_range() function is an internal interface of the
 samsung gpio driver and should not be called directly by drivers, so
 move the iis pin initialization into the boards.

+This means the pin configuration is only run once at early boot, rather
+than each time the driver binds, but the effect should be the same.

        Arnd

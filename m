Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9A7C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414CC2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XLGV3B0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgAGLDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:03:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34366 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGLDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:03:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so53430469wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 03:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=xyZS91HmTWb7A0olo7U4XRnlJNJkRCAhnyhMR3Zh6ng=;
        b=XLGV3B0w53+LAAAizJxW1KD6wXybJqgKTbqEDCaylaY0nMPB+bmDM8i7LKh3jThJPY
         piJdz/2D7EbKmCcVQrRYJwAmUyub+Ty7SyHXAZDRxLlLdVFE9IzL7NHOmwxKTX+BMvhH
         /tfyxAFTf3vbrWl4PnSzSVVVPtRA1V7NWo0hSIU4nqC2RjJQDAyoojirexKnN2FiADKL
         8nJwJKeQUai6h423Z8BeTpA6X2ZjvlBGevlkk1ghfj47tCArhxzyDKnzqN6nlSVHY0Ic
         4zbRPZIFcPo+iCNmn80bK6j6/MB4Yfh22ECRG66CeUhKKAvm49EkE3M1NSLW3JdP+GjX
         n5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=xyZS91HmTWb7A0olo7U4XRnlJNJkRCAhnyhMR3Zh6ng=;
        b=AB9NNjf8Bd0Us6Fig6IekJ7oUje7v3YBmzwk7jo/1FdxV9NzX9YkOYTDtfU7kTt3lb
         YkDLThAc1TTtWRPmiaq4Fss+8P/Ozwq1b3pIb5+qWsIDg0KfmFai3kNB3BOGbVCiol7w
         KEFlD//RYF/fhRYsQJcFawdTEMBMe6oyApsB6TadS19OhW4pPLkaifdvO6JsiPDWEiTA
         gxSPl1EvL9fAEwo81o8VdiNjlYLkFm+X6g46tXQISgRGffzqd1DAMO6vFh81BDIeDXJj
         WFBkOyanzfa1ZlylQP9+CfAgsuJRv2fOAcgELnhTXk+RDFkBXKpwM5K3HMEdWr5wcXl2
         LAhg==
X-Gm-Message-State: APjAAAVbmTVrORihE4+d0Y0OlBZwrCYrcHYFI+htNVE1/qWyOq/Jp++F
        A+SHcYdYbYO0pxhauROZaVftAQ==
X-Google-Smtp-Source: APXvYqxyl/9a9ndyMLQUorspRbu6urqXJ/bewpXlI4wYvwP42WN3gQ4wZ6G2CNwanKvMWN5KgJ7pSg==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr104815122wrw.327.1578394997006;
        Tue, 07 Jan 2020 03:03:17 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x6sm26383184wmi.44.2020.01.07.03.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 03:03:16 -0800 (PST)
References: <20191226191224.3785282-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, sboyd@kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] clk: Meson8/8b/8m2: fix the mali clock flags
In-reply-to: <20191226191224.3785282-1-martin.blumenstingl@googlemail.com>
Date:   Tue, 07 Jan 2020 12:03:15 +0100
Message-ID: <1j36crsf4c.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 26 Dec 2019 at 20:12, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> While playing with devfreq support for the lima driver I experienced
> sporadic (random) system lockups. It turned out that this was in
> certain cases when changing the mali clock.
>
> The Amlogic vendor GPU platform driver (which is responsible for
> changing the clock frequency) uses the following pattern when updating
> the mali clock rate:
> - at initialization: initialize the two mali_0 and mali_1 clock trees
>   with a default setting and enable both clocks
> - when changing the clock frequency:
> -- set HHI_MALI_CLK_CNTL[31] to temporarily use the mali_1 clock output
> -- update the mali_0 clock tree (set the mux, divider, etc.)
> -- clear HHI_MALI_CLK_CNTL[31] to temporarily use the mali_0 clock
>    output again
>
> With the common clock framework we can even do better:
> by setting CLK_SET_RATE_PARENT for the mali_0 and mali_1 output gates
> we can force the common clock framework to update the "inactive" clock
> and then switch to it's output.
>
> I only tested this patch for a limited time only (approx. 2 hours).
> So far I couldn't reproduce the sporadic system lockups with it.
> However, broader testing would be great so I would like this to be
> applied for -next.
>
> Changes since v1 at [0]:
> - extend the existing comment in patch #1 to describe how the glitch-
>   free mux works with the CCF
> - slightly updated the patch description of patch #1 to clarify that
>   the "mali_0" or "mali_1" trees must not be changed while running
> - add patch #2 to update the clk_set_rate() kerneldoc because we agreed
>   that clk_set_rate() should do a root-to-leaf update (it does already,
>   it's just not documented)
>
>
> [0] https://patchwork.kernel.org/cover/11293177/
>
>
> Martin Blumenstingl (2):
>   clk: meson: meson8b: make the CCF use the glitch-free "mali" mux
>   clk: clarify that clk_set_rate() does updates from top to bottom
>

Applied with Stephen's Ack

>  drivers/clk/meson/meson8b.c | 11 +++++++----
>  include/linux/clk.h         |  3 +++
>  2 files changed, 10 insertions(+), 4 deletions(-)


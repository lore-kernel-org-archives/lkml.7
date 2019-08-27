Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8158206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfH0IUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:20:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42795 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfH0IUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:20:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id m44so30182620edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qY2Ghx+cvhqn0reVmcdYz/Ra4oEaXlOnSP3k2TEC06I=;
        b=LpXhwH6sW7+HdGD6sD7j0OeFQTqCm4HyR2flnIDguO1xVm9gssAi89cAxxBaGKpQE8
         swQR/6aCBQhv7sCuKf1IL0kRm+MqyRM+5yvKfqLQVsS5I3rjfzFBi0KtBntL2kIq2dNz
         EHlP5ov/Vc8JT9HgPMdDtT+cgihxF2eGroWIwqawt6K1w4KyRnqqVcocTgzX+41r7N6u
         z2KO4HZepFt/yOFRqwnmOxXnCVs5ITLvsPRZUYs7udq4LirdjNNvTRjw5Wm5uDR5v1t0
         nXiHh4SCcoyS7vV1oMdF7lXMxoVJ2OuWDl70LBIim0VKwOCwpE3/prgGaTpRU5HeIZOE
         ThLA==
X-Gm-Message-State: APjAAAUj5234SRA/ISYtnGStr0r72VgTuUtKh8pi5rJvrFXwqdicAJ0n
        V2yYyrC0MKfXbfNw1lSeyaaxkKCQ3Xs=
X-Google-Smtp-Source: APXvYqzDxyt8tTJFYG6pGk11v0j0eb2cSZkjp9QuG64NbcMGDMQrAWizCuMFq6vUW9FGXsYAem+A3w==
X-Received: by 2002:a50:c38f:: with SMTP id h15mr22706104edf.256.1566894036327;
        Tue, 27 Aug 2019 01:20:36 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id va28sm3312079ejb.36.2019.08.27.01.20.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 01:20:35 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id k1so2092055wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:20:35 -0700 (PDT)
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr26175657wmf.47.1566894035615;
 Tue, 27 Aug 2019 01:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 27 Aug 2019 16:20:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v64xOcs3Vi5k3yUwMiUrzZMuJ5vZ3kxp9w1=CQDrkn3cgA@mail.gmail.com>
Message-ID: <CAGb2v64xOcs3Vi5k3yUwMiUrzZMuJ5vZ3kxp9w1=CQDrkn3cgA@mail.gmail.com>
Subject: Re: [PATCH 00/21] ASoC: sun4i-i2s: Number of fixes and TDM Support
To:     Maxime Ripard <mripard@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Code Kipper <codekipper@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

On Tue, Aug 20, 2019 at 3:25 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Hi,
>
> This series aims at fixing a number of issues in the current i2s driver,
> mostly related to the i2s master support and the A83t support. It also uses
> that occasion to cleanup a few things and simplify the driver. Finally, it
> builds on those fixes and cleanups to introduce TDM and DSP formats support.
>
> Let me know what you think,
> Maxime
>
> Marcus Cooper (1):
>   ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on newer SoCs
>
> Maxime Ripard (20):
>   ASoC: sun4i-i2s: Register regmap and PCM before our component
>   ASoC: sun4i-i2s: Switch to devm for PCM register
>   ASoC: sun4i-i2s: Replace call to params_channels by local variable
>   ASoC: sun4i-i2s: Move the channel configuration to a callback
>   ASoC: sun4i-i2s: Move the format configuration to a callback
>   ASoC: sun4i-i2s: Rework MCLK divider calculation
>   ASoC: sun4i-i2s: Don't use the oversample to calculate BCLK
>   ASoC: sun4i-i2s: Use module clock as BCLK parent on newer SoCs
>   ASoC: sun4i-i2s: RX and TX counter registers are swapped
>   ASoC: sun4i-i2s: Use the actual format width instead of an hardcoded one
>   ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer SoCs
>   ASoC: sun4i-i2s: Fix the LRCK polarity
>   ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t
>   ASoC: sun4i-i2s: Fix MCLK Enable bit offset on A83t
>   ASoC: sun4i-i2s: Fix the LRCK period on A83t
>   ASoC: sun4i-i2s: Remove duplicated quirks structure

Unfortunately the patches that "fix" support on the A83T actually break it.
The confusion stems from the user manual not actually documenting the I2S
controller. Instead it documents the TDM controller, which is very similar
or the same as the I2S controller in the H3. The I2S controller that we
actually support in this driver is not the TDM controller, but three other
I2S controllers that are only mentioned in the memory map. Support for this
was done by referencing the BSP kernel, which has separate driver instances
for each controller instance, both I2S and TDM.

Now to remedy this I could send reverts for all the "A83t" patches, and
fixes for all the others that affect the A83t quirks. However the fixes
tags existing in the tree would be wrong and confusing. That might be a
pain for the stable kernel maintainers.

Any suggestions on how to proceed?

Regards
ChenYu

>   ASoC: sun4i-i2s: Pass the channels number as an argument
>   ASoC: sun4i-i2s: Support more channels
>   ASoC: sun4i-i2s: Add support for TDM slots
>   ASoC: sun4i-i2s: Add support for DSP formats
>
>  sound/soc/sunxi/sun4i-i2s.c | 660 ++++++++++++++++++++-----------------
>  1 file changed, 372 insertions(+), 288 deletions(-)
>
> base-commit: d45331b00ddb179e291766617259261c112db872
> --
> git-series 0.9.1

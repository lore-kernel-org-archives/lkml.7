Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BE2C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB81E20675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mhp77Kkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfD2Kp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:45:27 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34954 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfD2Kp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:45:27 -0400
Received: by mail-vs1-f66.google.com with SMTP id d8so5619417vsp.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 03:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgVlRYPA/0SBPZWyIjkN6a7OUZzNHaXrRQ1q615/um0=;
        b=Mhp77Kkd9WXwbyYBlpZ5woBgCawBvXnq3BcHzCh/mbxh976VhrkbHXT1zZ0DqZjR8G
         +62/2mxBPdI6vysF0COJVvURMWpx+TQLOiqLE8pDI5K/Ldr4AB3Lw033885ETlR7D7xI
         h5daKHzIUuAe8Ia3LlOBgnRP05OCprHr+YT9WT+k1P/BTr6lZ9fjd1Q9aFqVflZkN9Rn
         AzFAe6LPofWPoZcIDR+eCJBDMK4an8Jl1U9QsERQ3yN9iLcTF8KmOZPRlzgwUUvdA7Il
         gYPHJ+eQrDo0ikjdtwKw5wxI9L3oQZNY2AcS2y0msWjepeWoUzAKGLat0gaQwEhwqm7o
         8WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgVlRYPA/0SBPZWyIjkN6a7OUZzNHaXrRQ1q615/um0=;
        b=KGTxddqnMg2v05fMMEnWNYz47WzW6tfcYRwNDtGEM7SrQitx9laUsNFnylv4T7gPAM
         AIZJt6E5KV1MOBF9Tx/+LbYTZEXncsJ8W86mroMoOYfgPAKABoGCJUd7U53bfe9/Ku8u
         7dSC8aBx7CsaGJ7Kro/kobozjqVBi9az99KDGzqZaJ/i/9TWdKNY1BTEoLabmDiV43KE
         6j5k+9zRuEh5SXAtRs16kFEUetn6jdweU5jZvysSz9s9rEngsXDzrsaQT+qNXhxfCQ6F
         1vbaXCn1A3Ir2hkQCbyMtOT09FltMrAWt7R4MeLZpUxUXlq8GLSdiiMmb0EnpwwUBQAP
         a5ew==
X-Gm-Message-State: APjAAAUX5gKyfLzi8yhHwWDlPyTImlbPSKnKjsJ+w8KARsyHppE144ij
        0CXMXYaOOEuxqselY9T/yydcpVVEb42OVeftftk1s2ax
X-Google-Smtp-Source: APXvYqyU0OjC9NmsUWrMLFXjs26w43E4wA6JZIIpG9iKeB+UHm1keJ61GIHX0h6+eU2kagK3uSzVH66MxY2gtilg2VI=
X-Received: by 2002:a67:8155:: with SMTP id c82mr2560442vsd.200.1556534726326;
 Mon, 29 Apr 2019 03:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com>
In-Reply-To: <20190423090235.17244-1-jbrunet@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 12:44:50 +0200
Message-ID: <CAPDyKFoQyPKERckAdU+kkw3go=161PWc+5GAkz7y=xWMGbq+SQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mmc: meson-gx: clean up and tuning update
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 at 11:02, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> The purpose of this series is too improve reliability of the amlogic mmc
> driver on new (g12a) and old ones (axg, gxl, gxbb, etc...)
>
> * The 3 first patches are just harmless clean ups.

Applied these first three, postponing the the rest until Martin are
happy with all of them. Thanks!

Kind regards
Uffe


> * Patch 4 makes sure HS400 can't be enabled, we still have not been able
>   to crack this modes.
> * Patch 5 removes some clock glitches when switching to DDR modes
> * Patch 6 and 7 changes the tuning method from Rx phase to signal
>   resampling. It could have been done in a single patch but the unified
>   diff was extremely ugly. The change has been split in two patches to
>   ease review.
>
> The last tuning update that went through was meant to improve the axg
> support. Since then, it was reported to break some other boards, like the
> s912 vim2.
>
> Also with the current tuning method, it was impossible to find phase
> settings which would work on all the SoCs, including the new ones.
>
> After redoing all the tests from scratch, it appeared that Rx phase made
> (strangely) almost no difference, especially on g12a and axg. However, it
> showed that it is important to have a phase shift between the Core and Tx
> clock, 180 works best.
>
> I discussed the test results with Amlogic. They suggested to use 180/0 or
> 0/180 for the Core and Tx phase. For tuning, they suggested to use
> signal resampling.
>
> So far, so good ... here the platform and modes tested:
>
> NanoPi-K2 (S905): SD UHS SDR50/DDR50, SDIO HS
> Odroid-C2 (S905): SD UHS SDR50/DDR50, eMMC DDR52/HS200 (16GB module)
> Khadas Vim (S905X): SD HS, SDIO HS, eMMC HS200
> Libretech CC (S905X): SD HS, eMMC HS200
> Khadas Vim2 (S912): SD HS, SDIO HS, eMMC HS200
> S400 (A113D): SDIO UHS SDR104, eMMC DDR52/HS200
> U200 (S905D2): SD HS, eMMC DDR52/HS200
> SEI510 (S905X2): SD HS, eMMC DDR52/HS200
>
> Changes since v1 [0]:
> * Add missing writel in patch 5 (error when switching width)
> * Change patch 3 commit description
>
> [0]: https://lkml.kernel.org/r/20190417204355.469-1-jbrunet@baylibre.com
>
> Jerome Brunet (7):
>   mmc: meson-gx: remove open coded read with timeout
>   mmc: meson-gx: ack only raised irq
>   mmc: meson-gx: correct irq flag
>   mmc: meson-gx: disable HS400
>   mmc: meson-gx: avoid clock glitch when switching to DDR modes
>   mmc: meson-gx: remove Rx phase tuning
>   mmc: meson-gx: add signal resampling tuning
>
>  drivers/mmc/host/meson-gx-mmc.c | 419 +++++++++-----------------------
>  1 file changed, 114 insertions(+), 305 deletions(-)
>
> --
> 2.20.1
>

Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A6AC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD5B20859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HP46O8oI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfDVPVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:21:42 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46366 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfDVPVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:21:42 -0400
Received: by mail-vs1-f65.google.com with SMTP id e2so6395942vsc.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jo4QnBFvCI2pSHJjt+WPg9GxNe4IYci0262Mc3uaeAs=;
        b=HP46O8oItxx97YrVVEwduwNQuCIzdcSk2DQTaaBQwOeSRtttO73+dUOYaPxAf1Ny18
         ETS3YeHtwlYUBEGcWEW/skIgQBGKGC5RsOSYTglryb9V/0nk10CGB5dLbs8OKTNJWlsj
         9J9ZukCuBgs882Ewzbap7mIB0wN7Mbxncq23k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jo4QnBFvCI2pSHJjt+WPg9GxNe4IYci0262Mc3uaeAs=;
        b=ozPQGfWOmehw4o0cPH+qO3PE0cxtwXBwej5RLsBv8tNEc5kQlEjRtAZHObCo74OHVi
         zdyUJ6WAaPjbZs7v1fKcc7GQLxNfsG+JMJ+669/tGH2wR9W86JT41C2CRFM4mztq6Poq
         s+oG4U7yzJh5pxJAxc1d82z1eqmfwpjCgDWLHu9y76T+oMkDhAgf6/PSK9G8G854zSO6
         i8tFcfJckahtZfZ0U6Wf/v3nHy9vbMgw6PQFQV3C9veWU2pjZUSEvIotPXDorFYdEFSX
         CXE4n0HaDgXo3OoImDF0QnOkT8ncqZNSrN8ZPEPfZEcIHsOEXwvX+Hmar2oo6GRpwCZ0
         B65A==
X-Gm-Message-State: APjAAAUdXdwVw0yFPAEUJ0bJZ9m7HL7Ex18uPN0MrPg04LvTvHQzi900
        SzOI2g5aX3wTasJ3730ZiJaAObppql4=
X-Google-Smtp-Source: APXvYqygvPi/EJzlO+32CqgQjhs03wgKP4tZUFpBuvcMvaFdbdbwAS8CqVOj9cr8tsNnLPJxqx+KrA==
X-Received: by 2002:a67:ed0b:: with SMTP id l11mr10175587vsp.55.1555946500737;
        Mon, 22 Apr 2019 08:21:40 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id g15sm405924uah.11.2019.04.22.08.21.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 08:21:39 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id j184so6396451vsd.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 08:21:39 -0700 (PDT)
X-Received: by 2002:a67:c812:: with SMTP id u18mr9580850vsk.87.1555946498770;
 Mon, 22 Apr 2019 08:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190410221237.160856-1-dianders@chromium.org>
In-Reply-To: <20190410221237.160856-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Apr 2019 08:21:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wm+T+W=LWTSiwBT3UQWG7YKQdGuL2+BmAFQhk8CYY1mQ@mail.gmail.com>
Message-ID: <CAD=FV=Wm+T+W=LWTSiwBT3UQWG7YKQdGuL2+BmAFQhk8CYY1mQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Disable SDIO interrupts while suspended to
 fix suspend/resume
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>, stable@vger.kernel.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 10, 2019 at 3:13 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Processing SDIO interrupts while dw_mmc is suspended (or partly
> suspended) seems like a bad idea.  We really don't want to be
> processing them until we've gotten ourselves fully powered up.
>
> You might be wondering how it's even possible to become suspended when
> an SDIO interrupt is active.  As can be seen in
> dw_mci_enable_sdio_irq(), we explicitly keep dw_mmc out of runtime
> suspend when the SDIO interrupt is enabled.  ...but even though we
> stop normal runtime suspend transitions when SDIO interrupts are
> enabled, the dw_mci_runtime_suspend() can still get called for a full
> system suspend.
>
> Let's handle all this by explicitly masking SDIO interrupts in the
> suspend call and unmasking them later in the resume call.  To do this
> cleanly I'll keep track of whether the client requested that SDIO
> interrupts be enabled so that we can reliably restore them regardless
> of whether we're masking them for one reason or another.
>
> Without this fix it can be seen that rk3288-veyron Chromebooks with
> Marvell WiFi would sometimes fail to resume WiFi even after picking my
> recent mwifiex patch [1].  Specifically you'd see messages like this:
>   mwifiex_sdio mmc1:0001:1: Firmware wakeup failed
>   mwifiex_sdio mmc1:0001:1: PREP_CMD: FW in reset state
>
> ...and tracing through the resume code in the failing cases showed
> that we were processing a SDIO interrupt really early in the resume
> call.
>
> NOTE: downstream in Chrome OS 3.14 and 3.18 kernels (both of which
> support the Marvell SDIO WiFi card) we had a patch ("CHROMIUM: sdio:
> Defer SDIO interrupt handling until after resume") [2].  Presumably
> this is the same problem that was solved by that patch.
>
> [1] https://lkml.kernel.org/r/20190404040106.40519-1-dianders@chromium.org
> [2] https://crrev.com/c/230765
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I didn't put any "Fixes" tag here, but presumably this could be
> backported to whichever kernels folks found it useful for.  I have at
> least confirmed that kernels v4.14 and v4.19 (as well as v5.1-rc2)
> show the problem.  It is very easy to pick this to v4.19 and it
> definitely fixes the problem there.
>
> I haven't spent the time to pick this to 4.14 myself, but presumably
> it wouldn't be too hard to backport this as far as v4.13 since that
> contains commit 32dba73772f8 ("mmc: dw_mmc: Convert to use
> MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs").  Prior to that it might
> make sense for anyone experiencing this problem to just pick the old
> CHROMIUM patch to fix them.
>
>  drivers/mmc/host/dw_mmc.c | 24 ++++++++++++++++++++----
>  drivers/mmc/host/dw_mmc.h |  3 +++
>  2 files changed, 23 insertions(+), 4 deletions(-)

Jaehoon / Shawn: any thoughts on this patch?

-Doug

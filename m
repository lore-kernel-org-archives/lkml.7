Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D25C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB7521537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfFNDqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:46:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35393 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFNDqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:46:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so1424663edr.2;
        Thu, 13 Jun 2019 20:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8hlfPfnXEjBTjeUfjk+FsaluQO4vebhuMrI7tB+55k=;
        b=M6VSvjx+Tgs7JBAoAsECcn1dvlUqo2FEYr0eW8fqliIetkc+KRKqs3XIO+SEMumkzp
         TMW6t2TwmAoKcQs4VeJ7bSu8XUJJqZZWn6CwIR2WFWeagnooGnq72aPgkd9grXQCn42/
         RAoZLhiRw+tbNxgiLTZ8bC0uwMPuLNRAWRwj2N3gNoCDxPWN1jGD8tvK72exqeGmnSLO
         Y/r73X4mRBnD47gRw9Rjm6SvGjalqPRSxMVI71uDLT+LW9dgDEQnqhgMXDzRt0xmp8Dt
         Ksd8C9sCesT/7J37uWjJ1UNOsLXlJId1nvwiVEWumMmJLAhr6Q/SLy1eLkoae2PyNlsX
         LEYA==
X-Gm-Message-State: APjAAAV9X3IpYzTVsQUwZtFb33hwsx7Jw3/frPDyMWzS903YHcV6NWR5
        rNP+O5ovmPZCR1r6JNR0gemhbmMp9OI=
X-Google-Smtp-Source: APXvYqxNsNzvOX9FquuhGLtfzoWNJVHkotXiwfmCjIb0vcelZE/fIOuNzDVzOiXiHENaZmHiveMsxA==
X-Received: by 2002:a17:906:670c:: with SMTP id a12mr33568082ejp.290.1560484008644;
        Thu, 13 Jun 2019 20:46:48 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id y22sm496449edl.29.2019.06.13.20.46.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 20:46:48 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id x17so898008wrl.9;
        Thu, 13 Jun 2019 20:46:48 -0700 (PDT)
X-Received: by 2002:a5d:4311:: with SMTP id h17mr64213816wrq.9.1560484007885;
 Thu, 13 Jun 2019 20:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190613185241.22800-1-jagan@amarulasolutions.com> <20190613185241.22800-6-jagan@amarulasolutions.com>
In-Reply-To: <20190613185241.22800-6-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 14 Jun 2019 11:46:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v654p=HZuXCTJkrbWbFP_kEkpRWHwj-7_Ck_=XbyMFmvFw@mail.gmail.com>
Message-ID: <CAGb2v654p=HZuXCTJkrbWbFP_kEkpRWHwj-7_Ck_=XbyMFmvFw@mail.gmail.com>
Subject: Re: [PATCH 5/9] ARM: dts: sun8i: r40: Add TCON TOP LCD clocking
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 2:54 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> According to Fig 7-2. TCON Top Block Diagram in User manual.
>
> TCON TOP can have an hierarchy for TCON_LCD0, LCD1 like
> TCON_TV0, TV1 so, the tcon top would handle the clocks of
> TCON_LCD0, LCD1 similar like TV0, TV1.

That is not guaranteed. The diagram shows the pixel data path,
not necessarily the clocks. In addition, the LCD TCONs have an
internal clock gate for the dot-clock output, which the TV variants
do not. That might explain the need for the gates in TCON TOP.

> But, the current tcon_top node is using dsi clock name with
> CLK_DSI_DPHY which is ideally handle via dphy which indeed
> a separate interface block.
>
> So, use tcon-lcd0 instead of dsi which would refer the
> CLK_TCON_LCD0 similar like CLK_TCON_TV0 with tcon-tv0.
>
> This way we can refer CLK_TCON_LCD0 from tcon_top clock in
> tcon_lcd0 node and the actual DSI_DPHY clock node would
> refer in dphy node.

That doesn't make sense. What about TCON_LCD1?

The CCU already has CLK_TCON_LCD0 and CLK_TCON_LCD1. What makes
you think that the TCONs don't use them directly?

Or maybe they do go through TCON_TOP, but there's no gate,
so we don't know about it.

You need to rethink this. What are you trying to deal with?

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi           | 6 +++---
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c     | 6 +++---
>  include/dt-bindings/clock/sun8i-tcon-top.h | 2 +-

This is going to be a pain to merge.

First, you need to split the driver parts from the DT parts.

Second, you might need to revert CLK_DSI_DPHY back to a raw
number for now, so that when the patches get merged through
different trees, nothing breaks.

Third, you'll come back after everything is merged, and change
the raw number to the new macro.

ChenYu

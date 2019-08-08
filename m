Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B5DC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE15521900
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfHHHve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:51:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41232 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfHHHve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:51:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so115021041ota.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 00:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zYvO8kgva/HCROTu3alVTGHgN2aevAEIYRY7aUYyOU=;
        b=MccHvAmoOe/8QmYajy8LKX5AKdfIjtVfYB2cLcwDiTEhnrsTiUN1Ok4YQi0mhMMBdH
         4dpYwmHaN2jv3T5viWqRcGE1b7hqPda0Wu4o9KLqofWpqlZTsklnsJaGHkWRdtmv31Lp
         Nronj/LvXRWGkrfCCr4m4/LmGLuNuXfxQ0Q5lHZux+EKPRy/5lelB9pxA1X44O2RLO+G
         U2tuLVQ9JwHPcLFDVJzwR1kD5Tt6m8hnmQ7sPESvkZGUaXIwe+sA5CR5cZ38Vn046Bjt
         vBLGAiL5JVCbK385tuRIfLsmpDGZR12HeqIa+0BHREb1nA6SGiFLO5PeLyBIw8yS4SLr
         6i4w==
X-Gm-Message-State: APjAAAVyNtNc/ilYqYY6TcLWJ3gxg4EQU5h3WYV+xsGZ8ESRAL94VtSp
        /nJzpj9Rxk/IxRc2Zwffu7rzksTmrfW+BmBUCEA=
X-Google-Smtp-Source: APXvYqwszIoNMVOKBwYp3aP3PPfCWFyxZCZa0aiTnpVpNAVmxKQDAkd6Dd55mIi8FsWP4N0IeISzw4KkePpuqLzoi4k=
X-Received: by 2002:a9d:529:: with SMTP id 38mr12029150otw.145.1565250693148;
 Thu, 08 Aug 2019 00:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190730053845.126834-1-swboyd@chromium.org> <20190731142645.GA1680@kunai>
 <5d41ab2c.1c69fb81.6129.661f@mx.google.com> <20190801122559.GC1659@ninjato>
In-Reply-To: <20190801122559.GC1659@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Aug 2019 09:51:22 +0200
Message-ID: <CAMuHMdW5QHvr=a1MXzqyCoYc2FC-4tKB-AbhTZQG=etbq=vmAQ@mail.gmail.com>
Subject: Re: [Cocci] [PATCH v5 0/3] Add error message to platform_get_irq*()
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        cocci@systeme.lip6.fr, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Thu, Aug 1, 2019 at 3:13 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> > these drivers pop up, I think we can have another function like
> > platform_get_irq_probe() or platform_get_irq_nowarn() that doesn't print
> > an error message. Then we can convert the drivers that are poking around
> > for interrupts to use this new function instead. It isn't the same as a
> > platform_get_optional_irq() API because it returns an error when the irq
> > isn't there or we fail to parse something, but at least the error
> > message is gone.
>
> True.
>
> I still feel uneasy about pushing false positive error messages to
> users. Do you think your cocci-script could be updated to modify drivers
> which do not bail out when platform_get_irq() fails to use
> platform_get_irq_nowarn()? I'd think this would catch most of them?
>
> Or maybe the other way around? platform_get_irq_warn() and only convert
> those which print something?

Following clk, gpio, regulator, and reset, the functions should be called
platform_get_irq() and platform_get_irq_optional().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

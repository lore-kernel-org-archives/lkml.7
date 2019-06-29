Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B038CC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857742086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFWhNzQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfF2OS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 10:18:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37803 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfF2OSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 10:18:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so4383231pfa.4;
        Sat, 29 Jun 2019 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9l1i0e9E3KExb1TZXbw5YKfu9Vo+bOWox+DaR8ptz/0=;
        b=MFWhNzQxVYHJePcbGzneqQOlwYaOUDSOOWNzLj0OIebF2gKLAxr74MnTynIPwCSGgf
         a0tkEIKhIvIUv0QJTEsufCFsZYdRjCu7rDSSaZWACmh3jh2UFLQGMh2INzwd8KzR7vmA
         EEOe4Pjw2CLV2+eFlhZXWzyibhLi/MCP9nHsqJeeJOvrh2sz/Zi5TIcMHKQCwc2lgzkP
         U1a3qMDMgRC1uSKs/GmywAK8GukM2Z9KBeyk8cml0jENtk7SZRRonAuxxOUZ25B/ewXL
         jSNvJAsJRgI9rd6hBKt/a+Mw+cQKrXGxyXcjPUA1XI/rU6Rk2nUbl8BCLpTvd++X+mHk
         sLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9l1i0e9E3KExb1TZXbw5YKfu9Vo+bOWox+DaR8ptz/0=;
        b=aRHiHzzRfhloICoqE1okxmH+d0YtQRFucuHqrJQa+LKnFwAzHGRbIGO0ajHCmrYu3d
         2yjcMRwvRjft8GZqM5jF5IleFeMEO871EPWS3F3Kjv/beP1JtDlais1OgaoHRlKUj3r4
         1gAhKJwwv5YjR5cEwdp3tZdueRlF6ThYjwN3OdUHlpSaYXJhHGHeRO1e7AltKfIFNMQs
         xejAWoXVTQPj2FlHjcL4/i+zYdwCDwLs/dUo4Os4/B+GIUtZ1PE3GhpccvnRgNRy2B/s
         lf/rcvW52ltOBDBqO8vcXzVmLh60XtfzV2hqwp8AwGSdYBTvrZ569Z6lsgTe9Zerx2A+
         d5Fg==
X-Gm-Message-State: APjAAAXORiNF8L40ld9x7sAQfwLVcQk02Scux4iVhRLP9zAt1f6FVwnw
        po2oinCGJH5ZzE/5pM3InCd2eJbbBYPeh7d/Vf9dPWcVuEQzHQ==
X-Google-Smtp-Source: APXvYqwsCXcJ0hqEdIMKkeabIEy3Bxzvp2QttSiZmMQtiFYgn6O5pn8dSB3wSQo7408fFYb5C7N0u7Kcgn0i/qFvX9I=
X-Received: by 2002:a65:448b:: with SMTP id l11mr14456233pgq.74.1561817935162;
 Sat, 29 Jun 2019 07:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190618133102.8083-1-linux-kernel-dev@beckhoff.com>
In-Reply-To: <20190618133102.8083-1-linux-kernel-dev@beckhoff.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Jun 2019 17:18:44 +0300
Message-ID: <CAHp75VfT6NvAv8C-bNKu36_9R=H1f05QRQppNA19R7O=1qhzRQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: pmc_atom: Add CB4063 Beckhoff Automation
 board to critclk_systems DMI table
To:     linux-kernel-dev@beckhoff.com
Cc:     Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 4:34 PM <linux-kernel-dev@beckhoff.com> wrote:
>
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>
> The CB4063 board uses pmc_plt_clk* clocks for ethernet controllers. This
> adds it to the critclk_systems DMI table so the clocks are marked as
> CLK_CRITICAL and not turned off.
>

Pushed to my review and testing queue, thanks!

> Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
>  drivers/platform/x86/pmc_atom.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index be802fd2182d..551ed44dd361 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -412,6 +412,14 @@ static const struct dmi_system_id critclk_systems[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "CB3163"),
>                 },
>         },
> +       {
> +               /* pmc_plt_clk* - are used for ethernet controllers */
> +               .ident = "Beckhoff CB4063",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "CB4063"),
> +               },
> +       },
>         {
>                 /* pmc_plt_clk* - are used for ethernet controllers */
>                 .ident = "Beckhoff CB6263",
> --
> 2.22.0



-- 
With Best Regards,
Andy Shevchenko

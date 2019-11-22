Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B68C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AEE20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bm7hmo71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKVFaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:30:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42921 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfKVFaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:30:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id b16so5154431otk.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 21:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kx1yQ2ubEiohF95o6dJ/xu7jQhtpeqgqKSgECbFNwQM=;
        b=Bm7hmo71iYwmnJK1S95rLm/DlUT2s5zRbjXugto1xyu21uN6cEztDamJ1W4uxy7EJN
         7p5IsY0HFCXR+mCEfjTjwAGy3Wb8EArljOPhx3rZrxx/2kuz8dgWwOcAiNaLZQM/iVIG
         JV9V735o1BNC+4JWknKAgGyPfvOpTFZ56Xdk7k3TgDSjVyzgqOvMTdp0VUSE+mZfnwLV
         dqtjF/RYzEJVIlYV2tQvEA2Sy0Jh91Vnec0PALPc1F8rK3FGNE65Du6HtheDWI/C0ibQ
         DmjIbaqMICw3mVfvPY3i/PKF7A3lA3CDEl3FImxJKzggG9dRQe7zKtrlCrYo6nK2k3Sq
         NMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kx1yQ2ubEiohF95o6dJ/xu7jQhtpeqgqKSgECbFNwQM=;
        b=tzCHGseC9tupPinrrfkaR1hgAgyclBODMHBcwulKGs0DyJyCFx3B1kwrocWc4b2lPT
         fw5uQq96+ZH4N7a5dZ1jPNPU9zA4u90qjUVvml/CVy5JJYuxeC20ytMtfQ33wR1hC/q5
         uFtRFySe/IrFcBHzpykeH4kRuv0Glu2YsG9ysAnB4wjgU/9qC5uo72rIQEaYVzaIU3mw
         V0FjuZDcbKSCwX1dXBW1AGbqJIJzJkes8PYX9ZqqXJB4k6y3/T4AUR8+kMIMN+wdORgm
         0t63JyjHMRtTdOO+632RjxOH1IO2zXad0bKTTNQE1j2BmwAXM+cwFN+UUM9WeB/Eb1MR
         CBbA==
X-Gm-Message-State: APjAAAXWufg8YwqKX2R6L9+QFr0yKJ5IAEQ3gzc+QI5pWFJ09IrROx3x
        313bX5B8lle+E/0oDyzMFsy/ogko3I/XDvH+Lb0WLA==
X-Google-Smtp-Source: APXvYqx6q9oWnlWD1uY/CpDpWnp4391UeWY5xQCBv1zgj50yTa5h+EB0wqoeFL6KWA4G6ysM9K4vNZXTuW5bka/SzUI=
X-Received: by 2002:a9d:5d1a:: with SMTP id b26mr9518420oti.139.1574400623580;
 Thu, 21 Nov 2019 21:30:23 -0800 (PST)
MIME-Version: 1.0
References: <20191120071302.227777-1-saravanak@google.com>
In-Reply-To: <20191120071302.227777-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 21 Nov 2019 21:29:47 -0800
Message-ID: <CAGETcx8cRnWuye_paUhHGu_rmWcLnFxN=kW7WJ-_0D2Q0KtDmg@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for
 interrupt-parent, dmas and -gpio(s)
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 11:13 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Add support for creating device links out of more DT properties.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 0fa04692e3cc..dedbf82da838 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1188,7 +1188,11 @@ DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
>  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
>  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
>  DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
> +DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
> +DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> +DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> +DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
>
>  static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_clocks, },
> @@ -1196,7 +1200,11 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>         { .parse_prop = parse_iommus, },
>         { .parse_prop = parse_mboxes, },
>         { .parse_prop = parse_io_channels, },
> +       { .parse_prop = parse_interrupt_parent, },
> +       { .parse_prop = parse_dmas, },
>         { .parse_prop = parse_regulators, },
> +       { .parse_prop = parse_gpio, },
> +       { .parse_prop = parse_gpios, },
>         {}
>  };
>

Rob,

Any chance I get an Ack/Review please?

-Saravana

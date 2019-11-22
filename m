Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B87C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1386520706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574429707;
	bh=Xc8NEhUH7x1Ru0D5hE6DS/61EqvwOoHXnghK6Qnxolg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j4rvrQiQbhr2mGS4luNLoWZNNDieGz/yl+n4GEFGHGYsuRRVy4eufYUBJY5Gh81Dk
	 siKJE2/+H3U3m/UdeEjt8jt8vPs6cXv5Jvc+Ils3CLviLPov+YPeI6E62J3Fi0i5no
	 hBTl3dTnrUmxQimfK41/DIogCT6ZUuj6rYraokQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfKVNfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfKVNfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:35:05 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F9F2077B;
        Fri, 22 Nov 2019 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574429705;
        bh=Xc8NEhUH7x1Ru0D5hE6DS/61EqvwOoHXnghK6Qnxolg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dpbMT4Xw98yDPO1nvqRYpcpH2lGk+6hOAUBQbwZNtohXzMR5SwP0c2wMxu9jC8LF4
         E1GO/L9BRDCbTqGJ860Rq9w23C5lG7N8QUTQhEwWIGGvRJz+Sq/II0Km1U24I9hG+w
         wW5wzCJKW0ZjceFRSzBD5XLu92320Q6QETL422DE=
Received: by mail-qk1-f173.google.com with SMTP id z65so1465163qka.6;
        Fri, 22 Nov 2019 05:35:04 -0800 (PST)
X-Gm-Message-State: APjAAAVAG0UnsZex8tr7Yak7YMu3chi5HIdAkRoC6MiSkVElS7ddM2Z7
        uacYp3m8hWBthu64niV71S3Bukyc214+LjN9Eg==
X-Google-Smtp-Source: APXvYqwQSwjxM5BHEVn5dZVK5SNNRkjxNzrcBxYKps9iwyn6mBOFDz8HEZmqFgKuJgRFzCvT68VZifGsfq/jhc0nItA=
X-Received: by 2002:a05:620a:226:: with SMTP id u6mr13116027qkm.393.1574429703879;
 Fri, 22 Nov 2019 05:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20191120071302.227777-1-saravanak@google.com>
In-Reply-To: <20191120071302.227777-1-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Nov 2019 07:34:51 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+f1+xRv36z0o--u4SskTG-WxUdssJ-CP32RUZbtVuQ3w@mail.gmail.com>
Message-ID: <CAL_Jsq+f1+xRv36z0o--u4SskTG-WxUdssJ-CP32RUZbtVuQ3w@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for
 interrupt-parent, dmas and -gpio(s)
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 1:13 AM Saravana Kannan <saravanak@google.com> wrote:
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

This one is not going to work most of the time (ignoring the fact that
the primary controller doesn't have a struct device) because the
interrupt-parent is typically in a parent node. You could make it work
by specifying 'interrupt-parent' in every node, but that's not a
pattern I want to encourage. There's also all the other ways the
parent can be determined. Any parent node with 'interrupt-controller'
or 'interrupt-map' property is the parent. And there's
'interrupts-extended' too.

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
> --
> 2.24.0.432.g9d3f5f5b63-goog
>

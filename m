Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04FCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5B32086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbfIIJob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:44:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38147 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfIIJoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:44:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id x5so12394675qkh.5;
        Mon, 09 Sep 2019 02:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eq2XuOQub5LXmNdZQdl0dNhC7+edIsPrDvzkz2RrzVA=;
        b=Xf8pct8uX5HJymD1dspMXEeG5CjYPNxBUYQKgXaH1Hx2+PaaQvIfSSuB7QCKY2BvJC
         zrcogVeS/CsBxWi4hCg5w2hHMM5dNjp8d1lHsCr3p8nr9g5Nn1/2j8YovgTp8z0/dJWc
         iL0GZziutJSg9c6ipP/06GiRjtUKF9yc3e1yHSvjQOKPTH/sNADbVjKGQEqvCJmmFXzO
         BpJFQyHxWqpod2oEvuozL+XCyJEJcsj2rKnjsISMWymqXvC6S4qdJPd9wr/kAvdsDxm8
         ePZIRZQGXMu4p0xTcj1Q9eHqaleiHr0qvms3nwu3FlN2QkefR61pEYawU+/UWe6qmxi6
         C11g==
X-Gm-Message-State: APjAAAVOdMXKjjqsUkts8u9eHUEybVDWi3UsBQEr8QjzPjXr2k/tZVNz
        IhEM9zltH+Sm9054t0LHa0kCetnu9OTuQXm4M70=
X-Google-Smtp-Source: APXvYqyP9aDV8ZsrfhZ0CKBAlFvxBvCyNUWYRtQ+3kZ7PzdPLrpPHD/Bz780Tvcj7KaHZ5XR85/SF7oeG/38AAgDTQw=
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr1781989qkg.3.1568022269523;
 Mon, 09 Sep 2019 02:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <1568020220-7758-1-git-send-email-talel@amazon.com> <1568020220-7758-3-git-send-email-talel@amazon.com>
In-Reply-To: <1568020220-7758-3-git-send-email-talel@amazon.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Sep 2019 11:44:13 +0200
Message-ID: <CAK8P3a3UF7xPV1U3eW6Jdu754P1bzG208UxD9KUxEm1JjZudww@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: amazon: al-pos: Introduce Amazon's Annapurna
 Labs POS driver
To:     Talel Shenhar <talel@amazon.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        paul.kocialkowski@bootlin.com, mjourdan@baylibre.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        hhhawa@amazon.com, ronenk@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, barakw@amazon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 11:14 AM Talel Shenhar <talel@amazon.com> wrote:
>
> The Amazon's Annapurna Labs SoCs includes Point Of Serialization error
> logging unit that reports an error in case write error (e.g. attempt to
> write to a read only register).
> This patch introduces the support for this unit.
>
> Signed-off-by: Talel Shenhar <talel@amazon.com>

Looks ok overall, juts a few minor comments:

> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Talel Shenhar");
> +MODULE_DESCRIPTION("Amazon's Annapurna Labs POS driver");

These usually go to the end of the file.

> +       log1 = readl_relaxed(pos->mmio_base + AL_POS_ERROR_LOG_1);
> +       if (!FIELD_GET(AL_POS_ERROR_LOG_1_VALID, log1))
> +               return IRQ_NONE;
> +
> +       log0 = readl_relaxed(pos->mmio_base + AL_POS_ERROR_LOG_0);
> +       writel_relaxed(0, pos->mmio_base + AL_POS_ERROR_LOG_1);

Why do you require _relaxed() accessors here? Please add a comment
explaining that, or use the regular readl()/writel().

> +       resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       pos->mmio_base = devm_ioremap_resource(&pdev->dev, resource);

This can be simplified to devm_platform_ioremap_resource().

> +       pos->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);

And this is usually written as platform_get_irq()

       Arnd

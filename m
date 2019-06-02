Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926D6C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 20:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66626278AF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 20:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mdnOW5bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfFBUfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 16:35:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33233 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfFBUfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 16:35:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id v29so2962711ljv.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 13:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ua7Bg2WTXh54kp2rUqBSlcTuCgZgsqmLT8oZP4ysRwE=;
        b=mdnOW5bofVv/5/qFr/LOVppZD9jE51jMdGume3hrgp2z/+0KL0LfX2a+FLaQ1PC1eH
         9mkXoLmeN+JU5ulWliHHSAA1RSE577e2u7clzYMm+ZgQ8Io6bgT4b87nkmqobJqLNiL3
         aPMYKoUTq9x+H69c/BFUMyCZdVAwG8/3so6Cy1LTQ1nKFpz8u0UF3Rqr+xfR8S2QILhQ
         CdKKBGI2e/5bf4kcz6c3uWtlXdhcWG1k6Z0f/7odY+EJkxVx6vDH+a0wqpbIojIWGcNZ
         JSzvM48cBA5vA+Raapu2hzogb1GHJHEfTF3kbe+LxkAzqAWI0mZXT/yBrlC3rLdEYtHo
         DPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ua7Bg2WTXh54kp2rUqBSlcTuCgZgsqmLT8oZP4ysRwE=;
        b=R1N4p9naSYmlJ+ONPkAOjCg0IuTDQW72vJPRXSY5aFSeWVJ0tt7JnzBvqS7Xyhyp+j
         QLHzxnqgRvl/IZU4VsuVTKB+ovKl4A3Fgh/SdrQUwAFDC1jHM16e5/MJg/VIUrA7tGPO
         yCSdUpAOyvJ6JZM5oCvEAPAYphUxH7GDaTK7bQVIkx3zYU7V5+/c20k1VKm7D5uui/df
         wOQiu0LxlLOc7/XG44SH8SWJYhi63I8Lgak8D8AKUzW1tGFqYeLBK811xZQcSJcLI4La
         ARFM0FfeN7MrT9C5Cdy3fvJp/vNKOfkowHLiuyfqfmzDKDD2t7h85W0iYjA6NDAC/U7e
         x1bQ==
X-Gm-Message-State: APjAAAXgCWOE2FB75lph1GwFYBttH1OwseK4oE3VFdLCf2Du/XdVp21o
        NqaL1U6Q4NE/heEs5jRyMRQ4g47WaAZNo5f6oK4J8g==
X-Google-Smtp-Source: APXvYqwGsGMLL4jmNK+u3Vc4fpOIFYqvavFRPbb8kW41gazuGxmhrGq1xjBhRInORzT2HTZ0GULsW1cybw3CRQIPBYE=
X-Received: by 2002:a2e:984a:: with SMTP id e10mr4150601ljj.113.1559507734458;
 Sun, 02 Jun 2019 13:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190529145322.20630-1-thierry.reding@gmail.com>
 <20190529145322.20630-2-thierry.reding@gmail.com> <CACRpkda_aK++k0eVHmGszgts86usaxbQ9uU0kqAzAjapK8AOQg@mail.gmail.com>
In-Reply-To: <CACRpkda_aK++k0eVHmGszgts86usaxbQ9uU0kqAzAjapK8AOQg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jun 2019 22:35:22 +0200
Message-ID: <CACRpkdb6OjHZGgDHXH8gfi0WwzX8170zHJKbpbnSRv+UsZvfhw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: Add support for hierarchical IRQ domains
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lina Iyer <ilina@codeaurora.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 2, 2019 at 3:51 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, May 29, 2019 at 4:53 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Hierarchical IRQ domains can be used to stack different IRQ controllers
> > on top of each other. One specific use-case where this can be useful is
> > if a power management controller has top-level controls for wakeup
> > interrupts. In such cases, the power management controller can be a
> > parent to other interrupt controllers and program additional registers
> > when an IRQ has its wake capability enabled or disabled.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v3:
> > - use irq_create_fwspec_mapping() instead of irq_domain_alloc_irqs()
> > - add missing kerneldoc for new parent_domain field
> > - keep IRQ_DOMAIN dependency for clarity
>
> Actually I applied the patch, and dropped the two lines making
> it possible to override .to_irq() for now, so I can illustrate my
> idea on top. If I manage.

Bah I rewrote the whole think as I want it, maybe my ideas are stupid
but take a look at it, also very interested in input from the irqchip
maintainers.

Sending it out as RFC in a moment.

Yours,
Linus Walleij

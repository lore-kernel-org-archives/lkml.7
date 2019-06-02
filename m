Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBED0C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 13:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A251527932
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 13:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuX28I3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFBNwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 09:52:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39253 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFBNwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 09:52:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id a10so10530163ljf.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lyUfE3HCHLjRLM9DWWhuPKiM2Ja5HdTmrq6DTMOqX24=;
        b=AuX28I3gLoY3HNsk9MDit29U1RHHQRLNbEbs1tCyXwUdFYbqEisfJP3M0rn50oamli
         LC8BqZJtcx4p0A8bQhvVh7sxBkAhj0vAbSDib/pMgadAQyjkxBEy9mjqP76qBIF23LT9
         0l5VQMVoU5RLSOx6kzEV/CHwz5XF0jMcAC0U3/igFSjz6zz9rULkKj4RWPwyyyEC9f93
         +uyY1oneLUtLHN4Falovg0gzgYaohlJQ9qmqg1kusjRM7d1i1CrI+WfmKPWZXzxqF+GT
         xnsaECCFiRygX6qqR2l8edgMMe52xvHUnBYI44xgiT6xs506QPZ/SLofO8ZANgY5QrZl
         3sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyUfE3HCHLjRLM9DWWhuPKiM2Ja5HdTmrq6DTMOqX24=;
        b=lw75GEaSTell6pFFQ2BNVppLK76KtCoH4YNsnTkAjhcQ24d2WUr7lrkjBzGGvkQhEm
         UcouXlTWEx7Y0RM9klTIocpfif+yL+blbys+5zbhcQgIGk0/rEb10HnzrqpgvGmb6Lit
         VnYyz1rrOjzQz/MzIBAHkm5zd4rUqQObofp8WaH9LOSjtPnLVWdMF08SAkOqmxwOWG8t
         MEAYpEIZojudi1NJArkCo3i3kD7gdj8Ta0zAIkayn5eYNdn2U11DAdjQFD8vL7Nncdt4
         O+yMcmumYoZUhEGGyS9HrrR7yYYDrPV4tFFgaA5u3m5zPoDfstDi7WfKm4CQslPNvp7X
         C0Uw==
X-Gm-Message-State: APjAAAVd1yk8myYzLxKwCfb4GzQZGr0T9Aqk23VMPwX+V95M0Nep3nEM
        VvD4IfhuBE+DARvDhewp3EGvJt/6FOBElm3M4epsTg==
X-Google-Smtp-Source: APXvYqw5tUx0mApKIJz+uww1Fj65ofep3jdE+mGrPIXd9bph8EemlhvdawhPNIs/inbQgkjnl+p0SCvle2OkoAaZgNs=
X-Received: by 2002:a2e:984a:: with SMTP id e10mr3538422ljj.113.1559483522555;
 Sun, 02 Jun 2019 06:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190529145322.20630-1-thierry.reding@gmail.com> <20190529145322.20630-2-thierry.reding@gmail.com>
In-Reply-To: <20190529145322.20630-2-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 2 Jun 2019 15:51:51 +0200
Message-ID: <CACRpkda_aK++k0eVHmGszgts86usaxbQ9uU0kqAzAjapK8AOQg@mail.gmail.com>
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

On Wed, May 29, 2019 at 4:53 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> Hierarchical IRQ domains can be used to stack different IRQ controllers
> on top of each other. One specific use-case where this can be useful is
> if a power management controller has top-level controls for wakeup
> interrupts. In such cases, the power management controller can be a
> parent to other interrupt controllers and program additional registers
> when an IRQ has its wake capability enabled or disabled.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v3:
> - use irq_create_fwspec_mapping() instead of irq_domain_alloc_irqs()
> - add missing kerneldoc for new parent_domain field
> - keep IRQ_DOMAIN dependency for clarity

Actually I applied the patch, and dropped the two lines making
it possible to override .to_irq() for now, so I can illustrate my
idea on top. If I manage.

Yours,
Linus Walleij

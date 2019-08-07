Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E9AC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23B821922
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="drdAJ26H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbfHGNlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:41:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46210 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388380AbfHGNlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:41:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so59801373lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgpWH2YHfeZR/X5CTcCs2YYyG/cbaml2jN9R+mWQJe8=;
        b=drdAJ26HduPkSd8P0kndpKneVTeGSZ/1Zig8OOG1YTvaJvYrosl7dM66iI7DG12ZdW
         9nW1z963s9U5s6dZU7nu5vfBt4XPuDwOOMjtT5widxECJe4baTRFEefacJ8Mw16LpC6z
         mBAvaslfDlqc5EfYnCIYlnvaMc9VZwNjTx4pe7jBuBmmikXIs3nA6MM2Wp4Njj7WkpFL
         OjTXq0Vnxfd6p/+UClvtrqDqHAjC6OpQEO6a9y83Xus9gVjyVkpLlHwun9/COECw15AT
         Af2pxEXy0227aCJYrZA4E/SH0jb1FlygYPBLKZYAHs86Ry/adRDCzC1s+XvUiV7Ol0uj
         g8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgpWH2YHfeZR/X5CTcCs2YYyG/cbaml2jN9R+mWQJe8=;
        b=n7mlC4nrg8RHVANWKZWwsPdotIaW2bOaAM8ZjscT3dldf+z70yEnQKFeA6eGjHlu5c
         lW533rjBhx0d0hvntPkphDRKjOeN5/AhCyFuWR4k8FJbnK9omK0jyZfr36oFEIGTfzAb
         6whjc3z/RqiKt08Kuuw5/fP0Gnv52ejKhX1qda9hMx0DEBmWOKJIVvX6LP12FjaJQ9HY
         7+lbLssfGbwNJtdj3K2IIjUeXkFg+jaN+8WlmonaQ6z2CGaZvTYkgTIEwUiFDdj8Em0R
         ecm0h82umRIIhHB0qeArM+iOgyJha/VYU912RPJ9rGSnoLL6Xr8/BFrVpkqMwA6mrWPd
         UUzg==
X-Gm-Message-State: APjAAAV7mJ0lCCBdNcR+JI704fiXAYpUQ8vr8neqf0Oh2poITECBzjWy
        vAU56CHYgwH0PKx+sIb/lUtIKtl+GEWzRdl8nhNOnw==
X-Google-Smtp-Source: APXvYqyetAWWbOXPmfrrAwd442wfPscqOxq1b+mraQGf4tL/l2xbnlWUM9Lf9Ap+xIMr6ZRLpWRfrPxYU/YbqpFiIZE=
X-Received: by 2002:ac2:4c07:: with SMTP id t7mr5511848lfq.152.1565185277723;
 Wed, 07 Aug 2019 06:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190708110138.24657-1-masneyb@onstation.org>
In-Reply-To: <20190708110138.24657-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Aug 2019 15:41:05 +0200
Message-ID: <CACRpkdYQhyh1BW789OcxGTomMkC3e8hMr8sodbWz-z1=5s9fDw@mail.gmail.com>
Subject: Re: [PATCH 0/4] gpio: hierarchical IRQ improvements
To:     Brian Masney <masneyb@onstation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>, linux-tegra@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thierry Reding <treding@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 1:01 PM Brian Masney <masneyb@onstation.org> wrote:

> This builds on top of Linus Walleij's existing patches that adds
> hierarchical IRQ support to the GPIO core [1] so that Qualcomm's
> spmi-gpio and ssbi-gpio can be converted to use these new helpers.
>
> Linus: Feel free to squash these into your existing patches if you'd
> like to use any of this code. Just give me some kind of mention in the
> commit description.
>
> [1] https://lore.kernel.org/linux-gpio/20190624132531.6184-1-linus.walleij@linaro.org/
>
> Brian Masney (4):
>   gpio: introduce gpiochip_populate_parent_fwspec_{two,four}cell
>     functions
>   gpio: allow customizing hierarchical IRQ chips
>   gpio: use handler in gpio_irq_chip instead of handle_bad_irq
>   qcom: spmi-gpio: convert to hierarchical IRQ helpers in gpio core

I solved things like this:

- I kept patches 1 & 4 as-is
- I squashed patches 2 and 3 into the main patch with minor modifications.
- I added Co-developed-by: for your contributions

Now I need to address Masahiro's comments on top and let's see if the
result looks acceptable!

Yours,
Linus Walleij

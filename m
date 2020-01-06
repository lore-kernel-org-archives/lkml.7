Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E288C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2275B207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F1W6FrjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgAFW7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:59:16 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34731 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgAFW7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:59:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id z22so47852785ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0KNG+0OExH+PgE3Je4nnY6Td9Ccw4KBccd9DW70NKo=;
        b=F1W6FrjBpZ29K0G9T9CoWndO9TPARRdTZkCrQ+TZ6DnirL28X/Ao01Xngla2oAx8aD
         wZg6KYQYKH495KPdcHL0gPBqyRskLBesIDSTE2LPxinAoggI0DaNjYwa6+9jREEcZgZW
         qSm6vVsfwPwEU+8R2hR9CdCbg1FILYS7Y85J0xzQbXGcGanAZ6VUxW6/JvhIPDPQIf+y
         7VWfuWdwEEL4LQV5mals5C2khcjyQksim3mb2q/O5Qt7Df3ojZbW8A90z+ROMB/hjTzW
         kAgoeDeN5DHHqv5zQSJ9m7pMwOMWBTjjssM5TxjH7MILgz8N6clZFh/F+CKbj7y9cQc5
         6AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0KNG+0OExH+PgE3Je4nnY6Td9Ccw4KBccd9DW70NKo=;
        b=Mx3dqeprUi+VRPhrYhPxZr3TGfQ5w1eGbYxcTy6Mc5ChZpN2o9LodrYXiM0YZFyA9K
         HD5kVWdkeg6J2NsIkAUKJA97ggCSYcRfiRDCBIlRLwQluWOmbZCJXg6tWw+SqzqkJJa2
         YudMLIS5djrV+ks76b5+OHZgspm/oEvu2XXa8EdQnHzwdjH+SDCgBCdKYgAXrPCAM2Fe
         WohbvomeI12eph3aL4Qv8OigVJS1Ce2t+letA2MHfdCl6BGK+sIjzFA4OBDZ5TidrBbs
         pAHvsZTB47WQn9RsSRb2TcqC6OrqwqE1AaKMyserygRT7+Ifs7bnxb46wnHmsS/0b0pM
         4CEg==
X-Gm-Message-State: APjAAAWXD0Ydb0zy1ivbgM+uhlxwpwN9f04Zed9Kkwx1m9QcAZODOfdT
        S6ByHhQitq4+FqF94GJZOuXMwnTK/VtygrmOQK+LOA==
X-Google-Smtp-Source: APXvYqzDJbaUismLGujeor0umiyYbHuGqsL7l41pJ5HBf+0/0CpHdmcEUNRW/RHFYfBWr5eT4fcWBMlE9u0L9WYEDME=
X-Received: by 2002:a2e:85cd:: with SMTP id h13mr59765545ljj.191.1578351552102;
 Mon, 06 Jan 2020 14:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20191215183047.9414-1-digetx@gmail.com>
In-Reply-To: <20191215183047.9414-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Jan 2020 23:59:01 +0100
Message-ID: <CACRpkdYAKS50-CNmE0nRNQanFxKejoHrwxho3fZXROoLZUb4+Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Tegra GPIO: Minor code clean up
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 7:31 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> I was investigating why CPU hangs during of GPIO driver suspend and in
> the end it turned out that it is a Broadcom WiFi driver problem because
> it keeps OOB wake-interrupt enabled while WLAN interface is DOWN and this
> may cause a bit weird CPU hang on writing to INT_ENB register during of
> GPIO driver suspend. Meanwhile I also noticed that a few things could be
> improved in the driver, that's what this small series addresses.
>
> Dmitry Osipenko (3):
>   gpio: tegra: Use generic readl_relaxed/writel_relaxed accessors
>   gpio: tegra: Properly handle irq_set_irq_wake() error
>   gpio: tegra: Use NOIRQ phase for suspend/resume

All three patches applied with Thierry's review/test tag.

Yours,
Linus Walleij

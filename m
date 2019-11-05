Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E70C17496
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B97B21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZjmCemA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbfKEOe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:34:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40435 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389326AbfKEOeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:34:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id f4so15299777lfk.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 06:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mE4B26PLyfdSEPu42T0Vc58mzmdMSqZyZyS3WXIQfEA=;
        b=DZjmCemA9B6pbWd89WUtuR257XeKPlWmL1YsI1WXDsLlQe9En9uo7/KWp107T6FC4g
         dMqkS47PtQLjwGUpMLHJiVER9Rx9eHewjTec3k7ujgniBxkzqtv983OfxMPABXYZFtkt
         Inyq6wRvYH5gRMss48KHGAipMoFbVTvcgFQl402aymS4BSAVagTtPM65FkYxvmVC6Yw3
         DxK+Xxb1y0b6WdtENCn/Q5prT5OD018T9P85xeS9pu3hcGAVTYHidz6K+QbWfV+Sv9qz
         PfIZjkPvnVb1arR1AjG+HOkBvMVnfH0144FsjYqa0b6s16Eq9CxHqXCDb5uPJw5zx2u2
         tFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mE4B26PLyfdSEPu42T0Vc58mzmdMSqZyZyS3WXIQfEA=;
        b=Fu7LpLAwkcc2Rt4UjxRB4EqlddxpPZrOyIu1OLVgmZDHr8sotnT/d9ZKNlWQgAdZRJ
         TNGYRm/1ZFxEtohhD9kaxTzQXUuB258tKkoD/pEa/ETT6srclT8id0SxF4aQZdGkRBDc
         ZYhwn2RAENL6gmedxPRKSgaGGs9kGkTyDbcTUpsmu+Rtc0K8DhRhWsAyZbz5MPDqHmc1
         cn3wy7l0M68HhyvWDZwREMPTFhrkumlN0Ki7Y87xDJJeqt5QWOP8RJO4azBE3jFGnfSL
         EjGiFtRw/Jkyr8afd38ssllB060uAyxj4hULGzan99HXUaF1qUwl8LuT7i+l2B16O5SN
         Dc4Q==
X-Gm-Message-State: APjAAAV2risSiGr4AY68a5tqBTFBO4h/TBsIzajS5Oka41bMlf5+wODO
        bw6ye0dYNMYMGj+mb5dwrhjeITM9AYw8DS5dvlTq1Q==
X-Google-Smtp-Source: APXvYqxktk1gD0mzdjJC7FeWKhTuZXLyZl4wOriHJZvkr/LZx8C100O1WzNfmE2iu/D6k7t4x70dWHHGazB5tXqUtSk=
X-Received: by 2002:a19:6a0d:: with SMTP id u13mr12046688lfu.86.1572964463497;
 Tue, 05 Nov 2019 06:34:23 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdb8D_zxHfzY=+ramnNjXVsN9MMO8Q-3=iZFLS2A_ZDQuw@mail.gmail.com>
 <20191104142654.39256-1-yuehaibing@huawei.com>
In-Reply-To: <20191104142654.39256-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 15:34:12 +0100
Message-ID: <CACRpkdZ7Qqd8STdSJP4jHjpfAmpPq878gmUXOrD9N_LANdJ0=Q@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: use devm_platform_ioremap_resource() to
 simplify code
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 3:29 PM YueHaibing <yuehaibing@huawei.com> wrote:

> devm_platform_ioremap_resource() internally have platform_get_resource()
> and devm_ioremap_resource() in it. So instead of calling them separately
> use devm_platform_ioremap_resource() directly.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> v2: squash all into one patch

Patch applied.

Yours,
Linus Walleij

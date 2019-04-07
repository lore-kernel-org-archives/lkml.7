Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B77EC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011FD2133F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkXm7JF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfDGBQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 21:16:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36958 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDGBQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 21:16:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id o19so6928575lfl.4;
        Sat, 06 Apr 2019 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CVyE28DbPYrg6P/pLC+zTZvUmtNTAl3E76QQwtFjho=;
        b=ZkXm7JF3K8U1sq0ZcAQq28zvBq6jsBN1oLnT7b0OKNrV+jzI6MA62pTc3+rXoaFPDv
         Jx8rJ0l6vNQNq6m5dZteLQcgcXSGDg98ziF828cv8YIdb0hwb3Tj9VQhs2A40/bY4owl
         YpinNfZtk2eWzvbpxKi3enpQVYvBaFjDF7yq2/JFlau5QvK4nzHdJUSjByYzaQotbrji
         JA9rQAZazF2lRqT5m/kRjFG+ia8W3Jsakn8lBL9L1rPycVEJ1v858PfI5D0o29oxd9wy
         AkntE0uqvdGbdYhmWX1FqWxjOCtmNbOucQGKgiSxM0MAtB580xAj0A7PCPb3dxFU9Z1j
         ey0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CVyE28DbPYrg6P/pLC+zTZvUmtNTAl3E76QQwtFjho=;
        b=LqpdmEJw4PbPuroO588DRz5YIIzc8zCtuQ7syZZjxZxmiavXt2U2wY+CzPhM+sm9ps
         7zuGRY+guzwpEYAh9QY2cR8xaMr6EvmvTsd6D77zLVUFtaaMSjEWud2g4/8bI7A0B4VK
         sB4fyQP0QFeZPCyBiXv0JTPzMceumiek8Bx7qNU9dUoTVfLEJf2KK7fYIOIIQ3P2R4yc
         BScjzgUGdCIgUlJk6oz87Ed9ycyQK7xk2WstoRySyGSHlOFOCkeKfToXf7cMbNb8lKPq
         BOP6P04u7NzIhn0ZOjfjhnkxmEfuB9YFSNedoHSjkd6xflfheh2u9mFVMyfcyYVtmim5
         0iTQ==
X-Gm-Message-State: APjAAAWdFgwCp3m3bXj4VKiZ5hWeTEPQMVTBmc/BEqvYpKYF8f20n+IF
        5CUoOIKoTIheTdBQOjXzQXoceoyGnMv7oi1jMA==
X-Google-Smtp-Source: APXvYqzThYz7CkjDnvWvO0NEf7Cj0MIxsBKtB41ZOuaqqz5rfFST3N/MqoqEqVd3oA3wU/SQdo3yeBKxmu1+kPcEq+I=
X-Received: by 2002:a19:7d84:: with SMTP id y126mr11363312lfc.124.1554599759085;
 Sat, 06 Apr 2019 18:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org> <20190401171724.215780-7-dianders@chromium.org>
In-Reply-To: <20190401171724.215780-7-dianders@chromium.org>
From:   Urja Rannikko <urjaman@gmail.com>
Date:   Sun, 7 Apr 2019 01:15:51 +0000
Message-ID: <CAPCnQJmWfnBwxj8gScNzmZTGV6eU5B1vk76sQ56A2FvpSiYRaw@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] ARM: dts: rockchip: Specify rk3288-veyron-chromebook's
 display timings
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 1, 2019 at 5:18 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Let's document the display timings that most veyron chromebooks (like
> jaq, jerry, mighty, speedy) have been using out in the field.  This
> uses the standard blankings but a slightly slower clock rate, thus
> getting a refresh rate 58.3 Hz.
>
> NOTE: this won't really do anything except cause DRM to properly
> report the refresh rate since vop_crtc_mode_fixup() was rounding the
> pixel clock to 74.25 MHz anyway.  Apparently the adjusted rate isn't
> exposed to userspace so it's important that the rate we're trying to
> achieve is mostly right.

I just thought it would be worth mentioning that I have picked &
tested a close to 60Hz mode on two veyron speedys of mine, but thought
it too much effort to try and upstream, especially as it was done as a
change to the actual panel info:
https://github.com/urjaman/linux/commit/23d46278911e18df138b7adde1bebc23f606baae

The difference would be in this format just setting hfront-porch = 87
and vback-porch = 14.
Anyways the point is: I support moving this mode info into the dts,
and I'd like to know how if at all should i go about getting a
60Hz(ish) mode upstreamed?

-- 
Urja Rannikko

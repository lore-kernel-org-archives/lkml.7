Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBC6FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B971D2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKDHkw+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393238AbfJPMpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:45:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44369 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390973AbfJPMpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:45:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so22537321qkk.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4Tlr8aaqHcqUHLIi1olwgg1FH4Wnc+VjJ6hwR+CHZ4=;
        b=UKDHkw+AsWNstYEdbran6nGCcRGuySyOhWzrs1M+lF6UxheGXfo+LcAWpEEbBx+GjI
         HjCtcPXBKQn4jwJy1cZJVsUKfW7IO6g+YkpfauBjo4HyT9qSp02EWBGyi3sOIeJrqugJ
         aNGP9AwBpU3FcCHdLXdwuvd0t0yyMgPBETbTKtu2DJj+lWiGvu+3fDWYAeAUK+WOEA4H
         F8rc+vcjQUPehy7NV4y5BA6xRXQqtAm5Nw1nm8zc582Y3Dcivh6Z7Y2lxO5s11cE/WnM
         Jkct9SJXs7YpPuGDgp+lQ+hSbBaEXPMKYZarrYIGCt8VYRjlw3XqOdiH5adCuAlguYgC
         XyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4Tlr8aaqHcqUHLIi1olwgg1FH4Wnc+VjJ6hwR+CHZ4=;
        b=kWXcGUybSM+B+ZBO9uDV1ca4OOzCJ3Dof/em9m6zB26JIy09ozhCviRNiZH2hbElft
         Y5LK4GT3yTIaFySYtU8kmSiahvXkURBcLIRmo+jZihYszsMOg4W9zvYsV9TCgNN597cN
         FO9stxp8ieOwccx9yWG/V/iGwJ9VhPT6jSM565K9c1ulfdQn2DXAZtW83n3UyskgcWCc
         H4wXnW3dMw19xnCNSkEVUCdvvhMd+yNAZe0jK7ZLvjNYC0/5KNOZQIoc0890SLbfYVAg
         nrOjolxpNUxJdUPL41ggpNBoXbyRQdzYV/mNC2NDpLQ4/60M2YWrVDsY8FxgM7Xag2aI
         Oqfg==
X-Gm-Message-State: APjAAAXiem4gFj6eUgRwTyCEANhEKhbH2ZvRQKsZHwuBgsKMqHhC9LCz
        sltwUsuSO+7Py1ArvTgXeSjU0Ofk7b/5J1VydwIqZw==
X-Google-Smtp-Source: APXvYqwOzWo5VbcvN0U8TDnN+1xwjUKgMyRheHPwsr6x9P70GL0NWL/tbYoCuW4aAJr51oKXjooJFWTyMu0zdWYL5a0=
X-Received: by 2002:a05:620a:751:: with SMTP id i17mr39890335qki.340.1571229949254;
 Wed, 16 Oct 2019 05:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191015091708.7934-1-jay.xu@rock-chips.com> <20191015091708.7934-3-jay.xu@rock-chips.com>
In-Reply-To: <20191015091708.7934-3-jay.xu@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 14:45:38 +0200
Message-ID: <CACRpkdbtfamz4H-RNUfdSz7eAOzRMgu-QPbVAVZKtC+Lg5VP9g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: rockchip: add rk3308 SoC support
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:17 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:

> This patch do support pinctrl for RK3308 SoCs.
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>

Patch applied!

Yours,
Linus Walleij

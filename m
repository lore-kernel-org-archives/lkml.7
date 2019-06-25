Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE435C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A3F20644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBCIky80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfFYNzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:55:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34868 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfFYNzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:55:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so12716891lfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMqlAp58Lm3MdFL1/oLfn8r6VrExYv+Qlr+51/E8+CI=;
        b=HBCIky80cw7b2VS9iWLL0Ww6oY2T4Czf/fAe41KlVer5eCS70N2T9N6i+HMJWbByYC
         s+fMTPIHVitU4jqxF2KA93qimnYLgc650UEYlCKuf1gfuyyQ33gDonObiXqXZe+gjs8O
         waAx5wLbgWDVZc3uKTHvWP6rM/o1xiWun8bYPuYn4HvHH+wq2MYhGCsRznPA1MyLWkA1
         /ZYctoRM+yOUBYmZXs29rpsTNWSfiQjdOe2MFcf487r4GU8KskEXpOGER/nADBI5ZvoK
         ABMpuOMCDGJwjkf6gnqacfGJeTxgqj9SsNuIcRnbDZ0aJsB+cfzaUGMtzb0UkeOYZUqV
         97DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMqlAp58Lm3MdFL1/oLfn8r6VrExYv+Qlr+51/E8+CI=;
        b=BhBL7ERpcRf4rFA2mdPWIPyXYafOv+iBrlWVf/v4CHCbVwSJ8MYjvgdtMjsjkHxtHO
         W13ShY4WOOdJnyKphYDX5LfG7iMa8LEJqCVX+FtzVyinad+Q+4K8FT4brsxDCsHjJXdY
         3qX9rbxwgfv/fukSMmflWszOb6Ys9TLIYj6y0z2MFNyAVGuOSQONk1TYv1sV8fibq561
         JmtJrqdULfTV2UGxIllpF9PVT9q8WGQ1bPhqokKCcg4VhaM4chFcNvH8CiGBvbJ3mrEY
         IdPfGkl5c4GLGo04PYySy4vEffd/URZIJM4FFETva+mPEUOkIzCQ4ky2+Bp4upUGJKVt
         7CXA==
X-Gm-Message-State: APjAAAWgQ+IJKV4Y9KzoI/4punHCBUJTP14ezAcZ1AX7IlHOsE2dqp1U
        fta7Ur7vD8Ezjf37UK2MyMCkztsvMVR57Aav+uymrw==
X-Google-Smtp-Source: APXvYqx4zfh4abumT8QCcMwPsQ4kGAi3uQZl6qg+f4xwtibi7ko9pWMCa9GCVANnvSnW7NG6HG7bW+OUwbld6KRMjBE=
X-Received: by 2002:ac2:598d:: with SMTP id w13mr250893lfn.165.1561470912218;
 Tue, 25 Jun 2019 06:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190623043801.14040-1-icenowy@aosc.io> <20190623043801.14040-6-icenowy@aosc.io>
In-Reply-To: <20190623043801.14040-6-icenowy@aosc.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 15:55:00 +0200
Message-ID: <CACRpkdbbxgeGPh1oKfyKKOMhpXiz4sQWjZv23FbYaafCz6NyCQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] dt-bindings: vendor-prefixes: add SoChip
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2019 at 6:39 AM Icenowy Zheng <icenowy@aosc.io> wrote:

> Shenzhen SoChip Technology Co., Ltd. is a hardware vendor that produces
> EVBs with Allwinner chips. There's also a SoC named S3 that is developed
> by Allwinner (based on Allwinner V3/V3s) but branded SoChip.
>
> Add the vendor prefix for SoChip.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> No changes in v3.
>
> Changes in v2:
> - Add the review tag by Rob.

Should I apply this to the pinctrl tree? Rob?

Yours,
Linus Walleij

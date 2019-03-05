Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADFBC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB40F2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAfUhGQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfCEHzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:55:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35183 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfCEHzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:55:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id t13so6740369lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 23:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4JoOtWsDVIWKo3LXJZTdF15lyL5cvzo08ovpPUuibE=;
        b=CAfUhGQpSpfCEgG9HKhZkY+LZoHs6N0eSdoTv2IG40dRBSq5dL3o/610ynw8JbU2dD
         OBkE3v/Pd9Wq4/brGNByhxiYfkgcS45/U+21WySOpZzdBdrTcmqrx5cw0n6APwjpzYH4
         8SlbYsJBd3lour5bXd9iz6tYPq5YOmSf2+mRQbVgowLOFXLR3WRT9kwqwhImOyPNIfrN
         ppNVeW4R1DuNW3BdXGP/SNNTsjINGAXSwmMh3Ej+W74SnhKX/mUdgPfivwIWhFI9vcDf
         eMNtO71Lkz0uBY1FNHzrxP8v3iv5NVTPsXJMDGXPnLeKt7toFkLd0pFFm3li65PWgPJo
         qUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4JoOtWsDVIWKo3LXJZTdF15lyL5cvzo08ovpPUuibE=;
        b=Md/tLRgiLofuQ4FXBPPaZEh4U/3JPzuOuEpg8NQcbfAAppV1fLLsifjRkyM13G/FFz
         sCuuHv5xBaP0OnKCn/yH7BLrXbGMvxo8CMOYkPdSZsairaODg8ujXBPnMPQw8gFpPy2W
         Gg1bejf6Xt/NAcPKuTRM4yJfoiSdlMA1b0HMachKi6em/ODpa6PPjP99lvsoCqEL01B2
         Yy7zVYWFY6dmvRSacRlhQzOCTnTnaM6NzmFUWK+HukYEREOAYwLvbMZXjKpeMV7Jy2ed
         +k5JUvSN6HNfRm6liDF6wBEDrpwUlWzLsO2fxnYC8w4GfRqKT6OFXQwQ7YQPTnSF+EMw
         uTog==
X-Gm-Message-State: APjAAAUR3hTP28g7mew6nkJ1ZJVzS8VCl9np3Ha2YgNC97xC9sIc3zXh
        VKS5M35tm0WiaykzEohuV4O6ShkGr/jFw00+BqbFow==
X-Google-Smtp-Source: APXvYqwJMi0VEPS0pFCuLHexkt935//bOy9YgOLrtaY53lm2dQiH4VR0pCqGl7ru/PtXh5YbEAlRCs6pOFgmRFr0404=
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr12469879ljt.107.1551772549595;
 Mon, 04 Mar 2019 23:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20190226115022.19022-1-manivannan.sadhasivam@linaro.org> <20190226115022.19022-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190226115022.19022-2-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Mar 2019 08:55:38 +0100
Message-ID: <CACRpkdaNvH7LwvkfWOtHQvWW=94ZtXCL8vEcdee2eSP5xbRSiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: bitmain: Add GPIO Line names for Sophon
 Edge board
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:50 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add GPIO line names for Sophon Edge board based on BM1880 SoC from
> Bitmain. Line names are based on the board schematics as well as the
> 96Boards Consumer Edition specification v1.0.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AD1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F20B20685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xfgIZIAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfDWIsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:48:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34969 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWIsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:48:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id t4so12730981ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 01:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkxGuQRYZSEV2PXaevoCieM4ZXUWjjwJ6wCDQHTEBAQ=;
        b=xfgIZIAQN+KXdspWfp9gF0t9dxeetMSCIsWG+Rft13AQiKpaCHluYi18K+uaTYOha/
         0m189M99Atd+HheEZy2+dbxJ3X6OziQ1wU9pmv8ad/+zs1EcnSR3EUaSDljjP9/6Vsbn
         BS+YA4BM9EXg7NWtHslRYRQmCAUj3yAPAXL865+snjsIyFBJnPGCLo5P8rqgOpKyy0AD
         B2S0jc5XCBzCSVm/+uiM0DoG4AtmhZDk1BHlvB+gQIHrPMc/9ELttu1ljeKCSBQZMwak
         rQlT82dQ/RMkHnpwnxJpJ/QTbES7nZwyag4pI5mxPX4P/MUwvj8DMlNwNp9HTntnZ7zg
         odWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkxGuQRYZSEV2PXaevoCieM4ZXUWjjwJ6wCDQHTEBAQ=;
        b=Zoc1Lim/Gq8iF6LP/Ozs+TjDwffXqz6oD/HJiAUn3P6onZ7FxHr1EDJNzCunnbKJj7
         3jjOMw7/5iObj2wgK61rSQsvHkzoHKiRMTT4e2+70WTwzEptT+o3CPbVY/6W8N3A7o7s
         4VCpHm3uXEfya9mFDpk+hHf7kOgDbVLyIGuXl+Gf+9UeJa9TP0ZnfxnSod+CN/68b0Ed
         hle/Qer5MOWsRdyEHG4+YOvPgnteuCNeDjbfa8dheeAFUeaHjETidQK6ioRF9fPtaWz7
         10pLBWuDTMEbK4bdq6Wr0rpLBQMI52BtEaVG0r6wtWcXRKhsZCbgk/MWs0tgUjTtaYh/
         6qSw==
X-Gm-Message-State: APjAAAXzu8GyXTomCztRhM6UwIEs321YAqaKow328dedJJRVb/wkUAXQ
        83Xhpy61OwQvDyG5YtQy2HHPcFd7Wh5v7r6GutDVDQ==
X-Google-Smtp-Source: APXvYqzeVDNUZ5M2WsxaeIE9p05YRT1bdx/OXCthFv/hAT21abhRI3JJe+RdiuMpbu+t7bno0vvAU9Yrwl6kE3+xNNw=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr12750558ljh.135.1556009332627;
 Tue, 23 Apr 2019 01:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <1554895824-25709-1-git-send-email-alexandre.torgue@st.com> <1554895824-25709-6-git-send-email-alexandre.torgue@st.com>
In-Reply-To: <1554895824-25709-6-git-send-email-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 10:48:41 +0200
Message-ID: <CACRpkdYYPu=MGwJvswXFX1mb=nfDd7T9bBV+rugT=cBuFKjsUA@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: stm32: use dedicated files to manage
 stm32mp157 packages
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 1:31 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> Four packages exist for stm32mp157 die. As ball-out is different between
> them, this patch covers those differences by creating dedicated pinctrl
> dtsi files. Each dtsi pinctrl package file describes the package ball-out
> through gpio-ranges.
>
> stm32mp157a-dk1 / dk2 boards embed a STM32MP_PKG_AC (TFBGA361 (12*12))
> package.
>
> stm32mp157c-ed1 / ev1 boards embed a STM32MP_PKG_AA (LFBGA448 (18*18))
> package.
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

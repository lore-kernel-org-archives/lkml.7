Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D3C33C9C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C916206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZiWmy0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKUOHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:07:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44347 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUOHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:07:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so1704501lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yR25p077sY7XsyzIresfvdGtP0NxdR3Phye7bNz8IVg=;
        b=CZiWmy0lOMSUMBEQdMx/dvvcTVUjQGVBpXZnRc5cLrC8Lf17LWwPQF5Ue+KBC2ZTlc
         lvcS6VGR90NTZiSpEGqtGHSWTCLg3HmrBLdf9GnUJFMj0TqHaMmchIbXjE1Q5E433UoV
         6rb2NkCG8Tlfy7Yt3mK9qzGuvUCeouGYHj+GNiA1pg2ex7KkaonvntMMb9fb9CRb9izC
         YrNQ3xr4hXKDmMmtH90fs84Vayv6fmfCJ+//aDIo/Pc+dqwm16pW7arYu5hPHASTWnGl
         vDChdWc9A5DqBuR067SuXgY0OIgK4mwwq3R80N4EBorhGyOguLd5G7Km3cuykdCNwlO3
         RG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yR25p077sY7XsyzIresfvdGtP0NxdR3Phye7bNz8IVg=;
        b=afDZpenqW5meLZaS1L+dF6SCM6GyhkyhTuFGhaIStjJxgrHjLCMEvdY97U1ga5R0/H
         Vt132zZMauJX/dhZrFMwmYS2PeKusjWuoMs6NwFr4VTiGQ5zLaYqGGlEP2qXQ9cBYCjE
         JsedfU6dkd5aWY4SyuT70ls/iIBKS2rlbDup+EV48EUswxp2EsL/AneUL6Ygj/PNlchP
         elblpBFMVwA26ZPtnB7RmbftDAHVQ+AT/qBf5RiGJSLZSZkn6RKcXsWEq9XileVc5qNP
         crvldFtbYG8wTk/wg0yEbNMxXitBa4S+UsDSHZryO3zF+raih6dnK1NXxL4Y9IpabyZ+
         GJHQ==
X-Gm-Message-State: APjAAAV1P3OkrKp/FYTZNX81WkaE9tJK623O7sgS1zgHPGpnuVasuEYw
        2oEdR7K6i2wmyqLpiiS8h4DBvbeQJo1ey+/dFm8yNQ==
X-Google-Smtp-Source: APXvYqx7y+O12Uu5ojAu8QNAvcacX/eJU7YDlJdyJO7nQwQjAJB69Xsu//F9QRhLjLh47IajvAAakFeD7WqmHGemTs4=
X-Received: by 2002:a19:7d02:: with SMTP id y2mr7406713lfc.86.1574345231034;
 Thu, 21 Nov 2019 06:07:11 -0800 (PST)
MIME-Version: 1.0
References: <1574306382-32516-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1574306382-32516-1-git-send-email-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Nov 2019 15:06:58 +0100
Message-ID: <CACRpkdaQCsSdZQrBkTQ_B-kz2jngkFoEgdYHW3uoPRwo=GcR7A@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        MSM <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 4:19 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>         $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Fix also 7-space and tab+1 space indentation issues.

Patch applied, why not.

If it causes severe merge conflicts with other trees (I don't
know at this point) then I might have to take it out again,
so keep fingers crossed.

Yours,
Linus Walleij

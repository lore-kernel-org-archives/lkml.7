Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016B5C751D3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3599E24796
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymPQwlgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfLMQFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:05:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40468 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbfLMQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:05:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id s22so3205155ljs.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbf8k5yJ19A5wSZeXVRUlCPqOm3eyldLxkULlc81AFU=;
        b=ymPQwlgoBu3AuxXxyAS8Pqr3jk0WyzPrXO0bCPOwIOGjnvgBRrGXil4Wbr2ayNyVg0
         5oHwBqXWHlNYU4H4t0AGAUVusSZhkfHiNJjIj3uc5bx4NxoOqz31/r1rWdCvix34S3ZY
         2LTTNgxyQ1bi8H8MZq9m+SG3t+rgn5AEU+AoO5VKhdPwcr7tzMRGFhdW9/jc9cvU1N9p
         yEh3vCXdHeINwcTyiFYrKgZxEzP6mSe5+H8dC7GEWci+dHT6he+jJOMaqoKrHvuaroER
         O8H3WuM0RCU6HzU+YAsXHI4yTGfj4+7zOW1wJoyn1ns5KWkT3b+TjkHMoaPRnN7i7Mnt
         wJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbf8k5yJ19A5wSZeXVRUlCPqOm3eyldLxkULlc81AFU=;
        b=LgWG7AAbmZ48vtVmxviE+0G8hdVpYVAPE7/www0WhLE0Dfan7F2Lv7cLQM/SB/siBq
         rzq1QEtsho4VgAOppC1hDogn6Lve8pGdP8wG/zpfL3Tl7Kf9luepjgJmfyNYYJLTwWDb
         zKx2wd9DHjjrV7qMsRy5YkuRmomGkV6BSCqUICtCIkdgvY5FLEh0WwtnWo8VWfLEHCBP
         Bb86xcXnlWw1OS2Y2GjmDJq0TUT8Pct6LPKde5nnzSp2b/yxZ98fJkG2Nib3yZZ9/C/H
         TwEvRUdmKHG7yJ4jmjukWhl3/PlJP+7vllEer/OR56S9wbJdLdRXSyCOFOhmMrwup++Y
         HO/Q==
X-Gm-Message-State: APjAAAWGjEW7Upojrr/pdLGxwXwcC0RvJqja2B5AeBaM3l/P+4Bexx3y
        9jApHyxAod//zplgl0TIF+aQBQvmv6ZHgNZfYsUTug==
X-Google-Smtp-Source: APXvYqwqvR2JGdbH6+gDLiMiftLZwqMCeGYmrtZEZ9p/3pwbALJms19uoBQteKErH11ha+LVboridg4Lm1ql8BrOASI=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr9963179ljm.233.1576253102887;
 Fri, 13 Dec 2019 08:05:02 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191211145104eucas1p1ce04a26eebcd4c22d72f204e7ae0aa5a@eucas1p1.samsung.com>
 <20191211145054.24835-1-m.szyprowski@samsung.com>
In-Reply-To: <20191211145054.24835-1-m.szyprowski@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Dec 2019 17:04:51 +0100
Message-ID: <CACRpkdbBBjXxftu1fw7H9N+hAe_MfkUPJErN6MPJ8Mxirh1w5A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4 RESEND] USB3503: correct GPIOs polarity and update
 the driver
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 3:51 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> Marek Szyprowski (3):
>   ARM: dts: exynos: Correct USB3503 GPIOs polarity
>   ARM: dts: qcom: Correct USB3503 GPIOs polarity
>   ARM: dts: sun8i: a83t: Correct USB3503 GPIOs polarity

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

for all these three.

Yours,
Linus Walleij

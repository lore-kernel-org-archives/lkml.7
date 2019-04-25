Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1AFC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3AC2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkKnHMnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfDYHPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:15:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42712 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfDYHPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:15:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id w23so16675027lfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSb0x3b1wgSY2SNIXybm2Ow49/WdQBGfKRtbnP4DDfw=;
        b=HkKnHMnVdNwd6yciQl1L1pFYkbN39WCQTD8PMxhjONgJi7Yiyxj+aixw+mPtP80jWE
         blN+BTebaM8HQQA/YYyg4aJdivcbqjnevpXham1S268HtMS5L5nc5/CgmgjgfN1BzF+B
         D1mYVp22nkhhkcQ9/NNIiiqPZ129VAOMy/MvS08zxLuCGkeWI13gwgkh9tTboyhwwNy4
         uUSg2H3eCuw9fLKnU7ZtVqrqNJPqHM0Fwh0wQET2N3Rhrd+Xwe4KrG0dAn5wGcIG5jAV
         q91WS3dE6kID3dP3SRSkKNLA61+aDx1NpHOuBmXGdOjidJ9rtFrEhBYoARulHjIRsYlN
         dC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSb0x3b1wgSY2SNIXybm2Ow49/WdQBGfKRtbnP4DDfw=;
        b=pumLGrzUrGpWXFn5ta3GeUg6GJSGHbHc0xbaStf7InPElUic0AlILLvmt/wl3dzc6W
         MercKZRnlcblNQrBw+YxEjOHPUwG+fkUL5B+Ii/lpbXRROm45pAyTjRwWGoHP7n7vBjX
         ddHnj6XXT5EtWAIS5JtXP8j30ifXcBjzJRqgATe3oOg3S1V5qc3BRhobaMh4hRSF5on4
         BJUpBMNWdH2F9uXLDzUE0/2n4lmcbjQGL+AACIoiW1Ygy7/csqz6WtGrfQJ9lOp5p4nR
         hUaK3CkQzfwM/rn1cMq1O3mzac71R0MA6ZfCotWRsvIWbwMYVtMmKkWA0ZdfEbF8GHFN
         AaHw==
X-Gm-Message-State: APjAAAU/BfOWSGSgEJNlTQo27MH1VCXO955HpJb9xxw7wneKPgNPN+4Q
        KBokZlbu7HnHQ5RPmn/vQVOvfI/JcyyozD5j+Na5x5H0
X-Google-Smtp-Source: APXvYqwqNJEVt2NKbSNgZYGSTANjqjuRezxHJkmz3JGeOyzhMtNPA2/Yt4E+mejpUSrFTFEtQ2VDAYJ+7JmiwUon7lo=
X-Received: by 2002:a19:f001:: with SMTP id p1mr21286256lfc.27.1556176519317;
 Thu, 25 Apr 2019 00:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190424135933.25545-1-geert+renesas@glider.be>
In-Reply-To: <20190424135933.25545-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Apr 2019 09:15:07 +0200
Message-ID: <CACRpkdZ0s2uZMS4K9SN+xQonKXQytBGnFR7v9ieBAwOUwi-XKg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: Fix gpiochip_add_data_with_key() error path
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 3:59 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The err_remove_chip block is too coarse, and may perform cleanup that
> must not be done.  E.g. if of_gpiochip_add() fails, of_gpiochip_remove()
> is still called, causing:

Good catch!

Patch applied for fixes.

Yours,
Linus Walleij

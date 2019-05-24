Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CF1C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001C5217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qno0DZOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391059AbfEXL01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:26:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33157 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390816AbfEXL00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:26:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id p18so6953495qkk.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQbzxXz1q7eupENIwZaibprKRQQ1QGdGQzKNp6w4Rig=;
        b=qno0DZOafF73RT0ZDcC5fDnleaIYN1r7Spg2AtrRPoNELpOm+eVBquKf6qMKWbrZll
         vML+ySumfkUfEYJsRHL24yaWH5pJ2yNZvk+QsCm9PHbbqB9FvVUNPlDWi7czSYwW62gh
         LZl2c3bZ6CtXghWBQfFf+LQJRDn3nM+w6HyXoPhLlkwZ26YXO2dC2zAUmr3wKfwVhcjz
         zJb7JHfyzcbGDJkHpUPYxU8vDenHtUxsi88gK56wAcnT1O7pEsALLubqM2Jv9hNu4Krf
         /OvG8Q/kHdAMj8+NFilB1sUaRV8xwnSu+MqeNgwFaIq7JTUC/dBUgN7YcA3F3ADeOT4k
         vaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQbzxXz1q7eupENIwZaibprKRQQ1QGdGQzKNp6w4Rig=;
        b=CU9RwDTnLYJdn4piT8EG2/om0WAv1dVGCBv8LsoI4rUqdjTbfn1F9sT5V9kYC5zwlA
         /dzwcQJg5SPbInDA+cALp9OyZ4exGYyxWNLvTJ1NIq5jHv+GlH0JYE2Lk6owezCFV31b
         qPrOvtTCqjQqjg43NTFWg1pMMpMk6fCY5B8hyL4tVSZ9eF/UgEtXVqvVjexkfjL3jDTE
         gZA/VSSPlKw3wpnpBC1rV7h6BEnxwazQBk7bKT5c28y+g+rYJz3IlF1babc2AyULO6oc
         PFgtd6wJjXytAVMMdZzkscf/QiDQT1+evKGAmqCTymJ5IofnOfr3eEEscNgTw/OGbXta
         ur3g==
X-Gm-Message-State: APjAAAWWs1W8seGwOlcKcJyQbAN3Z94Sie721OPJg8VWM0U93hKFpklq
        4W920P4l1gP9u0/23R927ugYmGwZea6cvfiQ8ppH2g==
X-Google-Smtp-Source: APXvYqwjkUQ0RLpOGJmq7DNe4leRPE5WFR5Q2/qSAXC1a4jjesdy4O9Mkrsk1p39MJVgfwXgFcwsHDCr+h35uS+jHwU=
X-Received: by 2002:a05:620a:1648:: with SMTP id c8mr73380286qko.186.1558697186148;
 Fri, 24 May 2019 04:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <1557474183-19719-1-git-send-email-alexandre.torgue@st.com>
In-Reply-To: <1557474183-19719-1-git-send-email-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:26:14 +0200
Message-ID: <CACRpkdZ4P=PSCu86p48nBPeVk-h5T0Ytc1CYV3XZGd4fLuJLGw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: add lock mechanism for irqmux selection
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 9:43 AM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> GPIOs are split between several banks (A, B, ...) and each bank can have
> up to 16 lines. Those GPIOs could be used as interrupt lines thanks to
> exti lines. As there are only 16 exti lines, a mux is used to select which
> gpio line is connected to which exti line. Mapping is done as follow:
>
> -A0, B0, C0.. -->exti_line_0 (X0 selected by mux_0)
> -A1, B1, C1.. -->exti_line_1 (X1 selected by mux_1)
> ...
>
> This patch adds a protection to avoid overriding on mux_n for exti_line_n.
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

Patch applied, can't say I fully understand it but you know what
you're doing!

Yours,
Linus Walleij

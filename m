Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A7CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4112075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuplLlJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389384AbfEXIKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:10:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42994 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389234AbfEXIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:10:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id 188so7829930ljf.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcI5nX0zsFocv6c9Dh5dsyELmuugz9pu4xszs0C7sEQ=;
        b=TuplLlJStenwIfjMi0SPcifzNyONWCjOAlzsqNaVJLUf0JuryBZSSfqTfFouJIuKzD
         0YC70wD3x8HwBrd+c6N7bKprIw/j7WEBdykVkNvZ5kfd1Q1dAik3xDID7CXPN47G5nKV
         2aBSa3fo6+2pNul3KMaZQtmWsojWbkfJ3TU7f/MQ26mY1/WEdKrxO0X3tLBuaN0kuqw1
         +YegxUN9DJ/Twi84rwuicS92wlXlg2Ir6jLEZ5BElnExtPPOot/MYLcJ94OvTDN/UACH
         l3GMGETArM3mdVdYN3y3YkrYU4j8JovLoxeuYk9/NgH+4yLCITdjm01+eKqcIJUoU543
         lETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcI5nX0zsFocv6c9Dh5dsyELmuugz9pu4xszs0C7sEQ=;
        b=M0Zqq0B9uzkcpWMY4DUW8Py827zOIph2gCvMhTDRc8CAM5fj0ZqFyBt0L7VTNAvacG
         Z1XmyN6GW8eLsuaIHsYm6bPgSU1V65teM1OJ63hBhFsFESZhSkd5Uv1fRvHRsXobdT3N
         Wg6nx3q7MaI90e2MrpxbXSuB2zTW01GP6DB9sPp/o2EooQyGuM9mfB28QBMnWg0h0pyZ
         cDEClLDXWO98UqlEO2dYLwSKSkqkO8tC21GOTZwDFTxF1EuiVmh0Jf+R0R1Fhzq3ymG6
         8sbJBfESVmbD3H3YK+oTo1hrxMq/avmjlZ130bbqo0ggWVGuo+bBmmYL/qijKFvaLP2L
         IBCw==
X-Gm-Message-State: APjAAAW6Mw4mbZ4BDKT90iMz77yYvd7Pwb9BovBP4y42L3zWtVHtoO+x
        FXAu5fVfRO/3tRHNUjANCfuMdHvh78HVSGWQ8lQaBw==
X-Google-Smtp-Source: APXvYqwVNWAVXwkUBL7c8AEmHQLOpoFiD7Z4FJzo1VkNZyw8J0vlNLuTHQZ22OQHfGXFRXfI0eoS6GlJNewBVqn8NeY=
X-Received: by 2002:a2e:9cd1:: with SMTP id g17mr11514251ljj.191.1558685422051;
 Fri, 24 May 2019 01:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <1558683125-31882-1-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1558683125-31882-1-git-send-email-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 10:10:10 +0200
Message-ID: <CACRpkdbRuveWT8huqpvo6vrSqyF2_g=xcHF+YjAs6AH4xcA65w@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: stmfx: Fix compile issue when CONFIG_OF_GPIO
 is not defined
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com, kbuild-all@01.org,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 9:32 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> When CONFIG_GPIO_OF is not defined, struct gpio_chip 'of_node' member does
> not exist:
> drivers/pinctrl/pinctrl-stmfx.c: In function 'stmfx_pinctrl_probe':
> drivers/pinctrl/pinctrl-stmfx.c:652:17: error: 'struct gpio_chip' has no member named 'of_node'
>      pctl->gpio_chip.of_node = np;
>
> Fixes: 1490d9f841b1 ("pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Patch applied for fixes.

Yours,
Linus Walleij

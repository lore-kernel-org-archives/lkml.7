Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3707C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABB520883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOwSnVNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfDHMG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:06:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34680 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfDHMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:06:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id o199so2173680lfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WlHkU7GlVSwL3RLn4WA0cqAwp5qu+bLTf1QEU8OH76k=;
        b=XOwSnVNzQJvin3TeLCgQxYAums1cyWDMx+wXzXy5T0fr317ycAyXWPzziEVjg7yU2O
         5w0mq/7+i6dbNq+Uyzde2xAdtpKIOX2z1284EroOK13uXzDBgHoRLmn0X5OPwhnUoPQ1
         w0bJ8t8iXsKu9GQuDypth+8USId0CFFhgqiG/JZeDegejF7fjdc6D3Tz4ip5xmBIfyql
         Pk+3jLgfQEtezynPUthbGBLOFaEjhRg+Sanmda1s1SD4m34zVnfPnFdoPW/n+MsOXt6M
         BJNFSXV87xAoTjUck44ZjB5E9ONOhmkTcInO/4ly7XVltWogxcuN+YG8RhOeg/oI80eZ
         koPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WlHkU7GlVSwL3RLn4WA0cqAwp5qu+bLTf1QEU8OH76k=;
        b=aU8GwRHQ+g+Rx3x6ZfV4fxD6jAPueo2JgkC7QAhvgiDAg2/QjzYup2W3LqoXdN5ZG9
         FJM5LFeeAOZnGx2F7Kn55wuh+yrJ5e7iBM5G8H4fWNfRZX/KUZy4MJPuasfwLYMhG6jV
         kqSAYLgMKkRSjW7ErPqD/E5yh80WlEjCU36H5nihsX45n74l7iGzfJ4QgVSeOSO5/Pxz
         Kf252Ga96TEiEAcWV9kegwnpASJbj7qo3ZEdKkJ9RfhG27IR4vx/M0lkHj25F4jCGMvr
         Dj88wKWsxsGv4zNvXXgTXEqilB7zpnMxWt5c4WLD+zvjgOze2OxMjJfj5m3GFhiLJoDC
         o4JQ==
X-Gm-Message-State: APjAAAXwDufhTAFUjyHOdj1QWNKBv40O7oRqkTgJ5oewpJBBJJD1BYiI
        hv0Bgk5GzEJ98/e1bD0v71n8CAh/yAnq0H9WeRRncQ==
X-Google-Smtp-Source: APXvYqyv8AJWbL/CbasVOz+dDGkT+CtzkBjxtuSAts0Sn3X7lyjsuKuP4vl59TyjvW2xEovS079XavKJii5ovuxDUiY=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr15385613lfh.103.1554725185800;
 Mon, 08 Apr 2019 05:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <1554298852-9955-1-git-send-email-p.paillet@st.com> <1554298852-9955-3-git-send-email-p.paillet@st.com>
In-Reply-To: <1554298852-9955-3-git-send-email-p.paillet@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 14:06:14 +0200
Message-ID: <CACRpkdb-ePddcJJLiFfOrP2QbxsNG2xQ17b5etrMHNGE3sFBmA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: stm32: add stpmic1 support on stm32mp157a
 dk1 board
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "biju.das@bp.renesas.com" <biju.das@bp.renesas.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 3:41 PM Pascal PAILLET-LME <p.paillet@st.com> wrote:

> This patch adds stpmic1 support on stm32mp157a dk1 board.
> The STPMIC1 is a PMIC from STMicroelectronics. The STPMIC1 integrates 10
> regulators, 3 power switches, a watchdog and an input for a power on key.
>
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
(...)
> +       status = "okay";
> +       /delete-property/dmas;
> +       /delete-property/dma-names;

Same comment here. Is the I2C DMA not working?
Why?

Yours,
Linus Walleij

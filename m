Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB823C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDFB20850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HHumoDlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfENSQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:16:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39805 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfENSQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:16:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id v2so9436483oie.6;
        Tue, 14 May 2019 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YMSOdywhMDkZIusrQTvSoGh0Q6ONeiUFTYpafArN1A=;
        b=HHumoDlFG8R5gAm3Ad1ciIosYI3vaJ7hvHU+HejRRC3yCLveG8A8/bU2GI1BTbzPaH
         IUwfrvrdpaTW6+rlhxdctqH0ds3IQeGLswlJygQJo8Wy8owPgytP15gmPLZgAk4FkBDg
         NgZhOKRTzusOhfrD0OLcPwc6cOCFj7fIZbmQX3qUu2d5lDU5d2QhslTTaVbc9IjZZG/C
         rARWXf1jUvtJLOMJCZ+Ly5WWspAoAMkEbPRS2xtQz0P3kLU+xBfNqPrhlzInuNT65nGC
         KMyOwwLqwZW5V3mdgjKe/Vi2o3InWL6SK1ZVnKOqmz9Smip2Y7WHvEvf+2+YD2o1F/Cm
         8TRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YMSOdywhMDkZIusrQTvSoGh0Q6ONeiUFTYpafArN1A=;
        b=C3UXHAwF3AXmNoefDJKL+/SyhC38nb0fdHxQjxI7/5YO/omGeNckktqJeXLDM77+CJ
         3zjXG9omGPutDj2GaF1uWQgTXilRzSidakNTSpndKBL1pjhv4JIjRaMoUSio0Mnm8u7D
         TDEtsyN4Q//JQoDlsu0R+sicVUrsgUZjbKykO4RUhbgEhp+KX96hsryX7g46uY0XfJmz
         LN+hy91JYEqqYD4MucQbQyHxnP5D7NqHypaPXC3JfQiW7QpeQggS/nb3t43SsHVChb0p
         AQToTGJxQAfoMpdngWyuEjzTu/eGmVcM/KqJ7v7pEq+dJo/u9PFGa2cCuHDirk8+rfZi
         8ZzA==
X-Gm-Message-State: APjAAAWvSN8ScZsQb3HMM39718PgX+ytBcBOPrPxYCQLpPoqXgGZ9lc9
        zC94eo+ZC4s5mbjbmYYNBqzU68brY6Mgw6I0GUU=
X-Google-Smtp-Source: APXvYqyY2t4CYQPKEHqtsUwWM2Rw8XRLaW0voMCaWNP5OK2WwOoKu/4mjsM6cQLFKNXGKuBZGFlXDA3GnbdV2cYN/5E=
X-Received: by 2002:aca:b68a:: with SMTP id g132mr3805890oif.47.1557857799214;
 Tue, 14 May 2019 11:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190513123115.18145-1-jbrunet@baylibre.com> <20190513123115.18145-2-jbrunet@baylibre.com>
In-Reply-To: <20190513123115.18145-2-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 May 2019 20:16:28 +0200
Message-ID: <CAFBinCBOtsSCg40L+PovAwN2dvLpDO7KMhJpcftpSiv+moBDSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] clk: meson: mpll: properly handle spread spectrum
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 2:31 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> The bit 'SSEN' available on some MPLL DSS outputs is not related to the
> fractional part of the divider but to the function called
> 'Spread Spectrum'.
>
> This function might be used to solve EM issues by adding a jitter on
> clock signal. This widens the signal spectrum and weakens the peaks in it.
>
> While spread spectrum might be useful for some application, it is
> problematic for others, such as audio.
>
> This patch introduce a new flag to the MPLL driver to enable (or not) the
> spread spectrum function.
>
> Fixes: 1f737ffa13ef ("clk: meson: mpll: fix mpll0 fractional part ignored")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
in v1 [0] I checked that Ethernet is still working on my Odroid-C1.
I didn't repeat this test with v2 but since the logic has not changed
you can still add my:
Tested-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>


[0] https://patchwork.kernel.org/patch/10877431/

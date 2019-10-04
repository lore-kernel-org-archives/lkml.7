Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E86C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626CB21D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ha6lkOgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbfJDV1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:27:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36444 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfJDV1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:27:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id x80so5449228lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmpGrwSq0XPnJhwom/TVm/5c5N1P1jlAi5DA1JlEF1g=;
        b=Ha6lkOgwkTpL5AMiiK4IECKVOL0pcN9MTeXWPS7e8RxpVDW7M5swL4KQa0dTtrLyu3
         DS72wkeVbSerc5JEVwnIS/UXzbtS1L9oFQlmzCorY8I0vlBZeSk1qnu/edYfQmNklhbx
         TfWYAxCfb/y1zApmj3ShaHheHplRkHqzVGd3CCiJgJqTXAhGZ6EmIvhuW4XemXP3v9wF
         YzVJteyPL+lKrmvVGpMIfzncPgv3zQHKMu9BCdJ/DlNAwdmOeHydBxhErJ9TO/cJdPgj
         TvW7NPP1erd6PD3Oka5hDjuLJRhKgKT5hKfRRotzYzH/UlIUezp0iq8WCQMwcuZlM9v+
         atrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmpGrwSq0XPnJhwom/TVm/5c5N1P1jlAi5DA1JlEF1g=;
        b=bsnBuOJ7IyTry3+XKzm13mw50vnvPxkXRTVk6WXix7mSomrOblGyiFRuGyYcPAzNut
         HDmsH0eekiT1B+pdy0wYjLNNbFEErSfUiqWZ52POMYHfD0R6enK4tmoOWjWZQ3zp7xyL
         kCFRoWgIW1T1Cpvax/jNiaIQ4DMzYYZ821MaRvHvxe1AxYWiSDXpjER2zRg94xCAdQuu
         Wbg7hKSmAx2SyIWu4TlLVyLoC8SigrPBpUaPwH1T5VJdMiz9AVT1BnuVStw7WLlGDlmB
         nPi0n5PIwTmb2bJCKcEue4d74RW7uGp9eej+ID6dSFPYHXbxCx5RO+KCeRSIJAQXR+Vc
         QlIg==
X-Gm-Message-State: APjAAAVI4TjpEUJkqQHgorb05zyiArzGl2aId/zL/VhouaoBuBlId6RH
        pWyHY4e5NDM46yTP/23Gfy752IOpTUx+F7z87npp+/SLIqc=
X-Google-Smtp-Source: APXvYqy1iXUFswdxVf7v5hts0g+S2c4fvXDUV5/d2xpEaHizj7JznUIXFYBa+srWPaWsj3gelqZqN3ypEP9s4wr/g24=
X-Received: by 2002:ac2:46ee:: with SMTP id q14mr9393307lfo.152.1570224437094;
 Fri, 04 Oct 2019 14:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190923142005.5632-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20190923142005.5632-1-linux@rasmusvillemoes.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Oct 2019 23:27:05 +0200
Message-ID: <CACRpkdYTD9x0TH0sxNatxRA_nedcXt13QfWRS=_7+rmRGT=_hQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: devicetree.c: remove orphan pinctrl_dt_has_hogs()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Tony Lindgren <tony@atomide.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 4:20 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:

> The helper pinctrl_dt_has_hogs() was introduced in
> 99e4f67508e1 (pinctrl: core: Use delayed work for hogs), but the sole
> use then got removed shortly after in 950b0d91dc10 (pinctrl: core: Fix
> regression caused by delayed work for hogs).
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Patch applied with Tony's ACK!

Yours,
Linus Walleij

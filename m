Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC54FC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3233207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cx5trC4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfFGWLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:11:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38666 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbfFGWLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:11:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id b11so2705678lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwd43iQ+uxpnBtPTqymsT6s+8HUa61yC8t5RUF2PcZU=;
        b=cx5trC4enXjixaDKj6Ievop4mO8XN9hgO9aAR04Q7aLPSDJ2c8Q6GPk2HH8EC/ErF0
         7MJ7D8Th748v7WMTnI63ah8gmGDXq0TkGf0uJ1v/q/g/zzZU3mmkwBkVYZE1sB8w1+Mf
         hASuZE/FTdqh3tRERGLesm/E3MnKbdXjC6lgCDZgIVjNnHUuOF3/kjmlNSijoiE1Oi6F
         6BxGVHxQaCMURQYR9jvt9oSgPaAFcvuDitqQjzpTRn9VB4Sg97qRzuS61nw2tl9Mowoj
         1tw9aHeC2Kb374as6WteoD0b9grq85chn9lJWbzEMwWrqkKHorAlIPnTz5cLF2GYFJAD
         X4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwd43iQ+uxpnBtPTqymsT6s+8HUa61yC8t5RUF2PcZU=;
        b=mv3nYYiuXvbTLtVCJRyDzF3yOUXNJr4bvoVLoPsIe+cgFj/sFLsYHxmLshGOigXX69
         peZVoC9fY/tnJcPIx4kXkXUUOdeA0/HF4hHIgdu3hiNpyJDPMAQKvkobdRXO6l2paM/k
         AKRcX7dNlTN0naeuLiteCzzHH7SyRJAktrTouD4lAMd17utoe7ZSib2N0wPBb/Hon/zz
         tSEuIoulbyM95AsXBuX2RmE59bDXr8NVBICNYk13z82/A8rvQK62ovvzJ9bjWmXjCGyq
         mGC4pA6Utt/SS5Cf63Tiv6A1ozicXy/BgG+fY5kT4R09XAW7HYIxjLVRkLwUAWDUSnpt
         50QQ==
X-Gm-Message-State: APjAAAVEv5/FZ61AOvCzqCBUlOjohkjiYmNhx9ZSsOVJ24VYTkAYFGqL
        Z4jUVJPofJ7OZOEX3RySqSbNPQYNjVcKkN5DSGo9hw==
X-Google-Smtp-Source: APXvYqzlzk1opCrnSZLf1NClG2hmLjUWMYvMv5LilcvGaMM1NvQ27Pl0x01y4ezRphDXsdt6wF8raMS/qpaHuG1ixW0=
X-Received: by 2002:a19:7616:: with SMTP id c22mr23929383lff.115.1559945461842;
 Fri, 07 Jun 2019 15:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190604163311.19059-1-paul@crapouillou.net>
In-Reply-To: <20190604163311.19059-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:10:54 +0200
Message-ID: <CACRpkdbKg22OyViYhXS=Vyps=2zQ_dmm23Xr8+dBp+uwwjheuQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: lb60: Fix pin mappings
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, od@zcrc.me,
        linux-mips@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 6:34 PM Paul Cercueil <paul@crapouillou.net> wrote:

> The pin mappings introduced in commit 636f8ba67fb6
> ("MIPS: JZ4740: Qi LB60: Add pinctrl configuration for several drivers")
> are completely wrong. The pinctrl driver name is incorrect, and the
> function and group fields are swapped.
>
> Fixes: 636f8ba67fb6 ("MIPS: JZ4740: Qi LB60: Add pinctrl configuration for several drivers")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Such things happen. Are you planning to phase all the board files over
to use devicetree eventually?

Yours,
Linus Walleij

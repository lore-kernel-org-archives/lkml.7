Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2CAC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457F321734
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaWYUfwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfHEKqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:46:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34137 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfHEKqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:46:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so78902712ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azjj3TFeiqdmOl8nmyercmf7iB34KF89eZoGG/R6Zs4=;
        b=gaWYUfwJYyttQBMe2nY+8yFL/8R5jK6AQk8xvuMDqQn5mcexQfU+ZUUBmyu+uJP9FD
         AmKll1bIV4/biJ6Qu5g1juCqirMX0AA9Y7O0FMduDj8D0GDyQdzizwqMTlzy5Bu9gjWv
         1HnI+DOVGuN2KsQjDbjg/5PnQh5CXxe8LbU1I1jgmfyS4ER7mB+VkEGz9UWTkkKnvIDb
         AE8kGu/a+T/WRFmIyQppd735PPaioAy1djy1ixvflToH7U7NTeqAlF3eQ9nOCL1KN0gH
         0asNpJXWqNkEs/u5hVmU5YZuz2wSW0AKsmclxTy6HUY95ONFEY6k/YlWjvb91w9mQ4xa
         GrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azjj3TFeiqdmOl8nmyercmf7iB34KF89eZoGG/R6Zs4=;
        b=XjVB9rqHChUT3h8coxy9IGIik/z31haN46WghSP+Ev85GUYg3H/FKwm+WinLnEbZVB
         c4aMiiDCV7VrEq70nWVVkFJgdrHgg+l55ZwJbd+zQKXxidaEUoj2aaYjEeuDzF6f/bUB
         GKs96ZNpk6w39PXAcGFVwnHC5gVC5XuyyW8nRSSXnItKT76MC5svTFnKShiYmECraast
         YuKnbyXGJ5hraXpy+Q2/OIG2lS3KyA0YTtJgY5ElNbdRPzQe+p2zEWS3SznMMwUtjfGE
         I5MMaOtqUg3tzz1HnrgWMlkiXjcCsXkFqGUq5pCA+tXMof+bx/ujupWwySzSI5waZ46A
         rdIQ==
X-Gm-Message-State: APjAAAUELgKo6i0s9/mN7Oi0KfK/pdZSqCFMjRXudmRQnAOD9zAMYDr1
        ZnmZlTUX9Zb2oqj+k52EWbgH/3k7gDQjzKyfEJ7dFQ==
X-Google-Smtp-Source: APXvYqyclUQUuvXpJI3a3I9xyKZ6YIBTCazGIgPNcBnTvtEx+0Gv4bfEuR07MD49TkWuHW7hIeykHmoPhEdmQSSmqjQ=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr29583690ljc.28.1565001969218;
 Mon, 05 Aug 2019 03:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190724081313.12934-1-andrew@aj.id.au> <CACRpkdapypySGPrLgSMSNy1fzkca2BfMUGzf3koFWQZ-M5VOvg@mail.gmail.com>
 <9d0f2b20-e6f6-419c-a866-c4a0dd92aa63@www.fastmail.com> <3691f6cb-2451-43f7-9f00-d5693071ba59@www.fastmail.com>
 <CACPK8XcWK9Gf=pW5ds=3muoXHAWnyYfHcVSVh+anaTigtMO8yA@mail.gmail.com>
In-Reply-To: <CACPK8XcWK9Gf=pW5ds=3muoXHAWnyYfHcVSVh+anaTigtMO8yA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 12:45:57 +0200
Message-ID: <CACRpkdbb9OFnnG6rN0fL-qA7vBsGze23GgOifAHqxhod=0kRpQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: aspeed: Deprecate g[45]-style compatibles
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 8:15 AM Joel Stanley <joel@jms.id.au> wrote:

> > Joel, do you mind if Linus takes this series through the pinctrl tree, given
> > the fix to the devicetrees is patch 1/3?
>
> It depends if you plan more changes to that part of the device tree
> this merge window :)
>
> Linus, perhaps the safer option is for me to take 1/3 through my tree
> and you can take the rest through yours?

OK let's proceed like that.

Yours,
Linus Walleij

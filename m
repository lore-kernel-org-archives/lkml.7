Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A180C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5DD20856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfMDJKbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfHELSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:18:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34143 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHELSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:18:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so78979294ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTrdNULqRQePZooec8hzYMuIdhWzshDsgdUne7v9Rpw=;
        b=HfMDJKbibOLBUBs34DEUtHqcUBsW8mIlsJ4cc8eYz6VcbQmKPZvnH/qVxN79tm1G08
         bEjAhCBkfH4Nj/pWLyZMs29VsnmVCV9q4O5CrlHx7hESCejGeUF5Y2ycoW+s1yhIrQBq
         sYcAbdXAidoCi9RTvz3gvMMZEzbhDFaae9gYrqA3JyeVq4vtDIb4kw6dDCyCZLt70BJX
         HGEx7Z65iLiegnTNg2lGymGYbDDRjkalIgzSel+z9gtWuD/MpLa88cjXdTRAOQM7AfOl
         FnEOH5AXGz8ex15jR2XnRA1OsQJoagE/0AUdvuplwCjEYYFrZDA5fYM4BxZM/aH/zXSs
         wMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTrdNULqRQePZooec8hzYMuIdhWzshDsgdUne7v9Rpw=;
        b=Fjlfun/aId6Cl1+k1wSIGlD3+ROzowVVatDu5b7QOXbEpDpNYGpa6z5uv3+5XAKwBW
         2XbtJTzxNj0g1qygFHkvrGsiOKLdJzPbtfWOfMCS8h6PWy0WaUrACIVjd7XqBrP5NV9j
         tGyN5iaUXYssUHgdivDD8RgDrYzd1f54AOmXmB5GXqDTRkL2b+Xc+hqKqvnI2QdOGdxk
         tajxG7hiSMyeIn6rDuqlFi+yY0sff76zx7Pr/wXp1uqtBD3DSelssGI1emu1TtoWd5R5
         YXNKBlljNnk7i3nQvGyPc7b38IaIBPus2pnIG6Zk5Pz8OVeqesS8e1Obtjw0ErdioygL
         5A8A==
X-Gm-Message-State: APjAAAXVh3JEKreCBqVYOLTQykuLNPH8vC26jUCSP8qGccxSi0ON8yVS
        Us1NagaT78jMxC7lcPL0ZXlA1zMCh8nAezVHbg8bMiG3
X-Google-Smtp-Source: APXvYqyLXiSKJTl98Lkgl0Ja3jEwM+BGOX7bwjIKoiganUjSPKjHOrR2xjbwuvFB38NS1GCnOdkwwVZ1OFVgw843jm4=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr16561733ljs.54.1565003894943;
 Mon, 05 Aug 2019 04:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <1564465410-9165-1-git-send-email-hayashi.kunihiko@socionext.com> <1564465410-9165-2-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1564465410-9165-2-git-send-email-hayashi.kunihiko@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 13:18:03 +0200
Message-ID: <CACRpkdbt63WrZszChi25H+mxrHneKFHbakiYYskCLSXO=A9rkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] pinctrl: uniphier: Separate modem group from UART
 ctsrts group
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 7:43 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:

> It depends on the board implementation whether to have each pins of
> CTS/RTS, and others for modem. So it is necessary to divide current
> uart_ctsrts group into uart_ctsrts and uart_modem groups.
>
> Since the number of implemented pins for modem differs depending
> on SoC, each uart_modem group also has a different number of pins.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Patch applied with Masahiro's ACK.

Yours,
Linus Walleij

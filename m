Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EA8C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA72C206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/2DxeE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfDWKpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:45:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33226 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfDWKpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:45:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id j11so11358933lfm.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CE838+i812Sf/vAq30btTvuZmas6cHKmmFF4qebP9bc=;
        b=W/2DxeE1BL23Pho5KrJ3TIBxO+Kwz+0b+GFzUBmbY+h3DG/1E6dpqXB9gsdlj/lokF
         k2qwUSxBv4DI05LS17j7mT6IWCCsC3sEynBwHAHGlfGBNXrhtM+vpE3Z03ZXNXRpMHwm
         gzqcu1buuZJGu2iJC616mw7VBN44ltGEsD6/bUkfIN91iFkdeH+zpW4Al7fQmTyKfySD
         12nXpn9hucjJoD7NkejtsR9ZLk6J/pccwtP569MetEhjqtmObD83l3RR1ClLK0CtoGjf
         zd9lx+LUVTXuhJedxjC4LvE4uwYjUKhaaZGRzKqW2DA1ywCAJRi5uyuCiFpt42jqQRh5
         yDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CE838+i812Sf/vAq30btTvuZmas6cHKmmFF4qebP9bc=;
        b=mm8/qfxSsbjra1cxUCODAQoB5Gc0+tWgRIXX5EKp2ooalt4H66yNjjheGSx08v6G5E
         3krqtjBZvcnnNio4Y5OHwmYuZC1x1MuDEJ25B18IQB4KUdyZ7GV19COTlHq4QP6+vCSu
         bERDCFbtikq1tqwpQJLlxF3/applge9f2/lQwsvIgCwvkdUMMvKFBV7UdC75NwIkzWI5
         q7ExarJ33EtM0Bh67/FiJ8brhNGjKwvMOobGvjbILIXbwqxeT33oC5KbDXkWLOGveUqw
         lNujU+BxtlfO5XxHEhm0ZVjj8UIU6EJTZsuWdMMhJ02hzI1M9+jfXxf7g+1ExnaOP2uA
         Ug5g==
X-Gm-Message-State: APjAAAXGKqcAqXrRmwpm89gx9u8FFZZs9oiQ71Jj3ZSi2lQCkDFhYUQL
        TSbZU+TaD+n91c76+V+vh6ewiBTSyu+XMGowzxzYZQ==
X-Google-Smtp-Source: APXvYqwpaeE+U6bdJNbQ2uj9zsv+p4JyD/CzugJ3IIWgIlAjcCvx0AfSLecds2blhbT8FxhZ02R10mMAz1uC4YsnQco=
X-Received: by 2002:a19:f001:: with SMTP id p1mr14345018lfc.27.1556016306794;
 Tue, 23 Apr 2019 03:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190415202501.941196-1-arnd@arndb.de> <20190415202501.941196-4-arnd@arndb.de>
In-Reply-To: <20190415202501.941196-4-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 12:44:55 +0200
Message-ID: <CACRpkdbU3=Jpt=41rfTV4OF6DU8kDLzjTJXqHcifA3A4B7XyKw@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: ks8695: move gpio code back into platform
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Ungerer <gerg@uclinux.org>, arm-soc <arm@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:27 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Properly splitting this out into a portable driver is
> hard, as the gpio code tightly interacts with the irqchip
> code. Give up and move it back to its original location,
> but make the headers private in the process.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I bet a million to one it "just" needs to be reworked into a hierarchical
interrupt controller with the GPIO at the level below the irqchip adding
level semantics.

I did provide an example of how to do this in the ixp4xx patchset, but
if you don't have the hardware at hand I would not recommend trying
it.

With the goal of getting a better build for ARM32 maintenance I
think this is a lesser evil, so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

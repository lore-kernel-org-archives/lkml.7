Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3305FC49EAA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078BC20717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKSM2QTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfKEJXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:23:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38369 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfKEJXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:23:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id q28so14567840lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 01:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ct9g/c4KnN6815DyJzsvIVZUxmWLuOF9LXKZAhVKbL8=;
        b=YKSM2QTBCckxvZ/6Gq5dfMrbdS0x5OlQiyIjgvVFfiy2DEtxC/YK2sAtJ8E8yGzGnC
         vC3vEgOdUGdyUWKGZm8gYADe06XUhQHrnBe6ZrDxDK7pUlLzOfDaqxBDFtTlhNG+NtMa
         8ZKf+R8bkPbKUrAZB7NIxUAycktPoNmgiLYHgWuBoXStS1YJJabyH96kbSVMiTGax8h1
         wT42Xk1tp58pYDdVtztuIbh5r2LpKP0lTkBAGpgnB5gRySMzDeXpQSAQSFInOLok0CtF
         ioN2DYfH8dv1tE3aoeLuiJ8++IkwiM1w9xYbdf7nkWsDbyvha3XVn1Ul07aTrAxlNzRy
         Dw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ct9g/c4KnN6815DyJzsvIVZUxmWLuOF9LXKZAhVKbL8=;
        b=iWjxtCBluRygfHcFDBpRkadWtiRScDVr9BLvbdVM/EfJdfBAbtAOV5tuNJ9BIR0uSm
         l5dqkgXhf3zEXwacoZyog5/CDvn2FvimGmPOgqLjZfS6pTaHhyNhXdNwWsCUuoHHl5mt
         Be/85lclUSPKm8RdwSEBk27WcT9/vplVSaC2RbaK9QrTqvf7Zf9VV9gmQkEpQYN69Bf8
         VIebAYFuAtEV/DhND/+jF0J09VMFPruBF0L09nyXOOsjdTWHNvCIbuvvrWvS+WYz7kWx
         lHm4ejCKsXKZ9Y8bGvkR83/YbxS8SuioWOxFn6bmBpVlKe7GLLr5xX7LA/jWZ8EGGp2T
         6/GA==
X-Gm-Message-State: APjAAAVpSlK38muykidE1Hk+FItN2U7a/jhUaBoxJxgOEHYWkvACRDlj
        dRa03mbFR7fpgl6ITBMxGORbLtC8CGmqH2t0dvu1Tw==
X-Google-Smtp-Source: APXvYqxeopO09ns4NgTxjigartGjOoe+JETioaWMrKGhyhGNAt2HdlvOIjunc3L7nT5gZgJzxfa7ONCTaP16w47SjKw=
X-Received: by 2002:ac2:5295:: with SMTP id q21mr19505657lfm.93.1572945781604;
 Tue, 05 Nov 2019 01:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-24-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-24-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 10:22:50 +0100
Message-ID: <CACRpkdaT4Tn2w0LZDo-mB-GGT=Epv-stkWW6S=AZ+OWam4QWPw@mail.gmail.com>
Subject: Re: [PATCH 24/46] ARM: pxa: magician: use platform driver for audio
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 5:42 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The magician audio driver creates a codec device and gets
> data from a board specific header file, both of which is
> a bit suspicious. Move these into the board file itself,
> using a gpio lookup table.
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D140C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF5B20748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uj//MN/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfKOJue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:50:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37340 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfKOJu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:50:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id d5so10008786ljl.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 01:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/UA8N9071Hs67JB/CtCLOKYsRujWaxB61T4BkLclrk=;
        b=Uj//MN/eYpagIL5SFVK5o9mqojQITuF2XVCgryREyFOYqXwn9xWNIEKr/hnSu/yd37
         OgcpwNqi83ryL9yGP1i3iNYM1NbRKkpytuLcvx7ux/H500d7XGmBTA1gGyjzvIoV1iEw
         ld7CduY+HoP5HPEWtCzcfMm9I2Dm+Qz4o73G7hmWuJKiE/659BHe9isr8jEu6zfrXY5w
         p6E8t5bh/a39/Z0Xs8X8yXae3wjaBpHdwtcjDJIrI75l11sES3dl5SnTE4LguB/l+0rp
         l/TlA8QLOU8hAcIlE+mlbdA00awq8mAiygKQOZVYY63BinchNpYcFAYnxZkBzVC+ig3U
         4gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/UA8N9071Hs67JB/CtCLOKYsRujWaxB61T4BkLclrk=;
        b=HmVh4mEd/FqEVbC0YDQWtnKWbfBw3/lpfbZPz3/QYuiJCoSuAI4/Vk2YnygkCQA5M6
         47gBga2UYwbr1xDygs2/Qz6Tmg0otFe0awd+ocxGMk7PpepM2ZfwHB0ej2wsSjPt7UDP
         W4UjmhGHEa9DA4bghI7BAjo495DErxqP6CV7OuvwuyTghJuN+JaoaLM8MWjmkw7mQQej
         NOMLLkTnxz2hlN8mas2Bdj1tqF6lvHFHGy+b0Kq3ZjBkaYnnhi41Lf+sja9+HnQ7AqIW
         Xo2QsZOZjCr74rY31xJbdwRr6Gos+g3bu6EiXZN1P5dh1XcNcH+tfQhibtdfSH9OnhrA
         B7qA==
X-Gm-Message-State: APjAAAX48lPGYnjo0f5XcQ3rIlcDDZL/BZEonKoil4u8uy3We8uGxpIn
        c8ltxbagLt07zqX3BH5uNW86+/fNVyB1GoDKUhelvg==
X-Google-Smtp-Source: APXvYqzoH0lE2meSnOsWYn4w2Vnm6zFN87zG7pAIdO4qZpC8+1a/pUkOgr9YtQTghftKTYLC9GIcmmSSdCngI9weV+A=
X-Received: by 2002:a2e:161b:: with SMTP id w27mr10500539ljd.183.1573811425820;
 Fri, 15 Nov 2019 01:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20191115062454.7025-1-hslester96@gmail.com>
In-Reply-To: <20191115062454.7025-1-hslester96@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Nov 2019 10:50:14 +0100
Message-ID: <CACRpkdaXcas08jy+oZOi4fKuXZYkbFAOipqf49smSdGd6TmFag@mail.gmail.com>
Subject: Re: [PATCH] net: gemini: add missed free_netdev
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 7:25 AM Chuhong Yuan <hslester96@gmail.com> wrote:

> This driver forgets to free allocated netdev in remove like
> what is done in probe failure.
> Add the free to fix it.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Looks correct!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

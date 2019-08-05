Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90409C32750
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682C720880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="klSSoLHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfHEJ0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:26:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39360 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfHEJ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:26:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so3588262lfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 02:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDnwC1sRX891ja7MrREnsLX3Gypilc9tkmj0BZcGzyg=;
        b=klSSoLHFds39D/tjuz0Uouf+k0MFSWUUmt0MXglw0jFkrtp7DgmQlIDeXpebYGGcPY
         REoZZDtMMNpeY+qJIyxVFlCYM5OxfYnu2xFXWFtr/udugFA/sxdnjaL3H3cHdBo0A9JD
         B9F08bseI78Iv8nqwzJ88MNI/RmQvD/CAzdAZjO/3nHa2FnJbZoBpygz8Y4cGw70OHpV
         tycISGMzl8e9j06kvw98NiST/mYfrc28eJ9KfxWkJQWgf6KcgyMAV7ZaGNSgOb3bBIGe
         Ncf8sKt7wF695jUT/9/ZEKyq2ZW9cX8gjXd3nAhABc2/hGIjy9tEIiBCi7xGZ9sEXlTX
         wztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDnwC1sRX891ja7MrREnsLX3Gypilc9tkmj0BZcGzyg=;
        b=HAWInyPs4rbpN/lcEUDLHNQ4HiElWbfkPTydT8GBmhDaMZXOH5vrXA4FsSosi9LGJf
         TDcOAMVYEjf0W8uASn4xqWjttgiU/rPdc7Jop0JNo+fIN6ydE69O9WYIv3b5qUvop14T
         +r8jPkGXQYO1AxXCobtZVJUWpIpNub4sH5wWyVBDCnIjRO2JXHbAhBun0xHZIZ9w/nLO
         ULEGO/eGjadHIhU9YcpfJM8CoEAFpHsSm6s234Vf6BjgKHd+njPYtV19JNDcqQVEqIJt
         FZ/ncjRsrFESvvw3+at0WvsFY43pd90jMdIdR7aGvc5GW5fE+4xKRB4Ky36DCgaMo/ac
         YMRQ==
X-Gm-Message-State: APjAAAUoOLlU3HnwBlmiSfxCHFBXPHSewqGe1qys4Cv/ul87u4z3Z9Cq
        Cok5NWFNBs1XjABzoURixsPFvpqvCdOYs198hhzWig==
X-Google-Smtp-Source: APXvYqyUv4njfTztLWuTYouFJHkECKq+fXZxeFHpI4KhokX8BPbPnioEMqwOxONQdEfZDKlADcF9YE7PEnlncumSd5g=
X-Received: by 2002:a19:ed11:: with SMTP id y17mr1700886lfy.141.1564997172789;
 Mon, 05 Aug 2019 02:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190721125259.13990-1-hm@bitlabs.co.za> <61045f29-73ca-cb62-ba6f-5b12970735a9@electromag.com.au>
 <20190722045154.rp2sqr2mxdmfn5qj@manjaro-1>
In-Reply-To: <20190722045154.rp2sqr2mxdmfn5qj@manjaro-1>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 11:26:01 +0200
Message-ID: <CACRpkdYO2r0EuCY6EOt=Px-O6J9Hxzu_LqbXziXk7axea1o+Jg@mail.gmail.com>
Subject: Re: [PATCH 1/2] [PATCH] gpio: Replace usage of bare 'unsigned' with
 'unsigned int'
To:     Hennie Muller <hm@bitlabs.co.za>
Cc:     Phil Reid <preid@electromag.com.au>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 6:52 AM Hennie Muller <hm@bitlabs.co.za> wrote:
> On Mon, Jul 22, 2019 at 10:05:00AM +0800, Phil Reid wrote:

> > I've encountered these checkpatch warnings as well.
> >
> > However 'struct gpio_chip' callbacks define the function signatures
> > as 'unsigned', not 'unsigned int'. So I've also left them as is, to explicitly
> > match the struct definition.
> >
> > Be interested to know what the official take on this is.
> In hindsight, I saw most of the other gpio drivers follow the same
> convention as the viperboard driver. which means
> a) my changes add no value and just creates inconsistency.
> or
> b) there's an opportunity to fix up the rest of the gpio drivers as
> well? Which I'll be happy to do.

I think it is fine to fix this in drivers and we can fix the prototypes
as well.

Yours,
Linus Walleij

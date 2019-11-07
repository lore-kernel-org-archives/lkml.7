Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9743AC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA922077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8Gr3BoV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKGIPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:15:37 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35079 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:15:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id y6so892173lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddu1jpN900ZYw8O2527aC0Qt1kxo8E2DHWggSrL8BkA=;
        b=s8Gr3BoVtXMT/Fb7k5L9tJbyp3KDE6/8ODrdgh3PTNxUoQ6QzlDAs7mYfYdFczW2ZP
         sQiWPKaG06EXfzjFEZn/G0pwSp7ve/HNU0PGv8P5Ht4J/rf5ifK4t63LWYsPDpoPHNev
         avrBqsDGp7wCgogRfGQIIOkRWyu/4n+uAtqpKZs0SEY/b1CK6fwbCkc7FBm5ZUGbW43E
         4jfT0vcH/CV3bLDszK1HNowBQSk1ZLX1e2HdmpNXNpBnFtL/wIQSUviM73revyjNLo3C
         voE42LyLYSaXAwDlX65a+1P/M0rCIGlFc/al1Wat71fu+ecCuqVtmITd9aEIRJWkrU1K
         9FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddu1jpN900ZYw8O2527aC0Qt1kxo8E2DHWggSrL8BkA=;
        b=GVfEKdm1TrFddxeCte/h174NMI+OnF89wGMSNt0eS93B8QERXyovsGPkyeGfKYUAH2
         FDCM4r84o8RsQvKkJeqBZbSnegmIF3TVruOiR6TR90VdkA+GSNYDND3/QKMWouKM8/b2
         hGxbjWlhJq94g5Kd/kd6MJF/Ov5U4qikMkN16Zhi1Sc0/Z6WWF7sQ3hgD57pTmkeTVRQ
         12NdsxFPtmyVVeNQWOxmfQEbXnCapKoD5q3en2p4jSbrOr/ULL+XaF7Dxtb02A96/ST1
         eZi7KCHjav7VfmxsZ2f/WjaUk/H+FftIMWQ+S7f/Ea8bD0w1t2iGD/v19uUua6xFTMGZ
         2/iw==
X-Gm-Message-State: APjAAAUllZTIMkBbY/u8XdaoVlLksAevxnm/nqoaU8/5eVAsUrwXixny
        uGZXUhCKeoGtCToFjYmdHBdG080i6Q8Mhm7A6VnvZw==
X-Google-Smtp-Source: APXvYqww5bQPnZN3NrQQtclGOU1WQ8bslsEpjPP5aLvQl+V5ZxWWIobqARd/TgCXuy71plqbep1x1/xXRUOzWfZqWQk=
X-Received: by 2002:a19:855:: with SMTP id 82mr1443368lfi.44.1573114533151;
 Thu, 07 Nov 2019 00:15:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572945605.git.matti.vaittinen@fi.rohmeurope.com>
 <d25edcc3a5d912be9d7c3a927bad6baf34a1331e.1572945605.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdav+Sz04WE6N5KkKMQLOtx2BZrjWrEin06yPZQ31a47hg@mail.gmail.com> <d1d33dee96a4dea71a14dfdb6d590beade529c2c.camel@fi.rohmeurope.com>
In-Reply-To: <d1d33dee96a4dea71a14dfdb6d590beade529c2c.camel@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 09:15:21 +0100
Message-ID: <CACRpkdaFzW5BGgK=p8MANJn23VC5X2oBh4oYhZJOOBPT2aJmSQ@mail.gmail.com>
Subject: Re: [PATCH 02/62] gpio: gpio-104-dio-48e: Use new GPIO_LINE_DIRECTION
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 7:58 AM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:
> On Tue, 2019-11-05 at 16:23 +0100, Linus Walleij wrote:

> > Oh the patch bomb already dropped, hehe.
>
> I was slightly impatient ^_^;

No big deal.

> > Anyways I want one
> > big patch to apply. Please make sure it applies on the GPIO tree's
> > "devel" branch.
>
> Right. I guess I can do that.

Thanks!

> > Collect any ACKs and drop most from the CC else the driver
> > maintainers may get annoyed.
>
> My problem is that I don't know who are the driver maintainers I should
> keep and who I should drop. I don't usually know who are interested in
> which changes.

The process is not perfect, just some best effort is fine, as subsystem
maintainer I do merge mechanical patches like this across all drivers
without consent of every possible stakeholder, it's impossible to
involve everyone.

Yours,
Linus Walleij

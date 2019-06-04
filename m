Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E53BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37FD24A4D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHwD7GKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfFDJdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:33:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43633 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfFDJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:33:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so5403983ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRCxsdtOibuHWniTvRjkJuYuUvyqKwna7YBc0m5IVcc=;
        b=UHwD7GKHxC3C5X5dgPpu/iqjCdsjNVRqtDVIZyaKoba6XS4suf7QIjYuluxqRmsabz
         /na8yIjIbRR2VvAEiYtFN4sFn2ubGUcjRtDDs6b44BFKKv89nR86UO2jGy52hnPvfx46
         4oVE59EdezY5g7xj2cuElXA0cXOdc0U1RSgws5SO6hKWeHFnhl4IlWzvnRokLndGSJ4k
         NWW+1Bn/BReSoBJcimTTt5B0bJ4a6DfEBAcMaJgJFwLOb8BnoUq+c0EJKkGLdxiCGm9y
         MkjmrHA1bXauhHh4cdgwY30/0XNzTZLLILPyPoGvN6NW67TjMLDAHmxJp9A0E7iZN4R+
         Hz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRCxsdtOibuHWniTvRjkJuYuUvyqKwna7YBc0m5IVcc=;
        b=i9UE2Jp3nWwgj4DdbJs5D5kyxs8Abo2qRpAni2mebkoqdR4ai615EKPqoIe3OUFAu1
         iy44ZGQJydQWJpOYfQA0EiD3WkC2nZA16MgbOpYP9/9CffYxGixB4f4SiBc2uczYpyaR
         7i58ncyTBSP9E4zWUeJATrzXIAabpcY+7NEweIlTlBALCKJKFJwSXBtdWKPp5+t1Qt4F
         d+2Cx/dcxOSw/Z5kpkbF1PPFA6d6ZQkdYfa3Irnpz/VqJENtQxboQcZGDdgf8cvDlvSo
         WAiiM75to1XvmEYdxEuJr4SjIQa+eqwHMIVHYc8R1SELEDfUfBLQbFTxjARVn7YG9e7q
         qUhg==
X-Gm-Message-State: APjAAAWwIo88FFu9KJQvIovKicysh5XL5Belr0z7eeYJoL9tCP7D/8Qe
        YCszAniyzLjJHrtW+IQfUtYUQbNtnpFtEnM4Zlc=
X-Google-Smtp-Source: APXvYqyrP8pdeVtz07P1IH9BWhta46YZkJ5Sm9D06iqPl5VqTf3sKI7zXgP9mwg/IgoNozHT4gWj90zU9nhRoUdXHKI=
X-Received: by 2002:a2e:9255:: with SMTP id v21mr9392465ljg.178.1559640803528;
 Tue, 04 Jun 2019 02:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190603174735.21002-1-codekipper@gmail.com> <20190603174735.21002-5-codekipper@gmail.com>
 <20190604074632.tby6r57vjehb4jne@flea>
In-Reply-To: <20190604074632.tby6r57vjehb4jne@flea>
From:   Code Kipper <codekipper@gmail.com>
Date:   Tue, 4 Jun 2019 11:33:12 +0200
Message-ID: <CAEKpxBmP6UJkfzqP-AkW5sDzRcb6W9J6vM7C6DAqYVvpEKfxcQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] ASoC: sun4i-i2s: Reduce quirks for sun8i-h3
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019 at 09:46, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Jun 03, 2019 at 07:47:30PM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > We have a number of flags used to identify the functionality
> > of the IP block found on the sun8i-h3 and later devices. As it
> > is only neccessary to identify this new block then replace
> > these flags with just one.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>
> This carries exactly the same meaning than the compatible, so this is
> entirely redundant.
>
> The more I think of it, the more I fell like we should have function
> pointers instead, and have hooks to deal with these kind of things.
>
> I've been working a lot on that driver recently, and there's some many
> parameters and regmap_fields that it becomes pretty hard to work on.
Hi Maxime,
let's sync with what you're doing as you're more lightly to see it
through to delivery!
I was trying to clean up the driver as some of this seemed a bit unnecessary,
hooks sounds like the way forward,
CK
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

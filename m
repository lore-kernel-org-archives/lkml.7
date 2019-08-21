Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A67C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7E1206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SqW7TKKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfHUVOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:14:41 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43293 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbfHUVOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:14:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so3425442otp.10;
        Wed, 21 Aug 2019 14:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/CYOAn9G51LhCL1PhYQHp67jOIFH7vLUlRMO7QJaME=;
        b=SqW7TKKnloEFxez2Iyvmd4w/a7Y1adWbSx7RV30lZ9QtnzxIFk3zddDYToTa9D3rn1
         YHZ7Fb8elG41k+TyBbQzC5uWRRAqsgILS3hVLeUoBKBODAiNYKUg2e1m7EfArGWALEYT
         OcD6LO1lQeVN0mEbUzHVL5czM/P4FtAyA0tLc2nsUh2gn6hLvFEr2atcwT/7fKrzgMOb
         t1dsEoHmzZ3VTlShRNIuYy5nPJjBn+vhxAEXAji8AtjdLQKICBNvQRKdZ2fA47cShxJb
         fKFBmzmirV14n8BFUjYH4PNzXRcnaY3sO9BOzlEBXpP6sMkf8zZ8OYQIatbpBxrpVj47
         IJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/CYOAn9G51LhCL1PhYQHp67jOIFH7vLUlRMO7QJaME=;
        b=NRKDoDNxj+un5xv6CTZGpWRibsMfC4x0/0pgWQSepQijth51IfDZktaxPgC2i8c4Eq
         uvtQa2DZU4/ii1onzCqTeQ1PoSPOy46YaxFEgQ+pM8iwTcWfOgX4Iq15hp/koykRgsiX
         iK/1/GSq3qNQcALguzf/JIYl5t2Xn6txlL+GlVCFlI8eRQEVCTvLbYG1xwVmJEIpvSj9
         +OCEplchLpiu6fDTt6f+NLsG2ukzpq+hGJ2hoUGmUEysrVmt+mMzm06+F++EZzsQA1ov
         Xh1N9h+XIC8GRYvjhvMnC/5IOqgUevDHeyETjrQzCTpt8icMpkfPuc3XdsQAkoYs+rjD
         28Fw==
X-Gm-Message-State: APjAAAWyCiJNqVpKCRLSEyDYj+EWdct5wff1ytDCkwNqm9rKs22GGscD
        GuehXHu0kAqvHUi9s9BYAOK/FV352XjBnLqnf8w=
X-Google-Smtp-Source: APXvYqyxg0+N2/pLhRdumFyevmwn3wQ++3ZOwx454FFxlyPdkbDOBklS4drA2Ee7P2E9hixQzAAgdoM0Yupd614a3TE=
X-Received: by 2002:a9d:6c0e:: with SMTP id f14mr26763602otq.6.1566422079559;
 Wed, 21 Aug 2019 14:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com>
 <20190814142918.11636-12-narmstrong@baylibre.com> <CAFBinCBWFNJNAWdeZ2LfEJA-MVpSf-A5SrLZEx+0z_P+-iBFDg@mail.gmail.com>
 <c2d78c7c-d9a8-e486-d3b1-c1447e24284b@baylibre.com>
In-Reply-To: <c2d78c7c-d9a8-e486-d3b1-c1447e24284b@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 21 Aug 2019 23:14:28 +0200
Message-ID: <CAFBinCA13xJHRmTrOHxSkoy2rMv3=+BBwZsLBmZn=cQ0pyE_Aw@mail.gmail.com>
Subject: Re: [PATCH 11/14] arm64: dts: meson-g12a-x96-max: fix compatible
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 4:08 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 20/08/2019 22:32, Martin Blumenstingl wrote:
> > On Wed, Aug 14, 2019 at 4:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> This fixes the following DT schemas check errors:
> >> meson-g12a-x96-max.dt.yaml: /: compatible: ['amediatech,x96-max', 'amlogic,u200', 'amlogic,g12a'] is not valid under any of the given schemas
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >
> > [...]
> >> -       compatible = "amediatech,x96-max", "amlogic,u200", "amlogic,g12a";
> >> +       compatible = "amediatech,x96-max", "amlogic,g12a";
> > only partially related: I wonder if we should add a s905x2 compatible
> > string here and to the .dts filename (just like we separate the GXL
> > variants s905x, s905d, s905w, ...)
> >
>
> We could, but AFAIK no variants of G12A are planned yet...
we already support two variants: S905X2 and S905D2 (I'm assuming that
these are similar to S905X and S905D meaning both are almost
identical)
but I guess we can stay with what we have until there's a reason to
have separate compatible strings (for example if we discover that
there is a difference that matters - like the OPP table on S922X vs
A311D)

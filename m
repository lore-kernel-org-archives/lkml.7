Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0A7C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28E920656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="s1NMDq9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgAGJb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:31:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34656 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgAGJb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:31:58 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so42466927qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FHSr1IYP6sHrnY75lBxGflLY4NIZIBc6Izm2kKVNa1E=;
        b=s1NMDq9/sBrmA5XoPocAi78NArZo9kNNswJunowCk2YHw7EZeh5mcuiJsdOUmT9dQ9
         zdxvvuLWbBaXFnUjhtCJaoowFYzNm24hnlXcLDPpFk+bp7M8K7aVIvNyMBmZcbCd5Jwa
         Qca0XIrWeeSWpoZbTEIkBbrx+36kVsDEBPwz066sTFsU7DAzAxdOOVsucbBtCvUOPYn4
         8yGu6Jaz+pdyxk3zBicmw8bKsQ1c+bYEkuyCDf4v9wyCLliimHSBuFvBvVHhCytSU0yu
         Rw+ggJEMZDX7Li5zFP5eDDI70qlIk+2MhudI1L2CE968YPlvrEZanauHkhEpTHRpn5XS
         qlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FHSr1IYP6sHrnY75lBxGflLY4NIZIBc6Izm2kKVNa1E=;
        b=ZE8QWRc7bpJMr9pZdDnMCCOfwccbiTT6HxVW39Gzpe5FnMoMcJJ0kHBAVab3Vs2e4j
         ye7tw/3Emp6fkqrNvJcUysWm08NXZV9Q8Uv3NGWkHHxBFlmGdqxxPNmIAMiUn7TL9MoV
         0MnHDTWfQ4KJtRpb3YHTpRh81X5KXsuds/f3JoF1xEZdetL0ZAZah6DHE1qHAwOq4X/0
         i2NGWXFXWLJve2VvWkTmJ18eCqDt/UTiTSAWzfaTQrKBiZAdLVatVVdYfEAYsc5Np8Zf
         fMmeUem8BWcer4X2KEtEzCds5S3FrUeDTXVIBTK/hmU0XV8FEM7TKNXdJ6REYwLqIs8Z
         Hq9w==
X-Gm-Message-State: APjAAAWqb5S+3TTjPg6UW8gPpz86GYfQ8eVQtFNwecXn5abpSyH+tkC/
        aq3ssv3jAz9NVOSWLysEIzZq9L13DI3eLZrA0n0pfw==
X-Google-Smtp-Source: APXvYqyzh/t07P9vyliAzsEnQQ0oKUIkV6IpBTsB8uwurKy6zHOgxpt9G9ywFzEef2V/hnj16hQ6sDb/IrlD+O/aKE8=
X-Received: by 2002:a37:6fc4:: with SMTP id k187mr74675027qkc.21.1578389517217;
 Tue, 07 Jan 2020 01:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20191215183047.9414-1-digetx@gmail.com> <CACRpkdYAKS50-CNmE0nRNQanFxKejoHrwxho3fZXROoLZUb4+Q@mail.gmail.com>
 <CAMpxmJVi1hy6a72M7rAHP0AXW1Z4cGp8H0O6ayLMwFm9UL3WPQ@mail.gmail.com> <CACRpkdaNAzpDu6uxETnuDGxnXTJTh0LhcE=9DL9-Kwi4butZLA@mail.gmail.com>
In-Reply-To: <CACRpkdaNAzpDu6uxETnuDGxnXTJTh0LhcE=9DL9-Kwi4butZLA@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 7 Jan 2020 10:31:46 +0100
Message-ID: <CAMpxmJXbR8=esuKhMKzD8LGFC6_Rz4uQXJ2egCXGLj_eauxS5g@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Tegra GPIO: Minor code clean up
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 7 sty 2020 o 10:29 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Tue, Jan 7, 2020 at 9:25 AM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
>
> > pon., 6 sty 2020 o 23:59 Linus Walleij <linus.walleij@linaro.org> napis=
a=C5=82(a):
> > > On Sun, Dec 15, 2019 at 7:31 PM Dmitry Osipenko <digetx@gmail.com> wr=
ote:
> > >
> > > > I was investigating why CPU hangs during of GPIO driver suspend and=
 in
> > > > the end it turned out that it is a Broadcom WiFi driver problem bec=
ause
> > > > it keeps OOB wake-interrupt enabled while WLAN interface is DOWN an=
d this
> > > > may cause a bit weird CPU hang on writing to INT_ENB register durin=
g of
> > > > GPIO driver suspend. Meanwhile I also noticed that a few things cou=
ld be
> > > > improved in the driver, that's what this small series addresses.
> > > >
> > > > Dmitry Osipenko (3):
> > > >   gpio: tegra: Use generic readl_relaxed/writel_relaxed accessors
> > > >   gpio: tegra: Properly handle irq_set_irq_wake() error
> > > >   gpio: tegra: Use NOIRQ phase for suspend/resume
> > >
> > > All three patches applied with Thierry's review/test tag.
> > >
> > > Yours,
> > > Linus Walleij
> >
> > Ugh, I now noticed I responded to Thierry only after applying this to m=
y tree.
> >
> > Anyway, it shouldn't be a problem. I'll take more care next time.
>
> OK shall I drop the patches from my tree then? No big deal.
>

If you're fine with this, sure!

Thanks a lot,
Bart

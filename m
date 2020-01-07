Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303E4C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0019820656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VawLg59+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgAGJ33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:29:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44341 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbgAGJ33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:29:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id u71so53939772lje.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QC9ax52njxZvfMScI+pYnjQCr3iWMenb27w408KKrvk=;
        b=VawLg59+alC4Ja6gv1Z3uCiXgCNzcJLJpvipMvn2OVSXu2KNmIuRsXFGua6ptiTh/w
         qSdYqTAEKZo8pIoRpmX2NKPkmOiPtuJawUbLF9dkcNAKwiAZNSrf1VzxsQc9sGovj5Bi
         3XZ36wmH4gl0oK+E1maUaLZbgFYEe8PsbKukmE/0L5HHkkesnEjA+o0yjHGchS/VsaRZ
         5zehEYxQiEh/uAlwFmemlszl/W8fqp1SkB26V0BPLy3tHmWzZJpFiLAAg84dfiE6XTsX
         haZ+flyh7QGPii5Bbp99VziRU3hhv8ZWxX/jC1QYphoMccZEVmGXxtRsuIb7N4KZr9Ey
         Z6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QC9ax52njxZvfMScI+pYnjQCr3iWMenb27w408KKrvk=;
        b=i8br9+dglTUugf2KlyuD6Q7274IpxeSQqgrixaKgfHOfe5MOcvQDStf8tGgJ28df2N
         oAxMETrP9m5Z7RYSbgUQU45vQfvNWryEY0PqdzPv1ovyH0hMOsqcr6GGWxr17iq5/QF0
         w/VDjLHR17ZcdN3fm9enoRAVmznVADbjpQLIaWCFxagDEcrYKIjKDjX4MFZOQcACrxfH
         XEwTDruS233i4D0edexxFPKn97czVnISSa506DaV/0y91oM5HvFDo4XYmOf/EVnfm6Xu
         JsHpE6IInHhDQ7F2/99f2tfKmFh89b5s6bfCx8ifUSXVKBU21Sfwr6GszhGMk3fr25U3
         vXCA==
X-Gm-Message-State: APjAAAWrkR0QZivth7VWIWhKYvrs5wjtPcKPg+O+RIxy1C5A0qUolPLU
        1+vknNDG6RrWMf0MqVKU3YV8aXU3U14dv0fhg82sxg==
X-Google-Smtp-Source: APXvYqwwJvG6nEjsJq9xGfjG/kmOi0JGnHLKITQfD4l4UDDPnalI+bHc11y+yVlnnuEjiIhEiQoZl0ssMyyQlW0D+js=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr63371948ljh.183.1578389366818;
 Tue, 07 Jan 2020 01:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20191215183047.9414-1-digetx@gmail.com> <CACRpkdYAKS50-CNmE0nRNQanFxKejoHrwxho3fZXROoLZUb4+Q@mail.gmail.com>
 <CAMpxmJVi1hy6a72M7rAHP0AXW1Z4cGp8H0O6ayLMwFm9UL3WPQ@mail.gmail.com>
In-Reply-To: <CAMpxmJVi1hy6a72M7rAHP0AXW1Z4cGp8H0O6ayLMwFm9UL3WPQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 10:29:15 +0100
Message-ID: <CACRpkdaNAzpDu6uxETnuDGxnXTJTh0LhcE=9DL9-Kwi4butZLA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Tegra GPIO: Minor code clean up
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

On Tue, Jan 7, 2020 at 9:25 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> pon., 6 sty 2020 o 23:59 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
> > On Sun, Dec 15, 2019 at 7:31 PM Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >
> > > I was investigating why CPU hangs during of GPIO driver suspend and i=
n
> > > the end it turned out that it is a Broadcom WiFi driver problem becau=
se
> > > it keeps OOB wake-interrupt enabled while WLAN interface is DOWN and =
this
> > > may cause a bit weird CPU hang on writing to INT_ENB register during =
of
> > > GPIO driver suspend. Meanwhile I also noticed that a few things could=
 be
> > > improved in the driver, that's what this small series addresses.
> > >
> > > Dmitry Osipenko (3):
> > >   gpio: tegra: Use generic readl_relaxed/writel_relaxed accessors
> > >   gpio: tegra: Properly handle irq_set_irq_wake() error
> > >   gpio: tegra: Use NOIRQ phase for suspend/resume
> >
> > All three patches applied with Thierry's review/test tag.
> >
> > Yours,
> > Linus Walleij
>
> Ugh, I now noticed I responded to Thierry only after applying this to my =
tree.
>
> Anyway, it shouldn't be a problem. I'll take more care next time.

OK shall I drop the patches from my tree then? No big deal.

Thanks,
Linus Walleij

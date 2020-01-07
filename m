Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3996C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7152207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bzrYxlco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbgAGIZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:25:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45587 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgAGIZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:25:59 -0500
Received: by mail-qt1-f194.google.com with SMTP id l12so44653657qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 00:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P1qNd7psLj1vN7YrSNjPLisR1SYB4sdk/yxx7a4dqv0=;
        b=bzrYxlco4uNeu7RE3s8e2uVp04X/ylErL+05vS7qIpO+v/86iOTebSWfPL5kFVs1ee
         vQlUC/RCwSEJjK/JplOZO0A1p5YdUhdaUBPkIhp6gWYMNeosBUUwPH+/Uch6kg19MaeN
         mqHSzPq1GskwNO05/rUG2U+JMl2Y9BrePYB+scQSMkzxn9cjXxvsSEUwPFMFzFbw5QEz
         L3UFTxDcGYy6VZkM5z+aWtlCpDKj2o95XuLrHr8mJu5Q1RGEnFSlQv2Buz3+x8z4A1Wl
         0C8JA879OWzxmHzfBCefMKAyftykJuQYapTgBDT2/VtRyGBBdLuy+EgGLy+/CX5vle8o
         USDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P1qNd7psLj1vN7YrSNjPLisR1SYB4sdk/yxx7a4dqv0=;
        b=sAWOGngMYy7UzrMcpKE4Tpz8noHwmhxfitg6wLdqTzZW8cz6yaIfKiQVW6JAqiEJIq
         VsSE2g/UIbIsiHScnkzARr8M8D55q+FDqTDV09pWv4CDhRDMLmdF3qUJZfsNQRYbwk89
         RW41d39Uneqz2rVYLgjUsPeDwx5wQ3NfHr8cG3NyJrNDIqByWhq8xgF4IaMyxtnNCEVP
         N1CsiDFsEYjLQQd3hcBSpoSkhLrUzKYKFYADXcDezwz/Ipdg1JaFWucYbaGYCA7MywXq
         tKEiZv3TCkWHMKiOTrWTmutUuxkU7+/as3rPoRgPgJRXKbEiDhrVqOMnrO57lquEvQU/
         HkFw==
X-Gm-Message-State: APjAAAVMEdZn3c2eJXZSGOffU+KEDNnkEaRfYBw1kP7eVIv0NOhI/Jqt
        MehBt244ghlVJNOcB26kOpcga3fzJo3WHI4RV8GyRQ==
X-Google-Smtp-Source: APXvYqzjhkSvCozGISHl98iBSuMlg0RKAZKkYeLKPjudgFxA5+wsaLdBqZ41PxHunEVSDcVUly1rZyC2ez3w7BJow5U=
X-Received: by 2002:ac8:6784:: with SMTP id b4mr75846060qtp.27.1578385558120;
 Tue, 07 Jan 2020 00:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20191215183047.9414-1-digetx@gmail.com> <CACRpkdYAKS50-CNmE0nRNQanFxKejoHrwxho3fZXROoLZUb4+Q@mail.gmail.com>
In-Reply-To: <CACRpkdYAKS50-CNmE0nRNQanFxKejoHrwxho3fZXROoLZUb4+Q@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 7 Jan 2020 09:25:47 +0100
Message-ID: <CAMpxmJVi1hy6a72M7rAHP0AXW1Z4cGp8H0O6ayLMwFm9UL3WPQ@mail.gmail.com>
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

pon., 6 sty 2020 o 23:59 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Sun, Dec 15, 2019 at 7:31 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> > I was investigating why CPU hangs during of GPIO driver suspend and in
> > the end it turned out that it is a Broadcom WiFi driver problem because
> > it keeps OOB wake-interrupt enabled while WLAN interface is DOWN and th=
is
> > may cause a bit weird CPU hang on writing to INT_ENB register during of
> > GPIO driver suspend. Meanwhile I also noticed that a few things could b=
e
> > improved in the driver, that's what this small series addresses.
> >
> > Dmitry Osipenko (3):
> >   gpio: tegra: Use generic readl_relaxed/writel_relaxed accessors
> >   gpio: tegra: Properly handle irq_set_irq_wake() error
> >   gpio: tegra: Use NOIRQ phase for suspend/resume
>
> All three patches applied with Thierry's review/test tag.
>
> Yours,
> Linus Walleij

Ugh, I now noticed I responded to Thierry only after applying this to my tr=
ee.

Anyway, it shouldn't be a problem. I'll take more care next time.

Bart

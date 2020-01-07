Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE4CC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B8E207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBgA2Em6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgAGMic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:38:32 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43520 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgAGMic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:38:32 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so38758734lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 04:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xNdg/eGe2spHZF8Ar7NLXHqFtzVzxyf+teERuO/bVjc=;
        b=IBgA2Em6iQG71nytT7MVKkAkSpchm34hogp9nrPDVFD2uq6bE3RLvT5EC2lmzO6J6c
         Dbg1dYo4ATLwVPgn2RytyJdEgTF84i4p/VdfrHVBASGlIo/MAWHtdDIDJErP4DFAXMh3
         aN4WgMRJ1rLGHzDYNjfegkvyLIlgRMuRRr2IftbxWokVUQTvks65sqQ/2lcGa1brrus0
         50pN1du3FO+emJhqwhHyfYqrCvhVETASPAVhymc1hEnaXzq3JRmoVXDN00dq1VCT5laB
         Q+0jWOsP1P9M4W9EabnTv4RrlSWAniEilZ7hgrBtP5rtkEooAK4qRb4b+dGg2y2mIqYi
         dXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xNdg/eGe2spHZF8Ar7NLXHqFtzVzxyf+teERuO/bVjc=;
        b=Ir0wLTNu1ZaV9BhvhX8mOBxgPBd+jhPEf9Wt+czY6VFT9gTLid9BSSpR51EDJrAZY4
         kifs4wXp3qWvDo6T9maKiB2cqrSm7AKYn//TQ8/yttDyySLhyF8UodqtFjO8B0W8hJb1
         bd1ZzWIrWeZa8J/SysQdaqs8NTRCz+22tmsttccGDMV38zNlHK9Q0ySn6POwipb29lIA
         q4i+pgdbgAuI1RP8+86Lrq8TZHrSeXaLMKh0+Lh1w70nMWdBQOAEA2I9hgZj90doOzZ8
         RXD+sF4ifeIqAgGITs2M4HZ11q39HvYLRAx4V+Y92UHWDfXxiMPpDhXFKx8211gPJNVk
         0LkA==
X-Gm-Message-State: APjAAAUT+c1eFgr3e6P57XosVuJrYBvEyLW2Lt9kxcDzKkI3fSDRVCjt
        T0nNq2lgXfp8tiyPPvDIheBJIXAzMBjwZ6BjgzCMzA==
X-Google-Smtp-Source: APXvYqyjy7HCbuFJZMBW/ujChvDuspmEEyJbLXUF8TFZisyKZFmn1M7N7wpY7pWWtfq9hM2MIuNebIt0EKDUy/5fjNI=
X-Received: by 2002:a19:8a41:: with SMTP id m62mr59247202lfd.5.1578400710421;
 Tue, 07 Jan 2020 04:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20191215183047.9414-1-digetx@gmail.com> <CACRpkdYAKS50-CNmE0nRNQanFxKejoHrwxho3fZXROoLZUb4+Q@mail.gmail.com>
 <CAMpxmJVi1hy6a72M7rAHP0AXW1Z4cGp8H0O6ayLMwFm9UL3WPQ@mail.gmail.com>
 <CACRpkdaNAzpDu6uxETnuDGxnXTJTh0LhcE=9DL9-Kwi4butZLA@mail.gmail.com> <CAMpxmJXbR8=esuKhMKzD8LGFC6_Rz4uQXJ2egCXGLj_eauxS5g@mail.gmail.com>
In-Reply-To: <CAMpxmJXbR8=esuKhMKzD8LGFC6_Rz4uQXJ2egCXGLj_eauxS5g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 13:38:19 +0100
Message-ID: <CACRpkdZZc2z9_9tjwOEYCuv1fzrqJ7Eb5UK-T9GA+6BqBYe_LQ@mail.gmail.com>
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

On Tue, Jan 7, 2020 at 10:31 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> wt., 7 sty 2020 o 10:29 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):

> > > Ugh, I now noticed I responded to Thierry only after applying this to=
 my tree.
> > >
> > > Anyway, it shouldn't be a problem. I'll take more care next time.
> >
> > OK shall I drop the patches from my tree then? No big deal.
> >
>
> If you're fine with this, sure!

OK dropped them, hadn't even pushed the branch out yet.

Soon reaching the top of my mailbox so I will be pushing the branches
for the autobuilders and later tonight for-next.

Yours,
Linus Walleij

Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE35C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93E821743
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8nkOPU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbfGPVqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:46:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44737 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbfGPVqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:46:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so21474457ljc.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/RAqXRe608t4DMx9FGyKisTh63SKLqBM/Ij+WPbCgPM=;
        b=w8nkOPU+3uflSrcrXxVEWNs9uhGpDdd+Rzxjc1vZSogoQypeYtVZZXnBAYPYoeQwTk
         QXylYhCAuTzEveN/SdH0E3tjYsDhtyjvhezP1JjINApaDK6H0Yi17N6btnci60KnTRnv
         7RX4plxLZk2v0cncumOcFIrmpLUqJn+4F8v0K3eEGHefnLHMrFASyUd0UGVcTzNozd1a
         vcogndbzJPjwP1MTJvTWUTAO9gkwTq5N8Sr2X2Fi2XFAPKEg6agIcorsdZPHxNFgGWgf
         7HdIu/jAzowkZHNUKuzdFQlzwV3SabCls6H1gs85AuaxjcVSAOo1qHdsEH//0kKtxz1k
         8vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/RAqXRe608t4DMx9FGyKisTh63SKLqBM/Ij+WPbCgPM=;
        b=GzSJzRBuHRsxAYyU5vb939GAdR9bWt4mhgpn9CN7bRjnhFu5Sx8Bls4BoUIJytKNVR
         e2SV00CVC012WCfcEy7+LqUnceHcFQDwuSV7Ldwz3+drd+S9RdRIHPA1yKvfu/24jw+U
         2RyjcF5et0XY3y8axBspv6oeCogCyZIsUCWv7YGUCWdT97MzZP7nQkH+L+mEqquhnS1h
         YPzgRRss6c3eo0f/ek75cclb96+5RxV1OCERtKb7Tt8pwhlh5l7NHLN0TeGx72YM2vye
         WPI/WfWafAR/olhCdgHOvvsHQUOMrHv6kmmNIPZZCl2Xr7Jw2ajRV0T6Dd+6ooFffE5j
         DNTQ==
X-Gm-Message-State: APjAAAVuqEoI9UGTvFDcBeSgJfd+NAphAIvNlC8XVrFd6/tjM2UoWQOF
        1roqOvjua9vxl85GAJ0ISHEXnqTOMoynwIAnXw8YLw==
X-Google-Smtp-Source: APXvYqw1LRlGMkwD0Zj/mXq1MDJT8exL4YfTyq/7bILPPJJo6uRhVajc9X7deRiYqmtGZGr6TgE+sPe18oyUING8rnc=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr18018479ljg.62.1563313593593;
 Tue, 16 Jul 2019 14:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190708082343.30726-1-brgl@bgdev.pl> <CACRpkdb5xKHZja0mkd-wZJ+YHZpGJaDrkA0dv60MNYKXFcPK4w@mail.gmail.com>
 <CAMRc=MfB9R70QDqtjG5a5Roq1roeL78Ss5noytrY-7P=tY1OHA@mail.gmail.com>
In-Reply-To: <CAMRc=MfB9R70QDqtjG5a5Roq1roeL78Ss5noytrY-7P=tY1OHA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Jul 2019 23:46:22 +0200
Message-ID: <CACRpkdaiZgK1EoaUxDtbm_GJHVjZU56e_qBQ-OF0mmwb5W8+tg@mail.gmail.com>
Subject: Re: [PATCH] gpio: don't WARN() on NULL descs if gpiolib is disabled
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Claus H . Stovgaard" <cst@phaseone.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 4:20 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> wt., 9 lip 2019 o 15:30 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):

> > I was thinking something like this in the stubs:
> >
> > gpiod_get[_index]() {
> >     return POISON;
> > }
> >
> > gpiod_get[_index]_optional() {
> >    return NULL;
> > }
>
> This is already being done.

Ah it is.

> > This way all gpiod_get() and optional calls are properly
> > handled and the semantic that only _optional calls
> > can return NULL is preserved. (Your patch would
> > violate this.)
> >
>
> Maybe I'm missing something, but I don't quite see how my patch
> violates this behavior. :(

I missed that we actually do pass a poison from the strict
*get functions, mea culpa.

Let's apply this, will you send me a pull request or shall I
just try to apply it?

Yours,
Linus Walleij

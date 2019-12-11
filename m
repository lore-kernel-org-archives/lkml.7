Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8F4C2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C55B206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzWEDMV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfLKAkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:40:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37139 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfLKAkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:40:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id u17so21970944lja.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 16:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+6mwPhn94U0FJCp8N/iLCGyoYPPPkFesQi/ZLGlNabg=;
        b=DzWEDMV6zFCN5CPxuB98wPU/lUNXV9fCtKG8vCaJDjqrBnuzhjUaeFZ1+la3wXQNbZ
         8/1piJtHwCYSk/iJH2vOcrQprWHzccO/cVI8fc6j9HT3nMHYJPMp50W2ZbayjxlZafpm
         OEJRafmYkmHflbQUtOlcyMahRvYz91/Hf3goXN6Zz+WIFvhQesbfOgF9knBF8WlES3+4
         fSxUmiSMjXRfs+mEUZbI+ocT2kGtWBHBQ/Q7pfc/glkE9HXO7uVV1HvthjvSH71AzryA
         0t0LBbJSLwDUNu6noDycU/vAunTwuYiBsh7EDK/8nri5y9zn1jgRN8DduJjuRD3zSQA6
         fmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+6mwPhn94U0FJCp8N/iLCGyoYPPPkFesQi/ZLGlNabg=;
        b=sJlw3QutarhsxVIpDcf3WxEISgZg+4Y2JQ73phwx3ZoztY3MOssJNQ5HkOeC4dUE8c
         MfNdvLGl9fhQHmplaLWxsT0DF9aEtjQY9GOgkcCKfq722kenitpf6ooa3fzI2zzKD1vK
         cEeYuA4EEHMqLijDoYAS/bDbZ/M6K682meWaR0w51/T3FY3dmQiQdf5Dq2eNEZHmkNBv
         iW45/mRULz/vOnNrc9KhrLViyxHl0v+GPq8R6sJvDpk8UN6xws35Ps3fLPQYd42m1+pN
         dg7S9hDyDam7Az/g3r7a3rWFDFe+gGnp1MG5nfYW/S2zpCqc9Bqu5vDr+WpkwhfQ+9rP
         CPjQ==
X-Gm-Message-State: APjAAAXu83EtOH/LWdnDArl61NSb+F0Ek6UaRnnVvIIgxXKIGf3SIjM5
        tkuKXKv8jTNfsHkGLZEhV84FEFfliR5T8v/2OGFnXxuGlj0=
X-Google-Smtp-Source: APXvYqz+5hSx8AyIO68PLEgCzJXxNiyGKQgrsukDLUqC8J76DV8xgyxi+ERIJqysr1OXhO0gL6QnXeuXk3A1jZ6O+EM=
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr93491ljm.218.1576024805657;
 Tue, 10 Dec 2019 16:40:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575925023.git.mirq-linux@rere.qmqm.pl> <56d2568cd45a13c738e2804d04348566a8ee8d03.1575925023.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <56d2568cd45a13c738e2804d04348566a8ee8d03.1575925023.git.mirq-linux@rere.qmqm.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Dec 2019 01:39:54 +0100
Message-ID: <CACRpkdZ0mk2dWBnWh+mRmBy2t-ALONtvv23Hr-2o8LD8CPYtgg@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: add gpiod_toggle_active_low()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 10:09 PM Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.=
qmqm.pl> wrote:

> Add possibility to toggle active-low flag of a gpio descriptor. This is
> useful for compatibility code, where defaults are inverted vs DT gpio
> flags or the active-low flag is taken from elsewhere.
>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Proliferating APIs isn't good but I think this is the lesser evil
given the mess there is in the MMC subsystem for this stuff.

Maybe I can make a second attempt to move all polarity
toggling back to gpiolib-of.c and remove the API after this
has landed, hehe ;)

Yours,
Linus Walleij

Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3019CC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008BA2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kujj5nAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgAGKEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:04:10 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46738 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgAGKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:04:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id f15so38416003lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2i9D0Ihitkev4ht4FSFiTVw1ZbJ3RS0U3X+Z21+sD0=;
        b=Kujj5nAsF/McaOhQh4QC/ZrO+uigeQKBkK1y6VnnbagQPt38lsaATNnpWZ44kW3Eup
         LYeSOwaKJxE5OXfOWa6OYbwpBxD6bdvzNDIhmrPKq2icgV4OD9OLencx+lGj1n8ke29V
         rFzdLzuQ/dz+ArrxHdcF1YHhgkzAiGrXYot51k7aWbpOcHFSmiqXa+aBDcnKQl/tKfp8
         pAUXIBM5IUQ4groRh2LWmayWsQ+reuh6Tz3kwPuh4/kLTVwTlgAIoaITz7NU0AZLNvcD
         a8hanYYcp5ZlGomDzh3uAHWKRIP/Vmgtc1eNdyL35GRLM5Chn3inD0gN6gjmGvlzbShS
         dPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2i9D0Ihitkev4ht4FSFiTVw1ZbJ3RS0U3X+Z21+sD0=;
        b=iCMdRbbLQ6a0XSCPK/TWYy515ky/R66pEkfFHmVHHZpNdil6bd4da6HUhDpYINRGgt
         mYwhErP6wvgFs3N9yPXpullBS//5yRvGL7V/AKNmcrcTWAUKJIu9yvk6D3DN2mpXohlk
         sS6q6ps42AfSQMSQrlJuWCxKeGzN5ZGRrv2z1jUbmjWnUvNBokAt8aEo8NeFpt2K8G2G
         3+NFBF3yBUsQik6BlYboOob25mNKbLBz0/yZuzlZ4raMjCxoOS+amefoHinMASVehjTY
         Sr+9nxaEEhncxFGqFo4fdPLPSiSm2glZcBwQ9CydtfZfLzP+RUk9z3C4RXT8NuejhP5q
         ImOw==
X-Gm-Message-State: APjAAAVWE3eJ3O9R3JqVQvDbcnsNYianXOe7/luGZQ0c88xjQ6ZENBe0
        jgk8WvO3cHcMLnx9TdN7C1X4UZfzwM6bT0ckZniZ0Q==
X-Google-Smtp-Source: APXvYqzw07li0joRnv19MMgwtPGOY2q0x9rVIibcmal6BmQL0ylqnZ3awHBmzcLvX9uirEHXIJmwvppn5akTDicF4Ss=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr58360297lfp.133.1578391447708;
 Tue, 07 Jan 2020 02:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20191224120709.18247-1-brgl@bgdev.pl> <20191224120709.18247-4-brgl@bgdev.pl>
In-Reply-To: <20191224120709.18247-4-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:03:57 +0100
Message-ID: <CACRpkdY6mUsydabXJDNZC2Wyu0Hx0Ut8xhqpYO5Rcr+FBHwMJg@mail.gmail.com>
Subject: Re: [PATCH v4 03/13] gpiolib: convert the type of hwnum to unsigned
 int in gpiochip_get_desc()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 1:07 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> gpiochip_get_desc() takes a u16 hwnum, but it turns out most users don't
> respect that and usually pass an unsigned int. Since implicit casting to
> a smaller type is dangerous - let's change the type of hwnum to unsigned
> int in gpiochip_get_desc() and in gpiochip_request_own_desc() where the
> size of hwnum is not respected either and who's a user of the former.
>
> This is safe as we then check the hwnum against the number of lines
> before proceeding in gpiochip_get_desc().
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

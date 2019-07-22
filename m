Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981EBC76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BEB22296
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PX/sutwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfGVGPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 02:15:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34071 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfGVGPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 02:15:03 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so71484019iot.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 23:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kX0BwYLOwNUlNgHxpx7CjmRWqoQEUjzIqeh8o3Pqthw=;
        b=PX/sutwSVjl/2Y3XTd4qqCfz05CLsbLY0nZ9nsfREhOtpGDWV7OZi60HWK+i5wXiyt
         yWpIG/ejlfDzC7yXMcJqIE3kCoWyHWuI3U96AV61BnGtvvshy6pllCmEC87xYMFnTQ3B
         I5tejJqQtT3M1lOcpN736GYOLowq8z9RlN/4hK+1Xde9OSmNm75kBJ6Q3j0gxM2LT6ms
         8taFE80ygibQHdlwOLZH8suTJjVI5L5lfl6FOu2jMjIna/hSiE7ZRl8qpBYDRF0Gef3P
         8QHhtH+EJudycoTb4AYf+OUwjHEKpU0Wm05ipWWP6p7VFSMXOHhBg6uSHFQ6RJU1VKRd
         HpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kX0BwYLOwNUlNgHxpx7CjmRWqoQEUjzIqeh8o3Pqthw=;
        b=lAEna0II4EASQUFMUthQ3bhF99klP/SX+wnPuqM7L/Glwz4CsASekeSgGV6wi+yeBG
         auj3Zx3T9LhEGKO8bt3UAEwWCTiytK4YUvhsZSGI9ASEtcFmxkGau9ddHPkhrLJTxTno
         xFL0/r1yNFaVo8+lKKkkD3BoTucR6taZK2A4TmGyUhuqJopfF0w8fL9jkD/UBFefl9Ml
         i12gpak7CL9DCq2NwvRJuxQbIf+VDejhrgfLQW1o7o0KwUHMFhcjiwTrqJ8RmNciiIfx
         LJ+VvoOdUdeFx8PSdXxuWLBnNSKjR+ciYb9ve7G9VtHFZCMwJkWMimRz5GzuCPzsOEe1
         1Y4g==
X-Gm-Message-State: APjAAAV5ONby/C/y8luYAb4+rPoUHBXwX4n+4PnfGhnkDp6m62Srf8K8
        dj/kNOzJm0NUlW90rWy84L5/IM72LANzLS20O+A=
X-Google-Smtp-Source: APXvYqzc/MqOnPkc6Erbr3xhLWJvVo8HVczLWBKMYcQnIGByIRIh/0GfUKYy/vZd+Z/uSeZ5HC7s7y1JYvOoMbLSM6g=
X-Received: by 2002:a02:37d6:: with SMTP id r205mr69512569jar.57.1563776102949;
 Sun, 21 Jul 2019 23:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190708082343.30726-1-brgl@bgdev.pl> <CACRpkdb5xKHZja0mkd-wZJ+YHZpGJaDrkA0dv60MNYKXFcPK4w@mail.gmail.com>
 <CAMRc=MfB9R70QDqtjG5a5Roq1roeL78Ss5noytrY-7P=tY1OHA@mail.gmail.com>
 <CACRpkdaiZgK1EoaUxDtbm_GJHVjZU56e_qBQ-OF0mmwb5W8+tg@mail.gmail.com>
 <CAMpxmJWDTkhuWhfSJ-fkJ6r+7a3kErXafQ_sJLVgMf=cA=1+aQ@mail.gmail.com> <CACRpkdYkp0OnyEiUX_VQF_nu5JumkupdsX9fG4rWCf0apNtX5A@mail.gmail.com>
In-Reply-To: <CACRpkdYkp0OnyEiUX_VQF_nu5JumkupdsX9fG4rWCf0apNtX5A@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 22 Jul 2019 08:14:52 +0200
Message-ID: <CAMRc=MchP-nAnYL8rq1k6QUF8DBoayZKB95xh-YL-5gB6GQC1g@mail.gmail.com>
Subject: Re: [PATCH] gpio: don't WARN() on NULL descs if gpiolib is disabled
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Claus H . Stovgaard" <cst@phaseone.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 20 lip 2019 o 21:45 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> On Sat, Jul 20, 2019 at 8:03 PM Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
>
> > I'll apply it to my local tree and send it for v5.3-rc2.
>
> OK! Do you see it as bug fix so it should go in the rcs?
>
> It pretty much needs to be a regression to go in there,
> because this stub stuff blew up in my face before :/
>
> Thanks,
> Linus

It causes a warning every time someone writes to an at24 EEPROM
without GPIOLIB selected. To me it sounds like a bug that should go
into stable. Let me know if I'm wrong in thinking that, then I'll send
it for v5.4.

Bart

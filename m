Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9B7C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204192081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUF5X57A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgAGKEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:04:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42081 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgAGKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:04:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id y4so39723163ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IaT+HGrfAbav44v71XZlSNd1URgNRj4zIy7n7ZKUqH4=;
        b=KUF5X57AU3DbtjYe/SJSlIXKHq/AW+fspiJQdDmQh/3dgRJPXClQ0RhUBWo9mjC35Y
         TWzWkhOYzLFoaQG127Wp8MjTvoh3hvfXSUa21dDfDpqVaNW4JsYoln5yh35extFkPx3G
         FnOyXNGTVm9AgshgMy9yoAlgHpEOl+A9GCNX/VCNxe3X+F7b6WI14t1vF0oBS3wq3QOA
         x380OnTuk0a/troAVSJmd060TG6m3MyVupFUqe+BDIU7HcZAajhURX7NjX0hQTexcfJg
         4UAyVX0uW5MhfwD8a3KLRzF+X946f1PQMoHET3DsaEknPSbCejmajjWomMsKn4f+aNV7
         5bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaT+HGrfAbav44v71XZlSNd1URgNRj4zIy7n7ZKUqH4=;
        b=axz+aVDx1gucQ8A0NTyD5KpDNmm1ZQHmO1+KOKy/KWKZpJRMRXgeCO/t5oXAlBEZSK
         tDFIxz4IZ+tLlnHMgKOEqdssHU9sXFalOnMmwTgPYdgyiZxkLS66fnpcdhCJ/Yj23COp
         g7E1qY3htbhIhXNQMhmeO/J1HOYH2IPv86CAKQ7tg6y0rNau5dL5P//xIwvFcu4cQMW2
         hb8R1s1A5m9/quJgvOZBl4nNZE/CziJTjeofYm5Pl2cnVZj2UkKGOvgPf/1GWUQHNNz9
         joVlO8lxuyNC8NsHtpPiQfSAzcYlVzciL4x0YSRlDdnWC5JV2WEbZjMBFY8IvSlHDGQ2
         o9pw==
X-Gm-Message-State: APjAAAWaVl8HolwKuq4bU3ujng+94TOTAQwZ9LHBDRzt8XtYb0LAVHjD
        c4lEFECJ+dBMCe/giDrOZAipvTCMtVgS6bQhPMCHJw==
X-Google-Smtp-Source: APXvYqwhP3VEPWnGeEz/Hc9rMS1FTioxd80K5vd1QR8JwE74xEVc6SMpiOX950msPkXRl8zkspdirMkWDQZTZq+eHfk=
X-Received: by 2002:a2e:86d6:: with SMTP id n22mr51901307ljj.77.1578391482661;
 Tue, 07 Jan 2020 02:04:42 -0800 (PST)
MIME-Version: 1.0
References: <20191224120709.18247-1-brgl@bgdev.pl> <20191224120709.18247-6-brgl@bgdev.pl>
In-Reply-To: <20191224120709.18247-6-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:04:31 +0100
Message-ID: <CACRpkdb71=HkE-f=8_XJCvfE+wqMYAOMah=4ceMhyWeMNVF+zA@mail.gmail.com>
Subject: Re: [PATCH v4 05/13] gpiolib: use gpiochip_get_desc() in lineevent_create()
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
> Unduplicate the ngpio check by simply calling gpiochip_get_desc() and
> checking its return value.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

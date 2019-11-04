Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E48DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631C820659
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wj/ZMbi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfKDPGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:06:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35386 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbfKDPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:06:17 -0500
Received: by mail-lf1-f67.google.com with SMTP id y6so12515320lfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNloHCnEtBbwd/RLhQCPuff9G3+A7zTymGTqgW0cFJs=;
        b=wj/ZMbi4O0qnIyehYcaBvYcnUc8q6yX0RA44xm+nXzL9BvAABB1c2AhmRkYBw1Qg7I
         mN5UCUUddY9HGRWlzT/6p2B200iREj8F/dF1hqApp7eUvhZx6Dd3ghEhcQ0VFLaL7Kl5
         Pgpy54adYlSA5tTEDRwDoFSXkUK4urF1D4wKL2deeefCfdS89LoQ6pCuo0xbgn/xopvR
         ul4n33zi6AgKbYGxO0TfRJkj6etOCS9z83C0N9mEFEKxcpb9bchw5ReBmmDS6V8AsoZH
         CxHhMEOqRM3aPdqCYKgl5ZIUF9bK5ZNtCsc70kKYSxQGZBBZJThi8FckONgrisLeQMIa
         5JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNloHCnEtBbwd/RLhQCPuff9G3+A7zTymGTqgW0cFJs=;
        b=jcBK5a2FxKJmYoSNuUcw/RQL5Qr8cKzmm8Ljb/8bVdpVeKdzJbyYo6XmioyYCrlfX4
         q+gnwYNVeHCGT0yd7O35ymbupPigVnNV6n9muF9knMTDL2sCwWydNL2kAbvM+UnzqQjF
         dqKDvvVZIF1ahuv+xMdDkqhQ6QI/amsMAeNFi8qP8RxsCOoyCAUztu7w7vd+PDYrk/VQ
         Mj1LAZgpPtWMyePS2Zus/o9g5lb7Wzm1LBMzQtbUZ7ar9anzHzbd92w+aOup9a7VcAra
         v+cyYEoUhQpMTaehEVtOY9z7zYuux2yfp+pJeBElUg9v90HZoQhSW2prX60OC5rjh7JC
         Qapw==
X-Gm-Message-State: APjAAAXNbUAt6Uh3tw0FDWpCOI9X1g7pEWItvGeKgs8uXmk4swZKeLnv
        dCDYhzUwz/j21LgGWK2BwZptrltWp9i7Y5TOYf/TTg==
X-Google-Smtp-Source: APXvYqxi25NXW+aVZ57onKX4CL5r0tUcHO+MYQcB/SWeVCchxkGa9OP810BuCSYMvWujYm7jnic6OJLm6w/D7qjiHVU=
X-Received: by 2002:a19:6a0d:: with SMTP id u13mr8410452lfu.86.1572879975573;
 Mon, 04 Nov 2019 07:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20191022084318.22256-1-brgl@bgdev.pl> <20191022084318.22256-9-brgl@bgdev.pl>
In-Reply-To: <20191022084318.22256-9-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Nov 2019 16:06:04 +0100
Message-ID: <CACRpkdZXDwN_z9pFzbHfn78u+51tWUa0OZdrBSSrtmZPoco3EQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 8/8] gpio: tegra186: use devm_platform_ioremap_resource_byname()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:43 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

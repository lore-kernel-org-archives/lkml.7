Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC90C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323DE22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSbUP94i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390720AbfHWHiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:38:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39955 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730723AbfHWHiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:38:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id b17so6441881lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 00:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lz2W/Er+vhSnNSGXtvI+raF02sxjt0QdGmNNXiXbeZ8=;
        b=xSbUP94itBW5D+EIP6J+VeADRYAq49B6u3tO5t95hiQ3LqFqEQ+LFuJEBkPwIvl6NJ
         rdHJD228PuvuWY4ayKaABZy0R7ZgUsv1KoJKe1+B4yBMntOltSIwBMnp0zedzqrv87zL
         FyQiEkp4NI1BU+dGZ0yLr0aX/BmREJwiUiVaQP7m7hDwK2klVCy6+CigyrmqkaynwxUX
         i9hJB5OCNPeM/9T9HUThretRY6cbh94rGzMPh3Hx8QHO9Re1SquQiiwQO2kbIgauukEr
         DUTZbK0uzXVvytwctPYRyQDuMKG6qUb+FWGnnGyZvGsYO7gI58znr1Ne4ZP01V0cDmVx
         f3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lz2W/Er+vhSnNSGXtvI+raF02sxjt0QdGmNNXiXbeZ8=;
        b=b7XGSDjTphl0b0uMLC0XeSoct0fUdCHN1SBKK8XNgkYd9W6bvpOsMBLcrxmggUqIh3
         ialpqgkJMf2r163Dz4L4W7eOAswDs9TArYh24lrbv7BwMQS7nWVj4Plk5kjwtj6HYcnK
         nA+S31fP8AZauM+2NUVpkjEl0KpyabqLjmknhIgjgvJH5zu4eBrfXAZDYGizsxxYdkt0
         iNL03tYnG5d9Qu7nggOKJ7I2dIbnl3EToiwsNhri0tNbj+rliNQrYsCFq/5kzZ6ReDN/
         j6NrI5W6ZVcjA69mmFIUwKlUZYZ830jGEUQXHEJ3eHB/TvqaSes/DFi6YZS9xbULt6KF
         t/LA==
X-Gm-Message-State: APjAAAWJhaqy/6FGG7iHjeeTA1EREcmugjZJ/JLZNn0KDJH3BMRI+joK
        cLIl8o2Oom57ZDfxcDbYb/QBa/mwTS9Ox2a7lDz5zOjJl/Q=
X-Google-Smtp-Source: APXvYqwn8sOli89h3xpwI0gsI6dJyFeTKTHshx0YK3OmzA9sFUzjhWgRf+UO3GE1WNBwItHvNrorYCww02wff3Qgq/U=
X-Received: by 2002:a19:e006:: with SMTP id x6mr1813674lfg.165.1566545928179;
 Fri, 23 Aug 2019 00:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190808101628.36782-1-hui.song_1@nxp.com> <20190808101628.36782-3-hui.song_1@nxp.com>
In-Reply-To: <20190808101628.36782-3-hui.song_1@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 09:38:37 +0200
Message-ID: <CACRpkdajLb3Spsq4SvRCEJVQcABK+QnNyZi5C3ciTvirjcHF-Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpio: mpc8xxx: add ls1088a platform special function
To:     Hui Song <hui.song_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 12:26 PM Hui Song <hui.song_1@nxp.com> wrote:

> From: Song Hui <hui.song_1@nxp.com>
>
> ls1028a and ls1088a platform share common special function.
> The gpio hardware what they use is the same version.
>
> Signed-off-by: Song Hui <hui.song_1@nxp.com>

Patch applied.

Yours,
Linus Walleij

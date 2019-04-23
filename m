Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A19C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E486C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHyw5ueF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfDWKlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:41:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42785 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfDWKlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:41:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id x13so2672608ljd.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIqaacCUVnQeT2k9cFYikNnIy+o4Tn2LxvLpusUvSj8=;
        b=JHyw5ueFWwjikJompbD46jbqdaKvBCacUe4TJaBZ4+Im+KK0Z4OKZKXyVJNUhv6g19
         eqZeaZhcTuzQ7+Q7O6Ok12qwnCeAhQN3tPcffCwab02kabQr/AV+lDmau8HMzh+tXX27
         /zLb/nzKhK6368PmheDafuwIe3xx531g0sAZSS0cciDNAGVLW85tqWPDMB0tXX1eZ2Qr
         poKrdAuJwSoBVy7ca80WYGXDsxXs3aNDz8kIc4W7ueQPlNg5GjeFoTLI8IdKB6CQxKk1
         SbEBjifUyvoGnd54ehiBh9GogiUn2NLC5wQi1VfLVeS8jx+qyLdicvbK2G0/g811kYuj
         l/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIqaacCUVnQeT2k9cFYikNnIy+o4Tn2LxvLpusUvSj8=;
        b=Zn2w78LPovQVAzxdmg4VHCVyTo+8I6rVsGDAYRPAjtCxYKXylf2XMx8YvuKWCyFS7K
         KyOG8rd3ahzDw7qGDoSw5avmLfww+9xQ7PTV1OcBazm951OhfrI7RoOMMOY9HE8+nyZD
         R1Z4y9b1hgIpplpPYV1NJozcz6WNzNCD+zGhLnhTIHqn4uf4SwFYgn/BbAEq56tjP753
         dsGpYNs37Lk0ArZFE1JDXeAFHqOWHkCgkfm1trblm4z+9rEr99n/zDfdjcxmvVhBrrFV
         dTtH4uOkFsNapqrJUiJoDug7YXBhne964RBx3PG5nOeEXrM5Jc8G6/A+MxkjfBtrR/Ns
         Y/Fg==
X-Gm-Message-State: APjAAAUyXCKN52Ezja/xkJ1WLDKfxJZcGYn/iN0BW0749qxt8LpzTXq5
        4065GCGr8jk4sKQebnVYzqwJb4sgCCHovqHA5/Ywig==
X-Google-Smtp-Source: APXvYqwLgkldZAvlQAYqm8FmkHxfQSCmOWqL+0ElQEHVQQIEiW0bjYcDlxr19xRpveVDHcvGG0Gw0JY8jBXjF0sNvPI=
X-Received: by 2002:a2e:5056:: with SMTP id v22mr3380905ljd.153.1556016072050;
 Tue, 23 Apr 2019 03:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190415192734.935387-1-arnd@arndb.de> <20190415192734.935387-3-arnd@arndb.de>
In-Reply-To: <20190415192734.935387-3-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 12:41:00 +0200
Message-ID: <CACRpkdaVYZf5y3gn-DFsDCutovtw+3-qyo7oKw3UABdfXDRYsw@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: ep93xx: move pinctrl interfaces into include/linux/soc
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org,
        Linux Input <linux-input@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 9:30 PM Arnd Bergmann <arnd@arndb.de> wrote:

> ep93xx does not have a proper pinctrl driver, but does things
> ad-hoc through mach/platform.h, which is also used for setting
> up the boards.
>
> To avoid using mach/*.h headers completely, let's move the interfaces
> into include/linux/soc/. This is far from great, but gets the job
> done here, without the need for a proper pinctrl driver.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

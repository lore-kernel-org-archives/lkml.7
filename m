Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC89C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCFC27752
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZN3yOrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfFARpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 13:45:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38743 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfFARpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 13:45:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id o13so12548335lji.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXOx4KeIoy5u65m3f547Wl3OoIYqly6wuZi2P/gW0Wc=;
        b=FZN3yOrjC7gc03SymAGLotKrHQQ5pLQb+K7hPid9q5fzyQTYusfDMW5FgO25wUHYiL
         tBpYzXVoVd52OeHbPKWOaSQ770OS7SUSeWlsef4vM3GjNfViB51vEXmyYBzWMknDKfWg
         DLjdJWF7oqsetqurvgep+9tFmWKmbOKjMa+KPDueJozFDtQx/NE/xvyGA8Vgr2KdjXLg
         R+CVky81pEdVcOYByBFrnLCJinRY9UYfruK8T2wyHQTW6e4bbQYWr8FU5MTQnpEUmzm/
         I13XvGE7ABq8xR17lI9Zkf3M6uNvrWNWTp+bq9YoxUu87/4nhphSC7ejK9gSi/oGQ5xB
         pTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXOx4KeIoy5u65m3f547Wl3OoIYqly6wuZi2P/gW0Wc=;
        b=JnVkoHcEK5W37lnV0THd2sywyOeOU791b74Uv6YtCVXwaWQEvDGkWVjpWAXnJXTtq0
         EuiyePZ7cghHz27eEQ30OibPadaM75YLb0y+bmHoVtkpK8xyrgvuKnOVvFnE9/AkMP0r
         SGa1+TsOMWRdN/xLuosenaeye/aZnq7ic9iWDrZmYoM1dtxILkzRj58cFd3aPJX2Byq7
         vVwX06ge/K9xAQJohKq5vekjZDI1OgWG/hErlvlsJvDVG0Z+JPu41jT+bIJEfbn6MPax
         KUqi1zVLfnmzZpdlbos3ausUs9NbQQBqbIw5iZYxICUSDClknY0a+2pUzkKT2eppcBKv
         7cgQ==
X-Gm-Message-State: APjAAAUfeFm5/8pAo7HCH5PdT6Z/AIY7RrHN0IgOULWRwwaH0orJSKEB
        lE+izfbCw4ldefjySETRD4Qm9+g50RR3OeteQ5Pchw==
X-Google-Smtp-Source: APXvYqzp4Po5ITkze/xPUJmMmbWc1bBXkKwp5O48dzl+OgvTFaArTL+3EiM1BRgEUeF2q1BFoRt5CfExhv7Ft+/C2os=
X-Received: by 2002:a2e:9e85:: with SMTP id f5mr3598541ljk.104.1559411115745;
 Sat, 01 Jun 2019 10:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190521090306.28113-1-brgl@bgdev.pl> <20190521090306.28113-2-brgl@bgdev.pl>
In-Reply-To: <20190521090306.28113-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Jun 2019 19:45:04 +0200
Message-ID: <CACRpkdYNSgVTLijca53kn6Ve1bje2U0TrVyvLAOU0Z=upv3R4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: max732x: use devm_gpiochip_add_data()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 11:03 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We can simplify the code a bit with a resource managed variant of
> gpiochip_add_data().
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

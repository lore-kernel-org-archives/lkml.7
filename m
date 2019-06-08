Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BBDC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 14:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE2521537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 14:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfSlXgIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfFHOHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 10:07:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35210 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHOHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 10:07:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id a25so3675919lfg.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSRTOSLA+/FemdbH6BEhfWhV1nvGjGDSfzo3b0dCtrg=;
        b=WfSlXgITYjk/kmX1IVtv6UxCnCs/kJHjqnUKJ8Zv8JZQDCQu7EtrGDPpInyTvm72uE
         6Jh3A8tTaALJbmtRlss2aI6W4+waViOr5mUaDGlAlyTXzRWkDgT/sb9MGndw0Lk5feY2
         NpDURIlsWRQ++l8z+dDvkGP9aAkJ+lx4rbv8b+nUmZjdXFakZXkApQTsdEi0esKWCEbu
         cA8WYC5vnZjS1GqHlkSp/aA0FHSG1wR7VUt5Q8pVz8Ijz1HqO348jK6RSTW8IW6QEl0O
         92dOgAbQtZgF9lPg0eXAD/Bwb+x+JIUq5t/QFcv/5K0eNzL0+5lT0VACA/v4ulpdnIY7
         u4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSRTOSLA+/FemdbH6BEhfWhV1nvGjGDSfzo3b0dCtrg=;
        b=Nj7Ft8q5WSbkuAki9AFURcq1on3zQKs5fEuqUGF92TBdP8pnZEhKI5s8icR1M4aHOI
         IQWp/ieav0G1+GKGWggoc/xpaadM65XSOijnh0ekLBnjM0qrhph4F0/k+lHtuIvjZCAF
         60knZ1rncNrnFUxIajdnltNLUVyGyreOPV9DAD5Pf6TO1e0Z5MkYhQ9Ir//64rvX0CqX
         ls5gNeIYo64kz8SZPa5wHb6OJjaRGeBu3vRVAlL/zVQNgpZ7TXE764HA/m5Gbr3JZoxW
         J5ZoU+4kxgyJ0rdYKXroGI9gsenjGcpIKznuRNp2mz5Ix+nK2AbkhexHaUnc8NYlUidI
         0hIA==
X-Gm-Message-State: APjAAAUonUcnY/4MIB0kQSWqCZ3u8xUTffqCZff6cC4K3mTXAF1IoT4i
        Rf7FRq8mhj6Vlp3GtJmzY+WlVf/FG+4lIw3pnJUH2A==
X-Google-Smtp-Source: APXvYqzhdX7oIqcBv/zUJO/5MKYb4k7O/5CPACCUetU6zB1YL1fMBc4XFNKk0JgXOpWjBNi39gAvRNca91ZKemc2KnE=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr27926050lfu.141.1560002835134;
 Sat, 08 Jun 2019 07:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190607090201.5995-1-brgl@bgdev.pl>
In-Reply-To: <20190607090201.5995-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 16:07:08 +0200
Message-ID: <CACRpkdYjXq-KV=zW=az+02tvjiHVHgUPiC149gNfkWTb4c29PQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: davinci: da850-evm: call regulator_has_full_constraints()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 11:02 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> The BB expander at 0x21 i2c bus 1 fails to probe on da850-evm because
> the board doesn't set has_full_constraints to true in the regulator
> API.
>
> Call regulator_has_full_constraints() at the end of board registration
> just like we do in da850-lcdk and da830-evm.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I assume Sekhar will queue this and the LED patch?

Yours,
Linus Walleij

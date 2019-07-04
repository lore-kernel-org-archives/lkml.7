Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FE9C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB4D2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lial0fUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfGDHki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:40:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39533 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfGDHki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:40:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so5141845ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgKcVXAAamjaQY/ifvSqvPergzyHsihVrlBqrjI0W3o=;
        b=lial0fUgVWj7cgxe1w3qVySyxQnXmgOZp+WFWikgUL6haJIFFOlYF8mNsE6azi2Jzp
         +w3/t054JPi3dvrx9tFl0GQuXo0s4Few3k0fZfYLrmRRr15Zn8T5ysmzRhUBLDVMOcTQ
         aGOLqd+wKLq89IzLQ4VPM02BNcuCSkX656kKPUfvs9cYeKako22hNVFGkMT7+HBLf1GK
         L2mtlmMKAXg9+AUbiBeE/1fVbSlRCPFF/4AhX9yL0vue7+Du9YaFiH+4YVLA2IWBnD9L
         ihCj43M2V0cCqFZX6zuz1EQuiK2q6e2t6s5H23NrFePTRmoZdVnFAoQP31H42wptE4Ak
         zdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgKcVXAAamjaQY/ifvSqvPergzyHsihVrlBqrjI0W3o=;
        b=cy1nact2cGa6lb0/8WuFwuh1lM3kLNbCw4X5VhkxrNaeiXHW/EGUlJ+Z3wbKx6o3jf
         0MdVFrZc1ZA2hxRXc8Yrc90YfCTw0cclEx/g0GZN1z8ZRjKyXdLht/IbuQsxUr18nCoo
         F/YXqj4bcGj3jPA5LK1xvNXa08hhkHsWrhhdd+pGf+YsKG31FFVBw94HgOFmD2UspImv
         +n2HQqhq9Jzkqvck+Jr8aptNlLCVwGTQ29o0hF2GcGQVsWp7GV4h6JYweZFuKjhVIO6n
         hXbg1Fsi0EgXQWvC0xZ8uvNvdmmYnCtjeZvp6iuGs491VtxVcVlMvDgqa348mU9ADnPa
         CTqA==
X-Gm-Message-State: APjAAAWYR+NblTM+W00VQKfyETKIHoSSJzmIbwXEEga++J+6zt4bC8sN
        gWNfAdgq5MjobgRiR29twoEKm7xK0T4Pe+NKn29rBw==
X-Google-Smtp-Source: APXvYqxcIK+Xcx+Q5/hTeLzrtubNqKcHX14aiqkByfIumlPYa4leZ0Qj636upmWfYdD7VVbjLHei9732Nr0Z0GmY498=
X-Received: by 2002:a2e:9048:: with SMTP id n8mr2111685ljg.37.1562226036149;
 Thu, 04 Jul 2019 00:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190702223248.31934-1-martin.blumenstingl@googlemail.com> <20190702223248.31934-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190702223248.31934-3-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:40:24 +0200
Message-ID: <CACRpkdYr2EjFWTfv5d5dLJtjnCxdvQCQdVSzt4sVwsEQu0ukAg@mail.gmail.com>
Subject: Re: [PATCH 2/4] gpio: stp-xway: improve module clock error handling
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     John Crispin <blogic@openwrt.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        dev@kresin.me,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 12:33 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> Three module clock error handling improvements:
> - use devm_clk_get() so the clock instance can be freed if
>   devm_gpiochip_add_data() fails later on
> - switch to clk_prepare_enable() so the driver is ready whenever the
>   lantiq target switches to the common clock framework
> - disable the clock again (using clk_disable_unprepare()) if
>   devm_gpiochip_add_data()
>
> All of these are virtually no-ops with the current lantiq target.
> However, these will be relevant if we switch to the common clock
> framework.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Patch applied.

Yours,
Linus Walleij

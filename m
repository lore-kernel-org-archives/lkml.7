Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0EEC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5284A20863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWxgzT1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDHLNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:13:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44150 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfDHLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:12:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so10795202ljg.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 04:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQmitJpwGXJM6LK3DUwBosXECOiXpahSLnM+Vn9iYCY=;
        b=bWxgzT1LAPgp2nND5rd0UH998ksax5/Y/7FCSqnMsiskhhr8VT7+6yirpIinKPhaSp
         hUXp6d6NYJAdSBsFUrZSN9D3/HDflDkCt6wp6ne0GThiIqIUTwnBuB55kBvVY4upjQR4
         ZsEAz7NzZhN50CnlOUm5r8W8fQvOlc1rUTWi7EEbg1C3NEbQza7SVc0+sSgIZX1y2k3c
         zr7qUcNXidORyS8uhYr4WWS/epr3WbH4WOAgK7oaRSoKj8qZOR+HI8YWfjmCoCBGr8nI
         RZ2evti94bImHgmHGrYGjusrWL9k9FR5b1xAYRCIOP07PhFHefpzKzFq6AMeaxYSKVaK
         dWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQmitJpwGXJM6LK3DUwBosXECOiXpahSLnM+Vn9iYCY=;
        b=N9KaSJtUxlrkjLU5qy/MfmbTg46fLDzhoabXwWxHoOl/otx1xNf3qLQjHS2Ur3pNiH
         KSWEb/22VorQSavinHVy3gEbhNA+FQiEuiJaIBajG+wG/2p1pRJ2QzPY5LiMtOWTkskR
         CRuyD5Y1EH4fcFx61qG2OrjR9FrG+e1NuvJRUmnmHhqceA4pwXIfxv+feEoDpeeWj9KG
         7pIyCP/n7zfvoY6HvAxAP+8ze4HKIinNnqKZZo9byiECPZUY38vddhoej60PFpGDXn1y
         szUqsRWNh2nYTuseVgkHglHrWBOqIZQvItWmuVcffhLIszcVW13Ez1Z/pzuBLbR+XnQI
         5CEw==
X-Gm-Message-State: APjAAAWYP1/YM+dzpis2/qjfrIFnVr3Z9ZnM63TzdDRQqqsKkfr/C9An
        JT1LlheHXSIyT8FtYXeYU7ify+HU+JU6FhDsxl5lgA==
X-Google-Smtp-Source: APXvYqyXo5vnZjnKSBFrjUkuT5b4CfcAurwarq2lT5HbwYRSwj2NlOsnwJDMr1pP2T+eHhG8jmz6vKWuVGhtvNXSR2c=
X-Received: by 2002:a2e:3512:: with SMTP id z18mr15071506ljz.25.1554721976233;
 Mon, 08 Apr 2019 04:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190403144656.8257-1-geert+renesas@glider.be>
In-Reply-To: <20190403144656.8257-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 13:12:44 +0200
Message-ID: <CACRpkdaY=0hhNL0c+Gr7JnE-9UFVAqXUXGUWA3+KYm2sAwc=MA@mail.gmail.com>
Subject: Re: [PATCH] spi: Add missing error handling for CS GPIOs
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 4:46 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> While devm_gpiod_get_index_optional() returns NULL if the GPIO is not
> present (i.e. -ENOENT), it may still return other error codes, like
> -EPROBE_DEFER.  Currently these are not handled, leading to
> unrecoverable failures later in case of probe deferral:
>
>     gpiod_set_consumer_name: invalid GPIO (errorpointer)
>     gpiod_direction_output: invalid GPIO (errorpointer)
>     gpiod_set_value_cansleep: invalid GPIO (errorpointer)
>     gpiod_set_value_cansleep: invalid GPIO (errorpointer)
>     gpiod_set_value_cansleep: invalid GPIO (errorpointer)
>
> Detect and propagate errors to fix this.
>
> Fixes: f3186dd876697e69 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Good catch! Sorry for my bugs...
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

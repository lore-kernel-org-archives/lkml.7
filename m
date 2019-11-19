Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95212C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD48222D1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCkQI+d2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfKSOuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:50:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34535 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfKSOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:50:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id 139so23657767ljf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 06:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9ZQjl9wnsKAB3Zoo4F9RgP5GlFui/VJLm448ki3rBw=;
        b=vCkQI+d2K135zgtVt+7P2PPf2Rpc8MsPNf2WQPoLquYf8/L7drQL26yA9UAHUJxyqh
         aKyvyc75wnsr+ma1wiqXJ28O7DcQeoghmTGnmeg6tmxgbkomWa7qrTFwKgugNxbViahZ
         kPSzFfDpFONKL8bgd1IQ7YFuKo0p+8SmIY120vbz/xGiZYeNAb/dy6+uDZ/+oqOOAU9r
         zdbkv1/RT9QnRUoMm3iZmlYaLHXZd12EB3PUjcI8ua5L2tpxXDqulpQ4+XhSf7bYXxw+
         Qh6faNWjS2YKiAay4R9dTNE8C5ccVZn4fFaOhZ4l/oOx3/9D/eyfzJO0TazR1CnydRmE
         HClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9ZQjl9wnsKAB3Zoo4F9RgP5GlFui/VJLm448ki3rBw=;
        b=U5bhFoNiVDji0lZwX06LklbKFCP2jhBy1BkT7aDvYdJcI6kWL6ydp+u67MFuwkFCkp
         tTI4UQm08oPlcLryOrBHfOFxbjXL7DB0beXQLsjZws6bVGjYphhwCfaZRQWQ2Gl8mtgB
         yDDCGgKhDEb13I6S31lPBxdPVeD8fXHt5x3PybF3o2VYY0eY4s3OEIdo8ibW/I+4fP0l
         CQyiKala7f5qLRq3tFjoyZFu5/D75ovYuCxCjGYpyQk98NcS+TgI7Bz4Ik6OMQPIrAOf
         Yd5a+zD7k+wtdCEI0G15nhx6Tu/b3qLcZNKQkCRXnhiFYO+aTaOx1DPU1mmf9iuw0JCN
         jvLA==
X-Gm-Message-State: APjAAAXYhwYRvZYT5gXQhkKZYWm39dDaWyO/8VfQcCQKvTPGCEyGAuw5
        VKF4ZO0adOQw2DMi4jzXyOM+Y7b0V6S+LYFLibhkVQ==
X-Google-Smtp-Source: APXvYqzJgWBhYdXEJT831ipF+tbS7McUT2nhsFOn/XLqq39OkcEoN7fRPKqD94tKrLYR0spiriWRyeFk0XTbbtftwxs=
X-Received: by 2002:a2e:9784:: with SMTP id y4mr4328823lji.77.1574175000780;
 Tue, 19 Nov 2019 06:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20191117205439.239211-1-stephan@gerhold.net>
In-Reply-To: <20191117205439.239211-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Nov 2019 15:49:49 +0100
Message-ID: <CACRpkdYZr7LAZ647DP1-_OPxE7eRnEDhfpMbL36XnELHcc4aTQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: db8500: Add mc0_a_2 pin group without
 direction control
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 9:55 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> Some devices do not make use of the CMD0/DAT0/DAT2 direction control
> pins of the MMC/SD card 0 interface. In this case we should leave
> those pins unconfigured.
>
> A similar case already exists for "mc1_a_1" vs "mc1_a_2"
> when the MC1_FBCLK pin is not used.
>
> Add a new "mc0_a_2" pin group which is equal to "mc0_a_1" except
> with the MC0_CMDDIR, MC0_DAT0DIR and MC0_DAT2DIR pins removed.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Patch applied.

Yours,
Linus Walleij

Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CDBC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADBA215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2bm3iMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfFLInJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:43:09 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40694 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731637AbfFLInI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:43:08 -0400
Received: by mail-lj1-f177.google.com with SMTP id a21so14345075ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x+EjlD1+T7CCrikjK1HAO5M7exqwmkOmFUVOPSS1Jzc=;
        b=o2bm3iMtBobjXXtxNv1yFCOKCEhNUdN1OsTsR9YVk17KPGSUwu4aT0rnhkx69gbg95
         e2jjaVb1Se7IrsCu31pdFspgjFlEuVi9fGbKbg5PlhWAR+3A8iphpCXysUy9RzLYddgl
         aQNZlqA2yjNcOCK0yYlTihm0cVfIdW7csM0JGNjE93raaG/4HQLO9z5U0AY8tolh5QGv
         E9IiagQROkDPg0Gek2RaF8qaGdek3UkTHykivSnaKNP2wVIHhAaH/Qzd5o65P2RAW7MQ
         1LcaQk9sZ0sz5i9K0nXFhZxkqx8Xwd8rM86vTPKG20eZr4FXCJkN14MSO3s8wSzqj5B+
         GLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+EjlD1+T7CCrikjK1HAO5M7exqwmkOmFUVOPSS1Jzc=;
        b=PYHCe8oKHpinj2JRjigRb/FC1EFR7rz28ZE2zlYbqrRQsHRwTf7oDbhvsSaCxFvV8J
         9aszOJdSOhVOXMDL9pGsLSRYiz6gRVR19qBkSdaPn0raRGhpL6M9Z54cd+FTz+7CxuXR
         A9tB/mHQMfyhXak5gc0INcft5b03TGO1Yo5y3gwYv35MGkeVYUj9yHWmcaoR+iDGwDk6
         f9vP9NoAav5XXd2Fc+aRKCHojNcAei9dWkN13UyfgdygiHhTFYiKGzRdE16WZE04hSnr
         v/qYp5MJOBf+dG5sznqFc0ty/+JWI910n++7v44ys0pnpAL8aqYG5X48WxkarHlHRtfM
         m8Rw==
X-Gm-Message-State: APjAAAWJmCvSx5QAUMnpfEkUAhGq7bh8ejzbGadMEsWMo++qw0s8+Myr
        TwKlukSgZuiLjcW+M/mBVCZiDGrqb9wwKUyyWi+OTw==
X-Google-Smtp-Source: APXvYqxcESdgBagFUM3+T7x4f4AJ5XZlAtn+aqs2xl9XMwCPhMnxciJL8Ij4vBzLWAJ5RBgDBwAgRsx8strN2LlYm58=
X-Received: by 2002:a2e:7508:: with SMTP id q8mr26813533ljc.165.1560328986596;
 Wed, 12 Jun 2019 01:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-6-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-6-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:42:54 +0200
Message-ID: <CACRpkdbaXFZQ3d8pQJAxd2WaCJQbBHZZ4XKS3ovrq=ZOmP8o7w@mail.gmail.com>
Subject: Re: [PATCH-next 05/20] gpio: gpio-omap: remove irq_ack method
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> The irq_ack method does not fit our hardware requirements. Edge
> interrupts must be cleared before we handle them, and level interrupts
> must be cleared after handling them.
>
> We handle the interrupt clearance in our interrupt handler for edge IRQs
> and in the unmask method for level IRQs.
>
> Replace the irq_ack method with the no-op method from the dummy irq
> chip.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij

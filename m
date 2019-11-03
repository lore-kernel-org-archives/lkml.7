Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D59DCA9EBB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725632190F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuHGE1F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfKCW1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 17:27:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38254 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbfKCW1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 17:27:15 -0500
Received: by mail-lf1-f68.google.com with SMTP id q28so10813439lfa.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 14:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzPJeK2cpUMQjH/975cPTUdiwrvG/dQ6KV42xRB7wAA=;
        b=TuHGE1F1+ZfQMWfZYOEceMUBeLUnTeKK5wwL276Sz2hY+xKk8yxeRPuxVCLI4K8K1b
         xc/+Bs3KENTr75oENU5Oij2awZZ1CEWkkAhr9YxWRcPvSoAZ0jwnjIPdTOs9KHH+bkjA
         gFA/bMn9usVK1w4Rsab/nFcqIguaiTrbPF90x6B7U0CPqlgL7IVMYuqCg0LkJ7UmqPtp
         nbt7syLDUloMjZ2JaJ7lBtj1V/QwAg3ng3c13tJGYyVP8U5en7JxXggkdqBp6at+kXvj
         ITQxqRfoZDCgVCzD0WsGKF7ftP+d2VB9+BO8PhPn6vdBZfC19rjv4tRamOHUEGXgKOd+
         5IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzPJeK2cpUMQjH/975cPTUdiwrvG/dQ6KV42xRB7wAA=;
        b=YItuxH+zUPXEmXAFYeMXitRB2VCbZeey2zL/7MNV4KVLZqC3wL38V//q3j4An79KBl
         4TXZVxf0HitXCVv4H1PTHUCgT0Tk3XnfSfrBO5LoeZxR3pcptXm0bmJouaIDwC3Tp3kF
         st1rV04leG8JgqB6zLa6CUWwpkthf3yMgWcpQmZjVVgVunWJQW6XFQX+Qhhy+eBFttjk
         YuwtYKThcRZg4gsqZNk4cfysXft1D9WRvWlozoZ7HcBTOX9TCMBbcbnZODXolYUbTj3W
         86AlWmhRpc7II2XmKOIyxzCK6+d/jBKLqa8tUknvoDLj2zyYiTXrTuzPXHP2VS5hc0xR
         i0ag==
X-Gm-Message-State: APjAAAVC1ONXxWyGb+7cjvBcWWsBDeD/Bb3BBLOkjL8YLAFNh50PBVAh
        JihpzLAuK0Z+wDivqn17hmAMVPofUc2+xo6T1T52YA==
X-Google-Smtp-Source: APXvYqyjdYFNN9CDPrBMD1LL8+RPj9zGpSDVydNpsun9Cd81xB4a7KEsrKrdBFbr3NcThDQn/dcVLwc/glAw4mUAc7w=
X-Received: by 2002:a19:6a0d:: with SMTP id u13mr5835609lfu.86.1572820033814;
 Sun, 03 Nov 2019 14:27:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572606437.git.matti.vaittinen@fi.rohmeurope.com> <2a8fa03308b08b2a15019d9b457d9bff7aafce94.1572606437.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <2a8fa03308b08b2a15019d9b457d9bff7aafce94.1572606437.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 3 Nov 2019 23:27:02 +0100
Message-ID: <CACRpkdZYw3QQcQ4h5y_C0UD6+4Wz9AdmQ0qSrrjfUweuJj8hyQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/15] regulator: bd71828: Add GPIO based run-level
 control for regulators
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 12:43 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> Bucks 1,2,6 and 7 on ROHM BD71828 can be either controlled as
> individual regulartors - or they can be grouped to a group of
> regulators that are controlled by 'run levels'. This can be
> done via I2C. Each regulator can be assigned a voltage and
> enable/disable status for each run-level. These statuses are
> also changeable via I2C.
>
> Run-levels can then be changed either by I2C or GPIO. This
> control mechanism is selected by data in one time programmable
> area (during production) and can't be changed later.
>
> Allow regulators to be controlled via run-levels and allow
> getting/setting the current run-level also via GPIO.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

I like the way you use the gpio API so FWIW:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I do not understand the regulator parts of the patch.

Yours,
Linus Walleij

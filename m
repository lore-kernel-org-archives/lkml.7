Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAEDC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66B820861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuTo/QN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfFQLuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:50:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37513 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfFQLuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:50:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so9002524ljf.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUC3oAv954DDdM3Qoub7t5o8CIOFNWz/tUxECd+JQ9s=;
        b=BuTo/QN7Xsk7pkbu1e9KTEhJat0l1vZhloCRxm0xW7p0PHAtECvTmN4DyRUvWnjY7F
         425/HzaReo/WGxA2vRP+9whOnA8l5R7G/hCUShepGlHEpyWlnF0+klfqxV0Zkhi8Bz+0
         jV4gq1J37BAZ3kW71udx4PVHTSDbvB43bURTwX7+6ZvcQpXKeN2toNqRAhr7RformkLw
         6pgUeq7MQcctyJamYjgMyuyaJSaXDbS9aSDe2bU6HRcHWNpFKZb1PUVZ5EBagKifKxOf
         +jrOWqbqJ4KyIlrZlv7VHhbJJqtfvDqgRIULjvBBernbELvj0uJYjzQabAfqGTX916DY
         uIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUC3oAv954DDdM3Qoub7t5o8CIOFNWz/tUxECd+JQ9s=;
        b=mF09FHh4ut++NuQRTj8Nc5N0pk5deKn/eFU/tfJdeetSqVmV717TcHE4amtq9FkyGs
         0QA/RY43yhuHhxhcjI/Smd1Aea75fv+J5V+9U5A7Bqzz+l8RwF4dSO5sc5NEAAP+aPA5
         bPQY16jVksrSgbSbUfskzobUZlbAAylb6HRF+7bYl2wC2gfHg6WUdvs7l+RAre+6STur
         O/iKsI61RLeaB3jKykWLFhh1yvddBI/PgUaYRp8hPgWHqY7q1cQWrH1i6K6b/+l3iWd9
         gUMz0QWcbpshCqTr7w5JfZvZBvkCo6PQ/Y90oIvyIw3V+/lVfPxN7J7N1P6fz4tMBOxz
         ezjg==
X-Gm-Message-State: APjAAAW6P3UrekzqmdnJHpd18t+0DVsIgAGjOVIKQmR0eRg7py3nFdQI
        CX0EYysAL1k7lxgmTgx+bq57g9HhUIeI4+d5lfoqLQ==
X-Google-Smtp-Source: APXvYqxc9icfPV6JO31y7/yaQv+ExXgLV0eomSpNfThNBkfv0HxBRb+mT8ya0W5DCcu8LUONsl0ZC4+8TIbqz0JTEG0=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr29112501ljm.180.1560772220963;
 Mon, 17 Jun 2019 04:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190611185102.368ED21744@mail.kernel.org> <671f87d6-f4a4-6d2c-967b-e1aa0677d83e@codeaurora.org>
 <b0fdbcb1-4d5d-5c60-4150-7762a577cd10@codeaurora.org>
In-Reply-To: <b0fdbcb1-4d5d-5c60-4150-7762a577cd10@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Jun 2019 13:50:09 +0200
Message-ID: <CACRpkdahUNNOhQdri3T86jHr+qOBmXH61_AMmoWpv_be2koMrw@mail.gmail.com>
Subject: Re: Fwd: Re: [PATCH] pinctrl: qcom: Clear status bit on irq_unmask
To:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Tengfei Fan <tengfeif@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>, sramana@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 12:35 PM Neeraj Upadhyay <neeraju@codeaurora.org> wrote:

> Hi Stephen, there is one use case with is not covered by commit
> b55326dc969e (
>
> "pinctrl: msm: Really mask level interrupts to prevent latching"). That
> happens when
>
> gpio line is toggled between i/o mode and interrupt mode :
>
> 1. GPIO is configured as irq line. Peripheral raises interrupt.
>
> 2. IRQ handler runs and disables the irq line (through wq work).
>
> 3. GPIO is configured for input and and data is received from the
> peripheral.

There is no distinction between using a GPIO line as input
and using it for IRQ. All input GPIOs can be used for IRQs,
if the hardware supports it (has an irqchip).

> 4. Now, when GPIO is re-enabled as irq, we see spurious irq, and there
> isn't
>
> any data received on the gpio line, when it is read back after
> configuring as input.

That's an interesting usecase. Hans Verkuil reworked the
GPIO irq support very elegantly exactly to support this type
of usecase (irq switch on and off dynamically), where he
was even switching the line into output mode between
the IRQ trains. (one-wire transcactions for CEC).

> Patch https://lkml.org/lkml/2019/6/17/226 tries to cover this use case.
> Can you please provide your comments?

What this patch does is clear all pending IRQs at irq
unmask. This is usually safe, unless there may be cases
where you *want* to catch any pending IRQs. I guess
normally you don't so it should be safe?

The corner case is when you start some transaction
or whatever that gets ACKed by an IRQ and you actually
get the IRQ back before you had time to execute the code
enabling the IRQ.

That would be racy and bad code, as you should clearly
enable the IRQ first, then start the transaction. So I think
this patch is safe.

But let's see what Bjorn says.

Yours,
Linus Walleij

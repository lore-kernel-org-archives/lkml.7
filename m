Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062C9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77532133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UinkXU36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfDKNzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:55:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38425 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKNzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:55:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id u24so4787734lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWJE0acpGwCNlnQao7yAz7CWnogAQtDzoJbsb4F8LAE=;
        b=UinkXU36OFHFvpDJR1xQfcXAi8hSC2HPXHm33rhGGB3rSliW7UZbWw8guKGI4+F7bz
         f5MpBlxqdaa4SrKr8Hu+vkOUcfzQNpv6HkHaBjeRDulKNiC919/g8PRzuYCVN663P7Z2
         C7bGTbEnkoZ2KFYoh6gp9gRar1zW29BWOZKYn7Rj/pgGeVdhr0OYuYNiwCvtZP4k2XlY
         zC3zVmReKrUK/YzolSZb0JEjkq23yRm/w4ACZZ7qbc6ouiWRHCmEZbNs3CB3Wiv1EWRy
         XmXqzitwPZKbluVefK2TtDVOC9WFOp9qwKTyCH5XDIf6ppBI8jRpjMgZy9hsn8RKXpZp
         wieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWJE0acpGwCNlnQao7yAz7CWnogAQtDzoJbsb4F8LAE=;
        b=cI4SjOvEm1RPaDInrnuslqFDK9YMxH+FViHieWeFUhbhP7gJ7JKXR+IpZHBoAIuyZU
         ZFYjVkJw6yK2Wd8Btmvg4jfAB+fjwP32j1PXRzYwb2kv4o8VnJHGXb/1HphatCNaFzYS
         MmogSfcJQJcD5MzrQG+/I0WJEg6COLUu4dHyjluNv2IZ9BfuvQ9qxTvybhzq3+1/qMsw
         2n7JUPRZtekpM9GJyRLxW3pg8jE3OQ7mOQVNgSIst5of/ifmc7swl1BFB4pzx0GqAt+b
         EIbICcMc/LX02p0YeQNj30bMRW6clqfwk1wXN1PZDsqurWM7QQqP4YBURs3/y4JSAu/i
         Iu3A==
X-Gm-Message-State: APjAAAVw4NU5iin36dqn+UUW//viCwj8z1tPaWe6/cCK498hsNSj5ujd
        d/g/R5RzadMrTDp9GZtL0H0xlCLvMDqCAOuhzSwfwA==
X-Google-Smtp-Source: APXvYqwUNq6+dY2pL4ziQgB8W21fLY/spDR9MLlvL72MM+Nw0Gkb6QmG1FSyWbqW+iYnRVkdI+AwPOJpnikSZSjVMpE=
X-Received: by 2002:a05:6512:c8:: with SMTP id c8mr8767800lfp.138.1554990940861;
 Thu, 11 Apr 2019 06:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190410103926.8781-1-alexandre.belloni@bootlin.com> <20190410103926.8781-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20190410103926.8781-3-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:55:29 +0200
Message-ID: <CACRpkdY2Znvf0h5KiMqqq7J9r3uKU+Uss2Rteaw8a687BetV6A@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: lpc32xx: enable interrupt lookup for port 3
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:39 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Interrupt support was disabled "temporarily" in commit 320a6480ef24 ("gpio:
> lpc32xx: disable broken to_irq support").
>
> Reenable to_irq for port 3 as they are directly connected to an interrupt
> controller and a simple lookup is working.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Unfortunately this seems to be one of these hacks for
hierarchical interrupts that does not quite cut it.

> +static int lpc32xx_gpio_to_irq_p3(struct gpio_chip *chip, unsigned int offset)
> +       return of_irq_get_byname(chip->of_node, chip->names[offset]);

This works as long as consuming drivers pick a GPIO first
using gpiod_get() (and variants) and then convert it to an
IRQ using gpiod_to_irq().

But it doesn't work when some consumer is just picking an
IRQ off of the node without picking the GPIO first.
And in DT that is OK, this DT node is definately an interrupt
controller. (Leaving out the attribute for interrupt controller
as is currently the case doesn't really fix the issue, it is
just inconsistent.)

Look at Brian Masney's series for the qualcomm pin controller
chips for inspiration on how to do things right, see:
commit 9d2b563bc23acfa93e7716b3396fd2f79fa8f0cd
and down.

Also:
https://marc.info/?l=linux-gpio&m=154959228527643&w=2

Especially note how he removes the kind of hack you are
adding in e.g.
commit a796fab2c605d6340512c51c6c3fa1c581357993

Yours,
Linus Walleij

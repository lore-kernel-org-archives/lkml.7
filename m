Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63933C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6F4205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zQF4AgTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfHNJEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:04:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43408 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfHNJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:04:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id h15so10421045ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lq2l16RSFjq6wz/ruQesNuUbLI8gmiZmId5G0J+mFQo=;
        b=zQF4AgTB+9jEl7UsscxvQbb3C/iWEfR4hAhEodH95ojTdcbsoROw3XnU60PvQtxDcc
         KLO3c4fng1VTaMMoqMhN+6kfbYEAeC0rmOaIGjwz7EmbTXkN8mv6xUuUXiBKFQY48PTX
         h6SaaxEGRKrAfH25y8SCObSPisDoXFK/JcHqbwgIPzvmvmxSzB5rGjFw/JuTF1WrV8CO
         N4L6K56gDoxrBlvdai1ZTrldNmS0Wo7/JsNqAu+9xhExyoOzfT7lbF/xWCsTz376brts
         AUE7D3rTs96kryUmLSju9r6Wr3jB9RWG7fKXCrvg++wk1U4//1R2pQt8zeD+IjK3ojuz
         QCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lq2l16RSFjq6wz/ruQesNuUbLI8gmiZmId5G0J+mFQo=;
        b=dpdn89dFEdMhMMR6BLRz6dihvtxxMvOu2zB0a33IhA63pzis276SIe/WdBmqaA+t24
         V8p5v5ZDUF/XF63Bi8MtNE8MLvDrHV8/ohpqI+y0U6lMQyNwUKHbRKrKpvtF55WL3AVC
         BZzN95a291okPiRYkASd8amk+RtxpQZm6eHjeES8Fypm/kj5r+3syGLaiGugYdruLJ9Y
         0mYnGQRzgGVbYESnauzFHXDgI4cgOjhVdcMEDi72co/MJdkT2e9robpI0shXZPgu0AGa
         tpbkLM+8dPp1MK4OfYuAVPEhjysA9k12mZqQWpibu9/hJwCtzCrUdRq19kmFEt4O0wsJ
         jezw==
X-Gm-Message-State: APjAAAWK3ydAMwBEdv4LhYXpfSvnC3PjicWLnLgSS9xBUhNeKZi9eoNR
        PpP8npWDuLC1xUwy4gvptePrf9moRwKBkUGmDJSDmg==
X-Google-Smtp-Source: APXvYqzPYWkAeDfuLYjvtXLWvxIxO98UH5s/tMQr2Hk9GOmp+mYngZQOcDzHvZK/OEE9UNRS960d4fKBb6LVSE0+JWE=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr23992742ljc.28.1565773452821;
 Wed, 14 Aug 2019 02:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <5D514D6F.4090904@hisilicon.com>
In-Reply-To: <5D514D6F.4090904@hisilicon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Aug 2019 11:04:01 +0200
Message-ID: <CACRpkdbi21mV5quTmur6egb6FJMFrD-Lg1EUKtk+HejyWjzmUA@mail.gmail.com>
Subject: Re: [PATCH] gpio: pl061: Fix the issue failed to register the ACPI interruption
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>, jinying@hisilicon.com,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        Tangkunshan <tangkunshan@huawei.com>,
        huangdaode <huangdaode@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

thanks for your patch!

This doesn't apply for my "devel" branch, can you rebase
on this:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=devel

We have moved some ACPI headers around recently.

On Mon, Aug 12, 2019 at 1:28 PM Wei Xu <xuwei5@hisilicon.com> wrote:

> Invoke acpi_gpiochip_request_interrupts after the acpi data has been
> attached to the pl061 acpi node to register interruption.

Makes sense.

> Fixes: 04ce935c6b2a ("gpio: pl061: Pass irqchip when adding gpiochip")

I doubt this is a regression since I haven't seen anyone use this
gpiochip with ACPI before.

Please rename the patch "gpio: pl061: Add ACPI support" unless
you can convince me it worked without changes before.

Please include some ACPI people on review of this. From
MAINTAINERS:
ACPI
M:      "Rafael J. Wysocki" <rjw@rjwysocki.net>
M:      Len Brown <lenb@kernel.org>
L:      linux-acpi@vger.kernel.org

I would also include Andy Shevchenko and Mika Westerberg for
the GPIO aspects.

Thanks!
Linus Walleij

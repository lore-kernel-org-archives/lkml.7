Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914D6C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ACB214C6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 14:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8zCjMPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfFHOWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 10:22:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46466 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHOWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 10:22:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so989230lfh.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIUAKPG6L/Uk7RNnahoThkSWUC4nrgmZui5o+1IQtNk=;
        b=a8zCjMPgP8flEe8AX4DYltakrbTeXlf4HJdUBQFer/b0IPJPCfVav33LROaOIvkRBh
         d/ezKZe+qMrAcg+2zaULmB+dIX8setyM8Dw/amQKtBtuGvpqfUZdtCABo4QaT5ZFUGGd
         fksqElAG9w2gwbE6Q6S46627rrHHqLiRDCA8eScKkVkurpN9O6Dge+avOCJxW9CwIBjE
         vWmpOGwdimteMBWpy3R6+1wtE1HyS9jIIsl6y+9pjv6itruHNG55mTSg6Qzlisw2u1sl
         d/rKG06wFYR5828vG892iuyGTPq8CV75uQK3Cx8ndRZlvQhTZTCv/wvDzZyIGlw+oOwZ
         bmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIUAKPG6L/Uk7RNnahoThkSWUC4nrgmZui5o+1IQtNk=;
        b=uoUlheQCNyVt/SvYraFkmNuXPt3wjFL9CQPmP9DCMUkmq6/E3CbOmoRBsxWMOityLb
         N5XBTgzB4h1eSN1S0TxEf/dissfjJaB3Z04vGNbKn0y2nDozgDgicj1su+/WxIwom+87
         ZvYobjnleHtSZltPtx9NBuynBcvYfkqMzrsSq2MsDHvprDibTKpl3BBG8CA+Q3BlWfiP
         R8TzxREb/ngKQ6DDRsDiCCP5BVBl/GPe0IiiIDnz+zhrd4plqcpI/rZhVD+SEqfVCT8S
         rtm42vQPgTNolO6lYQ14joUlHVBKFx89vL5HKRZuu+2jkyXouLqTIi/AYrpR6n2+FeVy
         fHNA==
X-Gm-Message-State: APjAAAVTUx2vn0EGPdosgJVWCDPU148GQc5ArztrWdNJPbWt/jFBBadA
        hf8wYHY2sepQQv0Hxou5l5rhrNlsj2YLScPKotxL6w==
X-Google-Smtp-Source: APXvYqx2MoGtkoQjUm5Wa5IOCM/k/orM6EKwAwZG7AXIo8rcqREn8WTPkR2Fc2Pbt++tRSEdz7xZS6GOynFOOaZSLRQ=
X-Received: by 2002:ac2:598d:: with SMTP id w13mr28511822lfn.165.1560003730786;
 Sat, 08 Jun 2019 07:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190607082901.6491-1-lee.jones@linaro.org> <20190607082901.6491-3-lee.jones@linaro.org>
 <CAKv+Gu-1QhX-9aNhFJauc9NVe6ceQQueE8Kd14031XJ-2yaupA@mail.gmail.com>
In-Reply-To: <CAKv+Gu-1QhX-9aNhFJauc9NVe6ceQQueE8Kd14031XJ-2yaupA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 16:22:03 +0200
Message-ID: <CACRpkdZmBe6ucmekLUNkypDKx=eAXqtwdYNpZzwByzuWb-sjDA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] pinctrl: msm: Add ability for drivers to supply a
 reserved GPIO list
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, alokc@codeaurora.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jeffrey Hugo <jlhugo@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 1:10 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On Fri, 7 Jun 2019 at 10:29, Lee Jones <lee.jones@linaro.org> wrote:
> >
> > When booting MSM based platforms with Device Tree or some ACPI
> > implementations, it is possible to provide a list of reserved pins
> > via the 'gpio-reserved-ranges' and 'gpios' properties respectively.
> > However some ACPI tables are not populated with this information,
> > thus it has to come from a knowledgable device driver instead.
> >
> > Here we provide the MSM common driver with additional support to
> > parse this informtion and correctly populate the widely used
> > 'valid_mask'.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> I'm not sure if this is the correct approach. Presumably, on ACPI
> systems, all the pinctl stuff is already set up by the firmware, and
> so we shouldn't touch *any* pins unless they have been requested
> explicitly. Is there any way we can support this in the current
> framework?

I don't suppose anything but the GPIO portions of the pinctrl
driver is ever used under ACPI. I guess in an ideal ACPI world
noone (like userspace) would ever use a GPIO because ACPI
would have all GPIOs assigned a particular purpose, so accessing
any of them would lead to a crash.

But in practice it seems a lot of GPIOs are available and used
for example by userspace hacks, so just blacklisting the ones
that cannot be accessed by the GPIO subsystem seems like
a viable compromise.

Then we have the ACPI paradigm of pin control being controlled
by ACPI: this is also great in theory, but it seems like the ACPI
firmware has in cases forgot or omitted to implement some of
it and people need to access it anyways. The people writing the
default firmware cannot think out or test all usecases, so some
will be left open-ended to non-firmware authoring users. This is why
drivers/pinctrl/intel/* exists despite being for exclusively
ACPI platforms. Being able to control pins also from the kernel
has become a viable compromise.

Yours,
Linus Walleij

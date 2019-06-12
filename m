Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCBFC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABAB20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dM4y3ztI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408637AbfFLJL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:11:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45189 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408414AbfFLJLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:11:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so14386752lje.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 02:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYym2l8mqAEx5DPcwNMYFMU/GTCZC3cLzsLhFQIJHOM=;
        b=dM4y3ztI6yt1g4hASKxq2snbEX1K68CjUC6gTHWe+9d9vvdCjc0Hyb7Tt4SFpWfMnZ
         PP/1qBniNFTnD2xxgtG3ZnHDp3pAvcZ0c8KOwrNuqHiEukY0hi7MsorGkKtlPbbpBMyF
         epma8V7XicgRJLPbSvVz0Bb5ZAXr/qBaK4wG4k0ftrVRFJ+4phQYjdYLRjOhAVFwa7Wx
         T+Buc4YW4OtkNrK67CwaDSfapcUXfthRM4P8N8fGIE3Yzxk3j9Jn7CKZJxbXXdvAknSN
         amls9/vG09ZfIzWpnAPHn5suPlmmYG8YDi92WVUyX4FsL/+D9JHImhzF8Ietl15bSNTC
         G7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYym2l8mqAEx5DPcwNMYFMU/GTCZC3cLzsLhFQIJHOM=;
        b=ev61i3PqGo/rGuryhNMFN4a2thSoocRWx0xF8z7YySgs8u8GmVER1ccMbMPH8VYUgu
         unv2BKMvV5Ayw9Lshw4YR7H/bICl4mPt0O3aK++dAMpeDAWKeRMbU8H2UZA2VxMzEZVv
         2LujNWqYSRuaME7XgtLF0e2iVpFlUcPDwr06m7sLprVtVFJv1pAASFDcWxUdtGndelUp
         ugAu1dfF7uMzekOd5WSLUluzdEPv0SzBhAmnvdUa4xZzks6nIwytDM+IYM64DIu9IT/y
         T6mOZhzDhdNJ2+PvBmNFj/aoh9YN8JjQBTmZ+NIQZEFnQ0s3+xI6Lx3RYjPsxeSZUITo
         J2Sw==
X-Gm-Message-State: APjAAAUbrnTpPjCOiOkOalDCQg1biqemZB/F+cOipfTFCcLOkQgjiue8
        qvCDzD0MeoStKzWHWFt9bmKc1MNheODgSVavTgZ0Pw==
X-Google-Smtp-Source: APXvYqxPQeP+YZhtl1yArUP/kEZEaq45Z/0+ctNo29822y9vO0QaRlGNPkN9752MhVjSxAx4U3gKOqJrOx5tmU+Q5gs=
X-Received: by 2002:a2e:480a:: with SMTP id v10mr5624585lja.94.1560330713660;
 Wed, 12 Jun 2019 02:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-21-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-21-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 11:11:41 +0200
Message-ID: <CACRpkda2FhYNYA2TkVANOF5GWd3hE9cqM7N_pFDFj9nh-fh=iA@mail.gmail.com>
Subject: Re: [PATCH-next 20/20] gpio: gpio-omap: clean up register access in omap2_set_gpio_debounce()
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

On Mon, Jun 10, 2019 at 7:13 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

At your convenience please look at the debounce function a bit
closer because I think there is a bug/unpredictable behavior:

IIUC the whole bank/block of GPIOs share the same debounce
timer setting, and it is currently handled in a "last caller wins"
manner, so if the different GPIOs in the bank has different
debounce settings, the call order decides what debounce time
is used across all of them.

In drivers/gpio/gpio-ftgpio.c function ftgpio_gpio_set_config()
I simply reject a dounce time setting
different from the currently configured if any GPIOs are
currently using the deounce feature.

(It's the semantic I came up with but maybe there are other
ideas here.)

Yours,
Linus Walleij

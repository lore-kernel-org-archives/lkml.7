Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526C8C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2885A218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlTAdbPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfGCM0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:26:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40418 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfGCM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:26:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id a21so2204717ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQ0WKefyL3mNgqdY1lyjmoIdIu/J9QFCMjO3S3QGPlk=;
        b=VlTAdbPAVv+CgxXkv69g5pFeCgvV1hz0aXP9cXCKpkxBy0CDA9k2xNV7tZf4ewpsRV
         CfBK3aOdH/umCZArjXpAvTfiQ8qUDknk19sONR2SSCr/nA3INgUVucxl9W+wY6vmD1/1
         2XTsZQa768kgMRf+smzTYdGdE2fr5kRDxDXNzC/aja8OXl3MOf4dc/C7Tzv0skPj9ArV
         5KrOwux7PoctX4NlobTCgFwD/MlCdIoWxkCmb3pRJ3vYZg/lujxWop0Kh91LJAc5zJ/4
         76o1mOESfyyMSBcBY5BoqBxt9n6A8bk0K9hyl10Ujikl/+iQ6dVh+sBvFoluKOD2LqsE
         EhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQ0WKefyL3mNgqdY1lyjmoIdIu/J9QFCMjO3S3QGPlk=;
        b=QprypZXVyMIhKQbtbQIHGTaj9o89nW2QK7h5SAiMsQs9QAh56pJ6A3zCq3crSzh2Sl
         cWY6TuI4xUC5T4S6VzHM3WaiybaRNgflTrhQdB0q0KHKu3ES9S6arMNbEcmEt3Y6mqE8
         P4vpgWffPNuE1tBg+DZrI5MwcSUiy7OoSlLGnBvA5sd+AJ2WTiYAm9rgqpTYQeeqoUE4
         KiX3GmexwWFWAunyi5OaWkTE3WK0yQEa9oOkUtPcMirzfX/J8toDPIBdixrUsKenqf1u
         s4Lh3+ODixvqHlJ2DcUhU9Wlt+FFQ7CbvS3BzXlLuIpSPObEmQ1IDyCptUnqCWmuOZEb
         Q23Q==
X-Gm-Message-State: APjAAAUzbDGoM7QPKLysvsj86s4BuRyl/dHtNQYlJx9Mc1jR3ZCck4Y1
        RH2yTXDK59xjby3xUgYiTuzCBPbEc6YImry1MNy/JQ==
X-Google-Smtp-Source: APXvYqxTxZa9ESbuAcjCDllEi8XVNXyRZ46EbLsEXR4D9x59DgVsMw4Rpmc44K6jDKdIlcu8vkA5MW1BwruYFmuZR8I=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr3966445ljj.108.1562156786187;
 Wed, 03 Jul 2019 05:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <tip-f3d705d506a2afa6c21c2c728783967e80863b31@git.kernel.org>
In-Reply-To: <tip-f3d705d506a2afa6c21c2c728783967e80863b31@git.kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Jul 2019 14:26:14 +0200
Message-ID: <CACRpkdboWWKfaTu=TKqnZgjy4HNWr+fjmQXLBBmePsaDihkbSA@mail.gmail.com>
Subject: Re: [tip:irq/core] gpio: mb86s7x: Enable ACPI support
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 11:24 AM tip-bot for Ard Biesheuvel
<tipbot@zytor.com> wrote:

> Committer:  Marc Zyngier <marc.zyngier@arm.com>
> CommitDate: Wed, 29 May 2019 10:42:19 +0100
>
> gpio: mb86s7x: Enable ACPI support
>
> Make the mb86s7x GPIO block discoverable via ACPI. In addition, add
> support for ACPI GPIO interrupts routed via platform interrupts, by
> wiring the two together via the to_irq() gpiochip callback.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

OK!

> +#include "gpiolib.h"
> +

But this isn't needed anymore, is it?
I can try to remember to remove it later though.

Yours,
Linus Walleij

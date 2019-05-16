Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69880C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3986220815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cYaJwB40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfEPN1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:27:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46304 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfEPN1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:27:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id l26so2602655lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WxjQCsvVCJYqyumRz+jnewVmeYA5zYY9VNykeSLVi4=;
        b=cYaJwB40usbpVQi7JB725NH1c2aJJGSyxQSvdM2jZIHDEJrHsmOgi20KVuuo5unVIL
         5CCZ/gPl95YUInsupxVWgVV6iT+QF+Kw5zttZAATHls+0an8Cunb/+ukCDTaLAQYdgOw
         +upnD5HLCdC4d+PBExK6UwEPtRltfx4Q5Xrvgusq2WumgfPk4qwaP9UT5X9HjSmF859a
         KO8fejjCw/x147mbgm50wo6y+jIbj0H/CF9Wa4kALrUwKiwT96T1FDObrDwfRJHH9WOV
         o6UcWtt1zmQcHhJCRG8iP+08LE77Cx2n4+nvD6HCkR8KKGWxjHY6OPihuGTPs+yp10Ue
         4PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WxjQCsvVCJYqyumRz+jnewVmeYA5zYY9VNykeSLVi4=;
        b=loes1nbme2YFJZw6433IBWeQQkbUyA4wREAqEC/edtYwnB9yAWjpjZefyVbdeCYHVl
         gya5rUSkmk7xjpcTg8AVcYcCJKneJ1aY8lnkALN9qldC17LbPDEFtNNBbxQWcRornFOn
         urbwF44gIg+XM+K8OX3lW4BbA7Z3O8TrppRUQEZT4/x9NzpOHpwdfAH32JGjgDLBi4WR
         30vii8Zhnff8a+rlYOApwkkVer9nJH3wbqcretqcGrrJhPDJMygMDbIYwhznl5DsTivf
         GIdfUrhA3lIb9ZAERz/9yvBvYn2zQU7MB97WCMqJjHw51BE6/znclOOP7py1B5AdgAEb
         +tdw==
X-Gm-Message-State: APjAAAULboHnPVLnGf6SRWlTabvG76vhCHB7bHZAgGqHv2iAXXGBS2bR
        ljDtNHk39GFKIuMycaVSuktxNUllBUqLdZ5sh1Bo2g==
X-Google-Smtp-Source: APXvYqzKRSRZrOSzb8j47r4z5gkvvcvXMc+KXeXLn3AMVGqrIIudEn/2TzBR5TN3TJK02fLAdgUvNPBy8HDUhhbEpdY=
X-Received: by 2002:ac2:482a:: with SMTP id 10mr10554822lft.51.1558013271860;
 Thu, 16 May 2019 06:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190509205955.27842-1-f.fainelli@gmail.com> <20190509205955.27842-4-f.fainelli@gmail.com>
In-Reply-To: <20190509205955.27842-4-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 May 2019 15:27:40 +0200
Message-ID: <CACRpkdY3-yARtO9KQnUUMNefygzLC_c2RRn+ROZUdYfBJkRASQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: bcm2835: bcm7211: Add support for 7211
 pull-up functionality
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Al Cooper <alcooperx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Doug Berger <opendmb@gmail.com>,
        Matheus Castello <matheus@castello.eng.br>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Lukas Wunner <lukas@wunner.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 11:01 PM Florian Fainelli <f.fainelli@gmail.com> wrote:

> From: Al Cooper <alcooperx@gmail.com>
>
> The 7211 has a new way of selecting the pull-up/pull-down setting
> for a GPIO pin. The registers used for the bcm2837, GP_PUD and
> GP_PUDCLKn0, are no longer connected. A new set of registers,
> GP_GPIO_PUP_PDN_CNTRL_REGx must be used. This commit will add
> a new compatible string "brcm,bcm7211-gpio" and the kernel
> driver will use it to select which method is used to select
> pull-up/pull-down.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Following the discussion with Stefan it appears this patch
needs more work, but you will only need to resend this
one patch.

Yours,
Linus Walleij

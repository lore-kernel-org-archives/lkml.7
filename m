Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857A8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 20:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B43120811
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 20:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfCWUHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 16:07:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33629 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfCWUHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 16:07:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id k14so6320430qtb.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 13:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGIMTkb8Q6h0BN6ku5B4xFVCKzxQadbRHPxr8YdgvRk=;
        b=A6AjdXPb0KR46D88xtkPyfEFxdBEiT/Tdfk+L6Y0K7gO6p3Auj6PnFrQpTdDV5H7AS
         lrG3l2fXMt79vWNlSdmJ4nMPyL4UUKAdZg4s9al8nnn5mE0Gm7ZzrzRgGyVlVm/XaaCO
         DKMeukcORvwm390j704sQ2RblCb22T8JS9kiKe+7ghVdTjwCIqklDZzgiedqAMIXBeyD
         Af+d/knl7QMnP0m9d9cx2b2rQkqzlO7jZoLu2zM/LyXhgjTpLtCVlvu51X4oN4oFna90
         E9H0L3Ck/YLmLyFuASFOnohUwZZegmF/rTpCPUY6v5/M9ZQNWYCu/AEfkKSeGZ0VIL3d
         kAqw==
X-Gm-Message-State: APjAAAVi/PRul0Ri/oGbvEjJizhyYNbYnh406IBs4xc4q65lyfIy4yIC
        mSPYa53edDg9O6TfBA2o9tLGJfBy83lVm0zrDTo=
X-Google-Smtp-Source: APXvYqzWeqoDbaspXcriPAMgZtke2iQY0xn81O6ymgoFUuYfRtWTrGNqrvgG3UaESs1zjexPpdARwjsS0OdvY+4j0Z4=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr14019232qth.319.1553371633696;
 Sat, 23 Mar 2019 13:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
In-Reply-To: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 23 Mar 2019 21:06:56 +0100
Message-ID: <CAK8P3a0XBN+noCkdGT_TYfPNY1j9CcVH8mTjh_mQL3w+Z6jfaw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: use arch_extension directive instead of arch argument
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 4:52 PM Stefan Agner <stefan@agner.ch> wrote:
>
> The LLVM Target parser currently does not allow to specify the security
> extension as part of -march (see also LLVM Bug 40186 [0]). When trying
> to use Clang with LLVM's integrated assembler, this leads to a build
> errors such as this:
>   clang-8: error: the clang compiler does not support '-Wa,-march=armv7-a+sec'
>
> Use ".arch_extension sec" to enable the security extension in a more
> portable fasion.
>
> Note that this is technically not exactly the same as the old code
> checked for availabilty of the security extension by calling as-instr.
> However, there are already other sites which use ".arch_extension sec"
> unconditionally, hence de-facto we need an assembler capable of
> ".arch_extension sec" already today (arch/arm/mm/proc-v7.S). The
> arch extension "sec" is available since binutils 2.21 according to
> its documentation [1].
>
> [0] https://bugs.llvm.org/show_bug.cgi?id=40186
> [1] https://sourceware.org/binutils/docs-2.21/as/ARM-Options.html
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

This sounds like a good idea. I think we have platform specific
minimum toolchain versions elsewhere, but I don't see a problem
with raising the minimum version for all the armv7ve platforms.

I've added this patch to my randconfig test queue, but please
send it to arm@kernel.org for inclusion when you have
collected more Acks.

Do you have a git tree with other patches required for the
integrated assembler? I might try that out as well with
my randconfig tree. At the moment I'm building with
clang-8 and a small number of patches on top.

Acked-by: Arnd Bergmann <arnd@arndb.de>

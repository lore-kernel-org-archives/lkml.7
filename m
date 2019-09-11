Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00441C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81212067B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcbRuqnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfIKJnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:43:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35682 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfIKJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:43:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so15945032lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n0eGU7EwYvV44i/yZMlYO2mgsRqBSzpFil4+yiEnP3M=;
        b=jcbRuqnqmVkgtZ98MPCNgpOW1Z6kmUSw8xfMYAW37/xJ62Qt3QsQ/voTaoFkiTXyDP
         w1Q6d7XhKj2eklW4V5AoidRHlrApe860OCk56LBhG/GrCi+4h+4CGPvYYXbc21mT2Qmb
         n8/oZluaIZNJqeg71T5o1EhMoB+m0tTvFGbJeLBixpk1B0OvuwGsdc44VhKJIB54ydLM
         +rJ1kHOtRpY3wWwCnkSYJO6TzxUPRlzQadSIu3Q0h8wveQneMW03LB1cnaSuhiyk35Up
         nJFTKiaBIgKKwiKSXI8tF9Js1bVU4DuCKFCf6MOBC8EWum5/LM9CClP0N5EetYarRvQn
         HOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n0eGU7EwYvV44i/yZMlYO2mgsRqBSzpFil4+yiEnP3M=;
        b=Thiql6ceJA+NnrneWx3eq7m6mIATG4CnChoQ5bziSpVYOPus4gu1XNptPK0X4qhd+E
         VH37R/n/JIu+FXimVMfZP8euW0444Y8uF5436h5ozZqhBEpbVxybswFI65Rj3WUDp/Cg
         Ydn1CuvL9XI/tveKThBy0bIsiSGphOl1acKxKz80Gm94Q8Ef6rN6wRCqZ1YXrT3UYN/x
         eB26Es0a6EqzZzD6xvEUuuYifG863wgyzOTCH5GqSm8VySXGGwb/3WzzJlVoBKEGZzSX
         C0Jhz/QU09g6esS134wwR+97VLLDUZp1Y3oXt/1Z3tX0/W3FN6J7c7bEJcYW+jOPb5b/
         vKRw==
X-Gm-Message-State: APjAAAVd5mzrS8mrGwVfKNkyPsDyX9VnqYSd5LMUnE2/fCMBZkom4RO5
        +G0LAqYKvHFS5Aan9sMVdbSXJCTUQPFvGMFW63faaw==
X-Google-Smtp-Source: APXvYqx4fsV/WTIRSXhN20GDJfDooCB6DWGgBVXCN0nS2mCnPbakVJ5rn36/YEesW30QiVEAg3CUEQ+P0NTYpRFt3xA=
X-Received: by 2002:ac2:51a7:: with SMTP id f7mr1200184lfk.152.1568194988428;
 Wed, 11 Sep 2019 02:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <1567054348-19685-1-git-send-email-srinath.mannam@broadcom.com> <1567054348-19685-3-git-send-email-srinath.mannam@broadcom.com>
In-Reply-To: <1567054348-19685-3-git-send-email-srinath.mannam@broadcom.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 10:42:57 +0100
Message-ID: <CACRpkdYyHMHknkrH_Gm45tgwv6dgjFxdoeg+Hj_KBWWyQqV1og@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: iproc-gpio: Handle interrupts for multiple instances
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 5:52 AM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:

> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>
> When multiple instance of iproc-gpio chips are present, a fix up
> message[1] is printed during the probe of second and later instances.
>
> This issue is because driver sharing same irq_chip data structure
> among multiple instances of driver.
>
> Fix this by allocating irq_chip data structure per instance of
> iproc-gpio.
>
> [1] fix up message addressed by this patch
> [  7.862208] gpio gpiochip2: (689d0000.gpio): detected irqchip that
>    is shared with multiple gpiochips: please fix the driver.
>
> Fixes: 616043d58a89 ("pinctrl: Rename gpio driver from cygnus to iproc")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Patch applied, I had to rewrite it a bit to fit the new code that
set up the irqchip when adding the gpio_chip, please check that
the result works.

Yours,
Linus Walleij

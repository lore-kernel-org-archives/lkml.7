Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EF9C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC542086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q3u2Mh8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408151AbfITGB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:01:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35518 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404716AbfITGB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:01:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id y21so945838wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 23:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrJRto0V1tQECL7z3O9ZKJjMZZ7EfCuDScReljEVoD0=;
        b=Q3u2Mh8gz2fE3BJI573A/4KXqhnj4eoXlYMoZGGughIFG6Vb5FrwRq4f2U9S4oq1Vr
         Hbt9FsxwAgyBIq9a+hMcsz5uxfp8u73hXd7+1A6OV9p60H1OKGviHoiZWKnWNb7g7hfF
         mYVifC0KgoucYeWRHf5UYbWqoMgIslcMNPW+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrJRto0V1tQECL7z3O9ZKJjMZZ7EfCuDScReljEVoD0=;
        b=kmJh0dhMfY3brYmsJckhXUVWEfWb4Hm6SYhVpCJiZ/hFJVp39s2d6f1I5EOLpoDWrw
         EFoSVwC9EGp7krzrZHZ6qEhOg5GREKcYsrMg0pqYZxTo6S1Htk+UOv6d8oiUxKqXT5R/
         2hX6BNFN79M080dMYiZ/GIWKX5urcRZfu/xEHYP+Z/WZhf3n6La4+0kE2NjGGbepHtIe
         yldsrvY+c65VU+l7Bx2M3i70v5MAiPyxiexT/7L1jLj21qYmgU51e0BSx+83Sa/CTyUF
         kqAHH1wOQuXfC66XhJfxlxHbxC8k+mXJj2oR9Yvv2jE0PUNLDFblEXVJNi821Z1q/Q6N
         vxlQ==
X-Gm-Message-State: APjAAAWUtEie9Q4mJmSPXWVmfyvlItiCMJWg0hBYds5qNVrCTGo2Ok9e
        uUODZ3342gHKwmOVeUyVlGgUktEu4pNn3wXMFpaNIg==
X-Google-Smtp-Source: APXvYqzFCzSm0CfSfkwqk1qJj+FBKaMsFKoHb8kBLAJykpfyPHgRhuUNr7Y+6up7GrQ+zsoM2UYZ1XpAH5PFF+zHhXg=
X-Received: by 2002:a05:600c:217:: with SMTP id 23mr1913029wmi.76.1568959283898;
 Thu, 19 Sep 2019 23:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <1567054348-19685-1-git-send-email-srinath.mannam@broadcom.com>
 <1567054348-19685-3-git-send-email-srinath.mannam@broadcom.com> <CACRpkdYyHMHknkrH_Gm45tgwv6dgjFxdoeg+Hj_KBWWyQqV1og@mail.gmail.com>
In-Reply-To: <CACRpkdYyHMHknkrH_Gm45tgwv6dgjFxdoeg+Hj_KBWWyQqV1og@mail.gmail.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 20 Sep 2019 11:31:12 +0530
Message-ID: <CABe79T7h7=Y_fMv0n81hTS=nFnpRHXEFZTev-kLQsb6-eCGUdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: iproc-gpio: Handle interrupts for multiple instances
To:     Linus Walleij <linus.walleij@linaro.org>
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

Hi Linus,

We have tested patch with your changes, it works fine.
Thanks a lot for all the help.

Regards,
Srinath.

On Wed, Sep 11, 2019 at 3:13 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Aug 29, 2019 at 5:52 AM Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
>
> > From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> >
> > When multiple instance of iproc-gpio chips are present, a fix up
> > message[1] is printed during the probe of second and later instances.
> >
> > This issue is because driver sharing same irq_chip data structure
> > among multiple instances of driver.
> >
> > Fix this by allocating irq_chip data structure per instance of
> > iproc-gpio.
> >
> > [1] fix up message addressed by this patch
> > [  7.862208] gpio gpiochip2: (689d0000.gpio): detected irqchip that
> >    is shared with multiple gpiochips: please fix the driver.
> >
> > Fixes: 616043d58a89 ("pinctrl: Rename gpio driver from cygnus to iproc")
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>
> Patch applied, I had to rewrite it a bit to fit the new code that
> set up the irqchip when adding the gpio_chip, please check that
> the result works.
>
> Yours,
> Linus Walleij

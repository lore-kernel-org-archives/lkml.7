Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F61C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1F52171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2vZKP7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfDLNN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:13:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36937 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDLNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:13:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so5154583pfr.4;
        Fri, 12 Apr 2019 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9julFFNnjjmpRPEwh1/7ZmyWUlZl64V1L5pTrjM48n0=;
        b=W2vZKP7M4kf7G4UubRsddkMr/LDrMMxPetvcBihAXO0pjawdyrD18x95p9nWKLqIpE
         kb/PUhQSA7jWbzavgm8YyfMfqnQiQT5J+MMN5h3XnMgJXSygzmGuzN5UzGXgtk+dsTz5
         vyVPKKPeZqgLoTgi6eKGTgCec0XIUKOiv5bXVe/qhsas/HcN68XIoz0FEpQaQSYK4eKF
         xrFtewY5zZbMWo/pFvdJpssCPh0S03neu0B4sbXKjlM13lEUCWws5pseRQwRKoQNmOoK
         K0x2o5lUL+OWjtmOQJwQ06kNSEObvJd+MHeMmKQht5bXkoaFg6Z/e+nbKPz/ppL31kCl
         L1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9julFFNnjjmpRPEwh1/7ZmyWUlZl64V1L5pTrjM48n0=;
        b=aCngDAn+hr9bcHYBgqw5JiJUeOdKEuULhZFTiGt7NoWR9oLqFPr+awbLK/y4XtUza0
         9J9xQ/kdY+smchB96MEGy8E7PhNijUxaHo6rhhqdMBERlSx3m77DZIaBeoM7CAFSsMfO
         bgwFo7UHJmdtr76spI5jBqHJj23CwzSaGP1cyOICniL1k/WdVCzmi/TZGIdDTjqAKmEM
         mceGEyQq/6ApWhcThii8aNGH8Lx7w2kCtVuXRtA7Bl4QzRpi/XPQwEXdEvPfEe3QodSt
         ZEt2FVuud391N4GBO/QyoR/Lp9dWpHHpH7gAnRzagKbkMzSe7AZ+1hCJrMYgPcYCxx4Q
         UP9A==
X-Gm-Message-State: APjAAAVePfIU/n+fgXd11D7C4GkriDlBpva4gAKPuzdjXgtWqZs973VU
        vgYajIv1SutYJrrG8vZYzEv9lTgv5cjgWnx2gfI=
X-Google-Smtp-Source: APXvYqxkuX6py0td5Df1zd06ScNAAg5QEhoQbMz9ORZBsVgWsBMMIG4/0ZC50dtitehPFIh4YmUsJIeEYlF68JT2QNk=
X-Received: by 2002:a63:fd49:: with SMTP id m9mr53719071pgj.16.1555074806560;
 Fri, 12 Apr 2019 06:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190404103925.25652-1-yuehaibing@huawei.com> <20190405142112.26592-1-yuehaibing@huawei.com>
 <20190405145009.GD9224@smile.fi.intel.com> <2719325.nu6fPkO1U5@kreacher>
In-Reply-To: <2719325.nu6fPkO1U5@kreacher>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 12 Apr 2019 16:13:14 +0300
Message-ID: <CAHp75VccF9-ax8nJ9qOfAFMvLR19K6NqwyePEf-86r4ifMnJKA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: merrifield: Fix build err without CONFIG_ACPI
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 3:55 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, April 5, 2019 4:50:09 PM CEST Andy Shevchenko wrote:
> > On Fri, Apr 05, 2019 at 10:21:12PM +0800, Yue Haibing wrote:
> > > From: YueHaibing <yuehaibing@huawei.com>
> > >
> > > When building CONFIG_ACPI is not set
> > > gcc warn this:
> > >
> > > drivers/gpio/gpio-merrifield.c: In function
> > > mrfld_gpio_get_pinctrl_dev_name: drivers/gpio/gpio-merrifield.c:388:19:
> > > error: dereferencing pointer to incomplete type struct acpi_device>
> > >    put_device(&adev->dev);
> > >
> > >                    ^
> > >
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Fixes:d00d2109c367 ("gpio: merrifield: Convert to use
> > > acpi_dev_get_first_match_dev()") Signed-off-by: YueHaibing
> > > <yuehaibing@huawei.com>
> >
> > Thank you for an update, I have a comment below, but before sending v3, let
> > Rafael to have a chance to look at it.
> >
> > >  #ifdef CONFIG_ACPI
> > >  extern int acpi_platform_notify(struct device *dev, enum kobject_action
> > >  action);>
> > > +
> > > +static inline void put_acpi_device(struct acpi_device *adev)
> > > +{
> > > +   put_device(&adev->dev);
> > > +}
> >
> > This should probably go to acpi_bus.h under acpi_dev_get_first_match_dev().
> > And talking to Mika we agreed that naming would be better as acpi_dev_put().
>
> Agreed on both accounts.

Thanks!
YueHaibing, please, send v3 with suggested changes.

-- 
With Best Regards,
Andy Shevchenko

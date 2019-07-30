Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230E1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAA3204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRVhTKXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfG3Rbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:31:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38835 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfG3Rbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:31:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so29150005plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzFMQ9/zoHJSM6By+23ql9lKy9BIeRzGBGTz7X8/XOY=;
        b=kRVhTKXMSLVOaZPNkHJP0MfPHGKSH1562rHMl+MxThpg1abYRanXiLzcVHNjbQ5Nb9
         yrSETVUC+yO2ROKwhP2UFUD4fIU5BEwFDv9wqpIUry/NHn250Jo8QCA/FtqhYCYCql25
         0ou1lO4i8dkSUDcDw3CKBBqE3HqI08sVhC5Tw6juXNB7XkOKXTQdf8tvLEOeQE8Xa+VB
         7R5Fm11R7LQmdFWIRBM7DsGFqucnbXbhwpbCV1hQsDb+Lu1pP3Lv/NZT7vp2dRQ+QmS2
         5H6ijwr2+5Bppjhb87/mkUbSl5BuplUv1yvjyFaFkrbO2ReoZbR0Y508lQquXNeuldyj
         qo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzFMQ9/zoHJSM6By+23ql9lKy9BIeRzGBGTz7X8/XOY=;
        b=jR5MPLQbvTv7HGy10FVLJQCQBVnqxHneLG3adW5Z9oziA+hy9Md1pgkal6wwnw92Yx
         sQMSioEXhGPlv5gJbKpoKAgJ8yQNzV09tq/iLk/44+YUd5j2WOxF5awVUBkPBZLKi2bU
         Rgm4NSJa4CA/uCXL2vi+WGDjvrH4aOE+sZNH1UkoQDmBRJ54ekU4B2Y7lZ3pO5+xGo7E
         TRel7OdZBR/LofYRPF4aAmyYD4DjKM/CSiQs10bn3eDOlciVNCoMZ0NfQID36TwaANN+
         ubXMnEyno2Pslqwrs1gwYIsdz+VmlZvQaMXobxY4C6mBNt7rJ0FLxUVNCiG8UAdZ9sv1
         e4CQ==
X-Gm-Message-State: APjAAAWQNBONS6H/UBmpExwjVZtTOvSDHaYZEvVspqwdEO65by01jiXF
        nXdZ4YqIdPHi7sX6KZx6kT81xy8gNAK/xc65I8I=
X-Google-Smtp-Source: APXvYqx3F81etUNhhE44DTPYZOvGFFkjcaZ8FY/nQCIgjLisnwY0zwmzn/q8EBrzy6xuaeOZHwJ7H7YIuI9GSqgSUAU=
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr114319229plp.262.1564507912516;
 Tue, 30 Jul 2019 10:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190730053845.126834-1-swboyd@chromium.org> <20190730053845.126834-3-swboyd@chromium.org>
 <20190730064917.GB1213@kroah.com> <5d4063e0.1c69fb81.fb7c2.9528@mx.google.com>
 <CAHp75VcRJBmtqs6mN2wNE+fY8hVnPLDWRYZHQSwKXWsmhmhi8w@mail.gmail.com>
 <CAHp75VeiMY4snbDkM=hdqRoUQZ5bEmhjEMdinmvV1voQhWfANg@mail.gmail.com> <5d407ca6.1c69fb81.a0835.69e0@mx.google.com>
In-Reply-To: <5d407ca6.1c69fb81.a0835.69e0@mx.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Jul 2019 20:31:41 +0300
Message-ID: <CAHp75VeBFzx5zsOhqhPdAi-H=VA_4896cDztC8kJpjiKgEgrPA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] treewide: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 8:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Andy Shevchenko (2019-07-30 10:17:46)
> > On Tue, Jul 30, 2019 at 8:16 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Jul 30, 2019 at 6:36 PM Stephen Boyd <swboyd@chromium.org> wrote:

> > > > Ok. Let me resend just this patch broken up into many pieces.
> > >
> > > Please, for the subsystems / drivers where I'm the (co-)maintainer,
> > > please split on per driver / module basis.
> > > I will pickup them preventively, since it will be anyway run-time
> > > bisectability breakage.
> >
> > However, having two messages slightly better than none from user prospective...
> >
>
> I only have this diffstat showing your name.

drivers/pinctrl/intel/

>
>  drivers/platform/mellanox/mlxreg-hotplug.c | 5 +----
>  drivers/platform/x86/intel_bxtwc_tmu.c     | 5 +----
>  drivers/platform/x86/intel_int0002_vgpio.c | 4 +---
>  drivers/platform/x86/intel_pmc_ipc.c       | 4 +---
>
> You want a patch per line above?

Yes.

-- 
With Best Regards,
Andy Shevchenko

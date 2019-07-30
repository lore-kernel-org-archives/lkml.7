Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3AAC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED21D206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCscp0+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfG3RR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:17:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44966 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfG3RR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:17:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so30150292pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnE7vwigHqEnJ0WrTZDFhV+vZ+p2imvv/QSknrDQOfA=;
        b=uCscp0+G4rHcBxIX8+OU7+STyeLdFfX0vNnR4HR2EnRTTxq8OihIeRNLrKhHsZ4l7W
         vyVB5K4a0aHG5dtS5J9yaEhG1MBZg5CRzPlXWSXNc8UHWZNl48MQEJqxx6fWV09QfaKD
         Fx1Ri1inaEy48rCB7L8xb7fzCo3bwe54FgbCVSgTfgdo8gFyyxbHD/wpUpMTiUVfEqiW
         pd4xPmyAnXP6zel9GwrHBnjQSm767Ry+xrHPIzrXxP7bz2qARSTp/iqy+k3dv3iv2D5a
         ID9YGH66fchko/1cQmSPh74ESzyoRyuJ2JpczMHuvljvA8/3Q+uCvROpXZRioy84ixd7
         +WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnE7vwigHqEnJ0WrTZDFhV+vZ+p2imvv/QSknrDQOfA=;
        b=RJclGwxtvXIbkNGbNuCTwhWNorjsFx+m2S2WFr1CBhkvXSeM4kg9tWAr23HiN9+wlD
         BA04ZCbi3qywRmi5WpQqMy9kDrhIfovdmSHY8DgpOBVQBmk7JKt0IbR7yLXZe/l4+/Ij
         lhKzdONpViXj23iaxaCKIB9bp9ANc56t0obyMAYTFM+GDuDqOvlpD5o81epgTMB61GW2
         iTxg02fftfTGVoDiK7TN2q9P0OWAWd1M5dKwgR0LUgTVZsChofEl9dajoaB7IK+x2QQv
         LyWz9nWVUrYKwejnOF+gz1lShTDZyKXxqWvNuykgywRcuQf1t7rzESgaMXliatn4VzJM
         QpVg==
X-Gm-Message-State: APjAAAVhudA81wk7su4An9k3Nqjfx9pQycHNpj4GhTb/r2kLItUxcr3/
        b14SDxGjGzAy3UMG0QcG8F3fte2OGil0bEyQDs8=
X-Google-Smtp-Source: APXvYqz+frxEB58M7EQDTOW8bO9a34jRH3iC/+X67R4omApqy6KY/DXHS6hjzAXDMnvwTeMWQ7bTl21SA/vmcQrv98I=
X-Received: by 2002:aa7:9713:: with SMTP id a19mr24961711pfg.64.1564507077649;
 Tue, 30 Jul 2019 10:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190730053845.126834-1-swboyd@chromium.org> <20190730053845.126834-3-swboyd@chromium.org>
 <20190730064917.GB1213@kroah.com> <5d4063e0.1c69fb81.fb7c2.9528@mx.google.com>
 <CAHp75VcRJBmtqs6mN2wNE+fY8hVnPLDWRYZHQSwKXWsmhmhi8w@mail.gmail.com>
In-Reply-To: <CAHp75VcRJBmtqs6mN2wNE+fY8hVnPLDWRYZHQSwKXWsmhmhi8w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Jul 2019 20:17:46 +0300
Message-ID: <CAHp75VeiMY4snbDkM=hdqRoUQZ5bEmhjEMdinmvV1voQhWfANg@mail.gmail.com>
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

On Tue, Jul 30, 2019 at 8:16 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 30, 2019 at 6:36 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > Quoting Greg Kroah-Hartman (2019-07-29 23:49:17)
> > > On Mon, Jul 29, 2019 at 10:38:44PM -0700, Stephen Boyd wrote:
> > > > We don't need dev_err() messages when platform_get_irq() fails now that
> > > > platform_get_irq() prints an error message itself when something goes
> > > > wrong. Let's remove these prints with a simple semantic patch.
>
> > > Can you just break this up into per-subsystem pieces and send it through
> > > those trees, and any remaining ones I can take, but at least give
> > > maintainers a chance to take it.
> >
> > Ok. Let me resend just this patch broken up into many pieces.
>
> Please, for the subsystems / drivers where I'm the (co-)maintainer,
> please split on per driver / module basis.
> I will pickup them preventively, since it will be anyway run-time
> bisectability breakage.

However, having two messages slightly better than none from user prospective...

-- 
With Best Regards,
Andy Shevchenko

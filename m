Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83BBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E19621D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIRKYTaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437269AbfJYIvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:51:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37632 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733259AbfJYIvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:51:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id q130so1157682wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMQiRvfvzltgh99VMklkfKOfsR6mD4ds3sE5X/Su2O8=;
        b=TIRKYTaBshWTPJj4UWu519prJLZg9t6m71FKYN77RqdVJbA6wswRsoDddyDRllrah9
         eLJ3ZX1U4jp5zVDyhyakhz/h9viCJIKMk5e+zoedFAa6MS3btKN3u9No0budl9ClmrlA
         omN6AAfjUcChu8sDFXBzSTwu5dL8CNs49ncvElnoIN28khvj/Y/ZE2uOo4BtoIrCU1US
         E77RHhb6oKvX4/M+nYwCG/kFefGqMwUp0YwFG21cyaPOv93dMr9pScAm3j1wNMd1HkLg
         37EdA8Ii06PBPKCqELNApcGdvtq1xTGtSGKw36wBnrK4qlMwycpOMVtKMxWizxSwsOhq
         ePww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMQiRvfvzltgh99VMklkfKOfsR6mD4ds3sE5X/Su2O8=;
        b=MltvLQd/9Bj0LQkRA0A4FAnyPOjxRUKEI0diHpfk09ACtQVFuJzuy8Defa4OrjVgwC
         1NQ+xT+0yu0HA3/nGbHVrydltiLjUC1b8pwt1tV/kcRB9aNogFS6LKLX1Sc1MNH/SLsK
         R7Q+t6tNW7TAT8EudzlubOOBA/QreYyGZ9YLY0odNOfZQRKrnmqb8ntuDKGmu5/pfnEW
         8TGx0ivWKn1KamDpZcCGOZii2Z/oT3WKiw9qrV9b+7pNsHIHTiFMcTNuJ7K9OQ2np3Jy
         EVW0+xL2GbSH6sDd1OeWmIlGcwv1H5VbwvacKrAopmj/GXloauf/Q2F3hLrC7voLJdS/
         fjJQ==
X-Gm-Message-State: APjAAAXkAtVboTsuXdfJf43Xrd88kpjRBoBpMx0tzxUcExmXDzRz6X/g
        iUI4kB+iesa3sA8VaL37qM5N42hJ18ivEE9yO1BbLalj9BQ=
X-Google-Smtp-Source: APXvYqwXe4RLnYUEE5xCp6/dPcTi6vC7x27ZS6aisYOk3qLPoJRv2XdeWFAUsCJ7MCm/WyUwKOMjpH4VuQ/H0xMKp0o=
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr2266482wmf.37.1571993494613;
 Fri, 25 Oct 2019 01:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com> <20191025075540.GD32742@smile.fi.intel.com>
In-Reply-To: <20191025075540.GD32742@smile.fi.intel.com>
From:   Andrey Zhizhikin <andrey.z@gmail.com>
Date:   Fri, 25 Oct 2019 10:51:23 +0200
Message-ID: <CAHtQpK5ue=6u9ABugyQgzZODt9XuOyW-H4VvcZV3Vmacx8a6pg@mail.gmail.com>
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>, lgirdwood@gmail.com,
        broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 9:55 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 25, 2019 at 10:53:35AM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 24, 2019 at 02:29:37PM +0000, Andrey Zhizhikin wrote:
> > > This patchset introduces additional regulator driver for Intel Cherry
> > > Trail Whiskey Cove PMIC. It also adds a cell in mfd driver for this
> > > PMIC, which is used to instantiate this regulator.
> > >
> > > Regulator support for this PMIC was present in kernel release from Intel
> > > targeted Aero platform, but was not entirely ported upstream and has
> > > been omitted in mainline kernel releases. Consecutively, absence of
> > > regulator caused the SD Card interface not to be provided with Vqcc
> > > voltage source needed to operate with UHS-I cards.
> > >
> > > Following patches are addessing this issue and making sd card interface
> > > to be fully operable with UHS-I cards. Regulator driver lists an ACPI id
> > > of the SD Card interface in consumers and exposes optional "vqmmc"
> > > voltage source, which mmc driver uses to switch signalling voltages
> > > between 1.8V and 3.3V.
> > >
> > > This set contains of 2 patches: one is implementing the regulator driver
> > > (based on a non upstreamed version from Intel Aero), and another patch
> > > registers this driver as mfd cell in exising Whiskey Cove PMIC driver.
> >
> > Thank you.
> > Hans, Cc'ed, has quite interested in these kind of patches.
> > Am I right, Hans?
>
> Since it's about UHS/SD, Cc to Adrian as well.

Thanks for looking into this, and including also interested people
here. I've included only maintainers, but all interested parties are
also very welcomed.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

-- 
Regards,
Andrey.

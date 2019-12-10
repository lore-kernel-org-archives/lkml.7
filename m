Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E566DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7643207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7H1U1qR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfLJUBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:01:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35818 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfLJUBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:01:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so17123283edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/R0DvHO32Ps1xRQleCzKMKFqLHiFsSU0YTem1kX0McY=;
        b=R7H1U1qRykpKlz90guDfnfMLQu+EzMsrV2O6YkM4xhmZeMcLM57ApewNRgw7I3oxKI
         2aAD35/rc6ipU1JVj4R7fnWWDXdfU60Ru7OkIh/gvKcGZOMCsZoTifF7aVmY87MT6hgE
         dD5ngP3bxwvgxaUKGXlHDjhdzIOD2MYqyaZAQ0zNBWoe41+9R24H9mu0HoZ73/j1dZHO
         1e1NADmg1PX1InTdZK26A9BHbzzbv9g+wwZC320VhTgoMhgDSR7ws8a9GUG3L9eiWd/C
         XjXyLoPqpEfT9KeiRzpCp3r467r5KBUq+K4z3zpDpkHtZFXjE071oLAqXrPbaYl//h7O
         M3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/R0DvHO32Ps1xRQleCzKMKFqLHiFsSU0YTem1kX0McY=;
        b=T1t3WOAkbgVp3rVItQ+GX0U1aFutpUNP6juvSJ+DfN2DKifmxfSbUvaxi+HsZWJnpP
         6P8/Egah14TC6hnOZv17XrWS5uevBGnH3h4ZxEHYo8Ia/hZmxJKpIsXmf4lqmCsIgxRZ
         WjjHrVyuqrA2qtNA969FfzJ7U4+C3OR00a2h3TYUx37TKZUYJI4Xsw7P2H6eXnoIa9xu
         uBof0DH7gK+fx7jYyFArg3Jjijj+1IpPCdVmlII2cHrHoAWsC7y1PJPwayNSJvYGufY+
         9gGU83IRNhNRVpAaq6jPNAsDKYesO3F/dhEAthyM2za1mmRbP/lgICsQSRDpkQBpR5wX
         qreQ==
X-Gm-Message-State: APjAAAXxIsOSefTsF8HLcIBYih5IfSfxeLpifQ4cSGl1R0EENftEl4dj
        UZCZIXor0o4xBjEAoK9rBUEsIaUjAiSLs6F9rdR3bg==
X-Google-Smtp-Source: APXvYqw9iivvFvbh4l0R0xUIg3aOHjmVGVcBM1DAkbhY5OagPSNUaYsBKKSgVVT4xv09dpa7VBmQFMfoID9G8U35Vko=
X-Received: by 2002:a17:906:4881:: with SMTP id v1mr5729193ejq.329.1576008104565;
 Tue, 10 Dec 2019 12:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com> <69dd3a7a-c5fe-3ae7-8a4d-c3939870eed8@linaro.org>
In-Reply-To: <69dd3a7a-c5fe-3ae7-8a4d-c3939870eed8@linaro.org>
From:   Wei Wang <wvw@google.com>
Date:   Tue, 10 Dec 2019 12:01:32 -0800
Message-ID: <CAGXk5yrsmvHK_xwvp_kFNmSqKOZ7Ef3HrVBHYDMBmDsCz0FNSQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] thermal: introduce by-name softlink
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 6:36 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 05/12/2019 08:19, Wei Wang wrote:
> > The paths thermal_zone%d and cooling_device%d are not intuitive and the
> > numbers are subject to change due to device tree change. This usually
> > leads to tree traversal in userspace code.
> > The patch creates `tz-by-name' and `cdev-by-name' for thermal zone and
> > cooling_device respectively.
>
> Instead of adding another ABI, I suggest we put the current one
> deprecated with a warning in the dmesg, update the documentation and
> change the name the next version.
>
>

IMHO, we should keep the existing path which is a common pattern for
sysfs interface. There are reasons we need couple thermal zone and
cooling device in one class, but might be worth considering split as
the latter might be used for other purposes e.g. battery current limit
for preventive vdrop prevention. By nature, thermal zone are sensors,
and cooling devices are usually components with potential high power
use.


> > Changes since v1 [1]:
> >  * Split cooling device registration into a seperate patch
> > Changes since v2 [2]:
> >  * Split improve error message in thermal zone registration
> >
> > [1]: v1: https://lore.kernel.org/patchwork/patch/1139450/
> > [2]: v2: https://lkml.org/lkml/2019/12/4/1291
> >
> > Wei Wang (3):
> >   thermal: prevent cooling device with no type to be registered
> >   thermal: improve error message in thermal zone registration
> >   thermal: create softlink by name for thermal_zone and cooling_device
> >
> >  drivers/thermal/thermal_core.c | 55 +++++++++++++++++++++++++++-------
> >  1 file changed, 44 insertions(+), 11 deletions(-)
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

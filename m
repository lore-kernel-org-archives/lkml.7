Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6792FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF6B216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5NQ6RaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfEHXQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 19:16:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39171 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfEHXQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 19:16:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id q10so353436ljc.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 16:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rx0y6PQtDWpMB7dE4WTzT3yISSxb8pJ6fS91KAAE2fs=;
        b=X5NQ6RaS8EC1nu4gRLBpTlEsIT2tkLIDGg4XxjwiydTb8snqc62j9xFF8wCOh7pkB0
         9BLcr+9EcmSb2RPI6aO3m0J4z/WywXTZFadApdwuBPXBNXC32ndqwy65kQcXzxbNWIg6
         6nyUBMNH5r/JOXk6cfeXzR/SnqvmaXFwclvSn5sM9unSletf/hXLnY/pDo5ImF3IcWg5
         CTy/QJL8Xb2681vVVWGR94h8Q836lCuFMG8o/04E0Du+4E3DpecfA269C60AW1i1Vr1R
         osMDUJkl2oh5fOAI2uHQhu5iIDzMxz9Zzk2TB8CAgLhVtJwVcZbTQq8vA8YNv+kB8ZLT
         59oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rx0y6PQtDWpMB7dE4WTzT3yISSxb8pJ6fS91KAAE2fs=;
        b=p27GWFtoDl74aVKuabEfBpux1JFRTOP+DxVQK0n63BCocqSek863BHLzk2P5CDHNPu
         YBr2yqJGGG3eJ5fCGZT5Tkb5/aBJBfHKWWFVSQLljeP6Vdrvk1LxiQHNqivyflS4orUD
         GjaO+XA8iZJc+AxoMCgwzbUR0+mraIjY17FMo0hcz1tnVuhmf5SYOUzKM6lM7SRDmSjT
         fdBiG8QqK7KthAGX9rlrm2o74hn6vmnMhra6bb41+2pLc9IvNeaNeJgbZ+2kl+qswhOd
         8C7ukMveE54Xh9tj2nvvaSvaTcSvLLDx7mkZrWeEvgftwFUDVeItqtt+Oxn4FWVFvOwi
         +cdA==
X-Gm-Message-State: APjAAAXwCXKYdgiYEmEgArcVlrwR2+UJm53LHIjsHLWDxS8wZvGYkGul
        BMF0lSEhGvAgGpQW3iFCUBmMPFvzD0bDnytCp5ZV0Q==
X-Google-Smtp-Source: APXvYqwZdNmKqMgi/4nybYZl5Ciq1NCyMxq91349TSdCaOjV7hPZdrVfPjRjB1apQm5mL4vL/Yt2N2sG5ISkiDHeyVA=
X-Received: by 2002:a2e:8583:: with SMTP id b3mr267032lji.136.1557357358357;
 Wed, 08 May 2019 16:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190508173403.6088d0db@canb.auug.org.au> <fa0e68b2-b839-b187-150c-13391c197b99@infradead.org>
 <CAHp75Veq2=XA124rG8urt3eVE3pcaUm0VdsV7Mxr9zjMpa7mjg@mail.gmail.com>
In-Reply-To: <CAHp75Veq2=XA124rG8urt3eVE3pcaUm0VdsV7Mxr9zjMpa7mjg@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 8 May 2019 16:15:21 -0700
Message-ID: <CACK8Z6F2v8nyUYcnOrkp81WfK2D2NEmK=pcWybn1annrtqRwew@mail.gmail.com>
Subject: Re: linux-next: Tree for May 8 (drivers/platform/x86/intel_pmc_core_plat_drv.c)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, May 8, 2019 at 2:22 PM
To: Randy Dunlap
Cc: Stephen Rothwell, Linux Next Mailing List, Linux Kernel Mailing
List, Rajat Jain, Platform Driver, Rajneesh Bhardwaj, Vishwanath
Somayaji

> On Wed, May 8, 2019 at 11:45 PM Randy Dunlap <rdunlap@infradead.org> wrot=
e:
> >
> > On 5/8/19 12:34 AM, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Changes since 20190507:
> > >
> > > The ubifs tree gained a conflict against Linus' tree.
> > >
> >
> > on i386 or x86_64:
>
> Thank you for report. Can you provide what is the config option for
> this module? I suppose it's built-in.
> Rajat, I will drop this from the repo, because I don't see it would
> have a chance to be tested in time.


OK, NP. Just to be sure I understand,

1) Please let me know if I should send in a fix (it would be
#include/linux/module.h and also add MODULE_LICENSE() I believe)?
2) Would this be lined up for next version though?

Thanks,
Rajat


>
>
> >
> >
> >   CC      drivers/platform/x86/intel_pmc_core_plat_drv.o
> > ../drivers/platform/x86/intel_pmc_core_plat_drv.c:40:1: warning: data d=
efinition has no type or storage class [enabled by default]
> >  MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
> >  ^
> > ../drivers/platform/x86/intel_pmc_core_plat_drv.c:40:1: error: type def=
aults to =E2=80=98int=E2=80=99 in declaration of =E2=80=98MODULE_DEVICE_TAB=
LE=E2=80=99 [-Werror=3Dimplicit-int]
> > ../drivers/platform/x86/intel_pmc_core_plat_drv.c:40:1: warning: parame=
ter names (without types) in function declaration [enabled by default]
> > ../drivers/platform/x86/intel_pmc_core_plat_drv.c:59:1: warning: data d=
efinition has no type or storage class [enabled by default]
> >  module_init(pmc_core_platform_init);
> >  ^
> > ../drivers/platform/x86/intel_pmc_core_plat_drv.c:59:1: error: type def=
aults to =E2=80=98int=E2=80=99 in declaration of =E2=80=98module_init=E2=80=
=99 [-Werror=3Dimplicit-int]
> > ../drivers/platform/x86/intel_pmc_core_plat_drv.c:59:1: warning: parame=
ter names (without types) in function declaration [enabled by default]
> > ../drivers/platform/x86/intel_pmc_core_plat_drv.c:60:1: warning: data d=
efinition has no type or storage class [enabled by default]
> >  module_exit(pmc_core_platform_exit);
> >  ^
> > ../drivers/platform/x86/intel_pmc_core_plat_drv.c:60:1: error: type def=
aults to =E2=80=98int=E2=80=99 in declaration of =E2=80=98module_exit=E2=80=
=99 [-Werror=3Dimplicit-int]
> > ../drivers/platform/x86/intel_pmc_core_plat_drv.c:60:1: warning: parame=
ter names (without types) in function declaration [enabled by default]
> > ../drivers/platform/x86/intel_pmc_core_plat_drv.c:42:19: warning: =E2=
=80=98pmc_core_platform_init=E2=80=99 defined but not used [-Wunused-functi=
on]
> >  static int __init pmc_core_platform_init(void)
> >                    ^
> >
> > and
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/platform/x86/inte=
l_pmc_core_plat_drv.o
> >
> > --
> > ~Randy
>
>
>
> --
> With Best Regards,
> Andy Shevchenko

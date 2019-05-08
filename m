Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAA5C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7404F20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaatLT/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfEHVWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:22:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46081 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfEHVWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:22:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id t187so16435pgb.13;
        Wed, 08 May 2019 14:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qEZ1nDQkLhnljnhO1XT+76Va+ERwzANAvgOJlth73mY=;
        b=MaatLT/JCFbNp7HRMV7J86ISG2sgXD1Aah5uhq6xrDRTHbHElZTJpxuxt63R1R/jzX
         ONys1xnFWaiGSuUgLQgMaERIZVEZZhjQ1bcLCyDguzD44Xj36PjDFLXOdl44GyLC4bc4
         y9DU/Ce+NrcsyCS7HlvrRIEzG/Q0tpCBn9WJvo5Q9drRNShAbc2z/t34/5T1RaAc52yU
         v4Z6eWSmF4DpM+0doSwWNwxx+dS1Fk+v6d1dKMv9Nroo0y21KqwwKoL+5mUUlflXTFR3
         T7E8TWQTSqyjwTKGSQ+8JQd+LFq64TS7Zw1BOUwbF9LkJ0mi9zIAkvwOJYFeAFZPDNGE
         /4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qEZ1nDQkLhnljnhO1XT+76Va+ERwzANAvgOJlth73mY=;
        b=dHyrq8N3qEMBhbDgXt26GAYdqSAFZlFyZ0+JOChpgIBZvuXQQh8L3hOXqQwoC9YquF
         RWo5nRq46V2Y7CSelvkzrN40kgo+zr7mqvAKTrclU2G/baXAmXcJhEvQHsAW35a2eIgl
         MJUHxwp3Cja7lSIzFAQks/YbidisJvHWeuyGQ+LF5QaxVrWZetp57M28bWiBjIWacasm
         qvmmA/ISX/8o1BLP0Q5ZM4CVtMHSQ9uvuEtgytD/zrR5oLfS7HPhg61UFtIG2U5OgxjE
         vTayhXZ4Rt+h9278smC4WHJr4Ewfcgv+rCJJutrnLsTon/W9KXcFGPpjJtw42Ho7BIFP
         Aa0Q==
X-Gm-Message-State: APjAAAVoXkSPdx/8+Xwv5cKGdsArH+VnabBoTABHzXmYCUqXtZOfq/ko
        jEsXhR/p0zbnWguu1E/uP5dqshsjJR7tPKDLJa4=
X-Google-Smtp-Source: APXvYqyY7257EkFyuqYMO3No5jmetxnshT0y6vWMpuTkrZfXDyQFDOhNoBkNrUTxpTpzwcNtSTbWVz8LzkgUMeJK2h8=
X-Received: by 2002:a63:8e4b:: with SMTP id k72mr502101pge.428.1557350526122;
 Wed, 08 May 2019 14:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190508173403.6088d0db@canb.auug.org.au> <fa0e68b2-b839-b187-150c-13391c197b99@infradead.org>
In-Reply-To: <fa0e68b2-b839-b187-150c-13391c197b99@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 May 2019 00:21:54 +0300
Message-ID: <CAHp75Veq2=XA124rG8urt3eVE3pcaUm0VdsV7Mxr9zjMpa7mjg@mail.gmail.com>
Subject: Re: linux-next: Tree for May 8 (drivers/platform/x86/intel_pmc_core_plat_drv.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 11:45 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/8/19 12:34 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20190507:
> >
> > The ubifs tree gained a conflict against Linus' tree.
> >
>
> on i386 or x86_64:

Thank you for report. Can you provide what is the config option for
this module? I suppose it's built-in.
Rajat, I will drop this from the repo, because I don't see it would
have a chance to be tested in time.

>
>
>   CC      drivers/platform/x86/intel_pmc_core_plat_drv.o
> ../drivers/platform/x86/intel_pmc_core_plat_drv.c:40:1: warning: data def=
inition has no type or storage class [enabled by default]
>  MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
>  ^
> ../drivers/platform/x86/intel_pmc_core_plat_drv.c:40:1: error: type defau=
lts to =E2=80=98int=E2=80=99 in declaration of =E2=80=98MODULE_DEVICE_TABLE=
=E2=80=99 [-Werror=3Dimplicit-int]
> ../drivers/platform/x86/intel_pmc_core_plat_drv.c:40:1: warning: paramete=
r names (without types) in function declaration [enabled by default]
> ../drivers/platform/x86/intel_pmc_core_plat_drv.c:59:1: warning: data def=
inition has no type or storage class [enabled by default]
>  module_init(pmc_core_platform_init);
>  ^
> ../drivers/platform/x86/intel_pmc_core_plat_drv.c:59:1: error: type defau=
lts to =E2=80=98int=E2=80=99 in declaration of =E2=80=98module_init=E2=80=
=99 [-Werror=3Dimplicit-int]
> ../drivers/platform/x86/intel_pmc_core_plat_drv.c:59:1: warning: paramete=
r names (without types) in function declaration [enabled by default]
> ../drivers/platform/x86/intel_pmc_core_plat_drv.c:60:1: warning: data def=
inition has no type or storage class [enabled by default]
>  module_exit(pmc_core_platform_exit);
>  ^
> ../drivers/platform/x86/intel_pmc_core_plat_drv.c:60:1: error: type defau=
lts to =E2=80=98int=E2=80=99 in declaration of =E2=80=98module_exit=E2=80=
=99 [-Werror=3Dimplicit-int]
> ../drivers/platform/x86/intel_pmc_core_plat_drv.c:60:1: warning: paramete=
r names (without types) in function declaration [enabled by default]
> ../drivers/platform/x86/intel_pmc_core_plat_drv.c:42:19: warning: =E2=80=
=98pmc_core_platform_init=E2=80=99 defined but not used [-Wunused-function]
>  static int __init pmc_core_platform_init(void)
>                    ^
>
> and
> WARNING: modpost: missing MODULE_LICENSE() in drivers/platform/x86/intel_=
pmc_core_plat_drv.o
>
> --
> ~Randy



--=20
With Best Regards,
Andy Shevchenko

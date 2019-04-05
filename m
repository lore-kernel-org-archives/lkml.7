Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5C021872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJCYUFqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfDEOFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:05:09 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37671 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfDEOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:05:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so3097896ply.4;
        Fri, 05 Apr 2019 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2ReBw8p6BvVMoS2amLFJIUrT29OseEsI3YUdhLf3s8M=;
        b=jJCYUFqAt4jgMaYL5ZHCpfv3o/zH6SMTTKDQcPy77i/DhRxtZ9v37+MNZV3gGnGkii
         WNcsOPq0zl/EIDXopjoaT143HpX946tuJ0FHsyt2YsddWw9KzjK8mEWxIgu9nt1gMLcc
         js/MTnk9FGw9K3kAmF3PBwEsMNTjQzbXVZTn0aPQTG2u7KOCfHk1HAU5ng/8sRI1T+2b
         km8o2CuICHnE+8jMpoNCRmjp78JPWFaZVSrxf0mMpnIPoykqJpndr8Iyyq2XHuKUS8Go
         IRkOS+aOQPD3qeGTuk/yXAJiFD+rJnAwtIGKpVXPT8IV+wyHR24gjVh9qBB3hgNG37XR
         oAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2ReBw8p6BvVMoS2amLFJIUrT29OseEsI3YUdhLf3s8M=;
        b=WDBH+V+TGkIap2mVJIBTwyj2Ey8VLm3LPi6OZswuAgjUw2dFvB2tGdZuoceiIZK4RV
         dvDClgV+ZjsUserb4G9qmc/0V8akBs0E3BdSGy+Xnagd1yyW6+1TFPz2CQQr3CHXJ1E0
         vPdTJfaGcMBwV5Y+o5Ylsukhgk3xGkwrgZV2dSa0NGz59S+slMgNOItQAL0wAVCZrok3
         yNm2UDrcqi/tR9FC9pLgW75b1PLslMVdzhFZH8F9yhDE5q8ADkHts34GwSR0NlqyFbUI
         sAHWJQE52Tm4mMhyvC6xQba2FKSHkxgACVzqXqJdL2bLqRpshXjyenVcObvcIK+C38i2
         8AXg==
X-Gm-Message-State: APjAAAW2AaBXRtYTx7fdAuJfbKaFwe2ovdPjSkIJdXPAsCCdMxcMigG/
        NSSWe+WYJImJrty2+vQi+tss0T7JoejWcs4j4GQ=
X-Google-Smtp-Source: APXvYqwJQUW529bS9mcQjuqyTzKVmEwQP+ZC9ptSvLYO4XaaX7jAsK8UzTgWc+7mkdoPIBSQ2Ipf5xDwmfADy6xeAs8=
X-Received: by 2002:a17:902:e091:: with SMTP id cb17mr13412832plb.222.1554473108062;
 Fri, 05 Apr 2019 07:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <17631.1552389966@turing-police> <20190312224611.elsl2buuhkddecih@pali>
In-Reply-To: <20190312224611.elsl2buuhkddecih@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Apr 2019 17:04:56 +0300
Message-ID: <CAHp75Vft=SfD0BEsM8hOUuHKVBa_-p_-mk4c6odrFjkbuYtO1A@mail.gmail.com>
Subject: Re: [PATCH] drivers/platform/x86/dell-rbtn.c - add missing #include
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:46 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> On Tuesday 12 March 2019 07:26:06 Valdis Kl=C4=93tnieks wrote:
> > Building with W=3D1 complains:
> >   CC [M]  drivers/platform/x86/dell-rbtn.o
> > drivers/platform/x86/dell-rbtn.c:345:5: warning: no previous prototype =
for 'dell_rbtn_notifier_register' [-Wmissing-prototypes]
> >   345 | int dell_rbtn_notifier_register(struct notifier_block *nb)
> >       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/platform/x86/dell-rbtn.c:371:5: warning: no previous prototype =
for 'dell_rbtn_notifier_unregister' [-Wmissing-prototypes]
> >   371 | int dell_rbtn_notifier_unregister(struct notifier_block *nb)
> >       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Can you identify in which commit was introduced this problem? If yes,
> then Fixes: keyword should be added into commit message.
>

Pushed to my review and testing queue, thanks!

P.S. I have added Fixes tag.

> >
> > The real problem is a missing include. Add it to keep dell-rbtn.c and .=
h in sync
> >
> > Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> >
> > diff --git a/drivers/platform/x86/dell-rbtn.c b/drivers/platform/x86/de=
ll-rbtn.c
> > index f3afe778001e..d50ca96d99f0 100644
> > --- a/drivers/platform/x86/dell-rbtn.c
> > +++ b/drivers/platform/x86/dell-rbtn.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/rfkill.h>
> >  #include <linux/input.h>
> > +#include "dell-rbtn.h"
> >
> >  enum rbtn_type {
> >       RBTN_UNKNOWN,
> >
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
With Best Regards,
Andy Shevchenko

Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4286DC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F31B205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgAHIS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:18:27 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:36587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAHIS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:18:27 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N0G5n-1jab9q2o4d-00xKuk for <linux-kernel@vger.kernel.org>; Wed, 08 Jan
 2020 09:18:25 +0100
Received: by mail-qv1-f42.google.com with SMTP id o18so1057494qvf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 00:18:25 -0800 (PST)
X-Gm-Message-State: APjAAAXx7YaQk0PxpQ2n8opEwXWHRwNnxY59U3ngOyMaAe/BygTpkK1y
        Rh+SJ2PdEcWVpytIv+18SXuRxFd883JYZKAB1gA=
X-Google-Smtp-Source: APXvYqw0ZBNJxzzyqnFyauYwGWHsDYTX8zgJMSpwqoHcf3dieGCqPMdb2QQItS7mU7UFLZCj05288vbPPvGH5wUT7Io=
X-Received: by 2002:a0c:d788:: with SMTP id z8mr2851256qvi.211.1578471504503;
 Wed, 08 Jan 2020 00:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20200107212509.4004137-1-arnd@arndb.de> <20200108091528.2c89d97f@xps13>
In-Reply-To: <20200108091528.2c89d97f@xps13>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jan 2020 09:18:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Q+-zYhkw_CpanXis7iM=9Hqw1Et8-GwxYw5d5Qy-sQA@mail.gmail.com>
Message-ID: <CAK8P3a0Q+-zYhkw_CpanXis7iM=9Hqw1Et8-GwxYw5d5Qy-sQA@mail.gmail.com>
Subject: Re: [PATCH] mtd: sm_ftl: fix NULL pointer warning
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ikF0SShA2SnpNlUrvMlaqnepFl52sQ+iqqhZe8uq0vMNxVNb0T6
 3wQ+yOasyr5bSwfw4oMe8eTeOHq7MnJBqHPVla7r5jORjL2BT1O6bHa/kOs9M4Uu7hEl1GA
 gQva9kMSIB5WfDCtT3U4a1MfhJyNa+gZuNEwfKmSv9fTWV1o5reYyqvr+y6LY+RBJbdMBzD
 DsDZn829u6sp0h3eR3xzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wu+mK83V2tg=:MAuLS4lgg/yFo1LEVEDXfv
 bA0UI9Z6lj5YNvejyEolbOOrMwY+13Z1x0jnHQ8HC9D7Nd9bn9uzs3LYfZf72l56u7/LDe+oU
 SF1n/QxDixGwtmUk5cegLG8X6TN0orq+QRx0vRGGKsGCzbw8nGGR7aY9b77SLxowWxqyhmX2U
 lRAM8uNIRNUTrqN48g1UdqWH2TqDOoe5xDJKsDPmwpraVq4RW2o5Mt5Y/DLzaEveYaixNclTP
 7tvlXyl1nu0pN8SXl1p7KKvfiObYJOBgD5JSIlyQJqHhFL0toR4pAb5M6qAq0FeeQ2bn6dj1c
 UgD2yM5xQ0K7og6JF7tp51zKEz+1+JjwB9Eg6ZNr8bT9P8uy5g62GyIHfzx5ZXaC2GgrrXU6H
 3cT7KsjTygb3m1ZkBOOTKakXqeA52C3AHA0E7/C2YKAzCuT0AnMo4Qh7R7uJL3zMRonFOmOym
 bIELUsJKukCTJjVh+6qJt4kJZw3mB5PhkRG3vJtjO5tnGhJ+jmCa3rCcFAUQm/Iuf0Ma919iE
 2g+YRMhOA+jzxA5UeJvq3n7FZnoHgyj4KXu/kbxVsbT0+9uAmdXBRuhFY3lqyjGtEZoTWLTeO
 bzsJPOzidQMxDa0RjqXyAb41iV0Rzeo3HF69IrUx3k8epiWEcKQsyVyt+gsogMMh5Z4CsLAPE
 8t/kCPl69DQhrGPUPBI7uwK5WgAxHQjTrczTQLhWVV0/uVV3v5qwMtWklismyCkH8hbkEZKGV
 xBliRR5L0lumYZduWMpdExAB5cnarz5xTihsfbO4L6a73p67kcZvIumhtYor19hWsbUCbJ1E7
 cZOu8bxdRV5iaXT+jfIYHIr99CiqQsuASVQGda1qf+DL+IQmif7L2Mcs+svarBAzAV7ph2Irq
 Tx3OXUN3gWY7bI/V1DOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 9:15 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Arnd,
>
> Arnd Bergmann <arnd@arndb.de> wrote on Tue,  7 Jan 2020 22:24:52 +0100:
>
> > With gcc -O3, we get a new warning:
> >
> > In file included from arch/arm64/include/asm/processor.h:28,
> >                  from drivers/mtd/sm_ftl.c:8:
> > In function 'memset',
> >     inlined from 'sm_read_sector.constprop' at drivers/mtd/sm_ftl.c:250:3:
> > include/linux/string.h:411:9: error: argument 1 null where non-null expected [-Werror=nonnull]
> >   return __builtin_memset(p, c, size);
> >
> > From all I can tell, this cannot happen (the function is called
> > either with a NULL buffer or with a -1 block number but not both),
> > but adding a check makes it more robust and avoids the warning.
> >
> > Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/mtd/sm_ftl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
> > index 4744bf94ad9a..b9f272408c4d 100644
> > --- a/drivers/mtd/sm_ftl.c
> > +++ b/drivers/mtd/sm_ftl.c
> > @@ -247,7 +247,8 @@ static int sm_read_sector(struct sm_ftl *ftl,
> >
> >       /* FTL can contain -1 entries that are by default filled with bits */
> >       if (block == -1) {
> > -             memset(buffer, 0xFF, SM_SECTOR_SIZE);
> > +             if (buffer)
> > +                     memset(buffer, 0xFF, SM_SECTOR_SIZE);
> >               return 0;
> >       }
> >
>
> What about a simpler form:
>
>         if (buffer && block == -1) { ...
>
> Instead of an additional indentation level?

That would fail to return early from the function if we ever get block==-1
and buffer==NULL, probably resulting is worse problems later.

       Arnd

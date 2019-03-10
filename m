Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E3CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 19:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED37B20652
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 19:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="h11Kd8me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfCJT0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 15:26:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42821 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfCJT0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 15:26:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id u7so2790403qtg.9;
        Sun, 10 Mar 2019 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OoL9XEI9fQDaF/BNmKrMzNbBnKchcPQ513u4QH8nENk=;
        b=h11Kd8meciJCBSpcAEiRW5DH6pBfNunBD0Lx8oAGucO7806RwCw8/qMllph5Fpqsm0
         jsNVb6Lst41s/VBy8OndyMZQ0CHk6DdMt303pLEhD5hyMBUnJUXqPymh84sHnYylNxoC
         EG9ISev6DtXgt9Lzt2uzNrt9Mf8fQvlI455ggddeEb9ZWYeUEN4ge+JKWpKM4/IEJi78
         5MVOFsEbwavyZJlMdqG46ZciX6o28sLQA0307xw26ynjRJ47rIp2aTfd5lRnRvdXK22e
         /Zdwk9fWNLzkwXzDwqkHDMGomw9ig8iOGekKlO39HeGP47RiYtrSwCitteIc/hbJmUjv
         taTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OoL9XEI9fQDaF/BNmKrMzNbBnKchcPQ513u4QH8nENk=;
        b=XD+BuAwx/4WtLXDPHSyIcIDBTATn2q3QmN74q2QxAaiwS8XJ5wFVSaoVLAzWfUzOBQ
         C+LQ2Qt/7zUT38mR7Sss5uIY8R+FztwvEJ+Dn1eXS7L/RnAMRfM4rnzRKarTi2aCCach
         6JfoNeaTaslPFIMW2vZMj5EEAUbGYO2l+24G61X+brtBNy80MznNV+73Wqh1t1mn/fO2
         EPhgD3dqO/84shtmAjm56OLsYe2BzZB9o+2dqD8Ne0t6v2E5oM4H40J+UiNno6dnP3cs
         hUAUM8yr1RMovw3fCFK1/VLkXevq9mws7+qbTKsX4GYjoUyVEO+xSBjd55zpMMhy1Ed0
         1pqg==
X-Gm-Message-State: APjAAAWtqtpi3X+1hxUuHmLEySPqpXhZkyLH8Cw8vXlYcf4iODOd/5oe
        W6JDJkhbx6K1jLnDnP8brOorYeULoJbf8oA68NM=
X-Google-Smtp-Source: APXvYqwSI4EYsiWj5hkBffbRSXkceGmd1yGOstkFnDVqHdzC5hRi1ovQeu+nDfwirtkH3DFaQBKtzHHddXB2Nv9kpew=
X-Received: by 2002:ac8:48cd:: with SMTP id l13mr4054789qtr.330.1552245970960;
 Sun, 10 Mar 2019 12:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <1546173604-26066-1-git-send-email-minipli@googlemail.com>
 <20190102202938.GA26600@linux-8ccs> <CA+rthh87tutLV=857g-Nrd6gAYK8xhRJX8MqpjC+CnmsjTqqJg@mail.gmail.com>
In-Reply-To: <CA+rthh87tutLV=857g-Nrd6gAYK8xhRJX8MqpjC+CnmsjTqqJg@mail.gmail.com>
From:   Mathias Krause <minipli@googlemail.com>
Date:   Sun, 10 Mar 2019 20:26:00 +0100
Message-ID: <CA+rthh_OnmvQQbKAG55rha56HCp2vjhZMv0ahRdgJjbjmG=xRA@mail.gmail.com>
Subject: Re: [PATCH] vmlinux.lds.h: drop unused __vermagic
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

On Mon, 21 Jan 2019 at 12:39, Mathias Krause <minipli@googlemail.com> wrote:
>
> On Wed, 2 Jan 2019 at 21:29, Jessica Yu <jeyu@kernel.org> wrote:
> >
> > +++ Mathias Krause [30/12/18 13:40 +0100]:
> > >The reference to '__vermagic' is a relict from v2.5 times. And even
> > >there it had a very short life time, from v2.5.59 (commit 1d411b80ee18
> > >("Module Sanity Check") in the historic tree) to v2.5.69 (commit
> > >67ac5b866bda ("[PATCH] complete modinfo section")).
> > >
> > >Neither current kernels nor modules contain a '__vermagic' section any
> > >more, so get rid of it.
> > >
> > >Signed-off-by: Mathias Krause <minipli@googlemail.com>
> > >Cc: Rusty Russell <rusty@rustcorp.com.au>
> > >Cc: Jessica Yu <jeyu@kernel.org>
> >
> > Thanks for the cleanup.
> >
> > Reviewed-by: Jessica Yu <jeyu@kernel.org>
> >
>
> Arnd, will you carry this patch through your asm-generic tree or did
> the MAINTAINERS file mislead me here?
>

looks like Arnd keeps ignoring my Emails. :/ Can you carry this patch
through your module tree? Or do you think I should ask Andrew Morton
instead?

Thanks,
Mathias

> > >---
> > > include/asm-generic/vmlinux.lds.h | 1 -
> > > 1 file changed, 1 deletion(-)
> > >
> > >diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > >index 3d7a6a9c2370..530ce1e7a1ec 100644
> > >--- a/include/asm-generic/vmlinux.lds.h
> > >+++ b/include/asm-generic/vmlinux.lds.h
> > >@@ -332,7 +332,6 @@
> > >               __start_rodata = .;                                     \
> > >               *(.rodata) *(.rodata.*)                                 \
> > >               RO_AFTER_INIT_DATA      /* Read only after init */      \
> > >-              KEEP(*(__vermagic))     /* Kernel version magic */      \
> > >               . = ALIGN(8);                                           \
> > >               __start___tracepoints_ptrs = .;                         \
> > >               KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> > >--
> > >2.19.2
> > >

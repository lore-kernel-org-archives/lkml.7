Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3465FC3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7502133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 13:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IkgaQBVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfJENSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 09:18:31 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:59668 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfJENSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 09:18:31 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x95DIFn5003042
        for <linux-kernel@vger.kernel.org>; Sat, 5 Oct 2019 22:18:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x95DIFn5003042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570281496;
        bh=XQQrQV2coAXu1tGXYRqn7BxTASrf27/RFdYiV7yFz0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IkgaQBVK/FasoKk5jnljJNgAWtUqRrFYMsiJXUInfqW5sk5y1bRs8N/W8KNT2wku0
         ImUAYt24bZx/a0NfsDRa7Kds4E9YINpTDcleZphGKpKftb636jtgscxgF8/xkSl0Er
         BoNkk5cHMDW862/0O5+9GwhCpkG+eHKGJ5qRpiH84zDCI5sibCmCVCh4IFQkHmLzOw
         JAL1jvMgs7Ln1YKg/cFNxihbBOWq+zPORF8XyDGI10m/zWMYWx7mM5DaDuHq7OGFuL
         QxjQJE15AQHaSz4mXGve6ji2nbzNyQsvByR8Axjvetw62zII1Q8qJdQiAHjTup7nxu
         ey/bxdQH8QqHQ==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id p13so5974356vsr.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 06:18:16 -0700 (PDT)
X-Gm-Message-State: APjAAAUSNJ5U6OhV9lQlfw9tyAMWBKqfuoETaj61eNx5AnGUtMV8ryce
        EGXYT/s2s4BGqtgVFSi9JtTeysBtjsoZz1eAYpM=
X-Google-Smtp-Source: APXvYqwMWW182r99fqvM9st0TK29KgPJC2MzzA7Pu525peSQbJh6575OlRWXvg6QRM+OF+tg5eRbi1OQXSGb6wKUMhc=
X-Received: by 2002:a67:7c03:: with SMTP id x3mr10789661vsc.155.1570281495237;
 Sat, 05 Oct 2019 06:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <cf947abb-c94e-9b6f-229a-1e219fd38e94@skogtun.org>
 <CAK7LNAS-msvdv+=msqfSYX3ZKPQm_AJ0B=Uu7hfah1V+NGPjmQ@mail.gmail.com>
 <240d0353-2e66-7d0c-3dc0-f58f62c999be@skogtun.org> <fafb9730-6d0c-eac1-e2e2-374de509244a@skogtun.org>
 <CAK7LNARsDQU11GGA3N11zERJdiGFCDR=fS6LtTUXfj5TZBEj4w@mail.gmail.com> <d0259e98-225c-58f8-1640-04322c621690@skogtun.org>
In-Reply-To: <d0259e98-225c-58f8-1640-04322c621690@skogtun.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 5 Oct 2019 22:17:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNATF=50am-TBOAvr8-O+usgyczyfbDYbMp3MAmAKu46-1A@mail.gmail.com>
Message-ID: <CAK7LNATF=50am-TBOAvr8-O+usgyczyfbDYbMp3MAmAKu46-1A@mail.gmail.com>
Subject: Re: BISECTED: Compile error on 5.4-rc1
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 7:50 PM Harald Arnesen <harald@skogtun.org> wrote:
>
> Masahiro Yamada [05.10.2019 12:19]:
>
> > CONFIG_SHELL previously fell back to 'sh' when bash is not installed,
> > so I just kept it as it was.
> >
> > If we had used the exact absolute path /bin/sh,
> > it would have worked irrespective of the PATH environment.
> >
> > But, there is a counter option like this:
> >
> >
> > commit 16f8259ca77d04f95e5ca90be1b1894ed45816c0
> > Author: Bj=C3=B8rn Forsman <bjorn.forsman@gmail.com>
> > Date:   Sun Nov 5 10:44:16 2017 +0100
> >
> >     kbuild: /bin/pwd -> pwd
> >
> >     Most places use pwd and rely on $PATH lookup. Moving the remaining
> >     absolute path /bin/pwd users over for consistency.
> >
> >     Also, a reason for doing /bin/pwd -> pwd instead of the other way a=
round
> >     is because I believe build systems should make little assumptions o=
n
> >     host filesystem layout. Case in point, we do this kind of patching
> >     already in NixOS.
> >
> >     Ref. commit 028568d84da3cfca49f5f846eeeef01441d70451
> >     ("kbuild: revert $(realpath ...) to $(shell cd ... && /bin/pwd)").
> >
> >     Signed-off-by: Bj=C3=B8rn Forsman <bjorn.forsman@gmail.com>
> >     Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> >
> >
> > I cannot find a way to satisfy everybody.
> >
>
> I'm totally fine with the way it is now, now that I know how it works.
> However, doesn't Posix dictate that there is a /bin/sh?


As for POSIX, I found this:

---------------------->8----------------------------
Applications should note that the standard PATH to the shell cannot
be assumed to be either /bin/sh or /usr/bin/sh, and should be determined
by interrogation of the PATH returned by getconf PATH , ensuring that
the returned pathname is an absolute pathname and not a shell built-in.
---------------------->8----------------------------

https://pubs.opengroup.org/onlinepubs/009695399/utilities/sh.html


--=20
Best Regards
Masahiro Yamada

Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38364C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE514222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cAukObZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfJEKUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 06:20:37 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:28652 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfJEKUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 06:20:36 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x95AKXHM024345
        for <linux-kernel@vger.kernel.org>; Sat, 5 Oct 2019 19:20:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x95AKXHM024345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570270833;
        bh=kv1TVlZxgB2c5EKc2iXk+e359JOFbt4NOZtOSVP9SpE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cAukObZpBqWxGlpYOWJxEU1vnD39ECyQnHXsjNrwkGibVc1CR9ZNuN1Dofzh6X6c2
         XnwiV3zR9KslyithUnTQ4+WS+CpU3qjiMl0piq1AwOQYUfelgTj9QMMGSxz1OSRPhW
         94yYJ6bVfTRYKBAQKp0UatBz+waCrUnAMohsRygbfsoUWDdX30uJn0pWP9KqFaW7OW
         CCQLaaqgSCS0ayDLBQki4n+gYRPDCubY7r1JH7j5nYXSFK1kaRfz8lJfxJ413Irg8l
         uXs6BXNi5s1UPrsi/tFqIbGi4/PZWMogBQi4TTtQPGuQjl9j13IPzcN7BsqUPfIwKl
         jAwjdKzcoCVIQ==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id z14so5765613vsz.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 03:20:33 -0700 (PDT)
X-Gm-Message-State: APjAAAU+c4YiZP9YkEOFVEJfsvLCZ/5RWDEL2lwTVYvgGmRj+ceQkPSr
        NPNr9DuW9UH/rRPhn5vxF3g7nBg7jIXyA5ROINg=
X-Google-Smtp-Source: APXvYqxkpiCLv0VztURUIw4KpiBwLzdzZt8azaSByyCCaLCQuihoRUSFTykPbb0RQRFIBHa9XIZy86h6RIL5xE9KfkY=
X-Received: by 2002:a67:7c03:: with SMTP id x3mr10493136vsc.155.1570270832499;
 Sat, 05 Oct 2019 03:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <cf947abb-c94e-9b6f-229a-1e219fd38e94@skogtun.org>
 <CAK7LNAS-msvdv+=msqfSYX3ZKPQm_AJ0B=Uu7hfah1V+NGPjmQ@mail.gmail.com>
 <240d0353-2e66-7d0c-3dc0-f58f62c999be@skogtun.org> <fafb9730-6d0c-eac1-e2e2-374de509244a@skogtun.org>
In-Reply-To: <fafb9730-6d0c-eac1-e2e2-374de509244a@skogtun.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 5 Oct 2019 19:19:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNARsDQU11GGA3N11zERJdiGFCDR=fS6LtTUXfj5TZBEj4w@mail.gmail.com>
Message-ID: <CAK7LNARsDQU11GGA3N11zERJdiGFCDR=fS6LtTUXfj5TZBEj4w@mail.gmail.com>
Subject: Re: BISECTED: Compile error on 5.4-rc1
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 6:36 PM Harald Arnesen <harald@skogtun.org> wrote:
>
> Harald Arnesen [05.10.2019 11:03]:
>
> > Masahiro Yamada [05.10.2019 05:24]:
> >
> >> I cannot reproduce it.
> >>
> >> I tested bindeb-pkg for the latest Linus tree successfully.
> >
> > Strange, I have now tried another machine running the same distro
> > (Devuan Beowulf), and I get the same result there. Will check further.
>
> I found out what was wrong.
>
> Both machines have been used for dvd burning, and I have used J=C3=B6rg
> Schilling's cdrecord - and I had installed all of the "Schily Tools",
> which unfortunately includes a shell command. Now, I had (by mistake)
> /opt/schily/bin early in my path, and his OpenSolaris-derived shell
> didn't work as expected.
>
> Moving /opt/schily/bin to the end of the path fixes the problem.
>
> But shouldn't it work even if "sh" is not equal to "/bin/sh"?


CONFIG_SHELL previously fell back to 'sh' when bash is not installed,
so I just kept it as it was.

If we had used the exact absolute path /bin/sh,
it would have worked irrespective of the PATH environment.

But, there is a counter option like this:


commit 16f8259ca77d04f95e5ca90be1b1894ed45816c0
Author: Bj=C3=B8rn Forsman <bjorn.forsman@gmail.com>
Date:   Sun Nov 5 10:44:16 2017 +0100

    kbuild: /bin/pwd -> pwd

    Most places use pwd and rely on $PATH lookup. Moving the remaining
    absolute path /bin/pwd users over for consistency.

    Also, a reason for doing /bin/pwd -> pwd instead of the other way aroun=
d
    is because I believe build systems should make little assumptions on
    host filesystem layout. Case in point, we do this kind of patching
    already in NixOS.

    Ref. commit 028568d84da3cfca49f5f846eeeef01441d70451
    ("kbuild: revert $(realpath ...) to $(shell cd ... && /bin/pwd)").

    Signed-off-by: Bj=C3=B8rn Forsman <bjorn.forsman@gmail.com>
    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>



I cannot find a way to satisfy everybody.



--=20
Best Regards
Masahiro Yamada

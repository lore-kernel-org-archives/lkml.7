Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B204C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B222084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vv7ynCE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfDKJHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:07:14 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:42222 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfDKJHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:07:05 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x3B9705Y017234
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 18:07:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x3B9705Y017234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554973621;
        bh=mYf69teb1w40PjpdABpc04QokK96/tr8qjs1lzvWhQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vv7ynCE20ulJzkSpVTvK7VbIVwqFn3q5mvIRAB3XDfGLQcJzp+5qPXnoACIMSodMn
         UtkqcuEReYV9eikX1jDNMOf0q26hHDclxFq0avJnAljhunQUEi3YFgID1jwMlW5UT2
         4dBqZd6bZBJxvwVofr/Ic09qB93xWmR1Z8g+PiUV5+9+uFmaUpbS02kgUA39f3boXJ
         XHJl8XSvuijoupgGTBjRbR1zVkQ9CTcYS/a9ONmdNDE0DfSPPEdxwk0iBlTddnzULs
         bFnsfOzVEjJ+ndh1R9wYnI7425i6XRjd3wOTyxOJRIUT4h06RxIkKZrXmzWVTEQElK
         rrzC+GGxJRxHA==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id n4so3056799vsm.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:07:00 -0700 (PDT)
X-Gm-Message-State: APjAAAV90KlBBQh2Yg9Y1722rJioomnn/CV7pZvYw7B8B1XRIi/HpYeb
        Y0Hlgzc2p1fPUwJcUC/8adx3KhcGTiZO2X7wcME=
X-Google-Smtp-Source: APXvYqw8QU1IunP9m0CAvDkHqxqQRA/Qjb/nH35g0v378SoiwVbAww1OliBtAJ2is7fjp8lYbzJpRkqx0uGvQZtrJ54=
X-Received: by 2002:a67:818e:: with SMTP id c136mr27077719vsd.65.1554973619704;
 Thu, 11 Apr 2019 02:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190323015227.245455-1-dianders@chromium.org>
In-Reply-To: <20190323015227.245455-1-dianders@chromium.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Apr 2019 18:06:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNARYMy2=viA1et9tZk409M=OSteD5D675oAKQEs6SG77HQ@mail.gmail.com>
Message-ID: <CAK7LNARYMy2=viA1et9tZk409M=OSteD5D675oAKQEs6SG77HQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: Get rid of broken attempt to print CCVERSION in kdb summary
To:     Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicholas Mc Guire <hofrat@osadl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,


On Sat, Mar 23, 2019 at 10:55 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> If you drop into kdb and type "summary", it prints out a line that
> says this:
>
>   ccversion  CCVERSION
>
> ...and I don't mean that it actually prints out the version of the C
> compiler.  It literally prints out the string "CCVERSION".
>
> The version of the C Compiler is already printed at boot up and it
> doesn't seem useful to replicate this in kdb.  Let's just delete it.
> We can also delete the bit of the Makefile that called the C compiler
> in an attempt to pass this into kdb.  This will remove one extra call
> to the C compiler at Makefile parse time and (very slightly) speed up
> builds.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>


I know you add lots of Cc: lines
when you pick up patches, but I think
your script can be improved.

You added "Cc: Douglas Anderson <dianders@chromium.org>",
but Douglas is the author.
I think the author should be excluded from Cc.




This commit looks as follows in linux-next:

commit 685dc1264544c947d26963dcf1ac982d3408f444
Author: Douglas Anderson <dianders@chromium.org>
Date:   Wed Apr 10 11:02:35 2019 +1000

    kdb: det rid of broken attempt to print CCVERSION in kdb summary

    If you drop into kdb and type "summary", it prints out a line that says
    this:

      ccversion  CCVERSION

    ...and I don't mean that it actually prints out the version of the C
    compiler.  It literally prints out the string "CCVERSION".

    The version of the C Compiler is already printed at boot up and it doesn't
    seem useful to replicate this in kdb.  Let's just delete it.  We can also
    delete the bit of the Makefile that called the C compiler in an attempt to
    pass this into kdb.  This will remove one extra call to the C compiler at
    Makefile parse time and (very slightly) speed up builds.

    Link: http://lkml.kernel.org/r/20190323015227.245455-1-dianders@chromium.org
    Signed-off-by: Douglas Anderson <dianders@chromium.org>
    Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Cc: Douglas Anderson <dianders@chromium.org>
    Cc: Jason Wessel <jason.wessel@windriver.com>
    Cc: Christophe Leroy <christophe.leroy@c-s.fr>
    Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
    Cc: Kees Cook <keescook@chromium.org>
    Cc: Johannes Weiner <hannes@cmpxchg.org>
    Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
    Cc: Nicholas Mc Guire <hofrat@osadl.org>,
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>



> ---
>
>  kernel/debug/kdb/Makefile   | 1 -
>  kernel/debug/kdb/kdb_main.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/kernel/debug/kdb/Makefile b/kernel/debug/kdb/Makefile
> index d4fc58f4b88d..efac857c5511 100644
> --- a/kernel/debug/kdb/Makefile
> +++ b/kernel/debug/kdb/Makefile
> @@ -6,7 +6,6 @@
>  # Copyright (c) 2009 Wind River Systems, Inc. All Rights Reserved.
>  #
>
> -CCVERSION      := $(shell $(CC) -v 2>&1 | sed -ne '$$p')
>  obj-y := kdb_io.o kdb_main.o kdb_support.o kdb_bt.o gen-kdb_cmds.o kdb_bp.o kdb_debugger.o
>  obj-$(CONFIG_KDB_KEYBOARD)    += kdb_keyboard.o
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 82a3b32a7cfc..fc96dbf8d9de 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -2522,7 +2522,6 @@ static int kdb_summary(int argc, const char **argv)
>         kdb_printf("machine    %s\n", init_uts_ns.name.machine);
>         kdb_printf("nodename   %s\n", init_uts_ns.name.nodename);
>         kdb_printf("domainname %s\n", init_uts_ns.name.domainname);
> -       kdb_printf("ccversion  %s\n", __stringify(CCVERSION));
>
>         now = __ktime_get_real_seconds();
>         time64_to_tm(now, 0, &tm);
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Best Regards
Masahiro Yamada

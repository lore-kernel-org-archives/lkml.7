Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA979C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 04:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D22E204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 04:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="u/pMjtK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCGEEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 23:04:10 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:42268 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfCGEEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 23:04:09 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x2743pwI029647;
        Thu, 7 Mar 2019 13:03:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2743pwI029647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551931432;
        bh=T0XOCFQPWvyCh+xcWOza88cRH27nM5Hy5y8DIuMyUuw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u/pMjtK0hIBi7BNzBE630kPzxEzE1wiKWkma5W09Lfqkg9Lj3oMXDjJt3JgNERk6V
         CprDMiADvHDHpuRmiWjFfr2aIXRkbYZ+D5C0Mc37sUvGkqFEXgi8WtHBUl0FfnG9ne
         uyymz8YJYUP1/ehgZSwjdCZb1nVJ74oXmDtON6kNXTGhrO3GdHNmHbkQX1xWqtVkW1
         UqWiNLS95keIS78vWI4kcicBm2Em9RYRs37gMmxOwFifXHWp4aJemNp6OWx77O1bUL
         onar13abGbMduyv3DTqlwhAwusaHbizo1zlMf5o7nChBvvqoJWzcF0DVUSaibpJp2v
         KwGKsRac5pzQw==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id h132so3651958vsd.5;
        Wed, 06 Mar 2019 20:03:51 -0800 (PST)
X-Gm-Message-State: APjAAAXvXtNnYVZACChGXWklDfL3TpO7m/6umjJDaWtSSF1cBVrSaGt/
        6Qr10yylc+m0LyqyJ4/lgZ3Fs4jurAiaMDyvO+c=
X-Google-Smtp-Source: APXvYqzvwcRi+lW1nubkxMSoUEVooF0HiTYq2g2YTIUC9og/Vmdz4+cZx/1XFTt5EPVDqWeY3LkVkztnaGfp3kJEqQc=
X-Received: by 2002:a67:7bd3:: with SMTP id w202mr5847973vsc.179.1551931430410;
 Wed, 06 Mar 2019 20:03:50 -0800 (PST)
MIME-Version: 1.0
References: <1551888035-13329-1-git-send-email-yamada.masahiro@socionext.com> <5760e0a210c7c39b486aa932ccbe7f3f2c210d62.camel@decadent.org.uk>
In-Reply-To: <5760e0a210c7c39b486aa932ccbe7f3f2c210d62.camel@decadent.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 7 Mar 2019 13:03:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQFWWzki-MvmhDpAn46XkDAu4_EGCQotbi5qAk5oJrgUQ@mail.gmail.com>
Message-ID: <CAK7LNAQFWWzki-MvmhDpAn46XkDAu4_EGCQotbi5qAk5oJrgUQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add workaround for Debian make-kpkg
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Liz Zhang <lizzha@microsoft.com>,
        Lili Deng <v-lide@microsoft.com>,
        Riku Voipio <riku.voipio@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manoj Srivastava <manoj.srivastava.1962@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 6:02 AM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> [Trying again with an alternate address for Manoj.]
>
> kernel-package is maintained by Manoj Srivastava (cc'd), not by the
> Debian kernel team.
>
> On Thu, 2019-03-07 at 01:00 +0900, Masahiro Yamada wrote:
> > Since commit 3812b8c5c5d5 ("kbuild: make -r/-R effective in top
> > Makefile for old Make versions"), make-kpkg is not working.
> >
> > make-kpkg directly includes the top Makefile of Linux kernel, and
> > appends some debian_* targets.
> >
> >   /usr/share/kernel-package/ruleset/kernel_version.mk:
> >
> >     # Include the kernel makefile
> >     override dot-config := 1
> >     include Makefile
> >     dot-config := 1
> >
> > I did not know the kernel Makefile was used in that way, and it is
> > hard to guarantee the behavior when the kernel Makefile is included
> > by another Makefile from a different project.
> >
> > Looks like Debian Stretch stopped providing make-kpkg (except
> > PowerPC).
>
> kernel-package is not included in stretch at all.  I'm not sure where
> you're seeing it as being present on powerpc - that architecture wasn't
> included in the stretch release.


Actually, I have not checked the powerpc part by myself.


I just read the following page:

https://unix.stackexchange.com/questions/238469/difference-between-make-kpkg-and-make-deb-pkg


"make-kpkg is included in wheezy and jessie but stretch (current
stable) only contains it for powerpc.

Powerpc is no longer supported in buster (testing)"



I will drop the PowerPC part.




> > Maybe it is obsolete and being replaced with 'make deb-pkg' etc.
> > but still widely used.
> [...]
>
> kernel-package is currently planned to be included in the next release,
> though I'm not sure whether it should be.

Hmm, OK.

I checked debian:buster in Docker,
and I see it.


root@3382de16960a:/home/foo# apt-file search  make-kpkg
kernel-package: /usr/bin/make-kpkg
kernel-package: /usr/share/man/man1/make-kpkg.1.gz
zsh-common: /usr/share/zsh/functions/Completion/Debian/_make-kpkg




If make-kpkg will still be included in the future Debian releases,
I'd like to change make-kpkg to make it work more reliably.


The git URL in the control file
"https://anonscm.debian.org/git/users/srivasta/debian/kernel-package.git"
seems stale.

Anyway, I found it in a new place:

$ git clone  https://salsa.debian.org/srivasta/kernel-package


Hmm, the last commit was three years ago.

So, it is almost unmaintained, I guess...


> There is another bug report about kernel-package with current kernel
> versions <https://bugs.debian.org/890817> but I don't know whether it
> has been worked around already.

Probably, not fixed.

It is not stalled actually.
I guess make-kpkg is hiding messages sent to stdout for some reasons.
If you continue pressing "Enter" key,
it will move on to the build stage.

I will take a look if it should be maintained.



Anyway, I want to hear from Manoj.


--
Best Regards
Masahiro Yamada

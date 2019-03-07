Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE45FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F0B20643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tJoPwnix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfCGPdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:33:10 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:65019 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGPdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:33:09 -0500
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x27FWmWD000306;
        Fri, 8 Mar 2019 00:32:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x27FWmWD000306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551972769;
        bh=YfjIYW+HIpiORMy8KChbuYS376y1l9RYm9Nuz1YEA7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tJoPwnixyySnw82kFgsPg7NTXztsYi4mXUS6Gh5EQOVYgqV3kIEsPIlWkLcsYKcHK
         X4zJurMsZ3NbMx5QWuT1e0GbKPwQSuOEdZyutWoXfL0HDVtOVCIRiGpF16tMCTbh4D
         3EtrvGGNyDvELnqVNpXXTJjghx9aiHUH3V7piHP77vme+Xvg3TnRNH3AmCkuNsQI0G
         aXa6Bi7S5lpz85n4Acjvtvlbeo88HoavxP1Q58QnsvBAGe72ksCPcBLM7YBT4qm+oG
         JYCOzkN3dBzm79vOdBe4ot9q7Zhy0dmhcvQZzTlRbjzvDe0imzKMkI+6KAdW9YKjSC
         hzaUNlEuwM48A==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id r201so4711340vsc.11;
        Thu, 07 Mar 2019 07:32:48 -0800 (PST)
X-Gm-Message-State: APjAAAW9Kj4dVO3jbvUhkI1CRr0+3UHyspwgfAMQHtfMi69TiRQ1IvDk
        84S8uO7TDXuLZwSZIYugtr4PD2zCBpQ+tzWCoxg=
X-Google-Smtp-Source: APXvYqwDt2znfVxQAk+IImUjxJoCf/Q9DzIFXca8aGCtr+3PNEFKsozIXAINE13If7WxOJGDxIiD0t3j91W2au/T6qM=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr7143871vsq.215.1551972767661;
 Thu, 07 Mar 2019 07:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20190221215901.23970-1-ar@cs.msu.ru>
In-Reply-To: <20190221215901.23970-1-ar@cs.msu.ru>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 8 Mar 2019 00:32:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQrN1e1GYRd760pWiAdgY9_7Jda3QD_zozTNHpHOim4Xg@mail.gmail.com>
Message-ID: <CAK7LNAQrN1e1GYRd760pWiAdgY9_7Jda3QD_zozTNHpHOim4Xg@mail.gmail.com>
Subject: Re: [PATCH] scripts/package/Makefile: put proper config in source tarball
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Riku Voipio <riku.voipio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 7:19 AM Arseny Maslennikov <ar@cs.msu.ru> wrote:
>
> It is widely known that one can build a kernel without a .config in the
> source tree

"without a .config in the source file"  means
KCONFIG_CONFIG will probably contain '..' or absolute path.



ex1)  KCONFIG_CONFIG=../my_dir/.config

ex2)  KCONFIG_CONFIG=/absolute/pass/to/my/.config





> by setting KCONFIG_CONFIG equal to the actual configuration
> file path.
>
> When making a *-pkg target, make(1) prepares a source tarball and tries
> to pack `.config' in there regardless of the value of KCONFIG_CONFIG,
> failing spectacularly if .config is absent and packing the wrong config
> if it exists.
> Let's fix that.


Did you notice the log 'Removing leading ...' from tar
for case ex1), ex2) ?


masahiro@grover:~/ref/linux$ make -j8  KCONFIG_CONFIG=../.config  deb-pkg
make clean
/bin/bash ./scripts/package/mkdebian
  TAR     linux-5.0.0+.tar.gz
tar: Removing leading `../' from member names
   ...


Even if I apply 3/3, it will produce a broken source package
since the tar will rip off the leading directory path,
then it mismatches to KCONFIG_CONFIG recorded in debian/rules.

A simple case like KCONFIG_CONFIG=my.config will work,
but I am not convinced with 3/3.




> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> ---
>  scripts/package/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/package/Makefile b/scripts/package/Makefile
> index 453fecee62f0..100a0d28ad25 100644
> --- a/scripts/package/Makefile
> +++ b/scripts/package/Makefile
> @@ -27,7 +27,7 @@ KDEB_SOURCENAME ?= linux-$(KERNELRELEASE)
>  KBUILD_PKG_ROOTCMD ?="fakeroot -u"
>  export KDEB_SOURCENAME
>  # Include only those top-level files that are needed by make, plus the GPL copy
> -TAR_CONTENT := $(KBUILD_ALLDIRS) .config .scmversion Makefile \
> +TAR_CONTENT := $(KBUILD_ALLDIRS) $(KCONFIG_CONFIG) .scmversion Makefile \
>                 Kbuild Kconfig COPYING $(wildcard localversion*)
>  MKSPEC     := $(srctree)/scripts/package/mkspec
>
> --
> 2.20.1
>


--
Best Regards
Masahiro Yamada

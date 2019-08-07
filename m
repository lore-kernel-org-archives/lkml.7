Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E623C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0379D21E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vekRQSa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfHGPLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:11:08 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:64822 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfHGPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:11:05 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x77FAuHI009710;
        Thu, 8 Aug 2019 00:10:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x77FAuHI009710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565190657;
        bh=67qqjSQgaI5xapbBsTJPeFasC6ZyVPxUa8DEePOjEzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vekRQSa3P0aA2Lt0Y0CKv6+bwcFu7HwdM7HAyDpK3IYWEDQ8AoR5NV/p+P8Mnj6eZ
         3W3vwlr2tmsU3NZI5lsj31pBxVswcQCfN3ZI4c9HvIw19y1L3mCkqmpmcfD6QebdsU
         DmNPs4p2U4wlZ547Qmm4e3gKPqqNo9MF4ZwR/40z0gmHBJspvOwLdU5POB+c+bAuWL
         4e26gXJQjxeiONu2Qsg36sCMuc71Vxfy+mKp1ByU/rcllOzjJmgAR1LfWErvlfoux/
         MwEVkY8JRlBa9mHu3XNnkOIoSoCxVi9PDE0qaRPhzIOJv9+nISwPJ4Vcoy/ZfHRM30
         8eW0lLDY5MSOA==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id v18so35142837uad.12;
        Wed, 07 Aug 2019 08:10:56 -0700 (PDT)
X-Gm-Message-State: APjAAAUgJLHx5SalSfri1/y+FJZhU4ptYRp06oc6CaTDUIRHR69gQJU1
        D0VvCSt1Vud7xLBNhQBDzjhoOgt7z/r6Rcfqu84=
X-Google-Smtp-Source: APXvYqxfQikh8Yu523ElqIvo8PJliB1J4wMrJ7x9x1KrVPC7PkEBOS+h5axLa83TRK219YZDEbKZ4bEGImsqE5VzUSs=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr6290071uaf.95.1565190655454;
 Wed, 07 Aug 2019 08:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190731061358.30117-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190731061358.30117-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 8 Aug 2019 00:10:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQPezQovn6Lnw1Zgz7Y2xz7_XXaccyZ-79zSYXAVSE6jQ@mail.gmail.com>
Message-ID: <CAK7LNAQPezQovn6Lnw1Zgz7Y2xz7_XXaccyZ-79zSYXAVSE6jQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add [M] marker for build log of *.mod.o
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 3:14 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This builds module objects, so [M] makes sense.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to linux-kbuild.


> ---
>
>  scripts/Makefile.modpost | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 6e328190d609..6c237af41417 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -112,7 +112,7 @@ $(modules:.ko=.mod.c): modules-modpost ;
>  # modname is set to make c_flags define KBUILD_MODNAME
>  modname = $(notdir $(@:.mod.o=))
>
> -quiet_cmd_cc_o_c = CC      $@
> +quiet_cmd_cc_o_c = CC [M]  $@
>        cmd_cc_o_c = $(CC) $(c_flags) $(KBUILD_CFLAGS_MODULE) $(CFLAGS_MODULE) \
>                    -c -o $@ $<
>
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada

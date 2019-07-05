Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448FCC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115B1218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 10:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="drq8MaMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfGEKAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 06:00:06 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:26229 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfGEKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:00:06 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x659xmjN009567
        for <linux-kernel@vger.kernel.org>; Fri, 5 Jul 2019 18:59:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x659xmjN009567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562320788;
        bh=7vo4tVVjFp2kF3CCv5uSappoveKorG1+DyG5PCqC1mo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=drq8MaMbdGESVV4jgCedEiZm6fgkjP+o5bmM0K9cOYi9ZwIVTd+iZfK2wFELQfdFC
         3WQ9Y8bSjaL3K4DNSYE6U+9pH49/yvNX4Wc5fFfUeFsnUexvpwQ/4XvMLvMduoD3QJ
         80IumNwsZg1SARySsPtcLCMlEsm6IYzLRHDS8Or9zOxzUtHowKUe235BAQ9JnhmB4y
         dq+fUaULEbCGZx5p6TgacoqjHJQfOVua4lVbFd6Vcohdo9tK5QaBp9SuyiU+Ybatqg
         31zCY2tAq3x8JrUrvXukE1b3C3R67GWUjZ2MwW5aBdZst2q4mn4Mim98GGVKVYkgRS
         Vr/OBAbNQlICw==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id v6so3473932vsq.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 02:59:48 -0700 (PDT)
X-Gm-Message-State: APjAAAXMMvKR3obSSio0MBazWnZvyGJP76WRIeRPqs8FpDq/iv/4yIvG
        jbB8ryeAy5xgLylcHBzPPqcNq3/GBg1E5wR2Ktk=
X-Google-Smtp-Source: APXvYqw/AUFCUUd5jXpPkprJCwIFt7JAmja2F/erzSFp296eLvhPJ66gWzHHWXgUX0GCg6HvO6LlFAxsNEuazgKizc0=
X-Received: by 2002:a67:fc45:: with SMTP id p5mr1635301vsq.179.1562320787446;
 Fri, 05 Jul 2019 02:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <1557756964-13087-1-git-send-email-yamada.masahiro@socionext.com> <87v9wibq5z.fsf@concordia.ellerman.id.au>
In-Reply-To: <87v9wibq5z.fsf@concordia.ellerman.id.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 5 Jul 2019 18:59:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNASK=z68pqPcPw8OGM1Y9SGSHOAMDygsbmNvOW1oOsQFRA@mail.gmail.com>
Message-ID: <CAK7LNASK=z68pqPcPw8OGM1Y9SGSHOAMDygsbmNvOW1oOsQFRA@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/boot: pass CONFIG options in a simpler and
 more robust way
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Mark Greer <mgreer@animalcreek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 9:26 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>
> > Commit 5e9dcb6188a4 ("powerpc/boot: Expose Kconfig symbols to wrapper")
> > was wrong, but commit e41b93a6be57 ("powerpc/boot: Fix build failures
> > with -j 1") was also wrong.
> >
> > The correct dependency is:
> >
> >   $(obj)/serial.o: $(obj)/autoconf.h
> >
> > However, I do not see the reason why we need to copy autoconf.h to
> > arch/power/boot/. Nor do I see consistency in the way of passing
> > CONFIG options.
> >
> > decompress.c references CONFIG_KERNEL_GZIP and CONFIG_KERNEL_XZ, which
> > are passed via the command line.
> >
> > serial.c includes autoconf.h to reference a couple of CONFIG options,
> > but this is fragile because we often forget to include "autoconf.h"
> > from source files.
> >
> > In fact, it is already broken.
> >
> > ppc_asm.h references CONFIG_PPC_8xx, but utils.S is not given any way
> > to access CONFIG options. So, CONFIG_PPC_8xx is never defined here.
> >
> > Pass $(LINUXINCLUDE) to make sure CONFIG options are accessible from
> > all .c and .S files in arch/powerpc/boot/.
>
> This breaks our skiroot_defconfig, I don't know why yet:
>
>   In file included from /kisskb/src/arch/powerpc/boot/../../../lib/decompress_unxz.c:236:0,
>                    from /kisskb/src/arch/powerpc/boot/decompress.c:42:
>   /kisskb/src/arch/powerpc/boot/../../../lib/xz/xz_dec_bcj.c: In function 'bcj_powerpc':
>   /kisskb/src/arch/powerpc/boot/../../../lib/xz/xz_dec_bcj.c:166:11: warning: implicit declaration of function 'get_unaligned_be32' [-Wimplicit-function-declaration]
>      instr = get_unaligned_be32(buf + i);


OK, now I see the cause of the error.

I will insert a new patch in v3.

Thanks.


>
> http://kisskb.ellerman.id.au/kisskb/buildresult/13862914/
>
> cheers



-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8470CC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3AA20843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="P91ZeAMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfDWDYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:24:24 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:52904 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfDWDYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:24:23 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x3N3OCIE026091;
        Tue, 23 Apr 2019 12:24:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x3N3OCIE026091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555989853;
        bh=ZaFZ1e3X9NvA8jIq/O0HE8feh53sYwHuO++fFuOS9nA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P91ZeAMhtMqYylWUwrm0osI7w4pI/iDlLSWG/rgtuV4n4+wggoIrtADSDmDO1F8IT
         9SwLYRNBLbn0b744T8wkCcKdwRp1bFydxoBb/Ez/b9cQ25oEEeJ8fGba2msUkgzzN7
         RVgAZWUxJsGwNQ1bWOAqoinA3tgIU6FXaJx5B1L/jq2wQU/LA3xl6qMAHwZmrwSwQr
         zRfXO4olxBoW18m482H250QJqKYOMqrg5Rb5U/oSnXgQXE947uj84smCxuOU3bNZk6
         XQX+9jSnBFsERD0tttKHFup0w0hnVx0NFKRLwUi8nadx+s4K1Nt/08Gj7JqtqRc3FH
         xGxtXeWji4Okg==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id c6so4301914uan.1;
        Mon, 22 Apr 2019 20:24:13 -0700 (PDT)
X-Gm-Message-State: APjAAAUjKMvZKY6A3TzUKyUja3hKKYKBnxvd4QgelcLWTMR9KGoetZNB
        xO7ziDVt7aZqc53MYUALLcQkZKwYHn6wdUpVJOE=
X-Google-Smtp-Source: APXvYqy2+X5gAZU5b5JBqG8lKaQqh8mqoq4bQSgIgGHvQKLEeXzwh1sBxjABZmsDHRTa0MRWHTkc9sQeXvoau4eItSo=
X-Received: by 2002:ab0:7008:: with SMTP id k8mr11599996ual.40.1555989851968;
 Mon, 22 Apr 2019 20:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
 <20190419094754.24667-7-yamada.masahiro@socionext.com> <CA+7wUsygTo=AN_giku_X6_a4mQWdJL48RoVbVB4hBqkZSKkP0Q@mail.gmail.com>
In-Reply-To: <CA+7wUsygTo=AN_giku_X6_a4mQWdJL48RoVbVB4hBqkZSKkP0Q@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 23 Apr 2019 12:23:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjQKu9GFyCyDJsQcyQjbeSGoJJPJV8YEtSXuV9JDqhqQ@mail.gmail.com>
Message-ID: <CAK7LNAQjQKu9GFyCyDJsQcyQjbeSGoJJPJV8YEtSXuV9JDqhqQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] MIPS: mark __fls() as __always_inline
To:     Mathieu Malaterre <malat@debian.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 12:45 AM Mathieu Malaterre <malat@debian.org> wrote:
>
> Hi,
>
> On Fri, Apr 19, 2019 at 12:06 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> > place. We need to eliminate potential issues beforehand.
> >
> > If it is enabled for mips, the following errors are reported:
> >
> > arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
> > sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
> > sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
> > sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
> > sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
> > sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
> > arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined references to `mips_gcr_base'
>
> Tested with success on ppc32/G4. But on CI20 (ci20_defconfig from
> master), I get:


Thanks for the test!

OK, I saw this error for ci20_defconfig.

I inline'd __ffs() to fix it
and sumitted v3.

Thank you.



>   MODPOST vmlinux.o
> mipsel-linux-gnu-ld: arch/mips/kernel/traps.o: in function
> `addr_gcr_err_control':
> /home/mathieu/tmp/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:169:
> undefined reference to `mips_gcr_base'
> mipsel-linux-gnu-ld:
> /home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:169:
> undefined reference to `mips_gcr_base'
> mipsel-linux-gnu-ld: arch/mips/mm/sc-mips.o: in function
> `addr_gcr_l2_pft_control':
> /home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
> undefined reference to `mips_gcr_base'
> mipsel-linux-gnu-ld:
> /home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
> undefined reference to `mips_gcr_base'
> mipsel-linux-gnu-ld:
> /home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
> undefined reference to `mips_gcr_base'
> mipsel-linux-gnu-ld:
> arch/mips/mm/sc-mips.o:/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
> more undefined references to `mips_gcr_base' follow




-- 
Best Regards
Masahiro Yamada

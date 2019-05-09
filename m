Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FBEC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A63420863
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vXF/soVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfEIApX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 20:45:23 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:40882 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfEIApW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 20:45:22 -0400
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x490jGOK004911;
        Thu, 9 May 2019 09:45:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x490jGOK004911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557362717;
        bh=Ru+R2ORrPqw7LLrV9WuQHOQEGZCvCvmHZGJp+XgMk80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vXF/soVCbtpS5f0Tu08V5muuPEeHvpraunn9QJockLtWJ1HvL/wzjYp+CSj6/9pch
         WeBYDWIwPNnTeCRoGTkTDPZLWWmQyhGn3bhCfe8e+uHudGnI+pxKvtqm5uhZ/x8ses
         17/rcjIXnxhu2e1TAuLSKKX5sQUU4nrc6g1LNBqVjueIXWBKpDBT5HnS+f0kyxQsQU
         BVNU+OZgSjia4lB6um9X6+O6xemOH1+ZNSSY2y6ioZLtXNb/13tapxDVN8OLJ+Aytz
         Wp3zGP+IuiPB4+oUA+sLGI4ZhQZCyd0BqbveQriKtOPBTXV4jeco+kqjLVaMs8WZ21
         JNmrNDecbXClw==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id d77so152114vke.13;
        Wed, 08 May 2019 17:45:17 -0700 (PDT)
X-Gm-Message-State: APjAAAWsxWJkAdF0jEZJFF2HhbGKRTkeeF0Jm3CHQxDwnX4NXevnqko7
        Dp6oIly23IVYupKzhRxkFX5HR+KfevWG20UQAcg=
X-Google-Smtp-Source: APXvYqxqigK4Zd4WROweEDNtiX9uCKXTUwALTs0K4eXUT/nrc10Jemy00RvqfCjLTOviHTVQMXpCqR0yXYzUp25OKYE=
X-Received: by 2002:a1f:d585:: with SMTP id m127mr163317vkg.34.1557362716285;
 Wed, 08 May 2019 17:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190423204821.241925-1-ndesaulniers@google.com>
 <CAKwvOd=ws1D95ydQjGtK0U0KQ-5poyj8Oek5Yka6-cvtCdpJ-g@mail.gmail.com> <CAKwvOd=tA3-i65B_92QHaJrpEREzBB91QkkqgRANncwfb2d-Kg@mail.gmail.com>
In-Reply-To: <CAKwvOd=tA3-i65B_92QHaJrpEREzBB91QkkqgRANncwfb2d-Kg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 9 May 2019 09:44:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR80+TxOHUN9cqPB3iHCJcK13HkyMmaVru1wHbe-KfeGQ@mail.gmail.com>
Message-ID: <CAK7LNAR80+TxOHUN9cqPB3iHCJcK13HkyMmaVru1wHbe-KfeGQ@mail.gmail.com>
Subject: Re: [PATCH] ia64: require -Wl,--hash-style=sysv
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 4:27 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> bumping for review, as the merge window is now open.


ia64 is not very active these days.

I applied this to my kbuild tree.
I will send PR for this in the current MW.

Thanks.




> On Tue, Apr 30, 2019 at 1:24 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Apr 23, 2019 at 1:48 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > Towards the goal of removing cc-ldoption, it seems that --hash-style=
> > > was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> > > of binutils for the kernel according to
> > > Documentation/process/changes.rst is 2.20.
> > >
> > > Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> > > Cc: clang-built-linux@googlegroups.com
> > > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  arch/ia64/kernel/Makefile.gate | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/ia64/kernel/Makefile.gate b/arch/ia64/kernel/Makefile.gate
> > > index f53faf48b7ce..846867bff6d6 100644
> > > --- a/arch/ia64/kernel/Makefile.gate
> > > +++ b/arch/ia64/kernel/Makefile.gate
> > > @@ -11,7 +11,7 @@ quiet_cmd_gate = GATE    $@
> > >        cmd_gate = $(CC) -nostdlib $(GATECFLAGS_$(@F)) -Wl,-T,$(filter-out FORCE,$^) -o $@
> > >
> > >  GATECFLAGS_gate.so = -shared -s -Wl,-soname=linux-gate.so.1 \
> > > -                    $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> > > +                    -Wl,--hash-style=sysv
> > >  $(obj)/gate.so: $(obj)/gate.lds $(obj)/gate.o FORCE
> > >         $(call if_changed,gate)
> > >
> > > --
> > > 2.21.0.593.g511ec345e18-goog
> > >
> >
> > bumping for review
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada

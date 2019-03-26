Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1717AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A8820811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="b3v2PRMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfCZGGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:06:37 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:60809 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZGGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:06:37 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2Q66TrX003798;
        Tue, 26 Mar 2019 15:06:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2Q66TrX003798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553580390;
        bh=qNd6pLDuqpVKfuGFWDIBYjjnWhjGz+oGpMjzhbmBxao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b3v2PRMP/tuouFwoo/lXPzdKlRDEEuq1Bzp8/aPaHj367FOh7cw84mq/cBk/SQHyC
         tK4zqyEQwiQpaqt7ce6j3lldQQOMHjNUYxkn3ZrDqu3YKaxFhuKAfZHiripc7IiP0b
         lEEfwjf4cctbGoq4GWT3GGak8VILquMwmWwwjmZ9fwsafmNZif3nDfFTzCbMtzzJc0
         5z5w0ZI3Z607bOLgXXQtmQJtg1Bnm1ptXasj9qefj/buMJr+pHrIuKLW13AUQTcvgq
         xIUB4Cbh2qpCeVfjN2AnE4QHRkupzAjYThgsFvYHweuwR2GQ9nNVGGQGi8O2/GhuHq
         T7oBRVWhO3HVw==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id r21so3875204uan.11;
        Mon, 25 Mar 2019 23:06:29 -0700 (PDT)
X-Gm-Message-State: APjAAAU82AGbU6kz8Plk0i6w/1poZRCTcjIN7qcv1Mqp2w0wDDV5E1LD
        uRjtsVCT0Kpq4BZPiOkcycFp5oVjNNCdL6xJdn8=
X-Google-Smtp-Source: APXvYqy9KmnP2wwWyyf3BRm2wdG+CDhfvoaXTe7v4mXeVvdv8MhX2GYVC0u/hpzdlv8JEVB6+/dJfQmleaN4n/n06ng=
X-Received: by 2002:ab0:7008:: with SMTP id k8mr16827863ual.40.1553580388672;
 Mon, 25 Mar 2019 23:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <1549943095-10956-1-git-send-email-yamada.masahiro@socionext.com>
 <CAKv+Gu8yLY+c6jNmHYkvP3n=xiojF7dcKBHmeGibUW2FUrEczA@mail.gmail.com>
 <CAK7LNASoyeFW=j9R=M2vaoLK_Gms1Z6hA_yKLyVSY=g5ALUi8A@mail.gmail.com>
 <CAKv+Gu8k63Fj2aPbQPLLvBXvJrdcu5NrODXuZKkb2n21AUM70Q@mail.gmail.com> <CAK7LNARd6R31QyGn4MZdDeTfUVGhF7bOx+5ZyuY-c7kZ6fETsA@mail.gmail.com>
In-Reply-To: <CAK7LNARd6R31QyGn4MZdDeTfUVGhF7bOx+5ZyuY-c7kZ6fETsA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 26 Mar 2019 15:05:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNASGFinR5EALd-2V-jezC+H5f+tw24NBBtfsUfxLBirwRw@mail.gmail.com>
Message-ID: <CAK7LNASGFinR5EALd-2V-jezC+H5f+tw24NBBtfsUfxLBirwRw@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: refactor cmd_stubcopy
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alistair Strachan <astrachan@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,



On Sat, Feb 16, 2019 at 11:07 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sat, Feb 16, 2019 at 12:38 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Fri, 15 Feb 2019 at 06:49, Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > On Tue, Feb 12, 2019 at 4:26 PM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Tue, 12 Feb 2019 at 04:45, Masahiro Yamada
> > > > <yamada.masahiro@socionext.com> wrote:
> > > > >
> > > > > It took me a while to understand what is going on in the nested
> > > > > if-blocks.
> > > > >
> > > > > Simplify it by removing unneeded code.
> > > > >
> > > > >   - if_changed automatically adds 'set -e', so any failure in the
> > > > >     series of commands makes it immediately fail as a whole.
> > > > >     So, the outer if block is entirely redundant.
> > > > >
> > > > >   - Since commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special
> > > > >     target"), GNU Make automatically deletes the target on any failure
> > > > >     in its recipe. The explicit 'rm -f $@' is redundant.
> > > > >
> > > > >   - surrounding commands with ( ) will spawn a subshell to execute them
> > > > >     in it, but it is rarely useful to do so.
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > >
> > > > Assuming that it still works as expected:
> > > >
> > > > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > >
> > > > You can test this by adding a statically initialized global function
> > > > pointer to any of the libstub source files that get built for ARM.
> > > >
> > > > Thanks!
> > >
> > >
> > > I tried that, and it failed as expected.
> > >
> >
> > Great, thanks for double checking.
> >
> > Are you taking this directly, or do you want me to take it via the EFI
> > tree? Either is fine with me
> >
> >
>
> Could you apply it to your EFI tree?
> Thanks.



Will you pick it up?



-- 
Best Regards
Masahiro Yamada

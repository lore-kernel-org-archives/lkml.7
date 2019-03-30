Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E07C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5AB20872
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dDRk6Knz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfC3MMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:12:14 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:52201 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbfC3MMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 08:12:14 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x2UCCAZg023969;
        Sat, 30 Mar 2019 21:12:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2UCCAZg023969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553947930;
        bh=ZzY9Nqoc/dtycqYkKiMjxbPUbyKNkN4G3EtgryKunIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dDRk6KnzwgzQkVROV5cJwIqOIx1rlzJghfAi2PDhsgjV11Ta5X4Lr/rRMBln1gzQf
         FfT/WmfnjSiY/lQZt242k2olYVDNrFBqK/BpRNEI8L3+3TDuOHALnc0jjnB/99OM5f
         OVFslAU5xuAb06XDSvRJZl/yYSTWKAhs9LcWnQJUp9haR2sZIM0HBivZtCynnksAfq
         5UdGMzkbSHZ0sOIW1KXGJDA69DW07hpslMW3Ejec8Rywn4B+heNlYfIRo/D/DY3JYX
         P6uyWFNRPe3s2I/2vCFfqn80lJ4eRr+I8G6f+JxMmy2u8LCscvBz39YRzHciwkMQDM
         4jqfwT10uSQUQ==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id d5so1579166uan.6;
        Sat, 30 Mar 2019 05:12:10 -0700 (PDT)
X-Gm-Message-State: APjAAAVHTuTHdzJH3BFDcbGoff4MsMcRm26+fwXdW+9ySr/1oAHh/iwg
        bkWZo2ntPNT5+XlncyXjVvgmbrvNRJxVDyYVKZo=
X-Google-Smtp-Source: APXvYqwJE6fIds62LDGhSu8ZLuObid8+O2DKLdiqT+5spLbDxqUpbzXP/VjQY9MuejVxsh+sH0LjiHsu4TGAnZyLUcA=
X-Received: by 2002:ab0:7008:: with SMTP id k8mr31608862ual.40.1553947929341;
 Sat, 30 Mar 2019 05:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
 <155373004377.7602.1209303093988055088.stgit@warthog.procyon.org.uk> <CAK7LNASRNyA9-Pfau=vyy9WZdjNEVD2gJxh+DrthRrKh6fgQhA@mail.gmail.com>
In-Reply-To: <CAK7LNASRNyA9-Pfau=vyy9WZdjNEVD2gJxh+DrthRrKh6fgQhA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 30 Mar 2019 21:11:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNASNtetbMkFWzbW69jh007B2R9dOzpYzgQ_xcFQj_ayVZA@mail.gmail.com>
Message-ID: <CAK7LNASNtetbMkFWzbW69jh007B2R9dOzpYzgQ_xcFQj_ayVZA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/68] kbuild: skip sub-make for in-tree build with
 GNU Make 4.x
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Andreas Schwab <schwab@suse.de>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 9:53 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> David,
>
>
> On Thu, Mar 28, 2019 at 8:41 AM David Howells <dhowells@redhat.com> wrote:
> >
> > From: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > Commit 2b50f7ab6368 ("kbuild: add workaround for Debian make-kpkg")
> > annoyed people who want to wrap the top Makefile with GNUmakefile
> > or something in order to customize it for their use.
> >
> > On second thought, we do not need to run the sub-make for in-tree
> > build with Make 4.x because the 'MAKEFLAGS += -rR' issue only happens
> > on GNU Make 3.x.
> >
> > With this commit, people will get back the workflow, and the Debian
> > make-kpkg will still work.
> >
> > Fixes: 2b50f7ab6368 ("kbuild: add workaround for Debian make-kpkg")
> > Reported-by: Andreas Schwab <schwab@suse.de>
> > Reported-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
>
>
> Why should this patch be included in a
> totally unrelated patch series?
>
>
> I already applied this to my fixes branch,
> and am planning to send a PR to Linus soon.
>
> (Sorry, I missed to send a PR for -rc2)


Now, this landed in Linus tree.



-- 
Best Regards
Masahiro Yamada

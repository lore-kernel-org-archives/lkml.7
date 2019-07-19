Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2368AC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF50B2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/dZ2wts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbfGSSs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:48:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36558 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfGSSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:48:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so16049503plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nwlthOc7MxXovC0OJU24IiiEzL2wO7sN9o+o7pxsw0=;
        b=B/dZ2wtsaMcGalesXYBvtHwgQMZ7lnhNvOX1BzaTrB92sA6KtFE/I0obBAuHt+AaLi
         TWxptAD1B/RLJ4Sh+5r9cqGev2IkuDARKJfwOPMrVUbVsh+eaZXLjTcnzPgOp0tezk5d
         Q0kbMJ8TuH1Mq4CJx1KM8lr9abtG24IzI2vKu1Uh0hvQiOkufKMigoLbZzZSUwG2X3U6
         Lsu2McLdCf49PV/JsHZxDgovaUTQL+cXct+/GMZFBP5knElIycUMRCZxiDog/Xo6Gi4H
         JqtDqhVn5l0ECL1NKTp6XQ060F/pbJLmCSia/LBtFN1Z/XLZBdccccnFXChJv1UCo9l0
         VDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nwlthOc7MxXovC0OJU24IiiEzL2wO7sN9o+o7pxsw0=;
        b=Kwzqjl/azg+Ph60Ddtx88JCmLdCFhh5DyXrJiAEkr1JPHo9c4tgrDg41R99ER2Ppi0
         E7rZX9cuwQbiF9hd4r6FOn2MbaruPnrULDwI7b94smbWuwYfF2rol3VEFBzf8WD3vURg
         PORdreSwz8LSm8nxW0RWN9X6ejjTK6fCdg0a7re5z4IfPVsMCMrGtIQNG7dB/AbNY4Wx
         0dUL9BSRTVfxIzKnv9keL57bcFItocstRdglnfM4mx2NKvCmG11Wd4HRaKwLswKqbnCl
         1lmOHLWpPSqX0cPhFM8CZou+pVlud4do7FZXv8VyYcevh/cYLV050mwFjQkf6Va4jtOJ
         1DZQ==
X-Gm-Message-State: APjAAAUAHIolq5RPSpxPQ18cIFdtWnQGU0fdEy7xvesfZt/nOGXifi+m
        kddFIBUwS9eq0CoaCYNJ7lCl6u2gFAXJgLRUDs9RoA==
X-Google-Smtp-Source: APXvYqzKJpnA0uk6K/f+tNSs6gctk9nWuQUzZeIp3W2U+ph0xl09hMnOkl0RQxmOn0tNtsuWLsIUseI8sZ7kLnsQsss=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr57916456plq.223.1563562105892;
 Fri, 19 Jul 2019 11:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a12cVdrEXdgWkHGHP6O04mz5khaB7WgQ1nvOptaUTu_SA@mail.gmail.com>
 <CAKwvOdmoD1wVFLdWRXTA=c-p4oc6HDxsfhXq5wQpD-8oFUfNNQ@mail.gmail.com>
 <20190719183125.2tuhcch2rtanxvyn@treble> <CAK8P3a1hxEAnuqt=ajUf4ETCOY9ckEEVZVrG1c+SV=bn2_Ga-Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1hxEAnuqt=ajUf4ETCOY9ckEEVZVrG1c+SV=bn2_Ga-Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Jul 2019 11:48:14 -0700
Message-ID: <CAKwvOdkC16irbGpP=cA8eEPvBWj+6mSgVgo+rs1ofDLNufWWzw@mail.gmail.com>
Subject: Re: warning: objtool: fn1 uses BP as a scratch register
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Craig Topper <craig.topper@intel.com>,
        Simon Pilgrim <llvm-dev@redking.me.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 11:44 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jul 19, 2019 at 8:31 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Fri, Jul 19, 2019 at 11:23:16AM -0700, Nick Desaulniers wrote:
> > > On Fri, Jul 19, 2019 at 11:10 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > A lot of objtool fixes showed up in linux-next, so I looked at some
> > > > remaining ones.
> > > > This one comes a lot up in some configurations
> > > >
> > > > https://godbolt.org/z/ZZLVD-
> > > >
> > > > struct ov7670_win_size {
> > > >   int width;
> > > >   int height;
> > > > };
> > > > struct ov7670_devtype {
> > > >   struct ov7670_win_size *win_sizes;
> > > >   unsigned n_win_sizes;
> > > > };
> > > > struct ov7670_info {
> > > >   int min_width;
> > > >   int min_height;
> > > >   struct ov7670_devtype devtype;
> > > > } a;
> > > > int b;
> > > > int fn1() {
> > > >   struct ov7670_info c = a;
> > > >   int i = 0;
> > > >   for (; i < c.devtype.n_win_sizes; i++) {
> > > >     struct ov7670_win_size d = c.devtype.win_sizes[i];
> > > >     if (c.min_width && d.width < d.height < c.min_height)
> > > >       if (b)
> > > >         return 0;
> > > >   }
> > > >   return 2;
> > > > }
> > > >
> > > > $ clang-8 -O2 -fno-omit-frame-pointer -fno-strict-overflow -c ov7670.i
> > > > $ objtool check  --no-unreachable --uaccess ov7670.o
> > > > ov7670.o: warning: objtool: fn1 uses BP as a scratch register
> > >
> > > Thanks for the report and reduced test case.  From the godbolt link, I
> > > don't see %rbp, %ebp, %bp, or %bpl being referenced (other that %rbp
> > > in the typical epilogue).  Am I missing something? Is objtool maybe
> > > not reporting the precise function at fault?
> >
> > I haven't looked, but it could very well be an objtool bug (surprise).
>
> Actually the reproducer may be wrong. I reduced the test case using
> 9.0.0-svn363902-1~exp1+0~20190620001509.2315~1.gbp76e756,
> and this contains a link
>
>          testl %ebp, %ebp
>
> I get the same thing with clang-8, but godbolt.org shows it only
> with clang-8 (see https://godbolt.org/z/g1lZO0) , not with trunk.
>
>        Arnd



-- 
Thanks,
~Nick Desaulniers

Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CFEC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241A121849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbfGSSoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:44:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36144 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfGSSoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:44:24 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so23958378qkl.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 11:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHHzqxevJlSZnlD75KoRCbvBygaRoQg8WzppZetoq+Q=;
        b=EnRaCdc/0gfpCbV1btaiPcAZxJ76YA3nLrixjzar/zSoQD1dx/Ng8+Be+Kw1e/DJZu
         iI20UF+RhMOMRaNQlY+CWBrKIbjb2wjdqn0tKitAy3pC63GFMltplQTcwS8f9lgCCg7l
         cMLZJwMA38u9x2USdVbJmEyWbnGJO1ubOevt6mH8VrbKP1sgRqRj0SdRL6c+A/dvim+y
         d/Svka9j8dAsaycJG3ZbOFq8hBbdxBPBQ2Kcti9CtBFG5QztqpKwU5hBQoZLYksor3/s
         XMUS/6CG4x19fM2Ed8vEUuJdMGhJ8qoxXuTvFbR7UPPmLgInbC/59TULlxTtrHviUW/S
         Jc1Q==
X-Gm-Message-State: APjAAAXd2yY1AH9vzlrS/NBwlSIJgoSxgVTAKngFqiurjaH4fzLJWUZv
        sliCdvQEANxS5g6LIkz3k7/xpkWW4IyHc32bL3c=
X-Google-Smtp-Source: APXvYqwtsURYs0yRZmX1wFGPxPUAdWeX2IT5q7bdg6fXIkwtddhpwlU7BMO8pn3dVMNVcHvu6sQW/CGTXW/CfvBw9hI=
X-Received: by 2002:a37:5f45:: with SMTP id t66mr36666944qkb.286.1563561863542;
 Fri, 19 Jul 2019 11:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a12cVdrEXdgWkHGHP6O04mz5khaB7WgQ1nvOptaUTu_SA@mail.gmail.com>
 <CAKwvOdmoD1wVFLdWRXTA=c-p4oc6HDxsfhXq5wQpD-8oFUfNNQ@mail.gmail.com> <20190719183125.2tuhcch2rtanxvyn@treble>
In-Reply-To: <20190719183125.2tuhcch2rtanxvyn@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 19 Jul 2019 20:44:07 +0200
Message-ID: <CAK8P3a1hxEAnuqt=ajUf4ETCOY9ckEEVZVrG1c+SV=bn2_Ga-Q@mail.gmail.com>
Subject: Re: warning: objtool: fn1 uses BP as a scratch register
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 8:31 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Jul 19, 2019 at 11:23:16AM -0700, Nick Desaulniers wrote:
> > On Fri, Jul 19, 2019 at 11:10 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > A lot of objtool fixes showed up in linux-next, so I looked at some
> > > remaining ones.
> > > This one comes a lot up in some configurations
> > >
> > > https://godbolt.org/z/ZZLVD-
> > >
> > > struct ov7670_win_size {
> > >   int width;
> > >   int height;
> > > };
> > > struct ov7670_devtype {
> > >   struct ov7670_win_size *win_sizes;
> > >   unsigned n_win_sizes;
> > > };
> > > struct ov7670_info {
> > >   int min_width;
> > >   int min_height;
> > >   struct ov7670_devtype devtype;
> > > } a;
> > > int b;
> > > int fn1() {
> > >   struct ov7670_info c = a;
> > >   int i = 0;
> > >   for (; i < c.devtype.n_win_sizes; i++) {
> > >     struct ov7670_win_size d = c.devtype.win_sizes[i];
> > >     if (c.min_width && d.width < d.height < c.min_height)
> > >       if (b)
> > >         return 0;
> > >   }
> > >   return 2;
> > > }
> > >
> > > $ clang-8 -O2 -fno-omit-frame-pointer -fno-strict-overflow -c ov7670.i
> > > $ objtool check  --no-unreachable --uaccess ov7670.o
> > > ov7670.o: warning: objtool: fn1 uses BP as a scratch register
> >
> > Thanks for the report and reduced test case.  From the godbolt link, I
> > don't see %rbp, %ebp, %bp, or %bpl being referenced (other that %rbp
> > in the typical epilogue).  Am I missing something? Is objtool maybe
> > not reporting the precise function at fault?
>
> I haven't looked, but it could very well be an objtool bug (surprise).

Actually the reproducer may be wrong. I reduced the test case using
9.0.0-svn363902-1~exp1+0~20190620001509.2315~1.gbp76e756,
and this contains a link

         testl %ebp, %ebp

I get the same thing with clang-8, but godbolt.org shows it only
with clang-8 (see https://godbolt.org/z/g1lZO0) , not with trunk.

       Arnd

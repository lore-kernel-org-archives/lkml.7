Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722D2C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7FC21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwQnaJJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbfGSSuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:50:25 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:45381 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfGSSuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:50:24 -0400
Received: by mail-pl1-f177.google.com with SMTP id y8so16033965plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 11:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtwstdfuOaP3ic+p5sbmiS56sJs1k20ZJhy+jU3nX1A=;
        b=NwQnaJJqh1no71dcwe6eYmLHuk5hvuAG347R+J3n1Zqc863TawqHSFyoA0w5VWDDVN
         iB8E6GxXQpsTEe75V24F8zXWpKGONnWccqOMJqhsYEufmer9MADKDQ1pH3nqvT/Zzys7
         cXmFkA2Ld1zn9dYjRx950TgM7T5eLR0YvFRFu3UskhUL0aQMHSEeBjKceokwpsA6pcTE
         JyeVhshMcJu69aO7Lgvy9k0zPjmAqPgJruVbY7f/2/htetzyKPc2yw+vuwjOCh0FXMYr
         3iiPAwH0I4qW/NWXZX57g70EwEOTUxrNO2+IaGWH/i0uojapoFXRU9K6eyHju3Ffinwk
         G5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtwstdfuOaP3ic+p5sbmiS56sJs1k20ZJhy+jU3nX1A=;
        b=gRZwbOuQgUuJ5jew8XFeuv+gJ/UjUvHMdfa2BFW9xD5HnuX3ANMyp8e7RoN/teGQDO
         dQJRqyK7sHUxHvEmrusTDh1mZcmGRHadBlUbNR7KAWqNFKIlT6YTuDuALp93m6M9W9Ml
         jodc5aSl20m7L4h4IwAUHQqSsoZR5neOhU+nKdjGvQuyZQzHwSFSnQSA8buew8D/QdZK
         ggAh2HzOZqxJmoIJ4r2qUGt3JuDrw1z+sLETypoZb+cEh0nPQXVCaLBXQ9IjipDf4jx+
         c6WXytMUpjxuDP12UzEAgPQz+HZxVf7khIGRkuVQTluFZPAl1VoJY4QguNanmQIScQpy
         HiXQ==
X-Gm-Message-State: APjAAAU+XoZerJspJ4SGvI+T+LSJQrUwXafkXDEdR58Vjxj1yh5w3GQh
        GBJVZhEhILhqbzzcr+CNO2IQq1Wwy8khiShflCEsHg==
X-Google-Smtp-Source: APXvYqy81tQUqLY17zVAnUIAragXq7Z0+BEvckRlb52NZBEZZaMtWz9tjBf8yl6mWr11duxmGhIDLiAA8kbhLv/APCM=
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr56112960pld.119.1563562223586;
 Fri, 19 Jul 2019 11:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a12cVdrEXdgWkHGHP6O04mz5khaB7WgQ1nvOptaUTu_SA@mail.gmail.com>
 <CAKwvOdmoD1wVFLdWRXTA=c-p4oc6HDxsfhXq5wQpD-8oFUfNNQ@mail.gmail.com>
 <20190719183125.2tuhcch2rtanxvyn@treble> <CAK8P3a1hxEAnuqt=ajUf4ETCOY9ckEEVZVrG1c+SV=bn2_Ga-Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1hxEAnuqt=ajUf4ETCOY9ckEEVZVrG1c+SV=bn2_Ga-Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 19 Jul 2019 11:50:12 -0700
Message-ID: <CAKwvOd=jc06YyF2YsAfHWCR9qtB8oOeR5oQMpJe69TTfG3s2RA@mail.gmail.com>
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

(Sorry for sending a blank email just now)
+ Craig and Simon, in case they recall this being a recent fix in
LLVM's x86 backend.
Sounds like this is fixing in upstream LLVM.  Guessing this could
result in improper unwinding w/ clang-8, but that's kind of irrelevant
for x86 as there's no asm goto (though we don't need CONFIG_JUMP_LABEL
in LTS branches :P)
-- 
Thanks,
~Nick Desaulniers

Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD2DC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38E621019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VgFYnWus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391342AbfGRWhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 18:37:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40072 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfGRWhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 18:37:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so13528217pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zlHONfgp4QrkRiAasjKvrG/YSZVb2X1BIf4rO6PjDZs=;
        b=VgFYnWusXHilzo0Ku47Cvh49q8V68B4awJ2TdrpuYGgFUJHuBvIDJT5tlkVBHjbV15
         +dxqU5Xf1FICAoZNSxbxvcH3HUuqtiZ9twnA92SAyze5g8YqlDWvzU/9kpZL+dJShZVn
         y0/yYsOW3lOZc390krTK1D71UDcuP6BMLTGlWcAZHWsga9r4MM2ElyjJp0GK/Qbx/pIm
         sQpl5qeeeczzCjtMLSFbt7PwNRY1FK2LGeBJ8gP90hL3IRRvHWirSzMjFOspsQtdVOze
         OsOEhQap8rWRdJnfQRIOs671ectGxWhSthjGKbGjzmN8eMIyok7fspYiU7QbviuHWdIg
         FObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zlHONfgp4QrkRiAasjKvrG/YSZVb2X1BIf4rO6PjDZs=;
        b=kh1NqlshA5pmNvu1WHpWJO60CCRToB0KiwVVY2gXMRbaWbKdFD4RSaJy8bo6HUZDaV
         5ZN0RE34m7S5HhZjpGNNPrudCOdvEv3tBwlSosIFLqgeOcgufAAkBBQiz/9Tx8BJ+M9D
         AFkljZFB258Qz/TpkrLqxaj8j2WPK+LetnGn3JUKVfcm2fmN1p6fxWi6+foYdRM1csXt
         uz2R7ASf1Tj+VxehzQ0nRsJoDKBlajoFLBTfZ6lqGKHS8OFhLjBmAGekbWJyowiiLROn
         VNz4e1jWgOYWlngyw90y0erelA4X5mArHSe1T9GTDF/uBagDVZqkKclWrAL++tA0G8V5
         W+DQ==
X-Gm-Message-State: APjAAAVzxX/r4STBVGuFgKaVFl6fvpA0veiEU+Dw57Z4AW9atrJBcagE
        LSU8Yu3mmPlWA0XnlOetZSGEaRxGYcapYK/r5sJo5g==
X-Google-Smtp-Source: APXvYqxjy2Gq2Lm2eY+1vfPzCn/zXiWCb/tZiQuoAH6R+x3cesLE0GBHZOkZ0E9++wSw1Wg/gc51UVTmxZV/TodgFFU=
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr46619294pgs.10.1563489419062;
 Thu, 18 Jul 2019 15:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez3ipuPHLxbqqc50=Kn4QuoNczkd7VqEoLPVd3WWLk2s+Q@mail.gmail.com>
 <CAK8P3a2=SJQp7Jvyf+BX-7XsUr8bh6eBMo6ue2m8FW4aYf=PPw@mail.gmail.com>
 <CAK8P3a1_8kjzamn6_joBbZTO8NeGn0E3O+MZ+bcOQ0HkkRHXRQ@mail.gmail.com>
 <20190712135755.7qa4wxw3bfmwn5rp@treble> <CAK8P3a13QFN59o9xOMce6K64jGnz+Cf=o3R_ORMo7j-65F5i8A@mail.gmail.com>
 <20190712142928.gmt6gibikdjmkppm@treble> <CAKwvOdnOpgo9rEctZZR9Y9rEc60FCthbPtp62UsdMtkGDF5nUg@mail.gmail.com>
 <CAK8P3a0AGpvAOzSfER7iiaz=aLVMbxiVorTsh__yT4xxBOHSyw@mail.gmail.com>
 <CAKwvOd=o16rtGOVm9DWhhqxed0OEW5NKt4Vt3y_6KCcbdU-dhQ@mail.gmail.com>
 <CAK8P3a2Vq+ojOZSefwziMhzU2SG+Bq6HDz2Ssjz7_BpVnMUu=A@mail.gmail.com> <20190716230336.y7nk24ybbwguio2s@treble>
In-Reply-To: <20190716230336.y7nk24ybbwguio2s@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jul 2019 15:36:47 -0700
Message-ID: <CAKwvOdm_MiACJWnRww3tSD7033J6MX2Erzs1xwmd1=taNmyg9A@mail.gmail.com>
Subject: Re: objtool crashes on clang output (drivers/hwmon/pmbus/adm1275.o)
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 4:03 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Jul 17, 2019 at 12:05:14AM +0200, Arnd Bergmann wrote:
> > On Tue, Jul 16, 2019 at 10:24 PM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> > >
> > > On Fri, Jul 12, 2019 at 1:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Fri, Jul 12, 2019 at 6:59 PM 'Nick Desaulniers' via Clang Built
> > > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > > > > The issue still needs to get fixed in clang regardless.  There are other
> > > > > > noreturn functions in the kernel and this problem could easily pop back
> > > > > > up.
> > > > >
> > > > > Sure, thanks for the report.  Arnd, can you help us get a more minimal
> > > > > test case to understand the issue better?
> > > >
> > > > I reduced it to this testcase:
> > > >
> > > > int a, b;
> > > > void __reiserfs_panic(int, ...) __attribute__((noreturn));
> > > > void balance_internal() {
> > > >   if (a)
> > > >     __reiserfs_panic(0, "", __func__, "", 2, __func__, a);
> > > >   if (b)
> > > >     __reiserfs_panic(0, "", __func__, "", 5, __func__, a, 0);
> > > > }
> > > >
> > > > https://godbolt.org/z/Byfvmx
> > >
> > > Is this the same issue as Josh pointed out?  IIUC, Josh pointed to a
> > > jump destination that was past a `push %rbp`, and I don't see it in
> > > your link.  (Or, did I miss it?)
> >
> > I think it can be any push. The point is that the stack is different
> > between the two branches leading up to the noreturn call.
>
> Right.

So if I remove the `-mstack-alignment=8` command line flag, it looks
like the stack depth will still differ on calls to __reiserfs_panic,
but now the call is not shared (two separate code paths):
https://godbolt.org/z/tvkXwK. Is that ok or also bad?

I'm getting the feeling that `-mstack-alignment=8` might have some
issues once we start pushing parameters on the stack.  How many can we
use registers for in x86 before resorting to the stack, and does the
function being variadic affect this? (if not, maybe a test case
without variadic and many-parameters would not conflate the issue?)
-- 
Thanks,
~Nick Desaulniers

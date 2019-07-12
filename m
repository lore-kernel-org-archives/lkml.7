Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30A9C742C2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECEE2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfGLOTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:19:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32885 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfGLOTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:19:19 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so6525959qkc.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 07:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tYEou2N5iYZgK6m9seQqHkvwf0ic0Qe60XG2Zt42iA=;
        b=H09D2ob0pgFQV5GLnnvq/vbr1uSyp9TTEfXBtwWBxsLTqDYK17EOhdXX1RhA0hboJM
         yt0hQNGj+O8J9MS4lEfKsahmJQkPxALS89ByLJ33OIfh2jsrJqP1+9cqCQpsCEaOVG+A
         IeXMT9bVFjqzgVzAbBJyRVy2OCUyGmzfHS+ZdNhXYgaaj4QlRNalWAxJXoIYQZYGA6sR
         a401hqRifQ8sGeEwBmSD8pXJACHZvqqT0uR5cmN5KeqCf8r8qUpZWyCxpJhazFLlXd0w
         FKoltE7ivvwMNWFauwTKG8e9JFv2dqR56PjboV8USe/vMXiKBDTjEsAlQqFolvMNptNP
         iDMw==
X-Gm-Message-State: APjAAAWeJ0bm2OFNj01GhMjK3EMK2iBXHCzFLQ8FotJIU9hVZ8w8MgUH
        rUkukoreMplfYK5/SoWAUstilU+++BkmaVDJtLs=
X-Google-Smtp-Source: APXvYqwfrTYNQUf83cpy0XRewpTXnYGeQtS7l7c7joqDFZpv0TL0Nmmvem0UJFbWA4siwv3v24UAoKlL/IIIOjQkzy0=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr6456377qkc.394.1562941158403;
 Fri, 12 Jul 2019 07:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2beBPP+KX4zTfSfFPwo+7ksWZLqZzpP9BJ80iPecg3zA@mail.gmail.com>
 <20190711172621.a7ab7jorolicid3z@treble> <CAK8P3a0iOMpMW-dXUY6g75HGC4mUe3P3=gv447WZOW8jmw2Vgg@mail.gmail.com>
 <CAG48ez3ipuPHLxbqqc50=Kn4QuoNczkd7VqEoLPVd3WWLk2s+Q@mail.gmail.com>
 <CAK8P3a2=SJQp7Jvyf+BX-7XsUr8bh6eBMo6ue2m8FW4aYf=PPw@mail.gmail.com>
 <CAK8P3a1_8kjzamn6_joBbZTO8NeGn0E3O+MZ+bcOQ0HkkRHXRQ@mail.gmail.com> <20190712135755.7qa4wxw3bfmwn5rp@treble>
In-Reply-To: <20190712135755.7qa4wxw3bfmwn5rp@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jul 2019 16:19:02 +0200
Message-ID: <CAK8P3a13QFN59o9xOMce6K64jGnz+Cf=o3R_ORMo7j-65F5i8A@mail.gmail.com>
Subject: Re: objtool crashes on clang output (drivers/hwmon/pmbus/adm1275.o)
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 3:57 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Jul 12, 2019 at 09:51:35AM +0200, Arnd Bergmann wrote:
> > I no longer see any of the "can't find switch jump table" in last
> > nights randconfig
> > builds. I do see one other rare warning, see attached object file:
> >
> > fs/reiserfs/do_balan.o: warning: objtool: replace_key()+0x158: stack
> > state mismatch: cfa1=7+40 cfa2=7+56
> > fs/reiserfs/do_balan.o: warning: objtool: balance_leaf()+0x2791: stack
> > state mismatch: cfa1=7+176 cfa2=7+192
> > fs/reiserfs/ibalance.o: warning: objtool: balance_internal()+0xe8f:
> > stack state mismatch: cfa1=7+240 cfa2=7+248
> > fs/reiserfs/ibalance.o: warning: objtool:
> > internal_move_pointers_items()+0x36f: stack state mismatch: cfa1=7+152
> > cfa2=7+144
> > fs/reiserfs/lbalance.o: warning: objtool:
> > leaf_cut_from_buffer()+0x58b: stack state mismatch: cfa1=7+128
> > cfa2=7+112
> > fs/reiserfs/lbalance.o: warning: objtool:
> > leaf_copy_boundary_item()+0x7a9: stack state mismatch: cfa1=7+104
> > cfa2=7+96
> > fs/reiserfs/lbalance.o: warning: objtool:
> > leaf_copy_items_entirely()+0x3d2: stack state mismatch: cfa1=7+120
> > cfa2=7+128
> >
> > I suspect this comes from the calls to the __reiserfs_panic() noreturn function,
> > but have not actually looked at the object file.
>
> Looking at one of the examples:
>
>     2346:       0f 85 6a 01 00 00       jne    24b6 <leaf_copy_items_entirely+0x3a8>
>     ...
>     23b1:       e9 2a 01 00 00          jmpq   24e0 <leaf_copy_items_entirely+0x3d2>
>     ...
>     24b6:       31 ff                   xor    %edi,%edi
>     24b8:       48 c7 c6 00 00 00 00    mov    $0x0,%rsi
>                         24bb: R_X86_64_32S      .rodata.str1.1
>     24bf:       48 c7 c2 00 00 00 00    mov    $0x0,%rdx
>                         24c2: R_X86_64_32S      .rodata.str1.1+0x127b
>     24c6:       48 c7 c1 00 00 00 00    mov    $0x0,%rcx
>                         24c9: R_X86_64_32S      .rodata.str1.1+0x1679
>     24cd:       41 b8 90 01 00 00       mov    $0x190,%r8d
>     24d3:       49 c7 c1 00 00 00 00    mov    $0x0,%r9
>                         24d6: R_X86_64_32S      .rodata.str1.1+0x127b
>     24da:       b8 00 00 00 00          mov    $0x0,%eax
>     24df:       55                      push   %rbp
>     24e0:       41 52                   push   %r10
>     24e2:       e8 00 00 00 00          callq  24e7 <leaf_item_bottle>
>                         24e3: R_X86_64_PC32     __reiserfs_panic-0x4
>
> Objtool is correct this time: There *is* a stack state mismatch at
> 0x24e0.  The stack size is different at 0x24e0, depending on whether it
> came from 0x2346 or from 0x23b1.
>
> In this case it's not a problem for code flow, because the basic block
> is a dead end.
>
> But it *is* a problem for unwinding.  The location of the previous stack
> frame is nondeterministic.
>
> And that's extra important for calls to noreturn functions, because they
> often dump the stack before exiting.
>
> So it looks like a compiler bug to me.

The change below would shut up the warnings, and presumably avoid
the unwinding problem as well. Should I submit that for inclusion,
or should we try to fix clang first?

       Arnd

diff --git a/fs/reiserfs/prints.c b/fs/reiserfs/prints.c
index 9fed1c05f1f4..da996eaaebac 100644
--- a/fs/reiserfs/prints.c
+++ b/fs/reiserfs/prints.c
@@ -387,7 +387,6 @@ void __reiserfs_panic(struct super_block *sb,
const char *id,
        else
                printk(KERN_WARNING "REISERFS panic: %s%s%s: %s\n",
                      id ? id : "", id ? " " : "", function, error_buf);
-       BUG();
 }

 void __reiserfs_error(struct super_block *sb, const char *id,
@@ -397,8 +396,10 @@ void __reiserfs_error(struct super_block *sb,
const char *id,

        BUG_ON(sb == NULL);

-       if (reiserfs_error_panic(sb))
+       if (reiserfs_error_panic(sb)) {
                __reiserfs_panic(sb, id, function, error_buf);
+               BUG();
+       }

        if (id && id[0])
                printk(KERN_CRIT "REISERFS error (device %s): %s %s: %s\n",
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index e5ca9ed79e54..f5bd17ee21f6 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -3185,10 +3185,9 @@ void unfix_nodes(struct tree_balance *);

 /* prints.c */
 void __reiserfs_panic(struct super_block *s, const char *id,
-                     const char *function, const char *fmt, ...)
-    __attribute__ ((noreturn));
+                     const char *function, const char *fmt, ...);
 #define reiserfs_panic(s, id, fmt, args...) \
-       __reiserfs_panic(s, id, __func__, fmt, ##args)
+       do { __reiserfs_panic(s, id, __func__, fmt, ##args); BUG(); } while (0)
 void __reiserfs_error(struct super_block *s, const char *id,
                      const char *function, const char *fmt, ...);
 #define reiserfs_error(s, id, fmt, args...) \

Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050BDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D122D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfCKIgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:36:53 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40035 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfCKIgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:36:53 -0400
Received: by mail-ua1-f67.google.com with SMTP id c5so1229981uaq.7;
        Mon, 11 Mar 2019 01:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4BC7vT4scBr9LMQHKeaQaGV2AZPUW9KitZzLfgtF10=;
        b=VyYAG8FPwoH0VrhGTnj8ftjCQveeOsMd0cofwYRlNACYaH+HNNN1DhVP3N7n4D5lwq
         n1CkwWzKGyOoyQ0rjGMMzz/CdXBM0g/1wG+Hh8iV9oX292oXBjqeyA6kCeP45/5VYERv
         52mlZrQLXdFODMjZPPvw5S1SKpqIfL4NpuiUyGyN2LfmlF1yxL8COeLCi5vDCKEUFaYT
         BsD7GbPIR5ePKSg7CaBB4LCRe+5PVsfxSSu5FRVUTR32C0U4G8w0mKuwOMNXIn8mm4/g
         6e+5VMmIGZhnj0j3u7iyI7/YVrLhGhwbH9Vvrxre38mrTQxR94+eJ0wmpHd2DRJoz3qb
         aJgQ==
X-Gm-Message-State: APjAAAVP61Zc/0x+pUhlhuF5plEkxjjKhk1uoYZokNIbD+Gy6lce8HYJ
        u7wq3/bI7qNx7TxAMevePyq8qgEiN7j8onStu+c=
X-Google-Smtp-Source: APXvYqxk1ZA1EWEdpLsCyvBxaQb1vTg6bc1Fgm4fDg14FiTnF0Jpc/aowcdPc2f4ZXtPudNg9CxU87ez7w4dbB/donY=
X-Received: by 2002:a9f:30dc:: with SMTP id k28mr16447296uab.75.1552293411707;
 Mon, 11 Mar 2019 01:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190122141027.70cd9166@canb.auug.org.au> <20190213162212.500a7cd5@canb.auug.org.au>
 <CAK8P3a1hw03ik+tZSG8PnP7Rd=Pzwbo7n59HLJW04ncndyqzsg@mail.gmail.com>
In-Reply-To: <CAK8P3a1hw03ik+tZSG8PnP7Rd=Pzwbo7n59HLJW04ncndyqzsg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Mar 2019 09:36:40 +0100
Message-ID: <CAMuHMdUmPBeQ=jcDufVBDEGiO1Yk4bWWBSg488Jm_wwAuySHBQ@mail.gmail.com>
Subject: New syscalls (was: Re: linux-next: manual merge of the pidfd tree
 with the y2038 tree (now block and tip trees))
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Feb 13, 2019 at 3:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Feb 13, 2019 at 6:22 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > On Tue, 22 Jan 2019 14:10:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > Today's linux-next merge of the pidfd tree got conflicts in:
> > >
> > >   arch/x86/entry/syscalls/syscall_32.tbl
> > >   arch/x86/entry/syscalls/syscall_64.tbl
> > >   include/uapi/asm-generic/unistd.h
> > >
> > > between commits:
> > >
> > >   63a96220ad45 ("arch: add split IPC system calls where needed")
> > >   0bd4bb9c5612 ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
> > >
> > > from the y2038 tree and commit:
> > >
> > >   3d2991bc7a67 ("signal: add pidfd_send_signal() syscall")
> > >
> > > from the pidfd tree.
> >
> > This is now a conflict between the block, tip and pidfd trees.  The
> > resolution now looks like below.
>
> Checked it again, still looks good. Thanks,

What's the plan with adding new syscalls to all architectures?

  + <stdin>: warning: #warning syscall io_uring_enter not implemented
[-Wcpp]:  => 1481:2
  + <stdin>: warning: #warning syscall io_uring_register not
implemented [-Wcpp]:  => 1484:2
  + <stdin>: warning: #warning syscall io_uring_setup not implemented
[-Wcpp]:  => 1478:2

and more seem to be planned for this merge window.

Shall each architcture maintainer take care of this hxxself, or will
this be done in
a coordinated way?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

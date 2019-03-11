Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A29C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D7120657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfCKVi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:38:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45722 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCKViZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:38:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so264681qtv.12;
        Mon, 11 Mar 2019 14:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyUft/RqubZVWIHTJ99/NednP6Xtq8YIkptzcvyysyM=;
        b=Q8rttX4iE9gEa8lngjlmFo/sJjaP56NXSVmzma4c6wS4YS2FY5ATzRTPOcPL6o+qxW
         Nm2jWEB3qE8aTKUvgUjjEtuVvBcvmWNwqATTbPSvACjoJrV8flo/0UfefvUYZml4/N02
         6Wpv1OQEtuwD5M9t0I9mQJ1/K97EzVGN/Akccc1NOKiwdpfMrkATdX/FmgT0SCQOGvu2
         Gp+cC7SytxBq/1ZoOxKFY3askJ42hbgJ3FUdQDeB6WG3aIl6RIl0z0jMkU9ppvSOb2y5
         Q00T4BH1UK43cQUyZ9I9/Qstb7CeUIr4JBevqFi1I5mh/9HxtL5fGPSJdtLoOnWm9sKf
         TiVw==
X-Gm-Message-State: APjAAAWFemsVduEJHJJoesCJ0/Z0SWrLy8JHZph0Mj89fefTm6oETDhc
        ZXQzoL92E3yD1r/e+H9cHZbZlYopP6r6/DzjBJ/pww==
X-Google-Smtp-Source: APXvYqwzG69VXZlckmZjLkXe5InGQjVr40YinRF8xOI+j2t3NaEC+UJL+67reJ6cDQkZ69uOI8bKa2Tu9YYrq8VvgU4=
X-Received: by 2002:ac8:1e17:: with SMTP id n23mr5436901qtl.152.1552340304772;
 Mon, 11 Mar 2019 14:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190122141027.70cd9166@canb.auug.org.au> <20190213162212.500a7cd5@canb.auug.org.au>
 <CAK8P3a1hw03ik+tZSG8PnP7Rd=Pzwbo7n59HLJW04ncndyqzsg@mail.gmail.com> <CAMuHMdUmPBeQ=jcDufVBDEGiO1Yk4bWWBSg488Jm_wwAuySHBQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUmPBeQ=jcDufVBDEGiO1Yk4bWWBSg488Jm_wwAuySHBQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 22:38:07 +0100
Message-ID: <CAK8P3a1zHm-WjYjEA65PomrKe7+5Sd110KbXv13=wiMVpxyuaQ@mail.gmail.com>
Subject: Re: New syscalls (was: Re: linux-next: manual merge of the pidfd tree
 with the y2038 tree (now block and tip trees))
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Mon, Mar 11, 2019 at 9:36 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Feb 13, 2019 at 3:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Feb 13, 2019 at 6:22 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > On Tue, 22 Jan 2019 14:10:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > Today's linux-next merge of the pidfd tree got conflicts in:
> > > >
> > > >   arch/x86/entry/syscalls/syscall_32.tbl
> > > >   arch/x86/entry/syscalls/syscall_64.tbl
> > > >   include/uapi/asm-generic/unistd.h
> > > >
> > > > between commits:
> > > >
> > > >   63a96220ad45 ("arch: add split IPC system calls where needed")
> > > >   0bd4bb9c5612 ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
> > > >
> > > > from the y2038 tree and commit:
> > > >
> > > >   3d2991bc7a67 ("signal: add pidfd_send_signal() syscall")
> > > >
> > > > from the pidfd tree.
> > >
> > > This is now a conflict between the block, tip and pidfd trees.  The
> > > resolution now looks like below.
> >
> > Checked it again, still looks good. Thanks,
>
> What's the plan with adding new syscalls to all architectures?
>
>   + <stdin>: warning: #warning syscall io_uring_enter not implemented
> [-Wcpp]:  => 1481:2
>   + <stdin>: warning: #warning syscall io_uring_register not
> implemented [-Wcpp]:  => 1484:2
>   + <stdin>: warning: #warning syscall io_uring_setup not implemented
> [-Wcpp]:  => 1478:2
>
> and more seem to be planned for this merge window.
>
> Shall each architcture maintainer take care of this hxxself, or will
> this be done in
> a coordinated way?

I was planning to send a patch for all architectures this time
(after all three sets are merged, which is now), and ask future
submitters to do it themselves when first adding a new system
call.

       Arnd

Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729FBC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404E92084C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO8018ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfKHCMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 21:12:50 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38269 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfKHCMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 21:12:50 -0500
Received: by mail-io1-f68.google.com with SMTP id i13so3284737ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 18:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mI2H1/JiMrgWfOQwsYN77DP2fyTgPIoA8PWUrElgIAQ=;
        b=eO8018epbWTB8R8wRPyM0TCODeYfAWo28VHUOHQpZBgRVCa0U7Z2a794XD3/Lchxn1
         UpNjqP75vS35IFdq+6xkpSkjEt0N47mu00Yivj50HCG43ZWaDX0N16baTt7X86Xp5IlY
         Rymy1/1GNTxm43BtviiHAJO6H7sfIS4F8HfVBIi7QAbzPv/mxMaU+ZjQoMHdS8E2yfXV
         7SKtL/cFZskmkgP8qMNmZ/PXPj1kkvuwWO6H/sN7Y3DYcgbq9a/7ZC5+5a/aD+CT4egJ
         bJyx0zPn32qakht5SQAIhgJavGTUAi0YTmJnCnkxcLpgx16HassQo05wf0FoX1WX21Pk
         /a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mI2H1/JiMrgWfOQwsYN77DP2fyTgPIoA8PWUrElgIAQ=;
        b=NyjmQ1hwDkQab+ONABp3hspDt4fuelP2Nq0dQyvuGKg9By78TTympJx5jLAJ+EY+1S
         itLnzcI6BkAARfCdXBSNZ0s2/MBLMld5LGPmYM9bAav2zPGosqbcQigTRPSFXDnzXN7b
         ++HRuHK8xbrm4ZRK7sejBVpLnRWmekP9rVQDcdGiA6Gdaj6lO96gSAXDNgqKVHF7j/j/
         7SNcl4cN4ulBMXiLg6BuUhOcThMrRKFA1xNoO5Dvj2sJOl+g7uKs+96+B3z/RhbcKE44
         q7J9GZSOpYHGFEI3M3WS/ZuEi7GHtARH9kM2g5OL2wjr5SwG9pFu1pFya8CSFml5Fkna
         8//Q==
X-Gm-Message-State: APjAAAVPKINH2tapYfPHBcKazcw0a1QANXlcVCgYXVgM+agHL04Tt6Du
        vx3VU+PbU+OGDXI9P5zMZBjZSvWM2EkvauqSwA==
X-Google-Smtp-Source: APXvYqzY9STxjC9gLO/kjIsthshQUi/v0Ta7sCk09dsOFWeTEwlWPLLDT3FORJqPU8kn1oLY/33hdBrXOcR/4O6nrVU=
X-Received: by 2002:a6b:8b02:: with SMTP id n2mr7288982iod.66.1573179169510;
 Thu, 07 Nov 2019 18:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de>
 <CAMzpN2juuUyLuQ-tiV7hKZvG4agsHKP=rRAt_V4sZhpZW7cv9g@mail.gmail.com>
 <CAHk-=wiGO=+mmEb-sfCsD5mxmL5++gdwkFj_aXcfz1R41MJnEg@mail.gmail.com>
 <CAMzpN2gt4qM41=96GpNHL-kbgBsjD-zphq+5oK0BXqoCFN4F4Q@mail.gmail.com>
 <CAHk-=wjocTzo+8OMwyKPX0MCVV=N4wtU8ifwSZ_qJJnDBgKJ8Q@mail.gmail.com> <6cac6943-2f6c-d48a-658e-08b3bf87921a@zytor.com>
In-Reply-To: <6cac6943-2f6c-d48a-658e-08b3bf87921a@zytor.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 7 Nov 2019 21:12:38 -0500
Message-ID: <CAMzpN2hCrcQg_u5sp7WWGjOBv13+ZWtSAecp6bWpT6rsTyo+-Q@mail.gmail.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage further
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 8:12 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 2019-11-07 13:44, Linus Torvalds wrote:
> > On Thu, Nov 7, 2019 at 1:00 PM Brian Gerst <brgerst@gmail.com> wrote:
> >>
> >> There wouldn't have to be a flush on every task switch.
> >
> > No. But we'd have to flush on any switch that currently does that memcpy.
> >
> > And my point is that a tlb flush (even the single-page case) is likely
> > more expensive than the memcpy.
> >
> >> Going a step further, we could track which task is mapped to the
> >> current cpu like proposed above, and only flush when a different task
> >> needs the IO bitmap, or when the bitmap is being freed on task exit.
> >
> > Well, that's exactly my "track the last task" optimization for copying
> > the thing.
> >
> > IOW, it's the same optimization as avoiding the memcpy.
> >
> > Which I think is likely very effective, but also makes it fairly
> > pointless to then try to be clever..
> >
> > So the basic issue remains that playing VM games has almost
> > universally been slower and more complex than simply not playing VM
> > games. TLB flushes - even invlpg - tends to be pretty slow.
> >
> > Of course, we probably end up invalidating the TLB's anyway, so maybe
> > in this case we don't care. The ioperm bitmap is _technically_
> > per-thread, though, so it should be flushed even if the VM isn't
> > flushed...
> >
>
> One option, probably a lot saner (if we care at all, after all, copying 8K
> really isn't that much, but it might have some impact on real-time processes,
> which is one of the rather few use cases for direct I/O) would be to keep the
> bitmask in a pre-formatted TSS (ioperm being per thread, so no concerns about
> the TSS being in use on another processor), and copy the TSS fields (88 bytes)
> over if and only if the thread has been migrated to a different CPU, then
> switch the TSS rather than switching  For the common case (no ioperms) we use
> the standard per-cpu TSS.
>
> That being said, I don't actually know that copying 88 bytes + LTR is any
> cheaper than copying 8K.

I don't think that can work.  The TSS has to be at a fixed address in
the cpu_entry_area so that it is visible when running in usermode
(thanks to Meltdown).

--
Brian Gerst

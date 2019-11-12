Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BF521E6F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573580534;
	bh=ukFBRhjz6JA+xtvHkGTJeVxwHWLAp4FvKedRKr02fsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kei7nu/1Fkj4aSLxT1HsTIqVCBqO+jDGQvcveBwltSWoWaDSmkFYZK7so5EVF0kU3
	 +rlAzVTptI5Fc2Du1MriOwhgthptuXm373Y2gS727xoyggGXpSGgWRdI51RpfsCreI
	 T0KZk8vWPtQFjSoV5powtKXclJfco4lJnHwvGQtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLRmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfKLRmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:42:12 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC99222C5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573580531;
        bh=ukFBRhjz6JA+xtvHkGTJeVxwHWLAp4FvKedRKr02fsc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PT8aZS5k5uk1BrbAC7cNvr/pkyPFyeuni8KsKdtHz6lpszOh/ABcEZwpMmylUnqTv
         jiYW9DbfxE3WJ1p22ZTZKUlt+4mKx7EmsLzsY44rOD8tImoHcLc3y7CyBKPJrbinYv
         VlU+UugKp25u4f7q5psUvCA9z9fdv3t1njkWt8nE=
Received: by mail-wr1-f49.google.com with SMTP id i10so19503850wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:42:11 -0800 (PST)
X-Gm-Message-State: APjAAAXPi2y7srNMnSQ3TLdcWSW/uJDtVDq1stD5VBUAxk5Dz1Dsxwjq
        IfdAzjRSoTgfQKXG8+jJYJZ+yIQyEhG2cqUa0oN0oA==
X-Google-Smtp-Source: APXvYqxTjtLWa+Ir8T+ZvAlxbNKfjXXLSPgi/Ebf5LBLoWqwqNRsOrz3lCjL6jnQ7giufNX3xudoimjIUYBS8YjMcC4=
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr27739401wrm.106.1573580529594;
 Tue, 12 Nov 2019 09:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223052.400498664@linutronix.de>
 <CALCETrU1i4_N8M0o=8hxxPFYisLsxpmDqM-GTsymORp9UeZYSg@mail.gmail.com> <alpine.DEB.2.21.1911121811150.1833@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911121811150.1833@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 09:41:58 -0800
X-Gmail-Original-Message-ID: <CALCETrWX7POruLpr27mVoZ-CtVjz35tJBaZz0FNy9_eXfZo_fg@mail.gmail.com>
Message-ID: <CALCETrWX7POruLpr27mVoZ-CtVjz35tJBaZz0FNy9_eXfZo_fg@mail.gmail.com>
Subject: Re: [patch V2 09/16] x86/ioperm: Move TSS bitmap update to exit to
 user work
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 9:20 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 12 Nov 2019, Andy Lutomirski wrote:
> > On Mon, Nov 11, 2019 at 2:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > There is no point to update the TSS bitmap for tasks which use I/O bitmaps
> > > on every context switch. It's enough to update it right before exiting to
> > > user space.
> > +
> > > +static inline void switch_to_bitmap(unsigned long tifp)
> > > +{
> > > +       /*
> > > +        * Invalidate I/O bitmap if the previous task used it. If the next
> > > +        * task has an I/O bitmap it will handle it on exit to user mode.
> > > +        */
> > > +       if (tifp & _TIF_IO_BITMAP)
> > > +               tss_invalidate_io_bitmap(this_cpu_ptr(&cpu_tss_rw));
> > > +}
> >
> > Shouldn't you be invalidating the io bitmap if the *next* task doesn't
> > use?  Or is the rule that, when a non-io-bitmap-using task is running,
> > even in kernel mode, the io bitmap is always invalid.
>
> Well it does not make much of a difference whether we do the above or
> !(tifn & _TIF_IO_BITMAP). We always end up in that code when one of the
> involved tasks has TIF_IO_BITMAP set. I decided to use the sched out check
> because that makes it clear that this is the end of the valid I/O
> bitmap. If the next task has TIF_IO_BITMAP set as well, then it will anyway
> end up in the exit to user mode update code. Clearing it here ensures that
> even if the exit to user mode malfunctions the bitmap cannot be leaked.
>
> > As it stands, you need exit_thread() to invalidate the bitmap.  I
> > assume it does, but I can't easily see it in the middle of the series
> > like this.
>
> It does.
>
> > IOW your code might be fine, but it could at least use some comments
> > in appropriate places (exit_to_usermode_loop()?) that we guarantee
> > that, if the bit is *clear*, then the TSS has the io bitmap marked
> > invalid.  And add an assertion under CONFIG_DEBUG_ENTRY.
> >
> > Also, do you need to update EXIT_TO_USERMODE_LOOP_FLAGS?
>
> No, the TIF_IO_BITMAP check is done once after the loop has run and it
> would not make any sense in the loop as TIF_IO_BITMAP cannot be cleared
> there and we'd loop forever. The other usermode loop flags are transient.
>

Right.  But your diff tool *said* the diff was in
exit_to_usermode_loop().  Can you look at your .gitconfig and see if
you have something weird going on?

--Andy

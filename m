Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A95C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6382080F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573419920;
	bh=BiMOa7BVbdDsJpnGBQ+dlgWZV0phrTRJm8NQ8hGPUjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=R2FgL1EhOiduTYPaKFIXbKTP1HqGDj8jcvU8FCdgZRq/vyAVk/o2ISPW51vb9on2F
	 8W/XCB9dBWmiKoNxDAu/lk0UTJHfd4L2ZrE583FMI9MauQ1Wj94Y10ALFp2+YBBJtP
	 +vkNjkZ/hUe9uIw2uMHEigQJvghIm+mBtVCKflNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfKJVFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfKJVFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:05:19 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C5F2085B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 21:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573419918;
        bh=BiMOa7BVbdDsJpnGBQ+dlgWZV0phrTRJm8NQ8hGPUjI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lit8Iot77iV2m7g9crnRYkCdYRUbiWTJa8v2jP/oXy2LnVqMoI77kOzseCejvLSFt
         ym2nQbVpnEsk0t0XMy96z/JBpH7GeG2IBjbhhfpowisiSuD/3NYuCNLtw3BVbwYHcU
         xRUsxXNehgaQG3yKkUwBBAsniPmVqg0atovEl/74=
Received: by mail-wm1-f48.google.com with SMTP id u18so3615201wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 13:05:18 -0800 (PST)
X-Gm-Message-State: APjAAAUkQJ+aNvS6mO4GiW4wWkPHyNtcYa409O319+hCWOvT189OV1hl
        XE8tE4wvKLhvJfXSUXOfcDakoFJafO+6hTETA6nTww==
X-Google-Smtp-Source: APXvYqxzCf7oNyiVNbpysNqNTAvbbJ6LTMktOnPu2KporXXemX5yXNQqGMLUQWX3ULVTSTVlBLEq44uERvdx6B2bF2s=
X-Received: by 2002:a7b:c1ca:: with SMTP id a10mr18936242wmj.161.1573419917046;
 Sun, 10 Nov 2019 13:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20191106193459.581614484@linutronix.de> <20191106202806.425388355@linutronix.de>
 <a1afc4bb-c90e-db58-42f2-da91a50b1872@kernel.org> <alpine.DEB.2.21.1911102125110.12583@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911102125110.12583@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 10 Nov 2019 13:05:05 -0800
X-Gmail-Original-Message-ID: <CALCETrXLNub_pTMKvVQiq26=8VQPnx865+w0e-ZnHEg9a397_A@mail.gmail.com>
Message-ID: <CALCETrXLNub_pTMKvVQiq26=8VQPnx865+w0e-ZnHEg9a397_A@mail.gmail.com>
Subject: Re: [patch 7/9] x86/iopl: Restrict iopl() permission scope
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 12:31 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sun, 10 Nov 2019, Andy Lutomirski wrote:
> > On 11/6/19 11:35 AM, Thomas Gleixner wrote:
> > > +
> > > +   if (IS_ENABLED(CONFIG_X86_IOPL_EMULATION)) {
> > > +           struct tss_struct *tss;
> > > +           unsigned int tss_base;
> > > +
> > > +           /* Prevent racing against a task switch */
> > > +           preempt_disable();
> > > +           tss = this_cpu_ptr(&cpu_tss_rw);
> > > +           if (level == 3) {
> > > +                   /* Grant access to all I/O ports */
> > > +                   set_thread_flag(TIF_IO_BITMAP);
> > > +                   tss_base = IO_BITMAP_OFFSET_VALID_ALL;
> >
> > Where is the actual TSS updated?
>
> Here. It sets the offset to the all zero bitmap. That's all it needs.

Ah, I see.

> > I think what you need to do is have a single function, called by
> > exit_thread(), switch_to(), and here, that updates the TSS to match a
> > given task's IO bitmap state.  This is probably switch_to_bitmap() or
> > similar.
>
> Well, no. exit_thread() and this here actually fiddle with the TIF bit
> which is not what the switch to case does. There is some stuff which can be
> shared.

I was thinking that the code that read iopl_emul and t->io_bitmap_ptr
and updated x86_tss.io_bitmap_base could be factored out of
switch_to().  Suppose you call that tss_update_io_bitmap().  And you
could have another tiny helper:

static void update_tif_io_bitmap(void)
{
  if (...->iopl_emul || ...->io_bitmap_ptr)
    set_thread_flag(TIF_IO_BITMAP);
  else
    clear_thread_flag(TIF_IO_BITMAP);
}

Then the whole iopl emulation path becomes:

preempt_disable();
...->iopl_emul = iopl;
update_tif_io_bitmap();
tss_update_io_bitmap();

and switch_to() does

if (new or prev has TIF_IO_BITMAP)
  tss_update_io_bitmap();

and exit_thread() does:

...->iopl_emul = 0;
kfree(...);
...->io_bitmap_ptr = 0;
clear_thread_flag(TIF_IO_BITMAP) or update_tif_io_bitmap();
tss_update_io_bitmap();

and ioperm() does:

kmalloc (if needed);
update the thread_struct copy of the bitmap.
set_thread_flag(TIF_IO_BITMAP) or update_tif_io_bitmap();
tss_update_io_bitmap();

Does that make sense?

>
> > (Maybe it already is, but I swear I checked all the patches in the
> > series and I can't find the body of tss_update_io_bitmap().  But you
> > should call it in all branches of this if-else thing.)
>
> It's in that very same patch:
>
> > -static void tss_update_io_bitmap(struct tss_struct *tss,
> > -                                struct thread_struct *thread)

But where did the line you just deleted come from?  I'm obviously just
bad at reading emails somewhere.

> > +void tss_update_io_bitmap(struct tss_struct *tss, struct thread_struct *thread)
> >  {
>
> Let me try to get a bit more reuse. Which still leaves the TIF bit fiddling
> in this code path.
>
> Thanks,
>
>         tglx

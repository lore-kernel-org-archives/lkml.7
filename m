Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210ABC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 16:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70EA20842
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573405025;
	bh=XFmIm5uNvCalb775ps81pVPYZuxiMQbAhHtu7PlPR+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kLZHno6Wlg4MLEtaYJS/x8F3/vE+W5S6lRPJGM+Ctvwd16bQXpqpzaemb2pO7dsU7
	 vF5XTs9ySyf54pTP145Q4Cd/3Tsj8PEA1Qy/aU+3CjciSW92a9DsTS4oMPT+PJNZf2
	 2n/iPf5HHM9PjKQ0dCm0+bjbxbAxvLyljitUvtII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKJQ5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 11:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfKJQ5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 11:57:03 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CBD42184C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573405023;
        bh=XFmIm5uNvCalb775ps81pVPYZuxiMQbAhHtu7PlPR+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=leqBJyp5JSFCuHY5dycHA6PMCwGu8BYjxRWH1XXSvPvGLVy7yhfjxREl05eP9xL3x
         UxFOeyb/3fyTArAADZeZ7EHLketIeHRa0LUQUB/bVOwKbuFHbBngHoEj4pABJXHJ6h
         1pK2YnoyfXg9m+A5VzHzydOHxknTwBxlBs0iumfk=
Received: by mail-wr1-f48.google.com with SMTP id i12so5189704wro.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 08:57:02 -0800 (PST)
X-Gm-Message-State: APjAAAVMUE3ZaSXI4R6gSdoALPl0AoRWQ+p4ihFaREAjLyB1I+pkFidR
        RLiS7ZqB6n0fNn41vBCjFpTtEfShb8d3rYrCDIkLpw==
X-Google-Smtp-Source: APXvYqzbWSh9ofYRjVtXX3r5+2bk3bNvV8uFhLNht3HCNwsg7R5DMwvreaEHXLNz0u+rZEOUEjMLTZhXa4YxFxvFC1U=
X-Received: by 2002:a5d:490b:: with SMTP id x11mr14742143wrq.111.1573405021467;
 Sun, 10 Nov 2019 08:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20191106193459.581614484@linutronix.de> <20191106202805.948064985@linutronix.de>
 <53a6f346-fca1-ac04-ee34-6d472a0d4408@kernel.org> <alpine.DEB.2.21.1911090040520.2605@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911101332490.12583@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911101332490.12583@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 10 Nov 2019 08:56:50 -0800
X-Gmail-Original-Message-ID: <CALCETrXqP2SfhM83diqS9xr+Zso8rhsfmF8G-DQBBHAY3UU0dw@mail.gmail.com>
Message-ID: <CALCETrXqP2SfhM83diqS9xr+Zso8rhsfmF8G-DQBBHAY3UU0dw@mail.gmail.com>
Subject: Re: [patch 2/9] x86/process: Unify copy_thread_tls()
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

On Sun, Nov 10, 2019 at 4:36 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 9 Nov 2019, Thomas Gleixner wrote:
> > On Fri, 8 Nov 2019, Andy Lutomirski wrote:
> > > On 11/6/19 11:35 AM, Thomas Gleixner wrote:
> > > > +static inline int copy_io_bitmap(struct task_struct *tsk)
> > > > +{
> > > > + if (likely(!test_tsk_thread_flag(current, TIF_IO_BITMAP)))
> > > > +         return 0;
> > > > +
> > > > + tsk->thread.io_bitmap_ptr = kmemdup(current->thread.io_bitmap_ptr,
> > > > +                                     IO_BITMAP_BYTES, GFP_KERNEL);
> > >
> > > tsk->thread.io_bitmap_max = current->thread.io_bitmap_max?
> > >
> > > I realize you inherited this from the code you're refactoring, but it
> > > does seem to be missing.
> >
> > It already got copied with the task struct :)
> >
> > > > +#ifdef CONFIG_X86_64
> > > > + savesegment(gs, p->thread.gsindex);
> > > > + p->thread.gsbase = p->thread.gsindex ? 0 : current->thread.gsbase;
> > > > + savesegment(fs, p->thread.fsindex);
> > > > + p->thread.fsbase = p->thread.fsindex ? 0 : current->thread.fsbase;
> > > > + savesegment(es, p->thread.es);
> > > > + savesegment(ds, p->thread.ds);
> > > > +#else
> > > > + /* Clear all status flags including IF and set fixed bit. */
> > > > + frame->flags = X86_EFLAGS_FIXED;
> > > > +#endif
> > >
> > > Want to do another commit to make the eflags fixup unconditional?  I'm
> > > wondering if we have a bug.
> >
> > Let me look at that.
>
> 64bit does not have flags in the inactive_task_frame ...
>

Hmm.  One more thing to unify, I guess.

--Andy

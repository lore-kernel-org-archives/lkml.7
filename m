Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E9AC5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 23:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6015B20843
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 23:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562457045;
	bh=AK8MgET1vrfHE69i8xCIsTkO4CaO+eooMrT7GkGRfGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DEmQcYC6FvC4bv0nO9v7lJMQrwnUNHOzlY1sEbWKifkQR2Vqm5tBbKbNtm0yO8H5j
	 ePEBa4DrqGH9++x1Xd7uoUJzTFdHVsCJhGtLYIwAJuVBNwrUhKHccBsrakdmCQ5YG6
	 BudyLZuGq7sscallTxrejvlHrjK3gVFcEspXS5Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfGFXum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 19:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfGFXum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 19:50:42 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC022089C
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2019 23:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562457041;
        bh=AK8MgET1vrfHE69i8xCIsTkO4CaO+eooMrT7GkGRfGc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uB8mhOawdEGj0VVxb4LMPtx5LHx9vLECFUYEox/FkrIxQ9Sqh7wbFO5hd8pzUoiQR
         heR5E0wKqs2TN4jaxv9nYFJGRn0PZwgwZzbKpZfY3TjZ9IPNe2n2iMm+e5xWbPtMmf
         EVfSa6/FWjHbxJhG2NKZ5ByHkg5be5JCf07ijjSo=
Received: by mail-wm1-f43.google.com with SMTP id l2so5695193wmg.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 16:50:40 -0700 (PDT)
X-Gm-Message-State: APjAAAUpKkjHPECSH2FPRKZhU7nJYmaNQJLnHmrzB9TWOPVYX9MgK0d7
        vVEjpP1YMxEQpN4cZiDTpFCWNMT7OjVJHuq6Zph/SQ==
X-Google-Smtp-Source: APXvYqw2mbkvN2ksL+tQ+wRpCb+FYbaaAGLQZ0VJdR5LCDNF6oX+liEC7zQ5wMiiHbvwNXOOg2u26qPoBH/KVfvCVpc=
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr5341761wmk.79.1562457039466;
 Sat, 06 Jul 2019 16:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.534802824@infradead.org>
 <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
 <20190705134916.GU3402@hirez.programming.kicks-ass.net> <CAHk-=whsgA+8XtqJY91gqHhh9xLYQLM3kLLFTby=uf2eoZyK7Q@mail.gmail.com>
 <20190706182728.435a89ed@gandalf.local.home>
In-Reply-To: <20190706182728.435a89ed@gandalf.local.home>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 6 Jul 2019 16:50:27 -0700
X-Gmail-Original-Message-ID: <CALCETrWOZ0BO5uaodKypWEHHkRDhDaDUCZm=GAppZm0sWtP_pQ@mail.gmail.com>
Message-ID: <CALCETrWOZ0BO5uaodKypWEHHkRDhDaDUCZm=GAppZm0sWtP_pQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 6, 2019 at 3:27 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 6 Jul 2019 14:41:22 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Fri, Jul 5, 2019 at 6:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Also; all previous attempts at fixing this have been about pushing the
> > > read_cr2() earlier; notably:
> > >
> > >   0ac09f9f8cd1 ("x86, trace: Fix CR2 corruption when tracing page faults")
> > >   d4078e232267 ("x86, trace: Further robustify CR2 handling vs tracing")
> >
> > I think both of those are because people - again - felt like tracing
> > can validly corrupt CPU state, and then they fix up the symptoms
> > rather than the cause.
> >
> > Which I disagree with.
> >
> > > And I'm thinking that with exception of this patch, the rest are
> > > worthwhile cleanups regardless.
> >
> > I don't have any issues with the patches themselves, I agree that they
> > are probably good on their own.
> >
> > I *do* have issues with the "tracing can change CPU state so we need
> > to deal with it" model, though. I think that mode of thinking is
> > wrong. I don't believe tracing should ever change core CPU state and
> > that be considered ok.
> >
> > > Also; while looking at this, if we do continue with the C wrappers from
> > > the very last patch, we can do horrible things like this on top and move
> > > the read_cr2() back into C code.
> >
> > Again, I don't think that is the problem. I think it's a much more
> > fundamental problem in thinking that core code should be changed
> > because tracing is broken garbage and didn't do things right.
> >
> > I see Eiichi's patch, and it makes me go "that looks better" - simply
> > because it fixes the fundamental issue, rather than working around the
> > symptoms.
> >
>
> We also have to deal with reading vmalloc'd data as that can fault too.
> The perf ring buffer IIUC is vmalloc, so if perf records in one of
> these locations, then the reading of the vmalloc area has a potential
> to fault corrupting the CR2 register as well. Or have we changed
> vmalloc to no longer fault?
>

What context is that happening in?  If the tracepoint-saves-CR2 patch
is in, then it should be fine if it nests inside of tracing, right?
And NMI needs to save and restore CR2 no matter what, since it can
happen before we can possibly save CR2.  For that matter, MCE should
save and restore CR2 as well.

All that being said, I do like the idea of moving all this crud (IRQ
tracing, CR2 handling, and context tracking) into C.  I haven't had
time to review that part of Peter's series yet, but I should get to it
soon.

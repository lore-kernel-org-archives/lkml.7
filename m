Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4887DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155482133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554336214;
	bh=IQwt+447qV5imO/UOH2jhGSMtL5tPnWfpXrss+nzitA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KJp8gzPwWv3pNGhQSzEl7s+oFWY/d4JssouL+mrmnorWdhkrXRGfDR3DEGgIHYJyS
	 nVl02GYkc5k5OXtJjzWmF0mNL/JB2h6MAESBFVjlDTfFqkv5TdAc7CQpfxHJy59gqb
	 n1O7N2NVqH9I21U3ZGJqa1h1nh5d/4KXCQb19UZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDDADc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDDADc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:03:32 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FB582133D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2019 00:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554336211;
        bh=IQwt+447qV5imO/UOH2jhGSMtL5tPnWfpXrss+nzitA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dNX3x4venusSc1fwvH2YF6qQfqJH9dsBL69VGyQmb/zqdGJdIe6MDsw7zUIYs5mvL
         yjHy4Pc+GPfgobYxtEEMIBxhQ9IdYOjX9coMZPHaBxITO1dG5iycTu6BY1iaLfmW2F
         t4CSWdBrLEIEAyg7axxJDGHiP4HUV+hu11nKPO7s=
Received: by mail-wm1-f41.google.com with SMTP id v14so931820wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:03:31 -0700 (PDT)
X-Gm-Message-State: APjAAAUKUMmLMHVy7Z9CB+bRJAVUi7r9Uj4TcbVjieCf+22wuA7OPQz4
        CL87vKFIS5+dv10l3NunzSUFvEgIRwEMmB6l2Zp4qA==
X-Google-Smtp-Source: APXvYqy97LxgMZiTUkqi3Ql+JcbPS2+P8YK/Pf36YSYLhTs3NSuDkZu83nsT3I1xiARU290pqIeiU43XCQMfCNjRBi8=
X-Received: by 2002:a1c:6c04:: with SMTP id h4mr1807935wmc.135.1554336210047;
 Wed, 03 Apr 2019 17:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190331214020.836098943@linutronix.de> <20190331215136.039902969@linutronix.de>
 <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de>
 <20190402154329.scp7i7uqevubgwrz@treble> <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de>
 <7789E14E-C623-4DB7-B076-76B931957C9C@amacapital.net> <alpine.DEB.2.21.1904022027170.1812@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1904022127210.1812@nanos.tec.linutronix.de>
 <6205D576-694A-4C7D-B1B7-A9FF2E1F9E77@amacapital.net> <alpine.DEB.2.21.1904031823100.1967@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1904032038500.1833@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904032038500.1833@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 3 Apr 2019 17:03:18 -0700
X-Gmail-Original-Message-ID: <CALCETrWfSytPj4a34DWFi+R3v+xGsaDuLg75GQ0n-5-y+Y8nSg@mail.gmail.com>
Message-ID: <CALCETrWfSytPj4a34DWFi+R3v+xGsaDuLg75GQ0n-5-y+Y8nSg@mail.gmail.com>
Subject: Re: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 12:42 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, 3 Apr 2019, Thomas Gleixner wrote:
> > On Tue, 2 Apr 2019, Andy Lutomirski wrote:
> > > > On Apr 2, 2019, at 1:29 PM, Thomas Gleixner <tglx@linutronix.de> wr=
ote:
> > > >>> How about a much better fix: make the DB stack be the same size a=
s all
> > > >>> the others and just have 4 of them (DB0, DB1, DB2, and DB3.  Afte=
r all,
> > > >>> overflowing from one debug stack into another is just as much of =
a bug as
> > > >>> overflowing into a different IST stack.
> > > >>
> > > >> That makes sense.
> > > >
> > > > Except that we just have two not four.
> > > >
> > > > It needs some tweaking of the ist_shift stuff in entry_64.S but tha=
t's not
> > > > rocket science. Famous last words....
> > > >
> > >
> > > The ist_shift mess should probably be in C, but that=E2=80=99s a big =
can of
> > > worms. That being said, why do we have it at all?  Once upon a time, =
we=E2=80=99d
> > > do ICEBP from user mode (or a legit breakpoint), then send a signal a=
nd
> > > hit a data breakpoint, and we=E2=80=99d recurse.  But we don=E2=80=99=
t run user debug
> > > handlers on the IST stack at all anymore.
> > >
> > > Maybe we can convince ourselves it=E2=80=99s safe?
> >
> > Maybe. Need to think about it for a while.
>
> What about kprobes. It has nasty reentrancy stuff as well...
>

Hmm.  We used to have #BP on the same stack, and I bet there were
plenty of ways to get #DB and #BP inside each other.

I bet the best solution is to set dr7 to 0 before we do anything
complicated in do_debug() (at least if we got there from kernel mode).
But we should probably make this a whole separate project after your
series is done.

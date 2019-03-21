Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE69218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="uaBxmPiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfCUSFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:05:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54429 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfCUSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:05:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so3764866wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+dhNtZHz2aUQGL57Bt9CcBI34CoiuhUBVvd8MrBP400=;
        b=uaBxmPiKdE0A4uewRSsua1ekvdezN5R7TtgfxjjewGXogugyr9TiSok3lPBcl9T0Ec
         /gmyvWvgOKziajMvH4UV/M12UEd5MaDcC/ohABiPiV4svB3Vi5LecGnIwzgU8FY3UsKx
         2OoYwNo1N0HIBRp/DZJuE5KUENepivf430aprLeTWqzVYtfWECatNC3KKi+jjPSL1Ljo
         ebrFoEp11jsC/LGtV0p0OPl6lz6xpI0xEgkXV+3lLZEcEWkwFgDqlzbcb7xrVfHzCAl/
         wqFJUJ9CoGrcCgV7d+pfW5XJxFJLxxwkr2vcptlPLSpky21YYTm1kABBxX6uQIEzvZVV
         CyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dhNtZHz2aUQGL57Bt9CcBI34CoiuhUBVvd8MrBP400=;
        b=MSGzA1JcXBSG9WYuMb78trrj/tfS8Bt14Mkao5gKkjx0TKILVIXQKHAGJpfrD95LcY
         cWWPIg8YFX78Z2RYQ61WAlL13BZX3k9MeXs3s8m+mAIsgkwImHUxbf5kjPNPhoa5PlN0
         lbgtkv18kkgyRvyp1ekgtenMDQjRCpRC5/5pAik3WgPc+F9B0qOndQR2RXL4dpldr/vi
         p8SVumufzGL6zAVLSfNQruf/XPG2tVXsre5rm3ip3F9VFDS1Hbr097dM5vHnKvvd/bVN
         L23ZDbkkzzpF6Q129trjviakzueWyK9XO57HD5F3hnawWY83vH0kOCXMTC5z2wYeCLY7
         NKQw==
X-Gm-Message-State: APjAAAWlwGt5qlcvnE3zy+LWZtj9br4bMkyKvoTvHAttJ3KdDpcwgPt9
        rUXIuiHnWs83YnLLdpdHSqDxvpP3Px96oG56/Vi5KA==
X-Google-Smtp-Source: APXvYqxulvtAysVzY3Gcky2L3Fldix6KNz7aalRIMxUCsSjMzkqHAMIpVPZfiQG5E/PZwTTFZWrJyLZwcQiwfHFKeLw=
X-Received: by 2002:a7b:c257:: with SMTP id b23mr327038wmj.83.1553191517585;
 Thu, 21 Mar 2019 11:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190320221534.165ab87b@oasis.local.home> <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net> <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home> <20190321172203.GS5996@hirez.programming.kicks-ass.net>
In-Reply-To: <20190321172203.GS5996@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 21 Mar 2019 11:05:06 -0700
Message-ID: <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on error_entry
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 21, 2019 at 09:32:42AM -0400, Steven Rostedt wrote:
> > On Thu, 21 Mar 2019 11:45:17 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > -   .if \paranoid
> > > +   .if \read_cr2
> > > +   mov     %cr2, %rdx                      /* XXX paravirt crap */
> > > +   .endif
> > > +
> >
> > I'm guessing this breaks paravirt, as that's one reason I didn't add
> > the read_rc in assembly.
>
> Still completely missing 32bit support.. but this has paravirt bits on.
>
> It changes the read_cr2 stuff to CALLEE_SAVED and implements it in asm
> to only require AX, this means that asm can use it without it clobbering
> all volatile regs.
>
> My compiler also tripped over the KVM asyn pagefault stuff, which I also
> converted to use the new form.
>
> Again, completely untested. And given that the last one just worked,
> this one will _have_ to explode and let the magic smoke out :-)
>

Ugh.

I certainly agree in principle that sticking the CR2 read into the asm
is the right solution.  But this patch makes the spaghetti even more
tangled.  Maybe we can rearrange the code a bit so that the entry
sequence saves at least one register before calling error_entry, so we
can do it the obvious way.

In the long run, I think the right solution is to rewrite even more of
this mess in C.  We really ought to be able to put the IRQ flag
tracing and the context tracking into C code.

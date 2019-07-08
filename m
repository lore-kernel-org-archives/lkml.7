Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E3CC606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F878217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404742AbfGHTs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:48:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42952 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfGHTs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:48:58 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkZdA-0004Di-6H; Mon, 08 Jul 2019 21:48:56 +0200
Date:   Mon, 8 Jul 2019 21:48:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/pti for 5.3-rc1
In-Reply-To: <CAHk-=whhq5RQYNKzHOLqC+gzSjmcEGNJjbC=Psc_vQaCx4TCKg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907082146110.1961@nanos.tec.linutronix.de>
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de> <156257673796.14831.2572103765106531133.tglx@nanos.tec.linutronix.de> <CAHk-=whhq5RQYNKzHOLqC+gzSjmcEGNJjbC=Psc_vQaCx4TCKg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019, Linus Torvalds wrote:

> On Mon, Jul 8, 2019 at 2:22 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > @@ -643,9 +644,11 @@ static unsigned long ptrace_get_debugreg(struct task_struct *tsk, int n)
> >  {
> >         struct thread_struct *thread = &tsk->thread;
> >         unsigned long val = 0;
> > +       int index = n;
> >
> >         if (n < HBP_NUM) {
> > -               struct perf_event *bp = thread->ptrace_bps[n];
> > +               index = array_index_nospec(index, HBP_NUM);
> > +               struct perf_event *bp = thread->ptrace_bps[index];
> 
> This causes a new warning:
> 
>    warning: ISO C90 forbids mixed declarations and code
> 
> and I'm fixing it up in the merge as follows:

Ooops. No idea how that slipped through. Sorry!

> @@@ -633,9 -644,11 +634,10 @@@ static unsigned long ptrace_get_debugre
>   {
>         struct thread_struct *thread = &tsk->thread;
>         unsigned long val = 0;
>  -      int index = n;
> 
>         if (n < HBP_NUM) {
> -               struct perf_event *bp = thread->ptrace_bps[n];
>  -              index = array_index_nospec(index, HBP_NUM);
> ++              int index = array_index_nospec(n, HBP_NUM);
> +               struct perf_event *bp = thread->ptrace_bps[index];
> 
>                 if (bp)
>                         val = bp->hw.info.address;
> 
> Holler if I did something stupid.

Obviously correct.

Thanks for fixing it up.

       tglx



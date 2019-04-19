Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D20C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA9E21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="onDEdL0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfDSTbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:31:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfDSTbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iXu7qtV90TAxKYH/2qDtZAm2vUFkr3vt93OSKIvW9PU=; b=onDEdL0JiIo8l0d2NI8ZiO57n
        BVufEsky0unkXIj+CGJ5Rf4D5OWdt1H5T+2F/N7YbwbDHVBJNvB1qihBRhIL5OtJmqr18pNyPJVnh
        zOOSpjrrCoO/2vNOxJUDadawkUAE3rzH8JVHM6A0dwvFcDyUtbOH7AOERt8MBMw2Zt00vN676QgJH
        OvqBChN536MS92WV/Pi+//hgplJM8RYyVIDB6JGTXdNwIW3VVkSd8SXgn/9T96u/vfru35/EqrzhC
        +rt2w60YBOAoxt3GqZFgr1JthdIWyNArmAb6bZyiaYTQJfOq1202jLkveBbBFSlI54TZ3b/9OB/Ih
        fcZ1P7hLQ==;
Received: from [92.65.108.250] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHQ3A-0004uf-9P; Fri, 19 Apr 2019 09:43:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB102984ED8; Fri, 19 Apr 2019 11:43:13 +0200 (CEST)
Date:   Fri, 19 Apr 2019 11:43:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v3] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190419094313.GO7905@worktop.programming.kicks-ass.net>
References: <20190418160730.11901-1-kasong@redhat.com>
 <20190419005821.ttlpav7gviaed7am@treble>
 <CACPcB9fsYqs+xaj6w6ExKdpi-Pk4RqiD5HxTyURpee_arYQANg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9fsYqs+xaj6w6ExKdpi-Pk4RqiD5HxTyURpee_arYQANg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 10:17:49AM +0800, Kairui Song wrote:
> On Fri, Apr 19, 2019 at 8:58 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > I still don't like using regs->bp because it results in different code
> > paths for FP and ORC.  In the FP case, the regs are treated like real
> > regs even though they're fake.
> >
> > Something like the below would be much simpler.  Would this work?  I don't
> > know if any other code relies on the fake regs->bp or regs->sp.
> 
> Works perfectly. My only concern is that FP path used to work very
> well, not sure it's a good idea to change it, and this may bring some
> extra overhead for FP path.

Given Josh wrote all that code, I'm fairly sure it is still OK :-)

But also looking at the code in unwind_frame.c, __unwind_start() seems
to pretty much do what the removed caller_frame_pointer() did (when
.regs=NULL) but better.

> > +       if (perf_hw_regs(regs)) {
> > +               if (perf_callchain_store(entry, regs->ip))
> > +                       return;
> > +               unwind_start(&state, current, regs, NULL);
> > +       } else {
> > +               unwind_start(&state, current, NULL, (void *)regs->sp);
> > +       }

> >  #define perf_arch_fetch_caller_regs(regs, __ip)                {       \
> >         (regs)->ip = (__ip);                                    \
> > +       (regs)->sp = (unsigned long)__builtin_frame_address(0); \
> >         (regs)->cs = __KERNEL_CS;                               \
> >         regs->flags = 0;                                        \
> >  }

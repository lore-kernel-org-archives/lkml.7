Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAAFC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C11120645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfDSTLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:11:05 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38080 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfDSTLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:11:03 -0400
Received: by mail-it1-f196.google.com with SMTP id f22so9629057ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTOZ59iF6vyITV6RUy35ISuiq8HQkbzhWEffOIA1370=;
        b=nka3so4UR+c6IjnlrfTkSoQVdGuNno0pgyeYC9kZECex5iZj+IvDmI5GPyV5pmKmrf
         JxB1DzC364QhmUrshhnmAtmNYg5W5XDkmtnreQMlv9yg5wpu8UOF4COPL/nD23YiYlOi
         LLKy68BNZ7WaVEo1Zdiq30tonrObE+NhtgYg3DMUtNN/tSk+PeqSJxETWXngFBoSTOS7
         S3twxIs0lHbTIL6hVJQI7kGS5l8HSI1UgeVAkYNH9ArGylabfJwN+2MmJUDESN23KyVC
         NvjUXIhk+VEzGyS3tbSmn2DeVqvHt0QcQDvLudcImEt3ST6GW4WrCkKjeGuC0ssrI7df
         6qaA==
X-Gm-Message-State: APjAAAU4oN9cycs0G4YRovE7QFkpE8LWIkXTDVMq+BEeK5C+lcJnIoEj
        +C1TlPmG4KKzX4qwuRS4Yz0VmAjCzq5GsON61Ro3rjuGyaM9ng==
X-Google-Smtp-Source: APXvYqxcW3nWbjBA1HutHIeI6yQle841Kg3kR1pT99RNxTcnlGUUMdYfPr0jvbZPcPrBHM+tuhPyV8d0Q8RRE1qZdG8=
X-Received: by 2002:a02:c510:: with SMTP id s16mr2144469jam.51.1555674449868;
 Fri, 19 Apr 2019 04:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190418160730.11901-1-kasong@redhat.com> <20190419005821.ttlpav7gviaed7am@treble>
 <CACPcB9fsYqs+xaj6w6ExKdpi-Pk4RqiD5HxTyURpee_arYQANg@mail.gmail.com> <20190419094313.GO7905@worktop.programming.kicks-ass.net>
In-Reply-To: <20190419094313.GO7905@worktop.programming.kicks-ass.net>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 19 Apr 2019 19:47:18 +0800
Message-ID: <CACPcB9dKmH4oNR1fAwGndoPMiZsgfFve4g2_d26pYTByGrt75w@mail.gmail.com>
Subject: Re: [RFC PATCH v3] perf/x86: make perf callchain work without CONFIG_FRAME_POINTER
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 5:43 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Apr 19, 2019 at 10:17:49AM +0800, Kairui Song wrote:
> > On Fri, Apr 19, 2019 at 8:58 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > I still don't like using regs->bp because it results in different code
> > > paths for FP and ORC.  In the FP case, the regs are treated like real
> > > regs even though they're fake.
> > >
> > > Something like the below would be much simpler.  Would this work?  I don't
> > > know if any other code relies on the fake regs->bp or regs->sp.
> >
> > Works perfectly. My only concern is that FP path used to work very
> > well, not sure it's a good idea to change it, and this may bring some
> > extra overhead for FP path.
>
> Given Josh wrote all that code, I'm fairly sure it is still OK :-)
>
> But also looking at the code in unwind_frame.c, __unwind_start() seems
> to pretty much do what the removed caller_frame_pointer() did (when
> .regs=NULL) but better.
>

OK, with FP we will also need to do a few more extra unwinding,
previously it start directly from the frame of the trace point, now
have to trace back to the trace point first.
If that's fine I could post another update (that will be pretty much
just copy&paste from the Josh's code he posted :P , is this OK?)





--
Best Regards,
Kairui Song

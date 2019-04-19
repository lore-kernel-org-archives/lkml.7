Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AB7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5467020821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfDSTXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:23:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfDSTXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:23:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63BE37DCC2;
        Fri, 19 Apr 2019 15:45:39 +0000 (UTC)
Received: from treble (ovpn-124-190.rdu2.redhat.com [10.10.124.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4617F600C7;
        Fri, 19 Apr 2019 15:45:38 +0000 (UTC)
Date:   Fri, 19 Apr 2019 10:45:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20190419154536.7n3pernnimblvtfe@treble>
References: <20190418160730.11901-1-kasong@redhat.com>
 <20190419005821.ttlpav7gviaed7am@treble>
 <CACPcB9fsYqs+xaj6w6ExKdpi-Pk4RqiD5HxTyURpee_arYQANg@mail.gmail.com>
 <20190419094313.GO7905@worktop.programming.kicks-ass.net>
 <CACPcB9dKmH4oNR1fAwGndoPMiZsgfFve4g2_d26pYTByGrt75w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPcB9dKmH4oNR1fAwGndoPMiZsgfFve4g2_d26pYTByGrt75w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 19 Apr 2019 15:45:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 07:47:18PM +0800, Kairui Song wrote:
> On Fri, Apr 19, 2019 at 5:43 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Apr 19, 2019 at 10:17:49AM +0800, Kairui Song wrote:
> > > On Fri, Apr 19, 2019 at 8:58 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > >
> > > > I still don't like using regs->bp because it results in different code
> > > > paths for FP and ORC.  In the FP case, the regs are treated like real
> > > > regs even though they're fake.
> > > >
> > > > Something like the below would be much simpler.  Would this work?  I don't
> > > > know if any other code relies on the fake regs->bp or regs->sp.
> > >
> > > Works perfectly. My only concern is that FP path used to work very
> > > well, not sure it's a good idea to change it, and this may bring some
> > > extra overhead for FP path.
> >
> > Given Josh wrote all that code, I'm fairly sure it is still OK :-)
> >
> > But also looking at the code in unwind_frame.c, __unwind_start() seems
> > to pretty much do what the removed caller_frame_pointer() did (when
> > .regs=NULL) but better.
> >
> 
> OK, with FP we will also need to do a few more extra unwinding,
> previously it start directly from the frame of the trace point, now
> have to trace back to the trace point first.
> If that's fine I could post another update (that will be pretty much
> just copy&paste from the Josh's code he posted :P , is this OK?)

You're right that FP will need to unwind a few extra frames, but I doubt
that will make much of a difference performance-wise.  I prefer the
simpler approach.

If you use that patch for the next version then you can add

  Co-developed-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks.

-- 
Josh

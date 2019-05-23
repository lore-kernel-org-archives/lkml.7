Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D90C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8759C2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbfEWR1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 13:27:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfEWR1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 13:27:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CE565946F;
        Thu, 23 May 2019 17:27:26 +0000 (UTC)
Received: from treble (ovpn-121-106.rdu2.redhat.com [10.10.121.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 331E560BF3;
        Thu, 23 May 2019 17:27:17 +0000 (UTC)
Date:   Thu, 23 May 2019 12:27:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190523172714.6fkzknfsuv2t44se@treble>
References: <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com>
 <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble>
 <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble>
 <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble>
 <CACPcB9e0mL6jdNWfH-2K-rkvmQiz=G6mtLiZ+AEmp3-V0x+Z8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPcB9e0mL6jdNWfH-2K-rkvmQiz=G6mtLiZ+AEmp3-V0x+Z8A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 23 May 2019 17:27:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:41:59AM +0800, Kairui Song wrote:
>  On Thu, May 23, 2019 at 11:24 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Thu, May 23, 2019 at 10:50:24PM +0800, Kairui Song wrote:
> > > > > Hi Josh, this still won't fix the problem.
> > > > >
> > > > > Problem is not (or not only) with ___bpf_prog_run, what actually went
> > > > > wrong is with the JITed bpf code.
> > > >
> > > > There seem to be a bunch of issues.  My patch at least fixes the failing
> > > > selftest reported by Alexei for ORC.
> > > >
> > > > How can I recreate your issue?
> > >
> > > Hmm, I used bcc's example to attach bpf to trace point, and with that
> > > fix stack trace is still invalid.
> > >
> > > CMD I used with bcc:
> > > python3 ./tools/stackcount.py t:sched:sched_fork
> >
> > I've had problems in the past getting bcc to build, so I was hoping it
> > was reproducible with a standalone selftest.
> >
> > > And I just had another try applying your patch, self test is also failing.
> >
> > Is it the same selftest reported by Alexei?
> >
> >   test_stacktrace_map:FAIL:compare_map_keys stackid_hmap vs. stackmap err -1 errno 2
> >
> > > I'm applying on my local master branch, a few days older than
> > > upstream, I can update and try again, am I missing anything?
> >
> > The above patch had some issues, so with some configs you might see an
> > objtool warning for ___bpf_prog_run(), in which case the patch doesn't
> > fix the test_stacktrace_map selftest.
> >
> > Here's the latest version which should fix it in all cases (based on
> > tip/master):
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?h=bpf-orc-fix
> 
> Hmm, I still get the failure:
> test_stacktrace_map:FAIL:compare_map_keys stackid_hmap vs. stackmap
> err -1 errno 2
> 
> And I didn't see how this will fix the issue. As long as ORC need to
> unwind through the JITed code it will fail. And that will happen
> before reaching ___bpf_prog_run.

Ok, I was able to recreate by doing

  echo 1 > /proc/sys/net/core/bpf_jit_enable

first.  I'm guessing you have CONFIG_BPF_JIT_ALWAYS_ON.

-- 
Josh

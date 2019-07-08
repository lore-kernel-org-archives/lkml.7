Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B3CC606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2AF216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfGHXCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:02:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfGHXCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:02:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B05CE8552A;
        Mon,  8 Jul 2019 23:02:07 +0000 (UTC)
Received: from treble (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E53F2B592;
        Mon,  8 Jul 2019 23:02:03 +0000 (UTC)
Date:   Mon, 8 Jul 2019 18:02:01 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kairui Song <kasong@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] bpf: Fix ORC unwinding in non-JIT BPF code
Message-ID: <20190708230201.mol27wzansuy3n2v@treble>
References: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
 <tip-b22cf36c189f31883ad0238a69ccf82aa1f3b16b@git.kernel.org>
 <20190706202942.GA123403@gmail.com>
 <20190707013206.don22x3tfldec4zm@treble>
 <20190707055209.xqyopsnxfurhrkxw@treble>
 <CAADnVQJqT8o=_6P6xHjwxrXqX9ToSb0cTfoOcm2Xcha3KRNNSw@mail.gmail.com>
 <20190708223834.zx7u45a4uuu2yyol@treble>
 <CAADnVQKWDvzsvyjGoFvSQV7VGr2hF2zzCsC9vnpncWMxOJWYdw@mail.gmail.com>
 <20190708225359.ewk44pvrv6a4oao7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190708225359.ewk44pvrv6a4oao7@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 08 Jul 2019 23:02:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 05:53:59PM -0500, Josh Poimboeuf wrote:
> On Mon, Jul 08, 2019 at 03:49:33PM -0700, Alexei Starovoitov wrote:
> > > > Sorry for delay. I'm mostly offgrid until next week.
> > > > As far as -fno-gcse.. I don't mind as long as it doesn't hurt performance.
> > > > Which I suspect it will :(
> > > > All these indirect gotos are there for performance.
> > > > Single indirect goto and a bunch of jmp select_insn
> > > > are way slower, since there is only one instruction
> > > > for cpu branch predictor to work with.
> > > > When every insn is followed by "jmp *jumptable"
> > > > there is more room for cpu to speculate.
> > > > It's been long time, but when I wrote it the difference
> > > > between all indirect goto vs single indirect goto was almost 2x.
> > >
> > > Just to clarify, -fno-gcse doesn't get rid of any of the indirect jumps.
> > > It still has 166 indirect jumps.  It just gets rid of the second
> > > optimization, where the jumptable address is placed in a register.
> > 
> > what about other functions in core.c ?
> > May be it's easier to teach objtool to recognize that pattern?
> 
> The GCC man page actually recommends using -fno-gcse for computed goto
> code, for better performance.  So if that's actually true, then it would
> be win-win because objtool wouldn't need a change for it.
> 
> Otherwise I can teach objtool to recognize the new pattern.
> 
> > > If you have a benchmark which is relatively easy to use, I could try to
> > > run some tests.
> > 
> > modprobe test_bpf
> > selftests/bpf/test_progs
> > both print runtime.
> > Some of test_progs have high run-to-run variations though.
> 
> Thanks, I'll give it a shot.

I modprobed test_bpf with JIT disabled.

Before: 2.493018s
After:  2.523572s

So it looks like it's either no change, or slightly slower.

I'll just teach objtool to recognize the optimization.

-- 
Josh

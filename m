Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08327C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8AC21726
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 01:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfF0Baj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 21:30:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfF0Baj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 21:30:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54CDB8666F;
        Thu, 27 Jun 2019 01:30:38 +0000 (UTC)
Received: from treble (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC2DC60BE5;
        Thu, 27 Jun 2019 01:30:36 +0000 (UTC)
Date:   Wed, 26 Jun 2019 20:30:34 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 3/4] bpf: Fix ORC unwinding in non-JIT BPF code
Message-ID: <20190627013034.cgyb7ytusvapmsqq@treble>
References: <cover.1561595111.git.jpoimboe@redhat.com>
 <a5a486434d31d77297d39c4adccea22fac3027c1.1561595111.git.jpoimboe@redhat.com>
 <CAADnVQL2z4BPUvtem-1C_JxzSgc_L8ED=VjGLu7ypPSq3wwC4w@mail.gmail.com>
 <20190627010653.yovvztgmimaywaz5@treble>
 <CAADnVQ+hZvNEx6pjWKEomn=Nh8zM1451kVscvCyyWaJ-DmcehA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQ+hZvNEx6pjWKEomn=Nh8zM1451kVscvCyyWaJ-DmcehA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 27 Jun 2019 01:30:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 06:22:48PM -0700, Alexei Starovoitov wrote:
> On Wed, Jun 26, 2019 at 6:07 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Wed, Jun 26, 2019 at 05:57:08PM -0700, Alexei Starovoitov wrote:
> > > On Wed, Jun 26, 2019 at 5:36 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > >
> > > > Objtool previously ignored ___bpf_prog_run() because it didn't
> > > > understand the jump table.  This resulted in the ORC unwinder not being
> > > > able to unwind through non-JIT BPF code.
> > > >
> > > > Now that objtool knows how to read jump tables, remove the whitelist and
> > > > rename the variable to "jump_table" so objtool can recognize it.
> > > >
> > > > Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
> > > > Reported-by: Song Liu <songliubraving@fb.com>
> > > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > ---
> > > >  kernel/bpf/core.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > > index 080e2bb644cc..ff66294882f8 100644
> > > > --- a/kernel/bpf/core.c
> > > > +++ b/kernel/bpf/core.c
> > > > @@ -1299,7 +1299,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> > > >  {
> > > >  #define BPF_INSN_2_LBL(x, y)    [BPF_##x | BPF_##y] = &&x##_##y
> > > >  #define BPF_INSN_3_LBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = &&x##_##y##_##z
> > > > -       static const void *jumptable[256] = {
> > > > +       static const void *jump_table[256] = {
> > > >                 [0 ... 255] = &&default_label,
> > > >                 /* Now overwrite non-defaults ... */
> > > >                 BPF_INSN_MAP(BPF_INSN_2_LBL, BPF_INSN_3_LBL),
> > > > @@ -1315,7 +1315,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> > > >  #define CONT_JMP ({ insn++; goto select_insn; })
> > > >
> > > >  select_insn:
> > > > -       goto *jumptable[insn->code];
> > > > +       goto *jump_table[insn->code];
> > >
> > > I thought we were clear that it is a nack?
> > > Either live it alone or rename to something like jump_table_bpf_interpreter
> > > or bpf_interpreter_jump_table.
> >
> > As I have said many times:
> >
> > The jump table detection is a generic objtool feature.  It makes no
> > sense to give a bpf-specific name to a generic objtool feature which can
> > be used by other components.
> 
> Nacked-by: Alexei Starovoitov <ast@kernel.org>

Whatever, it's your code...

To the -tip maintainers: patches 1 and 4 are independent of this change
and can be merged regardless.

-- 
Josh

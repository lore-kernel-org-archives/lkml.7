Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7BDC5B578
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 01:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3D32082F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 01:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfGGBcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 21:32:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfGGBcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 21:32:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9555B31628F9;
        Sun,  7 Jul 2019 01:32:10 +0000 (UTC)
Received: from treble (ovpn-122-197.rdu2.redhat.com [10.10.122.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A81C2A2C0;
        Sun,  7 Jul 2019 01:32:08 +0000 (UTC)
Date:   Sat, 6 Jul 2019 20:32:06 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     bp@alien8.de, hpa@zytor.com, songliubraving@fb.com,
        tglx@linutronix.de, rostedt@goodmis.org, kasong@redhat.com,
        daniel@iogearbox.net, ast@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] bpf: Fix ORC unwinding in non-JIT BPF code
Message-ID: <20190707013206.don22x3tfldec4zm@treble>
References: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
 <tip-b22cf36c189f31883ad0238a69ccf82aa1f3b16b@git.kernel.org>
 <20190706202942.GA123403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190706202942.GA123403@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sun, 07 Jul 2019 01:32:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 10:29:42PM +0200, Ingo Molnar wrote:
> 
> * tip-bot for Josh Poimboeuf <tipbot@zytor.com> wrote:
> 
> > Commit-ID:  b22cf36c189f31883ad0238a69ccf82aa1f3b16b
> > Gitweb:     https://git.kernel.org/tip/b22cf36c189f31883ad0238a69ccf82aa1f3b16b
> > Author:     Josh Poimboeuf <jpoimboe@redhat.com>
> > AuthorDate: Thu, 27 Jun 2019 20:50:47 -0500
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Sat, 29 Jun 2019 07:55:14 +0200
> > 
> > bpf: Fix ORC unwinding in non-JIT BPF code
> > 
> > Objtool previously ignored ___bpf_prog_run() because it didn't understand
> > the jump table.  This resulted in the ORC unwinder not being able to unwind
> > through non-JIT BPF code.
> > 
> > Now that objtool knows how to read jump tables, remove the whitelist and
> > annotate the jump table so objtool can recognize it.
> > 
> > Also add an additional "const" to the jump table definition to clarify that
> > the text pointers are constant.  Otherwise GCC sets the section writable
> > flag and the assembler spits out warnings.
> > 
> > Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
> > Reported-by: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Alexei Starovoitov <ast@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Kairui Song <kasong@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Link: https://lkml.kernel.org/r/881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com
> > 
> > ---
> >  kernel/bpf/core.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Hm, I get this new build warning on x86-64 defconfig-ish kernels plus 
> these enabled:
> 
>  CONFIG_BPF=y
>  CONFIG_BPF_JIT=y
> 
> kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x8da: sibling call from callable instruction with modified stack frame

I assume you have CONFIG_RETPOLINE disabled?  For some reason that
causes GCC to add 166 indirect jumps to that function, which is giving
objtool trouble.  Looking into it.

-- 
Josh

Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2040C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 06:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702D82070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 06:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574836875;
	bh=QMtUayIjPqfiRBFg5lJVyjGrBYgdKgmTLeiS9399/yo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=i9uJFforRMy9eUuzfaVCRnZ+h4F1Lj/d/rLDnrSxKQ24o+Zqr9abMj2//4ZOOuabz
	 evg92pQPbEC6Gg0/sTukY35a7aHrlnHhjbsd+9qtZt+kEPSm0m3LA9rA66l4ci9UVi
	 xE1f+APm38y/zG8NzeyFMmctq2xidPBCO5r1mxf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfK0GlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 01:41:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfK0GlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 01:41:11 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C1FC20409;
        Wed, 27 Nov 2019 06:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574836870;
        bh=QMtUayIjPqfiRBFg5lJVyjGrBYgdKgmTLeiS9399/yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k9wLEU/YiD+3WfMU7FlBwJqsPIoU77LvgmSWYL3G1zE6561ERnmMm8ske39qRr/54
         PVoCHLuccII1t+Hp+d67CCNZCzAHtiYj5pm/JLyid6NDaIkfPd63YrH+kl8in49wD4
         UTwGlhjezygJwvI6m+ip9YP8y/4b3YaAp1/YFtwM=
Date:   Wed, 27 Nov 2019 15:41:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        bristot <bristot@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        jbaron@akamai.com, Jessica Yu <jeyu@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and
 more)
Message-Id: <20191127154105.ec31e8b494b2b0f04e1f430c@kernel.org>
In-Reply-To: <CAADnVQ+y9-JRA1u+UMD8uWjq1dt9AZrJKeOMe_zDNRL=wZ39TA@mail.gmail.com>
References: <20191111131252.921588318@infradead.org>
        <20191125125534.2aaaccf00c38a9a25dee623a@kernel.org>
        <20191125123245.5ae9cb60@gandalf.local.home>
        <20191126091104.5e0cdc61e3b143fae4ed4cfd@kernel.org>
        <20191126175812.c6e0cd1249422989007c91fe@kernel.org>
        <20191126185809.91574fb8eb02f3b2dd3af863@kernel.org>
        <20191127084854.55ce1916e4f6d372f9731ed4@kernel.org>
        <CAADnVQK4twuXzFhD-qLHmCVK0n1h-GDENQLu+4PVV3Hp++R6kQ@mail.gmail.com>
        <CAADnVQ+y9-JRA1u+UMD8uWjq1dt9AZrJKeOMe_zDNRL=wZ39TA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 20:32:29 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Nov 26, 2019 at 4:03 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> >
> >
> > On Tue, Nov 26, 2019 at 3:49 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >>
> >> On Tue, 26 Nov 2019 18:58:09 +0900
> >> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >> > I applied following patch, but it seems not enough. While disabling 256 kprobes,
> >> > system was frozen (no BUG message).
> >>
> >> Aah, this is another bug in optprobe. I'll send a series for fix these bugs.
> >
> >
> > Awesome! I’ve started looking at this crash as well.
> > Could you share a brief description of the bug and cc me on fixes?
> > I’d like to test them too.

Yeah, please see my patches sent now.

> > Thanks
> 
> I noticed that your config doesn't have CONFIG_KPROBES_ON_FTRACE=y
> and without it most test.d/kprobe/ tests fail, but in your log they are passing.
> Also do you have KPROBE_EVENTS_ON_NOTRACE=y ?

That is a secondary results of disabling FUNCTION_TRACER. And that error
has been fixed by following series :)

https://lkml.kernel.org/r/157475724667.3389.15752644047898709246.stgit@devnote2

> Since without these two configs the crash wasn't reproducing for me.
> Anyhow waiting for your fixes.

Yeah, this config is accidentally changed multiple-kprobes.tc test
behavior. With the FUNCTION_TRACER, most of the target functions have
5-bytes nop on the entry as the room for ftrace instrumentation.
Thus the multiple-kprobes.tc adds 5-bytes offset to avoiding that nops.
In this case, most of the "symbol+5" address are on the instruction
boundaries.
But without FUNCTION_TRACER, those nops are gone, and (roughly) a half of
"symbol+5" are not on the instruction boundaries anymore. Thus, the set of
target functions are changed and hit this bug.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ADAC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 01:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A8B23711
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 01:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567216320;
	bh=6ZVO6Kgnl2/yMVACGky5QkUMCvnZiY739++Qznggkxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Io6vxIhfGxGV3/MvSUJ03oDh9PrXR5Ts8/DodZHsyCbV6+TJ2dP7wEeZiMobnPi5E
	 mtFH4H9vUF72SeIVaTo4EZn8Hy6QKdyMhiwp1NJXDTuMrhvlMidCWQ6ow7Q7Ea9JCP
	 4BYOleG9bCqZCs3SCAFQT+I/CeJXQOxdgUH/9g6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfHaBv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 21:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfHaBv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 21:51:59 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8614E23429;
        Sat, 31 Aug 2019 01:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567216317;
        bh=6ZVO6Kgnl2/yMVACGky5QkUMCvnZiY739++Qznggkxw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x3Mlo7tRXGz8TDC9ri0br/23lD+Q+RomNSuCbQCvQ1HE2Q0/42qiVejCh/0woXSFp
         VlJyaYk1XA4ZKREJyY0Q8MmW6SnFrzLtBLC88Gw7mgXKNmodQL2FKk6bmrgtktpzr4
         Vfb2sKDzzrPyjYokpE+Ih/wdNa1S2VvYkmAZw4MU=
Date:   Sat, 31 Aug 2019 10:51:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/4] objtool,perf: Use shared x86 insn decoder
Message-Id: <20190831105152.bcacc88a7cc760070fc95d98@kernel.org>
In-Reply-To: <20190830194845.GI28011@kernel.org>
References: <cover.1567118001.git.jpoimboe@redhat.com>
        <20190830184020.GG28011@kernel.org>
        <20190830190058.GH28011@kernel.org>
        <20190830193109.p7jagidsrahoa4pn@treble>
        <20190830194845.GI28011@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 16:48:45 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, Aug 30, 2019 at 02:31:09PM -0500, Josh Poimboeuf escreveu:
> > On Fri, Aug 30, 2019 at 04:00:58PM -0300, Arnaldo Carvalho de Melo wrote:
> > > I.e. we need to make sure that it always gets the x86 stuff, not
> > > something that is tied to the host arch, with the patch below we get it
> > > to work, please take a look.
> > > 
> > > Probably this should go to the master copy, i.e. to the kernel sources,
> > > no?

Interesting approach. Hmm, but I would like "diff -I" trick just
for short term solution.

> > > 
> > > That or we'll have to ask the check-headers.sh and objtool sync-check
> > > (hey, this should be unified, each project could provide just the list
> > > of things it uses, but I digress) to ignore those lines...
> > > 
> > > I.e. we want to decode intel_PT traces on other arches, ditto for
> > > CoreSight (not affected here, but similar concept).
> > > 
> > > will kick the full container build process now.
> > 
> > Interesting, I didn't realize other arches would be using it.  The patch
> 
> Yeah, decoding CoreSight (aarch64) hardware traces on x86_64 should be
> as possible as decoding Intel PT hardware traces on aarch64 :-)
> 
> > looks good to me.
> > 
> > Ideally there wouldn't be any differences between the headers, but if
> > that's unavoidable then I guess we can just use the same 'diff -I' trick
> 
> I'll go with this now, but...
> 
> > we were using before in the check script(s).
> 
> Masami? What do you think of applying the patch to the main kernel
> sources so that building a decoder for x86 on any other arch becomes
> possible?

I think the build of kernel and user-space tools are different especially
for "include/asm", since user-space tools may want to use all architecture
features, but kernel needs only the architecture which it runs on.
Maybe we need a special Makefile entries for the modules which depends
on architecture dependent parts. e.g.

x86-objs = insn.o inat.o ...
arm64-objs = coresight.o ...

and they should have different -I options ('-I arch/x86/include' or 
'-I arch/arm64/include') for compiling.
I think this is better and scalable, if you use common (clone) files in
the kernel tree.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E45C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDC62173C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439684AbfFLO1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:27:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439638AbfFLO1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:27:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91C0DC18B2F3;
        Wed, 12 Jun 2019 14:27:00 +0000 (UTC)
Received: from treble (ovpn-120-37.rdu2.redhat.com [10.10.120.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA67519483;
        Wed, 12 Jun 2019 14:26:54 +0000 (UTC)
Date:   Wed, 12 Jun 2019 09:26:52 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kairui Song <kasong@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190612142652.tzrlwduirm4edmtf@treble>
References: <ab047883-69f6-1175-153f-5ad9462c6389@fb.com>
 <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble>
 <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble>
 <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble>
 <20190524085319.GE2589@hirez.programming.kicks-ass.net>
 <20190612030501.7tbsjy353g7l74ej@treble>
 <20190612091023.6bccf262@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190612091023.6bccf262@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 12 Jun 2019 14:27:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 09:10:23AM -0400, Steven Rostedt wrote:
> On Tue, 11 Jun 2019 22:05:01 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > Right now, ftrace has a special hook in the ORC unwinder
> > (orc_ftrace_find).  It would be great if we could get rid of that in
> > favor of the "always use frame pointers" approach.  I'll hold off on
> > doing the kpatch/kprobe trampoline conversions in my patches since it
> > would conflict with yours.
> 
> Basically, IIUC, what you are saying is that the ftrace trampoline
> should always store the %sp in %rb even when CONFIG_FRAME_POINTER is not
> enabled? And this can allow you to remove the ftrace specific code from
> the orc unwinder?

Basically, yes.  Though the frame pointer encoding which Peter is adding
to the ftrace/kprobes trampolines might complicate things a bit.

-- 
Josh

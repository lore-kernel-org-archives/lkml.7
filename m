Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC541C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63DF214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGIPiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:38:00 -0400
Received: from foss.arm.com ([217.140.110.172]:46260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfGIPiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:38:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E31E2B;
        Tue,  9 Jul 2019 08:37:59 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC2773F246;
        Tue,  9 Jul 2019 08:37:57 -0700 (PDT)
Date:   Tue, 9 Jul 2019 16:37:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        James Morse <james.morse@arm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kprobes sanity test fails on next-20190708
Message-ID: <20190709153755.GB10123@lakrids.cambridge.arm.com>
References: <20190708141136.GA3239@localhost.localdomain>
 <a19faa89-d318-fe21-9952-b0f842240ba5@arm.com>
 <CADYN=9LBQ4NYFe8BPguJmxJFMiAJ405AZNU7W6gHXLSrZOSgTA@mail.gmail.com>
 <20190709213657.1447f508bd6b72495ec225d9@gmail.com>
 <20190709112548.25edc9a7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709112548.25edc9a7@gandalf.local.home>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 11:25:48AM -0400, Steven Rostedt wrote:
> On Tue, 9 Jul 2019 21:36:57 +0900
> Masami Hiramatsu <masami.hiramatsu@gmail.com> wrote:
> 
> > On Tue, 9 Jul 2019 12:19:15 +0200
> > Anders Roxell <anders.roxell@linaro.org> wrote:
> > 
> > > On Mon, 8 Jul 2019 at 17:56, James Morse <james.morse@arm.com> wrote:  
> > > >
> > > > Hi,
> > > >
> > > > On 08/07/2019 15:11, Anders Roxell wrote:  
> > > > > argh... resending, with plaintext... Sorry =/
> > > > >
> > > > > I tried to build a next-201908 defconfig + CONFIG_KPROBES=y and
> > > > > CONFIG_KPROBES_SANITY_TEST=y
> > > > >
> > > > > I get the following Call trace, any ideas?
> > > > > I've tried tags back to next-20190525 and they also failes... I haven't
> > > > > found a commit that works yet.
> > > > >
> > > > > [    0.098694] Kprobe smoke test: started
> > > > > [    0.102001] audit: type=2000 audit(0.088:1): state=initialized
> > > > > audit_enabled=0 res=1
> > > > > [    0.104753] Internal error: aarch64 BRK: f2000004 [#1] PREEMPT SMP  
> > > >
> > > > This sounds like the issue Mark reported:
> > > > https://lore.kernel.org/r/20190702165008.GC34718@lakrids.cambridge.arm.com
> > > >
> > > > It doesn't look like Steve's patch has percolated into next yet:
> > > > https://lore.kernel.org/lkml/20190703103715.32579c25@gandalf.local.home/
> 
> I forgot to push it after sending it. :-(
> 
> > > >
> > > > Could you give that a try to see if this is a new issue?  
> > > 
> > > The patch didn't apply cleanly.
> > > However, when I resolved the issue it works.
> > > I'm a bit embarrassed since I now remembered that I reported it a while back.
> > > https://lore.kernel.org/lkml/20190625191545.245259106@goodmis.org/
> > > 
> > > Both patches resolved the issue.
> > > I've tested both.  
> > 
> > In that case, the later one (move postcore to subsys) seems good to me.
> > 
> > Delaying the test is just avoiding the issue that the selftest found,
> > since right after init_kprobes() are called, the kprobe is ready for use.
> > This means that the selftest must be run as the first user of the kprobes
> > and it must be run right after initialize kprobes.
> 
> I agree. I pushed to my repo in the for-next branch. Care to test that?
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

I've just given that a spin with KPROBES and KPROBES_SANITY_TEST
selected, and it boots cleanly for me. FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

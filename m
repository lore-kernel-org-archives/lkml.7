Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67800C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA30217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbfDRCPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 22:15:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfDRCPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 22:15:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 19D7E307EAA4;
        Thu, 18 Apr 2019 02:15:54 +0000 (UTC)
Received: from treble (ovpn-124-190.rdu2.redhat.com [10.10.124.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 727025C207;
        Thu, 18 Apr 2019 02:15:50 +0000 (UTC)
Date:   Wed, 17 Apr 2019 21:15:48 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kairui Song <kasong@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v2] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190418021548.tutxiv2qaoop5nfa@treble>
References: <20190408165942.23640-1-kasong@redhat.com>
 <20190415153622.GG12232@hirez.programming.kicks-ass.net>
 <20190415165859.ul7i2w3lai3umgik@treble>
 <CACPcB9f8OJmk++54YwW3yhrnohj31+oJcxfesJbNbNSGk9WUQQ@mail.gmail.com>
 <CACPcB9f0D4SdJLAtUs4vYwduBiPYDpa-y8r7jracYy=sAJmo5g@mail.gmail.com>
 <20190416201559.d267liiwpjvo3wet@treble>
 <20190417070735.GW4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190417070735.GW4038@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 18 Apr 2019 02:15:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:07:35AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 16, 2019 at 03:15:59PM -0500, Josh Poimboeuf wrote:
> > If you do the regs->eflags thing to mark the regs as fake in
> > (perf_arch_fetch_caller_regs()), then I don't think skip_sp would be
> > needed, because regs->sp could probably mark the skip point.
> > 
> > Instead I was actually hoping we could get rid of fake regs and
> > perf_arch_fetch_caller_regs() altogether, because it's a nasty hack.
> > But I don't know what else those fake regs are used for.
> 
> This is the generic perf generate a sample path. It doesn't know the
> context. Normally it is an interrupt or exception of sorts and we simply
> pass the pt_regs from that down the chain and all is good.
> 
> It is just for a few software events, such as SW_CONTEXT_SWITCH,
> SW_MIGRATIONS and all the TP muck that we do not have regs to pass down.
> 
> These regs are used by:
> 
>  - SAMPLE_IP,
>  - SAMPLE_CALLCHAIN (this here issue),
>  - SAMPLE_REGS_INTR,
>  - a few misc bits
> 
> There's actually comment on top of perf_fetch_caller_regs() that tries
> to explain what is needed -- although I suppose that could do with an
> update.

Ok, I guess it makes a little more sense now to my perf-ignorant brain.
An improved comment would definitely help.

Sounds like using a reserved regs->flags bit to indicate fake regs is
the way to go.

-- 
Josh

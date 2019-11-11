Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849AEC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534E421655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CjGArxSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfKKOrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:47:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40854 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfKKOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KacwoM/PURyvxk09Q1LWi5n4/p0zOHyHZBnPkZyRKqk=; b=CjGArxSgB2NHoy6hOoUjWIeIr
        6Gquvm5IpmPSJo4vNAhZ2Ns7La5TzCzqKPISOZUj8ZO1KbRpG3q4SEQ/eJbk7MhIoHppHCu5wsVDJ
        Psh9WjRvwJaZrIw7fP8GM0RTzHTwy6Hui8481Hei6QOOEglBdDJltqpzKQHgv+DAi+JyFsAfddm0s
        j4rmj36cL8qHgFaHVBgWK7tSEP0qkoTwjXw6uKxfRFQx6P2idyxwfoJLQuQM4J5ASQZX0JA8NkXIr
        EHOugtYKHm4ovdNMXHX3gO3JwWmaYh4GbRARC0u7XaRrMAjMrDMGwjFVx2fKblzzS4iljpJ/+k0/z
        /0+IWqySw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUAxo-0003sO-LR; Mon, 11 Nov 2019 14:46:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9CFA305ED5;
        Mon, 11 Nov 2019 15:45:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11E9C201CB728; Mon, 11 Nov 2019 15:46:42 +0100 (CET)
Date:   Mon, 11 Nov 2019 15:46:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] perf/x86: Add perf text poke event
Message-ID: <20191111144642.GM4114@hirez.programming.kicks-ass.net>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
 <20191030104747.GA21153@leoy-ThinkPad-X240s>
 <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
 <20191030141950.GB21153@leoy-ThinkPad-X240s>
 <20191030162325.GT4114@hirez.programming.kicks-ass.net>
 <20191031073136.GC21153@leoy-ThinkPad-X240s>
 <20191101100440.GU4131@hirez.programming.kicks-ass.net>
 <20191104022346.GC26019@leoy-ThinkPad-X240s>
 <20191108150530.GA7721@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108150530.GA7721@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 11:05:30PM +0800, Leo Yan wrote:

> I will update some status for prototype (the code has been uploaded into
> git server [1]) and found some issues for text poke perf event on arm64.
> These issues are mainly related with arch64 architecture.
> 
> - The first issue is for the nosync instruction emulation.  On arm64,
>   some instructions need to be single stepped and some instructions
>   is emulated.  Especially, after I read the code for kprobe
>   implementation on Arm64.  So the main idea for prototyping is to use
>   the almos same method with kprobe for nosync instruction.

This makes no sense to me what so ever. What actual instructions are
patched with _nosync() ? ftrace/jump_label only use 'NOP/JMP/CALL'

For NOP you can advance regs->ip, for JMP you can adjust regs->ip, for
CALL you adjust regs->ip and regs->r14 (IIUC you do something like:
regs->r14 = regs->ip+4; regs->ip = func;)

(FWIW emulating CALL on x86 is fun because we get to PUSH something on
the stack, let me know if you want to see the patches that were required
to make that happen :-)

> - The second issue is race condition between the CPU alters
>   instructions and other CPUs hit the altered instructions (and
>   breakpointed).
> 
>   Peter's suggestion uses global variables 'nosync_insn' and
>   'nosync_addr' to record the altered instruction.  But from the
>   testing I found for single static key, usually it will change for
>   multiple address at once.
> 
>   So this might cause the issue is: CPU(a) will loop to alter
>   instructions for different address (sometimes the opcode also is
>   different for different address), at the meantime, CPU(b) hits an
>   altered instruction and handle exception for the breakpoint, if
>   CPU(a) is continuing to alter instruction for the next address, thne
>   CPU(a) might wrongly to use the value from 'nosync_insn' and
>   'nosync_addr'.
> 
>   Simply to say, we cannot only support single nosync instruction but
>   need to support multiple nosync instructions in the loop.

On x86 all actual text poking is serialized by text_mutex.

> - The third issue is might be nested issue.  E.g. for the injected
>   break instruction, we have no method to pass perf event for this
>   instruction; and if we connect with the first issue, if the
>   instruction is single stepped with slot (the slot is allocated with
>   get_insn_slot()), we cannot to allow the perf user space to know
>   the instructions which are executed in the slots.
> 
>   I am not sure if I think too complex here.  But seems to me, we
>   inject more instructions for poke text event, and if these injected
>   instructions are executed but the userspace decoder has no way to
>   pass the related info.

That's a misunderstanding, the text_poke event is a side-band event and
as such delivered to all events that expressed interest in it. You don't
need any exception to event mapping yourself.

> Just clarify, I am fine for merging this patch set, but we might
> consider more what's the best way on Arm64.  Welcome any public
> comments and suggestions; I will sync internally for how to follow up
> this functionality.

Thanks!

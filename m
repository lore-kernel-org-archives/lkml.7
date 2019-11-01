Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A350FCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E592086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YpKTgGLJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfKAKJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:09:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41972 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfKAKJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ECKTu0DSZlbKYxxmZ+ejGofPsyPDoNzlhSDblk4/nKw=; b=YpKTgGLJzM+2u5PTvSxiMXYlm
        f6l6zknzaYuwltO5JUPp/7tZCJKMH+35cn8vm4i7f6ryXwoPYGaFDg/T3tU0DERIJiBbhV/tmL9ek
        Fqo1pqUofSuDNXfIk8wwZ04K7HYNFlvxThrgUhoPlgFApie4ctearTDSpsKgNx2wAjaxhtAmnls0m
        7PlbD8GpbmkpoHfyzbnx5fjcuCPyIGqcf0VusNH+fWNDHCYUkUmhE7lD70xDlNcTzcQC5wLHxIPLa
        EP4W0ZWEhAmfxJILuiXWPQfXQwoTguaaBstHrIFDE761Z9fMOqlBLBa9yqx0MpXwp2ll/eddOLJes
        fi8OTW2Vw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQTrd-0005UV-4c; Fri, 01 Nov 2019 10:09:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF713306A7E;
        Fri,  1 Nov 2019 11:08:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8A4F26540349; Fri,  1 Nov 2019 11:09:03 +0100 (CET)
Date:   Fri, 1 Nov 2019 11:09:03 +0100
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
Message-ID: <20191101100903.GI5671@hirez.programming.kicks-ass.net>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-2-adrian.hunter@intel.com>
 <20191030104747.GA21153@leoy-ThinkPad-X240s>
 <20191030124659.GQ4114@hirez.programming.kicks-ass.net>
 <20191030141950.GB21153@leoy-ThinkPad-X240s>
 <20191030162325.GT4114@hirez.programming.kicks-ass.net>
 <20191031073136.GC21153@leoy-ThinkPad-X240s>
 <20191101100440.GU4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101100440.GU4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 11:04:40AM +0100, Peter Zijlstra wrote:

> I'm thinking something along the lines of:
> 
> static uintptr_t nosync_addr;
> static u32 nosync_insn;
> 
> int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
> {
> 	const u32 break = // some_breakpoint_insn;
> 	uintptr_t tp = (uintptr_t)addr;
> 	int ret;
> 
> 	lockdep_assert_held(&text_mutex);
> 
> 	/* A64 instructions must be word aligned */
> 	if (tp & 0x3)
> 		return -EINVAL;
> 
> 	if (perf_text_poke_update_enabled()) {
> 
> 		nosync_insn = insn;
> 		smp_store_release(&nosync_addr, tp);
> 
> 		ret = aarch64_insn_write(addr, break);
> 		if (ret == 0)
> 			__flush_icache_range(tp, tp + AARCH64_INSN_SIZE);
> 
> 		perf_event_text_poke(....);
> 	}
> 
> 	ret = aarch64_insn_write(addr, insn);
> 	if (ret == 0)
> 		__flush_icache_range(tp, tp + AARCH64_INSN_SIZE);

	// barrier that guarantees iflush completion ? dsb(osh) ?

	WRITE_ONCE(nosync_addr, NULL);

> 	return ret;
> }
> 
> And have the 'break' handler do:
> 
> aarch64_insn_break_handler(struct pt_regs *regs)
> {
> 	unsigned long addr = smp_load_acquire(&nosync_addr);
> 	u32 insn = nosync_insn;
> 
> 	if (regs->ip != addr)
> 		return;
> 
> 	// emulate @insn
> }
> 
> I understood from Will the whole nosync scheme only works for a limited
> set of instructions, but you only have to implement emulation for the
> actual instructions used of course.
> 
> (which is what we do on x86)
> 
> Does this sound workable?

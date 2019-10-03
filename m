Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B137AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852862070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u2FxOR8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfJCI2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:28:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48874 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCI2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fbgpkb4ZrN1nGnmGwSYFUAda/iVeR399X2dHLFAYocs=; b=u2FxOR8zeqCulSg/8YpUzgwQO
        Beao2Hmrly9ZYW+VfZvMRZ4k4HpOUqcdLBMRL4Y7ypmW2fLem5CHKlCysRIxUhMFEDtEqLz2968GE
        +QFtzp+tsF8sU78eCsGFwhvYUfkXqF2YD1O9RJocBCGIqFBn/AaAeQJPaaulycC9881geyqkNu1Yn
        gKlQHPDl42UJQFiUHL8qdebafFSZIVuGF0OhesLpW75rspRgeqX/Cv+oFTMSTHjCrebGFSFLp04Jy
        mu7NyNJyK1gcq/0q0Ioj/gN+RY4QMFN4ONx/4CpyPt9dDxwsAC33MogCYDPqFbKMyfdfFE0t2AxJr
        Dfc/bLbcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFwSn-0004Hq-8X; Thu, 03 Oct 2019 08:27:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 105E0301A79;
        Thu,  3 Oct 2019 10:27:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3415320D8F669; Thu,  3 Oct 2019 10:27:51 +0200 (CEST)
Date:   Thu, 3 Oct 2019 10:27:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/3] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20191003082751.GQ4536@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.053490768@infradead.org>
 <20191003140050.1d4cf59d3de8b5396d36c269@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003140050.1d4cf59d3de8b5396d36c269@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 02:00:50PM +0900, Masami Hiramatsu wrote:

> > This fits almost all text_poke_bp() users, except
> > arch_unoptimize_kprobe() which restores random text, and for that site
> > we have to build an explicit emulate instruction.
> 
> OK, and in this case, I would like to change RELATIVEJUMP_OPCODE
> to JMP32_INSN_OPCODE for readability. (or at least
> making RELATIVEJUMP_OPCODE as an alias of JMP32_INSN_OPCODE)

> > @@ -448,12 +447,18 @@ void arch_optimize_kprobes(struct list_h
> >  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
> >  {
> >  	u8 insn_buff[RELATIVEJUMP_SIZE];
> > +	u8 emulate_buff[RELATIVEJUMP_SIZE];
> >  
> >  	/* Set int3 to first byte for kprobes */
> >  	insn_buff[0] = BREAKPOINT_INSTRUCTION;
> >  	memcpy(insn_buff + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
> > +
> > +	emulate_buff[0] = RELATIVEJUMP_OPCODE;
> > +	*(s32 *)(&emulate_buff[1]) = (s32)((long)op->optinsn.insn -
> > +			((long)op->kp.addr + RELATIVEJUMP_SIZE));

I'm halfway through a patch introducing:

  union text_poke_insn {
	u8 code[POKE_MAX_OPCODE_SUZE];
	struct {
		u8 opcode;
		s32 disp;
	} __attribute__((packed));
  };

to text-patching.h to unify all such custom unions we have all over the
place. I'll mob up the above in that.

> > +
> >  	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
> > -		     op->optinsn.insn);
> > +		     emulate_buff);
> >  }

As argued in a previous thread, text_poke_bp() is broken when it changes
more than a single instruction at a time.

Now, ISTR optimized kprobes does something like:

	poke INT3
	synchronize_rcu_tasks() /* waits for all tasks to schedule
				   guarantees instructions after INT3
				   are unused */
	install optimized probe /* overwrites multiple instrctions with
				   JMP.d32 */

And the above then undoes that by:

	poke INT3 on top of the optimzed probe

	poke tail instructions back /* guaranteed safe because the
				       above INT3 poke ensures the
				       JMP.d32 instruction is unused */

	poke head byte back

Is this correct? If so, we should probably put a comment in there
explaining how all this is unusual but safe.

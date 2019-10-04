Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D297C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E9620873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570196747;
	bh=GcDR2QA5gwcel8zVmm7/+Rqsxv092y7YDdz9PoR1mZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WunAiM4+ZlgKgCUfHw0bj3YZNA1MkPYjgzzQ6QSGNjUzk4u0YgBgV3MSPCxRr5sTq
	 51TD0Gzn+EBWe+bqRrTpgKSJHHt6a1HI6Hqs92LLWTGHDvtf/FF+rguM3oYrmq5P/T
	 rURflMr5+ofhd5Y+A8DJtAGlbqi+r1rpmIO/lXFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbfJDNpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388333AbfJDNpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:45:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6836720700;
        Fri,  4 Oct 2019 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570196745;
        bh=GcDR2QA5gwcel8zVmm7/+Rqsxv092y7YDdz9PoR1mZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OJKxCoicMmFUSFKqHEg13ZNV3AOaWmeUaKcZHrF9x/LTwUwieaUuPqZNaC3NTTGFp
         5LODGEeN9VZkdkALRCxhAWnN5VrwyYTvZ6Yq/ubGNA0MRmIlMiP5hxOlXYeE6k8Hsa
         QnRDVu2Rn9vbbewkY6KZsbLRh6Z71YpWVHQGQ8qQ=
Date:   Fri, 4 Oct 2019 22:45:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/3] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-Id: <20191004224540.766dc0fd824bcd5b8baa2f4c@kernel.org>
In-Reply-To: <20191003110106.GI4581@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
        <20190827181147.053490768@infradead.org>
        <20191003140050.1d4cf59d3de8b5396d36c269@kernel.org>
        <20191003082751.GQ4536@hirez.programming.kicks-ass.net>
        <20191003110106.GI4581@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, 3 Oct 2019 13:01:06 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Oct 03, 2019 at 10:27:51AM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 03, 2019 at 02:00:50PM +0900, Masami Hiramatsu wrote:
> > 
> > > > This fits almost all text_poke_bp() users, except
> > > > arch_unoptimize_kprobe() which restores random text, and for that site
> > > > we have to build an explicit emulate instruction.
> > > 
> > > OK, and in this case, I would like to change RELATIVEJUMP_OPCODE
> > > to JMP32_INSN_OPCODE for readability. (or at least
> > > making RELATIVEJUMP_OPCODE as an alias of JMP32_INSN_OPCODE)
> > 
> > > > @@ -448,12 +447,18 @@ void arch_optimize_kprobes(struct list_h
> > > >  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
> > > >  {
> > > >  	u8 insn_buff[RELATIVEJUMP_SIZE];
> > > > +	u8 emulate_buff[RELATIVEJUMP_SIZE];
> > > >  
> > > >  	/* Set int3 to first byte for kprobes */
> > > >  	insn_buff[0] = BREAKPOINT_INSTRUCTION;
> > > >  	memcpy(insn_buff + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
> > > > +
> > > > +	emulate_buff[0] = RELATIVEJUMP_OPCODE;
> > > > +	*(s32 *)(&emulate_buff[1]) = (s32)((long)op->optinsn.insn -
> > > > +			((long)op->kp.addr + RELATIVEJUMP_SIZE));
> > 
> > I'm halfway through a patch introducing:
> > 
> >   union text_poke_insn {
> > 	u8 code[POKE_MAX_OPCODE_SUZE];
> > 	struct {
> > 		u8 opcode;
> > 		s32 disp;
> > 	} __attribute__((packed));
> >   };
> > 
> > to text-patching.h to unify all such custom unions we have all over the
> > place. I'll mob up the above in that.

I think it is good to unify such unions, but I meant above was, it was
also important to unify the opcode macro. Since poke_int3_handler()
clasifies the opcode by your *_INSN_OPCODE macro, it is natual to use
those opcode for text_poke_bp() interface.

> > > > +
> > > >  	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
> > > > -		     op->optinsn.insn);
> > > > +		     emulate_buff);
> > > >  }
> > 
> > As argued in a previous thread, text_poke_bp() is broken when it changes
> > more than a single instruction at a time.
> > 
> > Now, ISTR optimized kprobes does something like:
> > 
> > 	poke INT3
> 
> Hmm, it does this using text_poke(), but lacks a
> on_each_cpu(do_sync_core, NULL, 1), which I suppose is OK-ish IFF you do
> that synchronize_rcu_tasks() after it, but less so if you don't.
> 
> That is, without either, you can't really tell if the kprobe is in
> effect or not.

Yes, it doesn't wait the change by design at this moment.

> Also, I think text_poke_bp(INT3) is broken, although I don't think
> anybody actually does that. Still, let me fix that.

OK.

> 
> > 	synchronize_rcu_tasks() /* waits for all tasks to schedule
> > 				   guarantees instructions after INT3
> > 				   are unused */
> > 	install optimized probe /* overwrites multiple instrctions with
> > 				   JMP.d32 */
> > 
> > And the above then undoes that by:
> > 
> > 	poke INT3 on top of the optimzed probe
> > 
> > 	poke tail instructions back /* guaranteed safe because the
> > 				       above INT3 poke ensures the
> > 				       JMP.d32 instruction is unused */
> > 
> > 	poke head byte back

Yes, anyway, the last poke should recover another INT3... (for kprobe)

> > 
> > Is this correct? If so, we should probably put a comment in there
> > explaining how all this is unusual but safe.

OK.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

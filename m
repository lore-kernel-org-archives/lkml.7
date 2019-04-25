Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79F9C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CDA2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfDYQZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:25:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbfDYQZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:25:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE90530820E6;
        Thu, 25 Apr 2019 16:25:31 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B452A600C0;
        Thu, 25 Apr 2019 16:25:30 +0000 (UTC)
Date:   Thu, 25 Apr 2019 11:25:28 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <Raphael.Gault@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Julien Thierry <Julien.Thierry@arm.com>
Subject: Re: [RFC 3/6] objtool: arm64: Adapt the stack frame checks and the
 section analysis for the arm architecture
Message-ID: <20190425162528.mnmmierxxvixyoul@treble>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-4-raphael.gault@arm.com>
 <20190423203627.mwnaknit7cvr3l5l@treble>
 <cd86ce1a-7c6a-9ebf-4c84-6cb6ffd88017@arm.com>
 <20190424165640.5yeg2yicl7ej7g3i@treble>
 <c90f402e-6494-73bc-1df8-516c3113019a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c90f402e-6494-73bc-1df8-516c3113019a@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 25 Apr 2019 16:25:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 08:12:24AM +0000, Raphael Gault wrote:
> Hi Josh,
> 
> On 4/24/19 5:56 PM, Josh Poimboeuf wrote:
> > On Wed, Apr 24, 2019 at 04:32:44PM +0000, Raphael Gault wrote:
> >>>> diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
> >>>> index 0feb3ae3af5d..8b293eae2b38 100644
> >>>> --- a/tools/objtool/arch/arm64/decode.c
> >>>> +++ b/tools/objtool/arch/arm64/decode.c
> >>>> @@ -105,6 +105,33 @@ unsigned long arch_compute_rela_sym_offset(int addend)
> >>>>    return addend;
> >>>>    }
> >>>>
> >>>> +/*
> >>>> + * In order to know if we are in presence of a sibling
> >>>> + * call and not in presence of a switch table we look
> >>>> + * back at the previous instructions and see if we are
> >>>> + * jumping inside the same function that we are already
> >>>> + * in.
> >>>> + */
> >>>> +bool arch_is_insn_sibling_call(struct instruction *insn)
> >>>> +{
> >>>> +struct instruction *prev;
> >>>> +struct list_head *l;
> >>>> +struct symbol *sym;
> >>>> +list_for_each_prev(l, &insn->list) {
> >>>> +prev = (void *)l;
> >>>> +if (!prev->func
> >>>> +|| prev->func->pfunc != insn->func->pfunc)
> >>>> +return false;
> >>>> +if (prev->stack_op.src.reg != ADR_SOURCE)
> >>>> +continue;
> >>>> +sym = find_symbol_containing(insn->sec, insn->immediate);
> >>>> +if (!sym || sym->type != STT_FUNC
> >>>> +|| sym->pfunc != insn->func->pfunc)
> >>>> +return true;
> >>>> +break;
> >>>> +}
> >>>> +return true;
> >>>> +}
> >>>
> >>> I get the feeling there might be a better way to do this, but I can't
> >>> figure out what this function is actually doing.  It looks like it
> >>> searches backwards in the function for an instruction which has
> >>> stack_op.src.reg != ADR_SOURCE -- what does that mean?  And why doesn't
> >>> it do anything with the instruction after it finds it?
> >>>
> >>
> >> I will indeed try to make it better.
> >
> > I still don't quite get what it's trying to accomplish, but I wonder if
> > there's some kind of tracking you can add in validate_branch() to keep
> > track of whatever you're looking for, leading up to the indirect jump.
> >
> 
> The motivation behind this is that the `br <Xn>` instruction is a
> dynamic jump (jump to the address contained in the provided register).
> This instruction is used for sibling calls but can also be used for
> switch table. I use this to differentiate these two cases from one another:
> 
> Generally the `adr/adrp` instruction is used prior to `br` in order to
> load the address into the register. What I do here is go back throught
> the instructions and try to identify if the address loaded.
> 
> I also thought of implementing some sort of tracking in validate branch
> because it could be useful for identifying the switch tables as well.
> But it seemed to me like a major change in the sementic of this tool:
> indeed, from my perspective I would have to track the state of the
> registers and I don't know if we want to do that.

I don't have much time to look at this today (and I'll be out next
week), but we had a similar problem in x86.  See the comments above
find_switch_table(), particularly #3.  Does that function not work for
the arm64 case?

> >>>> -hash_add(file->insn_hash, &insn->hash, insn->offset);
> >>>> +/*
> >>>> + * For arm64 architecture, we sometime split instructions so that
> >>>> + * we can track the state evolution (i.e. load/store of pairs of registers).
> >>>> + * We thus need to take both into account and not erase the previous ones.
> >>>> + */
> >>>
> >>> Ew...  Is this an architectural thing, or just a quirk of the arm64
> >>> decoder?
> >>>
> >>
> >> The motivation for this is to simulate the two consecutive operations
> >> that would be executed on x86 but are done in one on arm64. This is
> >> strictly a decoder related quirk. I don't know if there is a better way
> >> to do it without modifying the struct op_src and struct instruction.
> >
> > Ah.  Which ops are those?  Hopefully we can find a better way to
> > represent that with a single instruction.  Adding fake instructions is
> > fragile.
> >
> 
> Those are the load/store of pairs of registers, mainly stp/ldp. Those
> are often use in the function prologues/epilogues to save/restore the
> stack pointers and frame pointers however it can be used with any
> register pair.
> 
> The idea to add a new instruction could work but I would need to extend
> the `struct op_src` as well I think.

Again I don't have much time to look at it, but I do think that changing
op_src/dest to allow for the stp/ldp instructions would work better than
inserting a fake instruction to emulate x86.

Or another idea would be to associate multiple stack_ops with a single
instruction.

-- 
Josh

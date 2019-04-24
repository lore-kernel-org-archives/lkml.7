Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB63C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F45218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfDXQ4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:56:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbfDXQ4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:56:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 657BBC0B2A4F;
        Wed, 24 Apr 2019 16:56:43 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88B785D705;
        Wed, 24 Apr 2019 16:56:42 +0000 (UTC)
Date:   Wed, 24 Apr 2019 11:56:40 -0500
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
Message-ID: <20190424165640.5yeg2yicl7ej7g3i@treble>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-4-raphael.gault@arm.com>
 <20190423203627.mwnaknit7cvr3l5l@treble>
 <cd86ce1a-7c6a-9ebf-4c84-6cb6ffd88017@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd86ce1a-7c6a-9ebf-4c84-6cb6ffd88017@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 24 Apr 2019 16:56:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 04:32:44PM +0000, Raphael Gault wrote:
> >> diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
> >> index 0feb3ae3af5d..8b293eae2b38 100644
> >> --- a/tools/objtool/arch/arm64/decode.c
> >> +++ b/tools/objtool/arch/arm64/decode.c
> >> @@ -105,6 +105,33 @@ unsigned long arch_compute_rela_sym_offset(int addend)
> >>   return addend;
> >>   }
> >>
> >> +/*
> >> + * In order to know if we are in presence of a sibling
> >> + * call and not in presence of a switch table we look
> >> + * back at the previous instructions and see if we are
> >> + * jumping inside the same function that we are already
> >> + * in.
> >> + */
> >> +bool arch_is_insn_sibling_call(struct instruction *insn)
> >> +{
> >> +struct instruction *prev;
> >> +struct list_head *l;
> >> +struct symbol *sym;
> >> +list_for_each_prev(l, &insn->list) {
> >> +prev = (void *)l;
> >> +if (!prev->func
> >> +|| prev->func->pfunc != insn->func->pfunc)
> >> +return false;
> >> +if (prev->stack_op.src.reg != ADR_SOURCE)
> >> +continue;
> >> +sym = find_symbol_containing(insn->sec, insn->immediate);
> >> +if (!sym || sym->type != STT_FUNC
> >> +|| sym->pfunc != insn->func->pfunc)
> >> +return true;
> >> +break;
> >> +}
> >> +return true;
> >> +}
> >
> > I get the feeling there might be a better way to do this, but I can't
> > figure out what this function is actually doing.  It looks like it
> > searches backwards in the function for an instruction which has
> > stack_op.src.reg != ADR_SOURCE -- what does that mean?  And why doesn't
> > it do anything with the instruction after it finds it?
> >
> 
> I will indeed try to make it better.

I still don't quite get what it's trying to accomplish, but I wonder if
there's some kind of tracking you can add in validate_branch() to keep
track of whatever you're looking for, leading up to the indirect jump.

> >> -hash_add(file->insn_hash, &insn->hash, insn->offset);
> >> +/*
> >> + * For arm64 architecture, we sometime split instructions so that
> >> + * we can track the state evolution (i.e. load/store of pairs of registers).
> >> + * We thus need to take both into account and not erase the previous ones.
> >> + */
> >
> > Ew...  Is this an architectural thing, or just a quirk of the arm64
> > decoder?
> >
> 
> The motivation for this is to simulate the two consecutive operations
> that would be executed on x86 but are done in one on arm64. This is
> strictly a decoder related quirk. I don't know if there is a better way
> to do it without modifying the struct op_src and struct instruction.

Ah.  Which ops are those?  Hopefully we can find a better way to
represent that with a single instruction.  Adding fake instructions is
fragile.

-- 
Josh

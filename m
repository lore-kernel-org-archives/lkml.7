Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1436BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC4A208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561374968;
	bh=LFqck4CeV3jBrl7Yqgi21ZqUHc7BseQ2I38AyrN4b3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lBYCQ5F1up0vRZgB3ayssWDqlNEJiNYTSB+xz65kDhoGUgC+nyDgpGCAM5CvS9GCK
	 h7gzpWm1Jry+DeRtTxqBAgr/sqcB2SEOZfeORegkBgGKaw8CV/MP3CVthKqQrNEnR5
	 gtg4OFJwGLXmGqPWs6sONYB6tdkEiKD4tzIfKcTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfFXLQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbfFXLQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:16:07 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ED1020449;
        Mon, 24 Jun 2019 11:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561374966;
        bh=LFqck4CeV3jBrl7Yqgi21ZqUHc7BseQ2I38AyrN4b3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSvX2o0P97KVpBlCPX61upv01HnSc9kZCztiFA3NLNpGco45CIh/rZ67XWlja2EVr
         vksn2UCldeO7t0n/lzFgMDLAb+ugyZ8v5hdUSmooKB4SZEXomTxQOY3AJWcU1Zq7VW
         ethUEz3+FgM9Le+Eh4bevMMllLhxj6571CK2n9Jk=
Date:   Mon, 24 Jun 2019 12:16:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH 0/4] arm64: wire up VM_FLUSH_RESET_PERMS
Message-ID: <20190624111600.b7e5kkfvuszj6522@willie-the-truck>
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
 <20190528100413.GA20809@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528100413.GA20809@fuggles.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 11:04:20AM +0100, Will Deacon wrote:
> On Thu, May 23, 2019 at 11:22:52AM +0100, Ard Biesheuvel wrote:
> > Wire up the code introduced in v5.2 to manage the permissions
> > of executable vmalloc regions (and their linear aliases) more
> > strictly.
> > 
> > One of the things that came up in the internal discussion is
> > whether non-x86 architectures have any benefit at all from the
> > lazy vunmap feature, and whether it would perhaps be better to
> > implement eager vunmap instead.
> > 
> > Cc: Nadav Amit <namit@vmware.com>
> > Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: James Morse <james.morse@arm.com>
> > 
> > Ard Biesheuvel (4):
> >   arm64: module: create module allocations without exec permissions
> >   arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP
> >   arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe instruction pages
> >   arm64: bpf: do not allocate executable memory
> > 
> >  arch/arm64/Kconfig                  |  1 +
> >  arch/arm64/include/asm/cacheflush.h |  3 ++
> >  arch/arm64/kernel/module.c          |  4 +-
> >  arch/arm64/kernel/probes/kprobes.c  |  4 +-
> >  arch/arm64/mm/pageattr.c            | 48 ++++++++++++++++----
> >  arch/arm64/net/bpf_jit_comp.c       |  2 +-
> >  mm/vmalloc.c                        | 11 -----
> >  7 files changed, 50 insertions(+), 23 deletions(-)
> 
> Thanks, this all looks good to me. I can get pick this up for 5.2 if
> Rick's fixes [1] land soon enough.

Bah, I missed these landing in -rc5 and I think it's a bit too late for
us to take this for 5.2. now particularly with our limited ability to
fix any late regressions that might arise.

In which case, Catalin, please can you take these for 5.3? You might run
into some testing failures with for-next/core due to the late of Rick's
fixes, but linux-next should be alright and I don't think you'll get any
conflicts.

Acked-by: Will Deacon <will@kernel.org>

Ard: are you ok with that?

Thanks,

Will

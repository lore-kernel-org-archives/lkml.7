Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45352C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22586208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfE1KEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:04:21 -0400
Received: from foss.arm.com ([217.140.101.70]:54054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfE1KEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:04:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 473B9341;
        Tue, 28 May 2019 03:04:20 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56DCD3F59C;
        Tue, 28 May 2019 03:04:18 -0700 (PDT)
Date:   Tue, 28 May 2019 11:04:13 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH 0/4] arm64: wire up VM_FLUSH_RESET_PERMS
Message-ID: <20190528100413.GA20809@fuggles.cambridge.arm.com>
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523102256.29168-1-ard.biesheuvel@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:22:52AM +0100, Ard Biesheuvel wrote:
> Wire up the code introduced in v5.2 to manage the permissions
> of executable vmalloc regions (and their linear aliases) more
> strictly.
> 
> One of the things that came up in the internal discussion is
> whether non-x86 architectures have any benefit at all from the
> lazy vunmap feature, and whether it would perhaps be better to
> implement eager vunmap instead.
> 
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> 
> Ard Biesheuvel (4):
>   arm64: module: create module allocations without exec permissions
>   arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP
>   arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe instruction pages
>   arm64: bpf: do not allocate executable memory
> 
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/cacheflush.h |  3 ++
>  arch/arm64/kernel/module.c          |  4 +-
>  arch/arm64/kernel/probes/kprobes.c  |  4 +-
>  arch/arm64/mm/pageattr.c            | 48 ++++++++++++++++----
>  arch/arm64/net/bpf_jit_comp.c       |  2 +-
>  mm/vmalloc.c                        | 11 -----
>  7 files changed, 50 insertions(+), 23 deletions(-)

Thanks, this all looks good to me. I can get pick this up for 5.2 if
Rick's fixes [1] land soon enough.

Cheers,

Will

[1] https://lore.kernel.org/lkml/20190527211058.2729-1-rick.p.edgecombe@intel.com/T/#u

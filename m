Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E6EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5687D2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfE1IU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:20:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51756 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfE1IU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:20:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82DCE341;
        Tue, 28 May 2019 01:20:28 -0700 (PDT)
Received: from [10.162.40.141] (p8cg001049571a15.blr.arm.com [10.162.40.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B8A83F59C;
        Tue, 28 May 2019 01:20:24 -0700 (PDT)
Subject: Re: [PATCH 3/4] arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe
 instruction pages
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, marc.zyngier@arm.com,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
 <20190523102256.29168-4-ard.biesheuvel@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e10f0e6c-2669-8e1e-1b28-ed7816e0b248@arm.com>
Date:   Tue, 28 May 2019 13:50:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190523102256.29168-4-ard.biesheuvel@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/23/2019 03:52 PM, Ard Biesheuvel wrote:
> In order to avoid transient inconsistencies where freed code pages
> are remapped writable while stale TLB entries still exist on other
> cores, mark the kprobes text pages with the VM_FLUSH_RESET_PERMS
> attribute. This instructs the core vmalloc code not to defer the
> TLB flush when this region is unmapped and returned to the page
> allocator.

Makes sense.

> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 2509fcb6d404..036cfbf9682a 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -131,8 +131,10 @@ void *alloc_insn_page(void)
>  	void *page;
>  
>  	page = vmalloc_exec(PAGE_SIZE);
> -	if (page)
> +	if (page) {
>  		set_memory_ro((unsigned long)page, 1);
> +		set_vm_flush_reset_perms(page);
> +	}

Looks good. It seems there might be more users who would like to set
VM_FLUSH_RESET_PERMS right after their allocation for the same reason.
Hence would not it help to have a variant like vmalloc_exec_reset() or
such which will tag vm_struct->flags with VM_FLUSH_RESET_PERMS right
after it's allocation without requiring the caller to do the same.

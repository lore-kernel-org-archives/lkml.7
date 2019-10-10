Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F97C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D49205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfJJQp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:45:26 -0400
Received: from foss.arm.com ([217.140.110.172]:35648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfJJQp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:45:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0333E28;
        Thu, 10 Oct 2019 09:45:26 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5D863F71A;
        Thu, 10 Oct 2019 09:45:23 -0700 (PDT)
Date:   Thu, 10 Oct 2019 17:45:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jia He <justin.he@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com
Subject: Re: [PATCH v11 4/4] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20191010164520.GC40923@arrakis.emea.arm.com>
References: <20191009084246.123354-1-justin.he@arm.com>
 <20191009084246.123354-5-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009084246.123354-5-justin.he@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 04:42:46PM +0800, Jia He wrote:
> When we tested pmdk unit test [1] vmmalloc_fork TEST3 on arm64 guest, there
> will be a double page fault in __copy_from_user_inatomic of cow_user_page.
> 
> To reproduce the bug, the cmd is as follows after you deployed everything:
> make -C src/test/vmmalloc_fork/ TEST_TIME=60m check
> 
> Below call trace is from arm64 do_page_fault for debugging purpose:
> [  110.016195] Call trace:
> [  110.016826]  do_page_fault+0x5a4/0x690
> [  110.017812]  do_mem_abort+0x50/0xb0
> [  110.018726]  el1_da+0x20/0xc4
> [  110.019492]  __arch_copy_from_user+0x180/0x280
> [  110.020646]  do_wp_page+0xb0/0x860
> [  110.021517]  __handle_mm_fault+0x994/0x1338
> [  110.022606]  handle_mm_fault+0xe8/0x180
> [  110.023584]  do_page_fault+0x240/0x690
> [  110.024535]  do_mem_abort+0x50/0xb0
> [  110.025423]  el0_da+0x20/0x24
> 
> The pte info before __copy_from_user_inatomic is (PTE_AF is cleared):
> [ffff9b007000] pgd=000000023d4f8003, pud=000000023da9b003,
>                pmd=000000023d4b3003, pte=360000298607bd3
> 
> As told by Catalin: "On arm64 without hardware Access Flag, copying from
> user will fail because the pte is old and cannot be marked young. So we
> always end up with zeroed page after fork() + CoW for pfn mappings. we
> don't always have a hardware-managed access flag on arm64."
> 
> This patch fixes it by calling pte_mkyoung. Also, the parameter is
> changed because vmf should be passed to cow_user_page()
> 
> Add a WARN_ON_ONCE when __copy_from_user_inatomic() returns error
> in case there can be some obscure use-case (by Kirill).
> 
> [1] https://github.com/pmem/pmdk/tree/master/src/test/vmmalloc_fork
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> Reported-by: Yibo Cai <Yibo.Cai@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

My reviewed-by still stands. Thanks.

-- 
Catalin

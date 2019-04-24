Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866E8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB8F218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfDXIIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:08:49 -0400
Received: from foss.arm.com ([217.140.101.70]:39334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfDXIIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:08:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B03180D;
        Wed, 24 Apr 2019 01:08:48 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F1713F238;
        Wed, 24 Apr 2019 01:08:46 -0700 (PDT)
Date:   Wed, 24 Apr 2019 09:08:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, brijesh.singh@amd.com
Subject: Re: [PATCH] x86/mm: fix a crash with kmemleak_scan()
Message-ID: <20190424080842.wjo2aj3g4sy4rkz7@mbp>
References: <20190423165811.36699-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423165811.36699-1-cai@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:58:11PM -0400, Qian Cai wrote:
> The first kmemleak_scan() after boot would trigger a crash below because
> 
> kernel_init
>   free_initmem
>     mem_encrypt_free_decrypted_mem
>       free_init_pages
> 
> unmapped some memory inside the .bss with DEBUG_PAGEALLOC=y. Since
> kmemleak_init() will register the .data/.bss sections (only register
> .data..ro_after_init if not within .data) and then kmemleak_scan() will
> scan those address and dereference them looking for pointer referencing.
> If free_init_pages() free and unmap pages in those sections,
> kmemleak_scan() will trigger a crash if referencing one of those
> addresses.
> 
> BUG: unable to handle kernel paging request at ffffffffbd402000
> CPU: 12 PID: 325 Comm: kmemleak Not tainted 5.1.0-rc4+ #4
> RIP: 0010:scan_block+0x58/0x160
> Call Trace:
>  scan_gray_list+0x1d9/0x280
>  kmemleak_scan+0x485/0xad0
>  kmemleak_scan_thread+0x9f/0xc4
>  kthread+0x1d2/0x1f0
>  ret_from_fork+0x35/0x40
> 
> Since kmemleak_free_part() is tolerant to unknown objects (not tracked by
> kmemleak), it is fine to call it from free_init_pages() even if not all
> address ranges passed to this function are known to kmemleak.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

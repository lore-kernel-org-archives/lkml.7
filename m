Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF8BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E997F21924
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfDPNos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:44:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55280 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfDPNos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:44:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E53D3EBD;
        Tue, 16 Apr 2019 06:44:47 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46BB93F59C;
        Tue, 16 Apr 2019 06:44:46 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:44:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm/mem_encrypt: fix a crash with kmemleak_scan
Message-ID: <20190416134443.GF28994@arrakis.emea.arm.com>
References: <20190409040502.55361-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409040502.55361-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 12:05:02AM -0400, Qian Cai wrote:
> The first kmemleak_scan() after boot would trigger a crash below because
> 
> kernel_init
>   free_initmem
>     mem_encrypt_free_decrypted_mem
>       free_init_pages
> 
> unmapped some memory inside the .bss.
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
> Signed-off-by: Qian Cai <cai@lca.pw>

It seems that commit 298a32b13208 ("kmemleak: powerpc: skip scanning
holes in the .bss section") has other uses as well.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

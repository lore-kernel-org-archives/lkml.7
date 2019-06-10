Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709D8C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A3E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560203504;
	bh=ei69O+j33sx9K9HiC+t6ksHIXHYNeqAG/ECmlBGCclM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yMhqslKp3FqYJ3utykWqDo6/RnYvZLEW+UH+PNjlSgZnCNYoAdyfFs0YbUt+AmG4+
	 cXaEQavXkua+gkzXbUggb69DpEq8fLFAJZ+vG+4rUA6eKju9BNErJKhH8GIY39+I7Z
	 Im8HTTGrHwwlG022AcliFzNzcm3ysT+RJMzQJ5LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfFJVvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfFJVvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:51:43 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19E1D20859;
        Mon, 10 Jun 2019 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560203502;
        bh=ei69O+j33sx9K9HiC+t6ksHIXHYNeqAG/ECmlBGCclM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ypBN0rdv63J2j7m4W6X3P3ToTVW/iKbmHP9DzgoEXA86zca52BqqHtfQagk+dc86p
         hyt8qDPBg8xKwF95wra7toIgG5FREYo5P2txhLlg6TCMgJFgcoPeZRtwuKBA3xEssV
         0Ey9s3CBmI8mCytO9atZRZ4D3wg2Y4TawTNbCDjs=
Date:   Mon, 10 Jun 2019 14:51:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Alexey Skidanov <alexey.skidanov@intel.com>,
        Olof Johansson <olof@lixom.net>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: Re: [PATCH] lib/genalloc.c: Avoid de-referencing NULL pool
Message-Id: <20190610145141.332f9750fa986cd15586bb2d@linux-foundation.org>
In-Reply-To: <20190607234333.9776-1-f.fainelli@gmail.com>
References: <20190607234333.9776-1-f.fainelli@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jun 2019 16:43:31 -0700 Florian Fainelli <f.fainelli@gmail.com> wrote:

> With architectures allowing the kernel to be placed almost arbitrarily
> in memory (e.g.: ARM64), it is possible to have the kernel resides at
> physical addresses above 4GB, resulting in neither the default CMA area,
> nor the atomic pool from successfully allocating. This does not prevent
> specific peripherals from working though, one example is XHCI, which
> still operates correctly.
> 
> Trouble comes when the XHCI driver gets suspended and resumed, since we
> can now trigger the following NPD:
> 
> ...
>
> [   13.327884] f8c0: 0000000000000030 ffffffffffffffff
> [   13.332835] [<ffffff80083c0df8>] addr_in_gen_pool+0x4/0x48
> [   13.338398] [<ffffff80086004d0>] xhci_mem_cleanup+0xc8/0x51c
> [   13.344137] [<ffffff80085f9250>] xhci_resume+0x308/0x65c
> [   13.349524] [<ffffff80085e3de8>] xhci_brcm_resume+0x84/0x8c
> [   13.355174] [<ffffff80084ad040>] platform_pm_resume+0x3c/0x64
> [   13.360997] [<ffffff80084b91b4>] dpm_run_callback+0x5c/0x15c
> [   13.366732] [<ffffff80084b96bc>] device_resume+0xc0/0x190
> [   13.372205] [<ffffff80084baa70>] dpm_resume+0x144/0x2cc
> [   13.377504] [<ffffff80084bafbc>] dpm_resume_end+0x20/0x34
> [   13.382980] [<ffffff80080e0d88>] suspend_devices_and_enter+0x104/0x704
> [   13.389585] [<ffffff80080e16a8>] pm_suspend+0x320/0x53c
> [   13.394881] [<ffffff80080dfd08>] state_store+0xbc/0xe0
> [   13.400094] [<ffffff80083a89d4>] kobj_attr_store+0x14/0x24
> [   13.405655] [<ffffff800822a614>] sysfs_kf_write+0x60/0x70
> [   13.411128] [<ffffff80082295d4>] kernfs_fop_write+0x130/0x194
> [   13.416954] [<ffffff80081b5d10>] __vfs_write+0x60/0x150
> [   13.422254] [<ffffff80081b6b20>] vfs_write+0xc8/0x164
> [   13.427376] [<ffffff80081b7dd8>] SyS_write+0x70/0xc8
> [   13.432412] [<ffffff8008083180>] el0_svc_naked+0x34/0x38
> [   13.437800] Code: 92800173 97f6fb9e 17fffff5 d1000442 (f8408c03)
> [   13.444033] ---[ end trace 2effe12f909ce205 ]---
> 
> The call path leading to this problem is xhci_mem_cleanup() ->
> dma_free_coherent() -> dma_free_from_pool() -> addr_in_gen_pool. If the
> atomic_pool is NULL, we can't possibly have the address in the atomic
> pool anyway, so guard against that.
> 

Arguably the caller shouldn't be pasing in a NULL pointer.  Perhaps we
couild do this as a convenience thing if addr_in_gen_pool(NULL) makes
some sort of semantic sense, but I'm having trouble convincing myself
that it does.

So I'm somewhat inclined to think that going oops was the appropriate
response to this input...

> --- a/lib/genalloc.c
> +++ b/lib/genalloc.c
> @@ -439,6 +439,9 @@ bool addr_in_gen_pool(struct gen_pool *pool, unsigned long start,
>  	unsigned long end = start + size - 1;
>  	struct gen_pool_chunk *chunk;
>  
> +	if (unlikely(!pool))
> +		return found;

I think it would be clearer to use "return false" here, so the reader
doesn't have to go find and out what value `found' has.

>  	rcu_read_lock();
>  	list_for_each_entry_rcu(chunk, &(pool)->chunks, next_chunk) {
>  		if (start >= chunk->start_addr && start <= chunk->end_addr) {


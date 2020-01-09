Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D58C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D10F2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgAIJXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:23:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:52402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729269AbgAIJXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:23:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1938ABC8D;
        Thu,  9 Jan 2020 09:22:51 +0000 (UTC)
Subject: Re: [PATCH v1 2/4] x86/xen: add basic KASAN support for PV kernel
To:     Sergey Dyasli <sergey.dyasli@citrix.com>, xen-devel@lists.xen.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200108152100.7630-1-sergey.dyasli@citrix.com>
 <20200108152100.7630-3-sergey.dyasli@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <0c968669-2b21-b772-dba8-f674057bd6e7@suse.com>
Date:   Thu, 9 Jan 2020 10:15:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200108152100.7630-3-sergey.dyasli@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.01.20 16:20, Sergey Dyasli wrote:
> This enables to use Outline instrumentation for Xen PV kernels.
> 
> KASAN_INLINE and KASAN_VMALLOC options currently lead to boot crashes
> and hence disabled.
> 
> Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
> ---
> RFC --> v1:
> - New functions with declarations in xen/xen-ops.h
> - Fixed the issue with free_kernel_image_pages() with the help of
>    xen_pv_kasan_unpin_pgd()
> ---
>   arch/x86/mm/kasan_init_64.c | 12 ++++++++++++
>   arch/x86/xen/Makefile       |  7 +++++++
>   arch/x86/xen/enlighten_pv.c |  3 +++
>   arch/x86/xen/mmu_pv.c       | 39 +++++++++++++++++++++++++++++++++++++
>   drivers/xen/Makefile        |  2 ++
>   include/xen/xen-ops.h       |  4 ++++
>   kernel/Makefile             |  2 ++
>   lib/Kconfig.kasan           |  3 ++-
>   8 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index cf5bc37c90ac..902a6a152d33 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -13,6 +13,9 @@
>   #include <linux/sched/task.h>
>   #include <linux/vmalloc.h>
>   
> +#include <xen/xen.h>
> +#include <xen/xen-ops.h>
> +
>   #include <asm/e820/types.h>
>   #include <asm/pgalloc.h>
>   #include <asm/tlbflush.h>
> @@ -332,6 +335,11 @@ void __init kasan_early_init(void)
>   	for (i = 0; pgtable_l5_enabled() && i < PTRS_PER_P4D; i++)
>   		kasan_early_shadow_p4d[i] = __p4d(p4d_val);
>   
> +	if (xen_pv_domain()) {
> +		pgd_t *pv_top_pgt = xen_pv_kasan_early_init();

You are breaking the build with CONFIG_XEN_PV undefined here.

> +		kasan_map_early_shadow(pv_top_pgt);
> +	}
> +
>   	kasan_map_early_shadow(early_top_pgt);
>   	kasan_map_early_shadow(init_top_pgt);
>   }
> @@ -369,6 +377,8 @@ void __init kasan_init(void)
>   				__pgd(__pa(tmp_p4d_table) | _KERNPG_TABLE));
>   	}
>   
> +	xen_pv_kasan_pin_pgd(early_top_pgt);

Same here (and below). For the pin/unpin variants I'd rather have
an inline wrapper containing the "if (xen_pv_domain())" in xen-ops.h
which can easily contain the needed #ifdef CONFIG_XEN_PV.


Juergen

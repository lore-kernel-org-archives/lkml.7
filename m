Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8B8C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 02:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582B9222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 02:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbfIZCXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 22:23:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfIZCXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:23:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9BD366E99926D5B331FD;
        Thu, 26 Sep 2019 10:23:32 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 10:23:30 +0800
Subject: Re: [PATCH] riscv: move flush_icache_range/user_range() after
 flush_icache_all()
To:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20190926022938.58568-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <4f7b4b37-1907-2afe-7600-dfce47f3bbdf@huawei.com>
Date:   Thu, 26 Sep 2019 10:23:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190926022938.58568-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this version.

On 2019/9/26 10:29, Kefeng Wang wrote:
> When build lkdtm module, which used flush_icache_range(), error occurred,
>
> ERROR: "flush_icache_all" [drivers/misc/lkdtm/lkdtm.ko] undefined!
>
> Fix it.
>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/include/asm/cacheflush.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 555b20b11dc3..f6ec26589620 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -80,13 +80,6 @@ static inline void flush_dcache_page(struct page *page)
>  		clear_bit(PG_dcache_clean, &page->flags);
>  }
>  
> -/*
> - * RISC-V doesn't have an instruction to flush parts of the instruction cache,
> - * so instead we just flush the whole thing.
> - */
> -#define flush_icache_range(start, end) flush_icache_all()
> -#define flush_icache_user_range(vma, pg, addr, len) flush_icache_all()
> -
>  #ifndef CONFIG_SMP
>  
>  #define flush_icache_all() local_flush_icache_all()
> @@ -99,6 +92,13 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
>  
>  #endif /* CONFIG_SMP */
>  
> +/*
> + * RISC-V doesn't have an instruction to flush parts of the instruction cache,
> + * so instead we just flush the whole thing.
> + */
> +#define flush_icache_range(start, end) flush_icache_all()
> +#define flush_icache_user_range(vma, pg, addr, len) flush_icache_all()
> +
>  /*
>   * Bits in sys_riscv_flush_icache()'s flags argument.
>   */


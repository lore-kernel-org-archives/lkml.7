Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3D2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7072121848
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732976AbfJVTw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:52:28 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59478 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbfJVTw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:52:28 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iN0Cf-0001zY-SH; Tue, 22 Oct 2019 13:52:26 -0600
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Stefan O'Rear <sorear2@gmail.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191022162136.19076-1-david.abdurachmanov@sifive.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b3ce6ae0-abc5-f85a-66e2-9c7d08580b84@deltatee.com>
Date:   Tue, 22 Oct 2019 13:52:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022162136.19076-1-david.abdurachmanov@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, tglx@linutronix.de, alex@ghiti.fr, david.abdurachmanov@sifive.com, sorear2@gmail.com, greentime.hu@sifive.com, rppt@linux.ibm.com, Anup.Patel@wdc.com, aou@eecs.berkeley.edu, palmer@sifive.com, paul.walmsley@sifive.com, david.abdurachmanov@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] riscv: fix fs/proc/kcore.c compilation with sparsemem
 enabled
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-10-22 10:21 a.m., David Abdurachmanov wrote:
> Failed to compile Fedora/RISCV kernel (5.4-rc3+) with sparsemem enabled:
> 
> fs/proc/kcore.c: In function 'read_kcore':
> fs/proc/kcore.c:510:8: error: implicit declaration of function 'kern_addr_valid'; did you mean 'virt_addr_valid'? [-Werror=implicit-function-declaration]
>   510 |    if (kern_addr_valid(start)) {
>       |        ^~~~~~~~~~~~~~~
>       |        virt_addr_valid
> 
> Looking at other architectures I don't see kern_addr_valid being guarded by
> CONFIG_FLATMEM.
> 
> Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
> Tested-by: David Abdurachmanov <david.abdurachmanov@sifive.com>

Makes sense to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


> ---
>  arch/riscv/include/asm/pgtable.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 42292d99cc74..7110879358b8 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -428,9 +428,7 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>  #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
>  #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
>  
> -#ifdef CONFIG_FLATMEM
>  #define kern_addr_valid(addr)   (1) /* FIXME */
> -#endif
>  
>  extern void *dtb_early_va;
>  extern void setup_bootmem(void);
> 

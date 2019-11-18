Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F74C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9372186D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKRQoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:44:37 -0500
Received: from ale.deltatee.com ([207.54.116.67]:44868 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfKRQoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:44:37 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iWk8Q-0000Vr-JU; Mon, 18 Nov 2019 09:44:19 -0700
To:     Yash Shah <yash.shah@sifive.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
References: <1574056694-28927-1-git-send-email-yash.shah@sifive.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <86b0a2c6-91ee-6ea6-92e7-1e5235b559f5@deltatee.com>
Date:   Mon, 18 Nov 2019 09:44:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574056694-28927-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sachin.ghadi@sifive.com, wangkefeng.wang@huawei.com, tglx@linutronix.de, bmeng.cn@gmail.com, ren_guo@c-sky.com, rppt@linux.ibm.com, Anup.Patel@wdc.com, aou@eecs.berkeley.edu, palmer@dabbelt.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, paul.walmsley@sifive.com, yash.shah@sifive.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2] RISC-V: Add address map dumper
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-11-17 10:58 p.m., Yash Shah wrote:
> Add support for dumping the kernel address space layout to the console.
> User can enable CONFIG_DEBUG_VM to dump the virtual memory region into
> dmesg buffer during boot-up.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Looks good to me, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
> This patch is based on Linux 5.4-rc6 and tested on SiFive HiFive
> Unleashed board.
> 
> Changes in v2:
> - Avoid #ifdefs inside functions
> - Helper functions instead of macros
> - Drop newly added CONFIG_DEBUG_VM_LAYOUT, instead use CONFIG_DEBUG_VM
> ---
>  arch/riscv/mm/init.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 573463d..7828136 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -45,6 +45,41 @@ void setup_zero_page(void)
>  	memset((void *)empty_zero_page, 0, PAGE_SIZE);
>  }
>  
> +#ifdef CONFIG_DEBUG_VM
> +static inline void print_mlk(char *name, unsigned long b, unsigned long t)
> +{
> +	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,
> +		  (((t) - (b)) >> 10));
> +}
> +
> +static inline void print_mlm(char *name, unsigned long b, unsigned long t)
> +{
> +	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld MB)\n", name, b, t,
> +		  (((t) - (b)) >> 20));
> +}
> +
> +static void print_vm_layout(void)
> +{
> +	pr_notice("Virtual kernel memory layout:\n");
> +	print_mlk("fixmap", (unsigned long)FIXADDR_START,
> +		  (unsigned long)FIXADDR_TOP);
> +	print_mlm("vmemmap", (unsigned long)VMEMMAP_START,
> +		  (unsigned long)VMEMMAP_END);
> +	print_mlm("vmalloc", (unsigned long)VMALLOC_START,
> +		  (unsigned long)VMALLOC_END);
> +	print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
> +		  (unsigned long)high_memory);
> +	print_mlk(".init", (unsigned long)__init_begin,
> +		  (unsigned long)__init_end);
> +	print_mlk(".text", (unsigned long)_text, (unsigned long)_etext);
> +	print_mlk(".data", (unsigned long)_sdata, (unsigned long)_edata);
> +	print_mlk(".bss", (unsigned long)__bss_start,
> +		  (unsigned long)__bss_stop);
> +}
> +#else
> +static void print_vm_layout(void) { }
> +#endif /* CONFIG_DEBUG_VM */
> +
>  void __init mem_init(void)
>  {
>  #ifdef CONFIG_FLATMEM
> @@ -55,6 +90,7 @@ void __init mem_init(void)
>  	memblock_free_all();
>  
>  	mem_init_print_info(NULL);
> +	print_vm_layout();
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> 

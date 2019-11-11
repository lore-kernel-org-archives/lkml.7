Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5A0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B04206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKKSOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:14:44 -0500
Received: from ale.deltatee.com ([207.54.116.67]:42876 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfKKSOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:14:43 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iUECv-00018v-1q; Mon, 11 Nov 2019 11:14:33 -0700
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
        Sachin Ghadi <sachin.ghadi@sifive.com>
References: <1573450015-16475-1-git-send-email-yash.shah@sifive.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <91f35033-ffc8-cd2e-36f7-c6f4f25be36b@deltatee.com>
Date:   Mon, 11 Nov 2019 11:14:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573450015-16475-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sachin.ghadi@sifive.com, tglx@linutronix.de, bmeng.cn@gmail.com, ren_guo@c-sky.com, rppt@linux.ibm.com, Anup.Patel@wdc.com, aou@eecs.berkeley.edu, palmer@dabbelt.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, paul.walmsley@sifive.com, yash.shah@sifive.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] RISC-V: Add address map dumper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-11-10 10:27 p.m., Yash Shah wrote:
> Add support for dumping the kernel address space layout to the console.
> User can enable CONFIG_DEBUG_VM_LAYOUT to dump the virtual memory region
> into dmesg buffer during boot-up.

Cool, I'd find this useful. Though, is there any reason we don't do this
more generally for all architectures?

> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
> This patch is based on Linux 5.4-rc6 and tested on SiFive HiFive Unleashed
> board.
> ---
>  arch/riscv/Kconfig.debug |  9 +++++++++
>  arch/riscv/mm/init.c     | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
> index e69de29..cdedfd3 100644
> --- a/arch/riscv/Kconfig.debug
> +++ b/arch/riscv/Kconfig.debug
> @@ -0,0 +1,9 @@
> +config DEBUG_VM_LAYOUT
> +	bool "Print virtual memory layout on boot up"
> +	depends on DEBUG_KERNEL
> +	help
> +	  Say Y here if you want to dump the kernel virtual memory layout to
> +	  dmesg log on boot up. This information is only useful for kernel
> +	  developers who are working in architecture specific areas of the
> +	  kernel. It is probably not a good idea to enable this feature in a
> +	  production kernel.
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 79cfb35..fcb8144 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -55,6 +55,36 @@ void __init mem_init(void)
>  	memblock_free_all();
>  
>  	mem_init_print_info(NULL);
> +#ifdef CONFIG_DEBUG_VM_LAYOUT

Generally, it's best to avoid #ifdefs inside functions, it's even
counter-indicated in the style guide[1].

> +#define MLK(b, t) b, t, (((t) - (b)) >> 10)
> +#define MLM(b, t) b, t, (((t) - (b)) >> 20)
> +#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)

I personally find these inline defines rather ugly. Maybe it would be
better to have a helper function that prints a single line. Also seems
like MLK and MLK_ROUNDUP could be the same assuming the entries in MLK
are aligned...

> +
> +	pr_notice("Virtual kernel memory layout:\n"
> +			"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> +			"    vmemmap : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> +			"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> +			"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> +			"      .init : 0x%px - 0x%px   (%4td kB)\n"
> +			"      .text : 0x%px - 0x%px   (%4td kB)\n"
> +			"      .data : 0x%px - 0x%px   (%4td kB)\n"
> +			"       .bss : 0x%px - 0x%px   (%4td kB)\n",
> +
> +			MLK(FIXADDR_START, FIXADDR_TOP),
> +			MLM(VMEMMAP_START, VMEMMAP_END),
> +			MLM(VMALLOC_START, VMALLOC_END),
> +			MLM(PAGE_OFFSET, (unsigned long)high_memory),
> +
> +			MLK_ROUNDUP(__init_begin, __init_end),
> +			MLK_ROUNDUP(_text, _etext),
> +			MLK_ROUNDUP(_sdata, _edata),
> +			MLK_ROUNDUP(__bss_start, __bss_stop));
> +
> +#undef MLK
> +#undef MLM
> +#undef MLK_ROUNDUP
> +#endif
>  }
>  
>  #ifdef CONFIG_BLK_DEV_INITRD

Thanks,

Logan

[1]
https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation

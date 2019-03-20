Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2F0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1F820828
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfCTAZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:25:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbfCTAZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:25:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9598281106;
        Wed, 20 Mar 2019 00:25:34 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2314669EC;
        Wed, 20 Mar 2019 00:25:32 +0000 (UTC)
Date:   Wed, 20 Mar 2019 08:25:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] x86/boot/KASLR: skip the specified crashkernel
 reserved region
Message-ID: <20190320002524.GD18740@MiWiFi-R3L-srv>
References: <1552450771-8360-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552450771-8360-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 20 Mar 2019 00:25:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please change subject as:

"x86/boot/KASLR: skip the specified crashkernel region"

Don't see why reserved is needed here.

On 03/13/19 at 12:19pm, Pingfan Liu wrote:
> crashkernel=x@y option may fail to reserve the required memory region if
> KASLR puts kernel into the region. To avoid this uncertainty, making KASLR
> skip the required region.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Pingfan Liu <kernelfans@gmail.com>
> Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> ---
> v1 -> v2: fix some trival format
> 
>  arch/x86/boot/compressed/kaslr.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 9ed9709..e185318 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -109,6 +109,7 @@ enum mem_avoid_index {
>  	MEM_AVOID_BOOTPARAMS,
>  	MEM_AVOID_MEMMAP_BEGIN,
>  	MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
> +	MEM_AVOID_CRASHKERNEL,
>  	MEM_AVOID_MAX,
>  };
>  
> @@ -240,6 +241,25 @@ static void parse_gb_huge_pages(char *param, char *val)
>  	}
>  }
>  
> +/* parse crashkernel=x@y option */
> +static void mem_avoid_crashkernel_simple(char *option)

Chao ever mentioned this, I want to ask again, why does it has to be
xxx_simple()?

Except of these, patch looks good to me. It's a nice catch, and only
need a simple fix based on the current code.

Thanks
Baoquan

> +{
> +	unsigned long long crash_size, crash_base;
> +	char *cur = option;
> +
> +	crash_size = memparse(option, &cur);
> +	if (option == cur)
> +		return;
> +
> +	if (*cur == '@') {
> +		option = cur + 1;
> +		crash_base = memparse(option, &cur);
> +		if (option == cur)
> +			return;
> +		mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
> +		mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
> +	}
> +}
>  
>  static void handle_mem_options(void)
>  {
> @@ -250,7 +270,7 @@ static void handle_mem_options(void)
>  	u64 mem_size;
>  
>  	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
> -		!strstr(args, "hugepages"))
> +		!strstr(args, "hugepages") && !strstr(args, "crashkernel="))
>  		return;
>  
>  	tmp_cmdline = malloc(len + 1);
> @@ -286,6 +306,8 @@ static void handle_mem_options(void)
>  				goto out;
>  
>  			mem_limit = mem_size;
> +		} else if (strstr(param, "crashkernel")) {
> +			mem_avoid_crashkernel_simple(val);
>  		}
>  	}
>  
> @@ -414,7 +436,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
>  
>  	/* We don't need to set a mapping for setup_data. */
>  
> -	/* Mark the memmap regions we need to avoid */
> +	/* Mark the regions we need to avoid */
>  	handle_mem_options();
>  
>  #ifdef CONFIG_X86_VERBOSE_BOOTUP
> -- 
> 2.7.4
> 

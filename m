Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C502C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E368A20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="isnz1ZLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfDPTBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:01:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45890 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfDPTBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:01:35 -0400
Received: from zn.tnic (p200300EC2F0D6900BD7AE2FF560FC812.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:bd7a:e2ff:560f:c812])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A8BA1EC05B8;
        Tue, 16 Apr 2019 21:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555441293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=F5xRbm9efINKQdR8vaSf/N5AR2hGc1XKPS/fdyAGySw=;
        b=isnz1ZLCe3k34ZVM8fwj0iZwiCxcFNi8cNzEzvV1UidVj88En5sftGMhySy13n+7TODJy9
        tQQnl5WLpoDeoDRwJVPRgeEjhFrtUlKWaKZRb9mu3T/iROk+pX/C7IGAgSQeg8XPYoW8/i
        y6L0K+/ir5ND5LNY7OuvHy+74pLc1Ks=
Date:   Tue, 16 Apr 2019 21:01:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] x86/boot/KASLR: skip the specified crashkernel
 region
Message-ID: <20190416190128.GL31772@zn.tnic>
References: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
 <1554703115-15299-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554703115-15299-3-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 01:58:35PM +0800, Pingfan Liu wrote:
> crashkernel=x@y or or =range1:size1[,range2:size2,...]@offset option may
> fail to reserve the required memory region if KASLR puts kernel into the
> region. To avoid this uncertainty, asking KASLR to skip the required
> region.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/boot/compressed/kaslr.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 2e53c05..765a593 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -107,6 +107,7 @@ enum mem_avoid_index {
>  	MEM_AVOID_BOOTPARAMS,
>  	MEM_AVOID_MEMMAP_BEGIN,
>  	MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
> +	MEM_AVOID_CRASHKERNEL,
>  	MEM_AVOID_MAX,
>  };
>  
> @@ -131,6 +132,11 @@ char *skip_spaces(const char *str)
>  }
>  #include "../../../../lib/ctype.c"
>  #include "../../../../lib/cmdline.c"
> +#ifdef CONFIG_CRASH_CORE
> +#define printk
> +#define _BOOT_KASLR
> +#include "../../../../lib/parse_crashkernel.c"
> +#endif
>  
>  static int
>  parse_memmap(char *p, unsigned long long *start, unsigned long long *size)
> @@ -292,6 +298,39 @@ static void handle_mem_options(void)
>  	return;
>  }
>  
> +static u64 mem_ram_size(void)
> +{
> +	struct boot_e820_entry *entry;
> +	u64 total_sz = 0;
> +	int i;
> +
> +	for (i = 0; i < boot_params->e820_entries; i++) {
> +		entry = &boot_params->e820_table[i];
> +		/* Skip non-RAM entries. */
> +		if (entry->type != E820_TYPE_RAM)
> +			continue;
> +		total_sz += entry->size;
> +	}
> +	return total_sz;
> +}
> +
> +/*
> + * For crashkernel=size@offset or =range1:size1[,range2:size2,...]@offset
> + * options, recording mem_avoid for them.
> + */
> +static void handle_crashkernel_options(void)
> +{
> +	unsigned long long crash_size, crash_base = 0;
> +	char *cmdline = (char *)get_cmd_line_ptr();
> +	u64 total_sz = mem_ram_size();
> +
> +	parse_crashkernel(cmdline, total_sz, &crash_size, &crash_base);

That function has a return value which you could test. And then you
don't need to set crash_base to 0 above.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

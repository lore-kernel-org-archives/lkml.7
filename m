Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C0AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF2620833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfDBGql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:46:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfDBGql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:46:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3804420AFF;
        Tue,  2 Apr 2019 06:46:40 +0000 (UTC)
Received: from localhost (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EA9E58B1;
        Tue,  2 Apr 2019 06:46:38 +0000 (UTC)
Date:   Tue, 2 Apr 2019 14:46:36 +0800
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
Subject: Re: [PATCHv3] x86/boot/KASLR: skip the specified crashkernel region
Message-ID: <20190402064636.GM7627@MiWiFi-R3L-srv>
References: <1554178246-8162-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554178246-8162-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 02 Apr 2019 06:46:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/19 at 12:10pm, Pingfan Liu wrote:
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
> Cc: Pingfan Liu <kernelfans@gmail.com>
> Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> ---
> v2 -> v3: adding parsing of crashkernel=range1:size1[,range2:size2,...]@offset
> 
>  arch/x86/boot/compressed/kaslr.c | 116 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 114 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 2e53c05..7f698f4 100644
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
> @@ -238,6 +239,115 @@ static void parse_gb_huge_pages(char *param, char *val)
>  	}
>  }
>  
> +/* code heavily copied from parse_crashkernel_mem() */
> +static void handle_crashkernel_mem(char *cmdline,
> +					unsigned long long system_ram,
> +					unsigned long long *crash_size,
> +					unsigned long long *crash_base)

This version looks better and the logic is simple. It will be much better
if we can share code with parse_crashkernel_mem() since both of them look
almost the same.

> +{
> +	char *tmp, *cur = cmdline;
> +
> +	/* for each entry of the comma-separated list */
> +	do {
> +		unsigned long long start, end = ULLONG_MAX, size;
> +
> +		/* get the start of the range */
> +		start = memparse(cur, &tmp);
> +		/* no value given */
> +		if (cur == tmp)
> +			return;
> +		cur = tmp;
> +		if (*cur != '-')
> +			return;
> +		cur++;
> +
> +		/* if no ':' is here, than we read the end */
> +		if (*cur != ':') {
> +			end = memparse(cur, &tmp);
> +			/* no value given */
> +			if (cur == tmp)
> +				return;
> +			cur = tmp;
> +			/* invalid if crashkernel end <= start */
> +			if (end <= start)
> +				return;
> +		}
> +		/* expect ":" after range */
> +		if (*cur != ':')
> +			return;
> +		cur++;
> +
> +		size = memparse(cur, &tmp);
> +		/* no size value given */
> +		if (cur == tmp)
> +			return;
> +		cur = tmp;
> +		if (size >= system_ram)
> +			return;
> +
> +		/* match ? */
> +		if (system_ram >= start && system_ram < end) {
> +			*crash_size = size;
> +			break;
> +		}
> +	} while (*cur++ == ',');
> +
> +	if (*crash_size > 0) {
> +		while (*cur && *cur != ' ' && *cur != '@')
> +			cur++;
> +		if (*cur == '@') {
> +			cur++;
> +			*crash_base = memparse(cur, &tmp);
> +		}
> +	}
> +}
> +
> +/* handle crashkernel=x@y or =range1:size1[,range2:size2,...]@offset options */
> +static void mem_avoid_specified_crashkernel_region(char *option)

Maybe just add more words to explain the specified crashkernel region
cases, but remove the 'speecified' word in function name?

> +{
> +	unsigned long long crash_size, crash_base = 0;
> +	char	*first_colon, *first_space, *cur = option;
> +
> +	first_colon = strchr(option, ':');
> +	first_space = strchr(option, ' ');
> +	/* if contain ":" */
> +	if (first_colon && (!first_space || first_colon < first_space)) {
> +		int i;
> +		u64 total_sz = 0;
> +		struct boot_e820_entry *entry;
> +
> +		for (i = 0; i < boot_params->e820_entries; i++) {
> +			entry = &boot_params->e820_table[i];
> +			/* Skip non-RAM entries. */
> +			if (entry->type != E820_TYPE_RAM)
> +				continue;
> +			total_sz += entry->size;

Wrap this for loop into a static function to calculate the system RAM
size?

Other than these, I think this adding looks good. It won't impact the
current handling, and very easy to recognize what it's doing. Thanks for
the effort.

Thanks
Baoquan
> +		}
> +		handle_crashkernel_mem(option, total_sz, &crash_size,
> +			&crash_base);
> +	} else {
> +		crash_size = memparse(option, &cur);
> +		if (option == cur)
> +			return;
> +		while (*cur && *cur != ' ' && *cur != '@')
> +			cur++;
> +		if (*cur == '@') {
> +			option = cur + 1;
> +			crash_base = memparse(option, &cur);
> +		}
> +	}
> +	if (crash_base) {
> +		mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
> +		mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
> +	} else {
> +		/*
> + 		 * Clearing mem_avoid if no offset is given. This is consistent
> + 		 * with kernel, which uses the last crashkernel= option.
> +		 */
> +		mem_avoid[MEM_AVOID_CRASHKERNEL].start = 0;
> +		mem_avoid[MEM_AVOID_CRASHKERNEL].size = 0;
> +	}
> +}
>  
>  static void handle_mem_options(void)
>  {
> @@ -248,7 +358,7 @@ static void handle_mem_options(void)
>  	u64 mem_size;
>  
>  	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
> -		!strstr(args, "hugepages"))
> +		!strstr(args, "hugepages") && !strstr(args, "crashkernel="))
>  		return;
>  
>  	tmp_cmdline = malloc(len + 1);
> @@ -284,6 +394,8 @@ static void handle_mem_options(void)
>  				goto out;
>  
>  			mem_limit = mem_size;
> +		} else if (strstr(param, "crashkernel")) {
> +			mem_avoid_specified_crashkernel_region(val);
>  		}
>  	}
>  
> @@ -412,7 +524,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
>  
>  	/* We don't need to set a mapping for setup_data. */
>  
> -	/* Mark the memmap regions we need to avoid */
> +	/* Mark the regions we need to avoid */
>  	handle_mem_options();
>  
>  	/* Enumerate the immovable memory regions */
> -- 
> 2.7.4
> 

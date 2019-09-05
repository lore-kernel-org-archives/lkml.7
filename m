Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79961C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352792070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732533AbfIENvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:51:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729318AbfIENvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:51:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D435318C4266;
        Thu,  5 Sep 2019 13:51:49 +0000 (UTC)
Received: from localhost (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB3B75D9E2;
        Thu,  5 Sep 2019 13:51:47 +0000 (UTC)
Date:   Thu, 5 Sep 2019 21:51:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] x86/boot: Get the max address from SRAT
Message-ID: <20190905135134.GC20805@MiWiFi-R3L-srv>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
 <20190830214707.1201-4-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830214707.1201-4-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Thu, 05 Sep 2019 13:51:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/19 at 05:47pm, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Get the max address from SRAT and write it into boot_params->max_addr.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  arch/x86/boot/compressed/acpi.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 908a1bfab..ba2bc5ab9 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -362,16 +362,24 @@ static unsigned long get_acpi_srat_table(void)
>  	return 0;
>  }
>  
> -static void subtable_parse(struct acpi_subtable_header *sub_table, int *num)
> +static void subtable_parse(struct acpi_subtable_header *sub_table, int *num,
> +		unsigned long *max_addr)
>  {
>  	struct acpi_srat_mem_affinity *ma;
> +	unsigned long addr;
>  
>  	ma = (struct acpi_srat_mem_affinity *)sub_table;
>  
> -	if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
> -		immovable_mem[*num].start = ma->base_address;
> -		immovable_mem[*num].size = ma->length;
> -		(*num)++;
> +	if (ma->length) {
> +		if (ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) {
> +			addr = ma->base_address + ma->length;
> +			if (addr > *max_addr)
> +				*max_addr = addr;

Can we return max_addr or only pass out the max_addr, then let the
max_addr compared and got outside of subtable_parse()? This can keep
subtable_parse() really only doing parsing work.

Personal opinion, see what maintainers and other reviewers will say.

Thanks
Baoquan

> +		} else {
> +			immovable_mem[*num].start = ma->base_address;
> +			immovable_mem[*num].size = ma->length;
> +			(*num)++;
> +		}
>  	}
>  }
>  
> @@ -391,6 +399,7 @@ int count_immovable_mem_regions(void)
>  	struct acpi_subtable_header *sub_table;
>  	struct acpi_table_header *table_header;
>  	char arg[MAX_ACPI_ARG_LENGTH];
> +	unsigned long max_addr = 0;
>  	int num = 0;
>  
>  	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
> @@ -409,7 +418,7 @@ int count_immovable_mem_regions(void)
>  		sub_table = (struct acpi_subtable_header *)table;
>  		if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
>  
> -			subtable_parse(sub_table, &num);
> +			subtable_parse(sub_table, &num, &max_addr);
>  
>  			if (num >= MAX_NUMNODES*2) {
>  				debug_putstr("Too many immovable memory regions, aborting.\n");
> @@ -418,6 +427,9 @@ int count_immovable_mem_regions(void)
>  		}
>  		table += sub_table->length;
>  	}
> +
> +	boot_params->max_addr = max_addr;
> +
>  	return num;
>  }
>  #endif /* CONFIG_RANDOMIZE_BASE && CONFIG_MEMORY_HOTREMOVE */
> -- 
> 2.18.1
> 

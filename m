Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6198C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 11:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73037206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 11:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfJLL1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 07:27:46 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56811 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfJLL1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 07:27:46 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iJFYb-0004nF-7B; Sat, 12 Oct 2019 05:27:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iJFYa-0002YW-Fa; Sat, 12 Oct 2019 05:27:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, bhe@redhat.com,
        dyoung@redhat.com, jgross@suse.com, dhowells@redhat.com,
        Thomas.Lendacky@amd.com, vgoyal@redhat.com,
        kexec@lists.infradead.org
References: <20191012022140.19003-1-lijiang@redhat.com>
        <20191012022140.19003-4-lijiang@redhat.com>
Date:   Sat, 12 Oct 2019 06:26:42 -0500
In-Reply-To: <20191012022140.19003-4-lijiang@redhat.com> (Lianbo Jiang's
        message of "Sat, 12 Oct 2019 10:21:40 +0800")
Message-ID: <87d0f22oi5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iJFYa-0002YW-Fa;;;mid=<87d0f22oi5.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+uhegb7qW+kWraLRHYBavwA95Me10UhX4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 3/3 v3] x86/kdump: clean up all the code related to the backup region
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lianbo Jiang <lijiang@redhat.com> writes:

> When the crashkernel kernel command line option is specified, the
> low 1MiB memory will always be reserved, which makes that the memory
> allocated later won't fall into the low 1MiB area, thereby, it's not
> necessary to create a backup region and also no need to copy the first
> 640k content to a backup region.
>
> Currently, the code related to the backup region can be safely removed,
> so lets clean up.
>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---

> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index eb651fbde92a..cc5774fc84c0 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  
>  #ifdef CONFIG_KEXEC_FILE
>  
> -static unsigned long crash_zero_bytes;
> -
>  static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>  {
>  	unsigned int *nr_ranges = arg;
> @@ -234,9 +232,15 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>  {
>  	struct crash_mem *cmem = arg;
>  
> -	cmem->ranges[cmem->nr_ranges].start = res->start;
> -	cmem->ranges[cmem->nr_ranges].end = res->end;
> -	cmem->nr_ranges++;
> +	if (res->start >= SZ_1M) {
> +		cmem->ranges[cmem->nr_ranges].start = res->start;
> +		cmem->ranges[cmem->nr_ranges].end = res->end;
> +		cmem->nr_ranges++;
> +	} else if (res->end > SZ_1M) {
> +		cmem->ranges[cmem->nr_ranges].start = SZ_1M;
> +		cmem->ranges[cmem->nr_ranges].end = res->end;
> +		cmem->nr_ranges++;
> +	}

What is going on with this chunk?  I can guess but this needs a clear
comment.

>  
>  	return 0;
>  }

> @@ -356,9 +337,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>  	cmd.params = params;
>  
> -	/* Add first 640K segment */
> -	ei.addr = image->arch.backup_src_start;
> -	ei.size = image->arch.backup_src_sz;
> +	/*
> +	 * Add the low memory range[0x1000, SZ_1M], skip
> +	 * the first zero page.
> +	 */
> +	ei.addr = PAGE_SIZE;
> +	ei.size = SZ_1M - PAGE_SIZE;
>  	ei.type = E820_TYPE_RAM;
>  	add_e820_entry(params, &ei);

Likewise here.  Why do we need a special case?
Why the magic with PAGE_SIZE?

Is this needed because of your other special case above?

When SME is active and the crashkernel command line is enabled do we
just want to leave the low 1MB unencrypted?  So we don't need any
special cases?

Eric

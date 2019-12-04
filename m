Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2DAC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84832073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8DAqp66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfLDUoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:44:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33038 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727889AbfLDUoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575492262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGKzM/L1KdTMS1T02YArhRfBu3OmO5dNN7xPVcxWihg=;
        b=a8DAqp66Miqw68K/f6D9Hy7S7ilzz86hjekIZVcEcETXF58Kt52XZRo8D3K6LTZ1kDdLeP
        2CBDcaH23wTA2Z4RNl8Qcei+QyS7NqYPvKqAN/VDk6/M1K5bwbKiinwhiPK3iUwMt4Vidr
        zwKCEshgtn/nV+6hUmzvxLJH/uAFcno=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-b-l7velgPbGbW3oOMALmfw-1; Wed, 04 Dec 2019 15:44:21 -0500
Received: by mail-pj1-f69.google.com with SMTP id e5so506560pjr.17
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 12:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iGKzM/L1KdTMS1T02YArhRfBu3OmO5dNN7xPVcxWihg=;
        b=qDVatyhS2Af0sSbVhpatYB1gdGp3JGjs7GPuU3Eh0mwcLZxU3wDpTW5zZdSGUHAtUF
         Wyt7aItd74j/dBD9BzXor8gBaQ7F0n5tBw+/1CHBliui4hhmsaPTExGut5sMXwPZQjur
         xi1tSWckRnUGW9vipeGPANSISk2jmcahEtd3v+e4eypv2WVQXeiZYHILftWEzwRMfkLI
         9XDyKkd59idRd1+8xvnic9isY51qActuq7XcsmIGAC5vlKsO5ZY/0vJ2OS44wqDYk2pr
         Xe/E4e18LpNxKUs5O4/wZF4tul3H7UeDD1jTimoi3hdKGCh5+MFlLGUy2sRt/+607xG6
         glOA==
X-Gm-Message-State: APjAAAUI5L438UgUtFiotQv8OX89bS7FgPU4koAR10aGs1lVoIM8BvNx
        a0oXBqKmIkZ3mCtYwO4Vaxbi+L2xsjOMUUQ4DvThsJYkoni1DI5KE6kMLgtomoVDDLLcaQ5iga9
        rW0uuD2tKbbGZn/dHZta/V7/h
X-Received: by 2002:a65:654d:: with SMTP id a13mr5652898pgw.141.1575492260347;
        Wed, 04 Dec 2019 12:44:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqw3rOvu9SsHFYYL6e8uTq4jA6Asl2mLRDqYHkAihg8vtLjHcoJOaa36R4HQLLLwWjYPmwUmHw==
X-Received: by 2002:a65:654d:: with SMTP id a13mr5652874pgw.141.1575492259934;
        Wed, 04 Dec 2019 12:44:19 -0800 (PST)
Received: from localhost.localdomain ([122.177.160.143])
        by smtp.gmail.com with ESMTPSA id b11sm8979596pfd.83.2019.12.04.12.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 12:44:19 -0800 (PST)
Subject: Re: [PATCH v2 3/3] arm64: kexec_file: add crash dump support
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     kexec@lists.infradead.org, james.morse@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191114051510.17037-1-takahiro.akashi@linaro.org>
 <20191114051510.17037-4-takahiro.akashi@linaro.org>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <679aba8b-c03d-8a15-46f1-3dc158c24fe9@redhat.com>
Date:   Thu, 5 Dec 2019 02:14:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20191114051510.17037-4-takahiro.akashi@linaro.org>
Content-Language: en-US
X-MC-Unique: b-l7velgPbGbW3oOMALmfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2019 10:45 AM, AKASHI Takahiro wrote:
> Enabling crash dump (kdump) includes
> * prepare contents of ELF header of a core dump file, /proc/vmcore,
>    using crash_prepare_elf64_headers(), and
> * add two device tree properties, "linux,usable-memory-range" and
>    "linux,elfcorehdr", which represent respectively a memory range
>    to be used by crash dump kernel and the header's location
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>   arch/arm64/include/asm/kexec.h         |   4 +
>   arch/arm64/kernel/kexec_image.c        |   4 -
>   arch/arm64/kernel/machine_kexec_file.c | 106 ++++++++++++++++++++++++-
>   3 files changed, 106 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 12a561a54128..d24b527e8c00 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -96,6 +96,10 @@ static inline void crash_post_resume(void) {}
>   struct kimage_arch {
>   	void *dtb;
>   	unsigned long dtb_mem;
> +	/* Core ELF header buffer */
> +	void *elf_headers;
> +	unsigned long elf_headers_mem;
> +	unsigned long elf_headers_sz;
>   };
>   
>   extern const struct kexec_file_ops kexec_image_ops;
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 29a9428486a5..af9987c154ca 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -47,10 +47,6 @@ static void *image_load(struct kimage *image,
>   	struct kexec_segment *kernel_segment;
>   	int ret;
>   
> -	/* We don't support crash kernels yet. */
> -	if (image->type == KEXEC_TYPE_CRASH)
> -		return ERR_PTR(-EOPNOTSUPP);
> -
>   	/*
>   	 * We require a kernel with an unambiguous Image header. Per
>   	 * Documentation/arm64/booting.rst, this is the case when image_size
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 7b08bf9499b6..f1d1bb895fd2 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -17,12 +17,15 @@
>   #include <linux/memblock.h>
>   #include <linux/of_fdt.h>
>   #include <linux/random.h>
> +#include <linux/slab.h>
>   #include <linux/string.h>
>   #include <linux/types.h>
>   #include <linux/vmalloc.h>
>   #include <asm/byteorder.h>
>   
>   /* relevant device tree properties */
> +#define FDT_PROP_KEXEC_ELFHDR	"linux,elfcorehdr"
> +#define FDT_PROP_MEM_RANGE	"linux,usable-memory-range"
>   #define FDT_PROP_INITRD_START	"linux,initrd-start"
>   #define FDT_PROP_INITRD_END	"linux,initrd-end"
>   #define FDT_PROP_BOOTARGS	"bootargs"
> @@ -40,6 +43,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>   	vfree(image->arch.dtb);
>   	image->arch.dtb = NULL;
>   
> +	vfree(image->arch.elf_headers);
> +	image->arch.elf_headers = NULL;
> +	image->arch.elf_headers_sz = 0;
> +
>   	return kexec_image_post_load_cleanup_default(image);
>   }
>   
> @@ -55,6 +62,31 @@ static int setup_dtb(struct kimage *image,
>   
>   	off = ret;
>   
> +	ret = fdt_delprop(dtb, off, FDT_PROP_KEXEC_ELFHDR);
> +	if (ret && ret != -FDT_ERR_NOTFOUND)
> +		goto out;
> +	ret = fdt_delprop(dtb, off, FDT_PROP_MEM_RANGE);
> +	if (ret && ret != -FDT_ERR_NOTFOUND)
> +		goto out;
> +
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		/* add linux,elfcorehdr */
> +		ret = fdt_appendprop_addrrange(dtb, 0, off,
> +				FDT_PROP_KEXEC_ELFHDR,
> +				image->arch.elf_headers_mem,
> +				image->arch.elf_headers_sz);
> +		if (ret)
> +			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> +
> +		/* add linux,usable-memory-range */
> +		ret = fdt_appendprop_addrrange(dtb, 0, off,
> +				FDT_PROP_MEM_RANGE,
> +				crashk_res.start,
> +				crashk_res.end - crashk_res.start + 1);
> +		if (ret)
> +			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> +	}
> +
>   	/* add bootargs */
>   	if (cmdline) {
>   		ret = fdt_setprop_string(dtb, off, FDT_PROP_BOOTARGS, cmdline);
> @@ -125,8 +157,8 @@ static int setup_dtb(struct kimage *image,
>   }
>   
>   /*
> - * More space needed so that we can add initrd, bootargs, kaslr-seed, and
> - * rng-seed.
> + * More space needed so that we can add initrd, bootargs, kaslr-seed,
> + * rng-seed, userable-memory-range and elfcorehdr.

nitpick:
s/userable-memory-range/usable-memory-range

>    */
>   #define DTB_EXTRA_SPACE 0x1000
>   
> @@ -174,6 +206,43 @@ static int create_dtb(struct kimage *image,
>   	}
>   }
>   
> +static int prepare_elf_headers(void **addr, unsigned long *sz)
> +{
> +	struct crash_mem *cmem;
> +	unsigned int nr_ranges;
> +	int ret;
> +	u64 i;
> +	phys_addr_t start, end;
> +
> +	nr_ranges = 1; /* for exclusion of crashkernel region */
> +	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> +					MEMBLOCK_NONE, &start, &end, NULL)
> +		nr_ranges++;
> +
> +	cmem = kmalloc(sizeof(struct crash_mem) +
> +			sizeof(struct crash_mem_range) * nr_ranges, GFP_KERNEL);
> +	if (!cmem)
> +		return -ENOMEM;
> +
> +	cmem->max_nr_ranges = nr_ranges;
> +	cmem->nr_ranges = 0;
> +	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> +					MEMBLOCK_NONE, &start, &end, NULL) {
> +		cmem->ranges[cmem->nr_ranges].start = start;
> +		cmem->ranges[cmem->nr_ranges].end = end - 1;
> +		cmem->nr_ranges++;
> +	}
> +
> +	/* Exclude crashkernel region */
> +	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> +
> +	if (!ret)
> +		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
> +
> +	kfree(cmem);
> +	return ret;
> +}
> +
>   int load_other_segments(struct kimage *image,
>   			unsigned long kernel_load_addr,
>   			unsigned long kernel_size,
> @@ -181,14 +250,43 @@ int load_other_segments(struct kimage *image,
>   			char *cmdline)
>   {
>   	struct kexec_buf kbuf;
> -	void *dtb = NULL;
> -	unsigned long initrd_load_addr = 0, dtb_len;
> +	void *headers, *dtb = NULL;
> +	unsigned long headers_sz, initrd_load_addr = 0, dtb_len;
>   	int ret = 0;
>   
>   	kbuf.image = image;
>   	/* not allocate anything below the kernel */
>   	kbuf.buf_min = kernel_load_addr + kernel_size;
>   
> +	/* load elf core header */
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		ret = prepare_elf_headers(&headers, &headers_sz);
> +		if (ret) {
> +			pr_err("Preparing elf core header failed\n");
> +			goto out_err;
> +		}
> +
> +		kbuf.buffer = headers;
> +		kbuf.bufsz = headers_sz;
> +		kbuf.mem = 0;

With commit c19d050f8088 ("arm64/kexec: Use consistent convention of 
initializing 'kxec_buf.mem' with KEXEC_BUF_MEM_UNKNOWN"), we are trying 
to standardize the way of setting up initial value of 'kbuf.mem'. So we 
can use the following notion (in v3?) instead:
		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;

> +		kbuf.memsz = headers_sz;
> +		kbuf.buf_align = SZ_64K; /* largest supported page size */
> +		kbuf.buf_max = ULONG_MAX;
> +		kbuf.top_down = true;
> +
> +		ret = kexec_add_buffer(&kbuf);
> +		if (ret) {
> +			vfree(headers);
> +			goto out_err;
> +		}
> +		image->arch.elf_headers = headers;
> +		image->arch.elf_headers_mem = kbuf.mem;
> +		image->arch.elf_headers_sz = headers_sz;
> +
> +		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +			 image->arch.elf_headers_mem, headers_sz, headers_sz);
> +	}
> +
>   	/* load initrd */
>   	if (initrd) {
>   		kbuf.buffer = initrd;
> 

Thanks,
Bhupesh


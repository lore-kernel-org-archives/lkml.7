Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D1BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 01:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236C5206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 01:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDKgLpTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLPBlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 20:41:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37453 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfLPBlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 20:41:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so2936379pfn.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 17:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vKWIjxi1nk8Ga7RhWUN0zgtcmVWngyFbgXRZIyxpNMU=;
        b=lDKgLpTl9zI9yi4kWI5u7L1tD+a5HVL6MHYFjwKqRSOT2WAhzY0x8hB9K97268cKdx
         js8uEiCTOCCLlqWgNMyJ389HuFTJYY78c6XA8QXwi0JP0L/S300txtxPaIL7HdlwQw7a
         r01cy3De9AQWUY7FBUyaVOzDycsi3G+hfSmntp4MxviPQ+fczG5ELtGnsXOehsNLEdRx
         XiJ4VENwgVvfsp0OZTq/j5di9YsZBFBsKUkIyUHWJ5a/Q4deIV8h3sh834Rl4/gVXKpb
         rsWUfxPBopo4UmcEMTZxElYUXNUK1+oM3KXxSN51nhx+YBxpMam8DpVN4qBixhseYwFT
         TW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vKWIjxi1nk8Ga7RhWUN0zgtcmVWngyFbgXRZIyxpNMU=;
        b=Yh4eSwBs/mfa1fiO/7TkKV6J/ZzX4aEoDrLEWI91QDmoNZ3j0miUPMvjiUil4GLg/k
         POXPPSVuifOGOrnPDxt+L0HlqbrWzNphHFouFjc7ScxXmXI5Ceco46QND0HKTN2EGcZG
         eSDfeDRPoXQeRE4uq1fjdtfjr//UuqA1rmnp6t4+tP7DlbYhMZwvNmLrWtWxLbML4LHq
         IygvdQkZ52Q8NJqMO+5/0V8K2chGEAe0orHgfUmLXKmWnmi6IBxHvZaI9E5OuwOe7FW9
         s4G0z2mMm38fsBotv/vkb8IEXmQHZhUcrgvC0ErjBFSlzlRyQvK7CS5e6Z0v0Y/pEMl0
         OPrw==
X-Gm-Message-State: APjAAAXgqgEsfTKgm93D4iLBkUfdWVkMY73hJfEzmpYI4aJj4AlDvtUI
        EMjST7KjmRNRbi8Hl/AShEOilw==
X-Google-Smtp-Source: APXvYqzs3ngwhbPfpuEwbRurQH9CB7RzuqXdoRId3UZCBcsAbamV6Ixl1viRAk3ujUTuYhFkNIII8g==
X-Received: by 2002:a63:4f59:: with SMTP id p25mr14957477pgl.230.1576460464331;
        Sun, 15 Dec 2019 17:41:04 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id f127sm17265619pfa.112.2019.12.15.17.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 17:41:03 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:43:07 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com, kexec@lists.infradead.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: kexec_file: add crash dump support
Message-ID: <20191216014306.GG22427@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bhupesh Sharma <bhsharma@redhat.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        kexec@lists.infradead.org, james.morse@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191114051510.17037-1-takahiro.akashi@linaro.org>
 <20191114051510.17037-4-takahiro.akashi@linaro.org>
 <679aba8b-c03d-8a15-46f1-3dc158c24fe9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <679aba8b-c03d-8a15-46f1-3dc158c24fe9@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have forgot to address Bhupesh's comment below in my v3.
I'm going to repost my patch.

Thank you, Bhupesh, for your review.

-Takahiro Akashi

On Thu, Dec 05, 2019 at 02:14:14AM +0530, Bhupesh Sharma wrote:
> On 11/14/2019 10:45 AM, AKASHI Takahiro wrote:
> >Enabling crash dump (kdump) includes
> >* prepare contents of ELF header of a core dump file, /proc/vmcore,
> >   using crash_prepare_elf64_headers(), and
> >* add two device tree properties, "linux,usable-memory-range" and
> >   "linux,elfcorehdr", which represent respectively a memory range
> >   to be used by crash dump kernel and the header's location
> >
> >Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >Cc: Catalin Marinas <catalin.marinas@arm.com>
> >Cc: Will Deacon <will.deacon@arm.com>
> >Reviewed-by: James Morse <james.morse@arm.com>
> >---
> >  arch/arm64/include/asm/kexec.h         |   4 +
> >  arch/arm64/kernel/kexec_image.c        |   4 -
> >  arch/arm64/kernel/machine_kexec_file.c | 106 ++++++++++++++++++++++++-
> >  3 files changed, 106 insertions(+), 8 deletions(-)
> >
> >diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> >index 12a561a54128..d24b527e8c00 100644
> >--- a/arch/arm64/include/asm/kexec.h
> >+++ b/arch/arm64/include/asm/kexec.h
> >@@ -96,6 +96,10 @@ static inline void crash_post_resume(void) {}
> >  struct kimage_arch {
> >  	void *dtb;
> >  	unsigned long dtb_mem;
> >+	/* Core ELF header buffer */
> >+	void *elf_headers;
> >+	unsigned long elf_headers_mem;
> >+	unsigned long elf_headers_sz;
> >  };
> >  extern const struct kexec_file_ops kexec_image_ops;
> >diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> >index 29a9428486a5..af9987c154ca 100644
> >--- a/arch/arm64/kernel/kexec_image.c
> >+++ b/arch/arm64/kernel/kexec_image.c
> >@@ -47,10 +47,6 @@ static void *image_load(struct kimage *image,
> >  	struct kexec_segment *kernel_segment;
> >  	int ret;
> >-	/* We don't support crash kernels yet. */
> >-	if (image->type == KEXEC_TYPE_CRASH)
> >-		return ERR_PTR(-EOPNOTSUPP);
> >-
> >  	/*
> >  	 * We require a kernel with an unambiguous Image header. Per
> >  	 * Documentation/arm64/booting.rst, this is the case when image_size
> >diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> >index 7b08bf9499b6..f1d1bb895fd2 100644
> >--- a/arch/arm64/kernel/machine_kexec_file.c
> >+++ b/arch/arm64/kernel/machine_kexec_file.c
> >@@ -17,12 +17,15 @@
> >  #include <linux/memblock.h>
> >  #include <linux/of_fdt.h>
> >  #include <linux/random.h>
> >+#include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> >  #include <linux/vmalloc.h>
> >  #include <asm/byteorder.h>
> >  /* relevant device tree properties */
> >+#define FDT_PROP_KEXEC_ELFHDR	"linux,elfcorehdr"
> >+#define FDT_PROP_MEM_RANGE	"linux,usable-memory-range"
> >  #define FDT_PROP_INITRD_START	"linux,initrd-start"
> >  #define FDT_PROP_INITRD_END	"linux,initrd-end"
> >  #define FDT_PROP_BOOTARGS	"bootargs"
> >@@ -40,6 +43,10 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
> >  	vfree(image->arch.dtb);
> >  	image->arch.dtb = NULL;
> >+	vfree(image->arch.elf_headers);
> >+	image->arch.elf_headers = NULL;
> >+	image->arch.elf_headers_sz = 0;
> >+
> >  	return kexec_image_post_load_cleanup_default(image);
> >  }
> >@@ -55,6 +62,31 @@ static int setup_dtb(struct kimage *image,
> >  	off = ret;
> >+	ret = fdt_delprop(dtb, off, FDT_PROP_KEXEC_ELFHDR);
> >+	if (ret && ret != -FDT_ERR_NOTFOUND)
> >+		goto out;
> >+	ret = fdt_delprop(dtb, off, FDT_PROP_MEM_RANGE);
> >+	if (ret && ret != -FDT_ERR_NOTFOUND)
> >+		goto out;
> >+
> >+	if (image->type == KEXEC_TYPE_CRASH) {
> >+		/* add linux,elfcorehdr */
> >+		ret = fdt_appendprop_addrrange(dtb, 0, off,
> >+				FDT_PROP_KEXEC_ELFHDR,
> >+				image->arch.elf_headers_mem,
> >+				image->arch.elf_headers_sz);
> >+		if (ret)
> >+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> >+
> >+		/* add linux,usable-memory-range */
> >+		ret = fdt_appendprop_addrrange(dtb, 0, off,
> >+				FDT_PROP_MEM_RANGE,
> >+				crashk_res.start,
> >+				crashk_res.end - crashk_res.start + 1);
> >+		if (ret)
> >+			return (ret == -FDT_ERR_NOSPACE ? -ENOMEM : -EINVAL);
> >+	}
> >+
> >  	/* add bootargs */
> >  	if (cmdline) {
> >  		ret = fdt_setprop_string(dtb, off, FDT_PROP_BOOTARGS, cmdline);
> >@@ -125,8 +157,8 @@ static int setup_dtb(struct kimage *image,
> >  }
> >  /*
> >- * More space needed so that we can add initrd, bootargs, kaslr-seed, and
> >- * rng-seed.
> >+ * More space needed so that we can add initrd, bootargs, kaslr-seed,
> >+ * rng-seed, userable-memory-range and elfcorehdr.
> 
> nitpick:
> s/userable-memory-range/usable-memory-range
> 
> >   */
> >  #define DTB_EXTRA_SPACE 0x1000
> >@@ -174,6 +206,43 @@ static int create_dtb(struct kimage *image,
> >  	}
> >  }
> >+static int prepare_elf_headers(void **addr, unsigned long *sz)
> >+{
> >+	struct crash_mem *cmem;
> >+	unsigned int nr_ranges;
> >+	int ret;
> >+	u64 i;
> >+	phys_addr_t start, end;
> >+
> >+	nr_ranges = 1; /* for exclusion of crashkernel region */
> >+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> >+					MEMBLOCK_NONE, &start, &end, NULL)
> >+		nr_ranges++;
> >+
> >+	cmem = kmalloc(sizeof(struct crash_mem) +
> >+			sizeof(struct crash_mem_range) * nr_ranges, GFP_KERNEL);
> >+	if (!cmem)
> >+		return -ENOMEM;
> >+
> >+	cmem->max_nr_ranges = nr_ranges;
> >+	cmem->nr_ranges = 0;
> >+	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> >+					MEMBLOCK_NONE, &start, &end, NULL) {
> >+		cmem->ranges[cmem->nr_ranges].start = start;
> >+		cmem->ranges[cmem->nr_ranges].end = end - 1;
> >+		cmem->nr_ranges++;
> >+	}
> >+
> >+	/* Exclude crashkernel region */
> >+	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
> >+
> >+	if (!ret)
> >+		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
> >+
> >+	kfree(cmem);
> >+	return ret;
> >+}
> >+
> >  int load_other_segments(struct kimage *image,
> >  			unsigned long kernel_load_addr,
> >  			unsigned long kernel_size,
> >@@ -181,14 +250,43 @@ int load_other_segments(struct kimage *image,
> >  			char *cmdline)
> >  {
> >  	struct kexec_buf kbuf;
> >-	void *dtb = NULL;
> >-	unsigned long initrd_load_addr = 0, dtb_len;
> >+	void *headers, *dtb = NULL;
> >+	unsigned long headers_sz, initrd_load_addr = 0, dtb_len;
> >  	int ret = 0;
> >  	kbuf.image = image;
> >  	/* not allocate anything below the kernel */
> >  	kbuf.buf_min = kernel_load_addr + kernel_size;
> >+	/* load elf core header */
> >+	if (image->type == KEXEC_TYPE_CRASH) {
> >+		ret = prepare_elf_headers(&headers, &headers_sz);
> >+		if (ret) {
> >+			pr_err("Preparing elf core header failed\n");
> >+			goto out_err;
> >+		}
> >+
> >+		kbuf.buffer = headers;
> >+		kbuf.bufsz = headers_sz;
> >+		kbuf.mem = 0;
> 
> With commit c19d050f8088 ("arm64/kexec: Use consistent convention of
> initializing 'kxec_buf.mem' with KEXEC_BUF_MEM_UNKNOWN"), we are trying to
> standardize the way of setting up initial value of 'kbuf.mem'. So we can use
> the following notion (in v3?) instead:
> 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> 
> >+		kbuf.memsz = headers_sz;
> >+		kbuf.buf_align = SZ_64K; /* largest supported page size */
> >+		kbuf.buf_max = ULONG_MAX;
> >+		kbuf.top_down = true;
> >+
> >+		ret = kexec_add_buffer(&kbuf);
> >+		if (ret) {
> >+			vfree(headers);
> >+			goto out_err;
> >+		}
> >+		image->arch.elf_headers = headers;
> >+		image->arch.elf_headers_mem = kbuf.mem;
> >+		image->arch.elf_headers_sz = headers_sz;
> >+
> >+		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> >+			 image->arch.elf_headers_mem, headers_sz, headers_sz);
> >+	}
> >+
> >  	/* load initrd */
> >  	if (initrd) {
> >  		kbuf.buffer = initrd;
> >
> 
> Thanks,
> Bhupesh
> 

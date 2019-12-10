Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172D8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31A820726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="L9kgcXtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfLJDHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:07:46 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38879 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfLJDHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:07:45 -0500
Received: by mail-pj1-f67.google.com with SMTP id l4so6765290pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 19:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+l3sjBeSVFh4rm+tGcPw6py430z3WdKBO1qe4zUPUJM=;
        b=L9kgcXtVkKdXP1vvTGOzo7P0KBeZ5Ho+sktp5bes1PmRFaarhpuFQC6ryBLDaG8rhW
         g/u6qPASdc0JFsr7N/ydqCd26rqm8sstrqSsR/1+8RzBOiyelM7UIldOhstJoxfgv7Dj
         J02kSA+0VIgJWS4YyPBiivIfcpHsxaTq/+dUhGQkoNbawZhnCYO7cPKF28xzYMRUtLS0
         tWsSuzJ8xwPfZZGvpo7uW8rb/h64z43lSUJ2H+JpPP5OlHvsx+uXuQBz8DnIC7B7K3Hr
         khVmnIU2qQXXC+HwqeIBCAHf7PjYqlDj3UbOBjff4j4QxDaHOOU7aFggLCoyJ3cMHSbO
         IPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+l3sjBeSVFh4rm+tGcPw6py430z3WdKBO1qe4zUPUJM=;
        b=iwt3XcwOmcN8/Nxhal/dlCf3avMZkNV9KdeWcmr8YUFfC8Ucpb/ri2UtSBJA8br/zB
         2xfbjVXEZQaaDu4RwLKi3aqCsuNsNIvftCOfQnCSW4O4rIYWAfB07YbzmWI9J6YEViXt
         cHyrtHdz4if1v0y0MsBk6qkLmdf3pvlorWmsWXpP3602rAZ38PscjaoxjsPEPnRVlqYv
         8eigxJ32KjItccc9vTXsgbdieopLKp5JOMgoyHt0SoDZ/luBggXjtNmLlTHf9V0g+DHx
         maekoNSOKUzQHjM9UMyerJNEA1C3poHDJRa23vDIcD0iS0ae1HsoS1jdVQMAkrV5xzsy
         SuEQ==
X-Gm-Message-State: APjAAAUNshZmhSiiqvO1C/HLbld+3/nEmJTLBU4E061m9chJwRhABy47
        Rez1peNENXcTSx/021wpv0+/yg==
X-Google-Smtp-Source: APXvYqzXTagyiiv8vyJOWr5RUs3+9ax/mNC9SzhDflplwNKGo8jCd7Zqv0+UDaRvkP/qJ5BRvQ8pWg==
X-Received: by 2002:a17:902:b212:: with SMTP id t18mr8772198plr.333.1575947265045;
        Mon, 09 Dec 2019 19:07:45 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id o31sm888119pgb.56.2019.12.09.19.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 19:07:43 -0800 (PST)
Subject: Re: [PATCH v5 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page
 with the hypervisor.
To:     Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        david@gibson.dropbear.id.au, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, hch@lst.de, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        cai@lca.pw, tglx@linutronix.de, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org, leonardo@linux.ibm.com
References: <1575681159-30356-1-git-send-email-linuxram@us.ibm.com>
 <1575681159-30356-2-git-send-email-linuxram@us.ibm.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <ed0f048c-bb40-c6c6-887c-ef68c9e411a2@ozlabs.ru>
Date:   Tue, 10 Dec 2019 14:07:36 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1575681159-30356-2-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/12/2019 12:12, Ram Pai wrote:
> H_PUT_TCE_INDIRECT hcall uses a page filled with TCE entries, as one of
> its parameters.  On secure VMs, hypervisor cannot access the contents of
> this page since it gets encrypted.  Hence share the page with the
> hypervisor, and unshare when done.


I thought the idea was to use H_PUT_TCE and avoid sharing any extra
pages. There is small problem that when DDW is enabled,
FW_FEATURE_MULTITCE is ignored (easy to fix); I also noticed complains
about the performance on slack but this is caused by initial cleanup of
the default TCE window (which we do not use anyway) and to battle this
we can simply reduce its size by adding

-global
spapr-pci-host-bridge.dma_win_size=0x4000000

to the qemu command line. And the huge DMA window will use 16MB or 1GB
TCEs so even mapping 32GB guests is barely noticeable. What do I miss?


> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/iommu.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 6ba081d..67b5009 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -37,6 +37,7 @@
>  #include <asm/mmzone.h>
>  #include <asm/plpar_wrappers.h>
>  #include <asm/svm.h>
> +#include <asm/ultravisor.h>
>  
>  #include "pseries.h"
>  
> @@ -179,6 +180,18 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  
>  static DEFINE_PER_CPU(__be64 *, tce_page);
>  
> +static void pre_process_tce_page(__be64 *tcep)
> +{
> +	if (tcep && is_secure_guest())
> +		uv_share_page(PHYS_PFN(__pa(tcep)), 1);
> +}
> +
> +static void post_process_tce_page(__be64 *tcep)
> +{
> +	if (tcep && is_secure_guest())
> +		uv_unshare_page(PHYS_PFN(__pa(tcep)), 1);
> +}
> +
>  static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  				     long npages, unsigned long uaddr,
>  				     enum dma_data_direction direction,
> @@ -187,7 +200,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  	u64 rc = 0;
>  	u64 proto_tce;
>  	__be64 *tcep;
> -	u64 rpn;
> +	u64 rpn, tcep0;
>  	long l, limit;
>  	long tcenum_start = tcenum, npages_start = npages;
>  	int ret = 0;
> @@ -216,6 +229,8 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  		__this_cpu_write(tce_page, tcep);
>  	}
>  
> +	pre_process_tce_page(tcep);
> +
>  	rpn = __pa(uaddr) >> TCE_SHIFT;
>  	proto_tce = TCE_PCI_READ;
>  	if (direction != DMA_TO_DEVICE)
> @@ -243,6 +258,14 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  		tcenum += limit;
>  	} while (npages > 0 && !rc);
>  
> +	/*
> +	 * if "tcep" is shared, post_process_tce_page() will unshare the page,
> +	 * which will zero the page. Grab any interesting content, before it
> +	 * disappears.
> +	 */
> +	tcep0 = tcep[0];
> +	post_process_tce_page(tcep);
> +
>  	local_irq_restore(flags);
>  
>  	if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
> @@ -256,7 +279,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>  		printk("tce_buildmulti_pSeriesLP: plpar_tce_put failed. rc=%lld\n", rc);
>  		printk("\tindex   = 0x%llx\n", (u64)tbl->it_index);
>  		printk("\tnpages  = 0x%llx\n", (u64)npages);
> -		printk("\ttce[0] val = 0x%llx\n", tcep[0]);
> +		printk("\ttce[0] val = 0x%llx\n", tcep0);
>  		dump_stack();
>  	}
>  	return ret;
> @@ -280,7 +303,6 @@ static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages
>  	}
>  }
>  
> -
>  static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages)
>  {
>  	u64 rc;
> @@ -413,6 +435,8 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
>  		__this_cpu_write(tce_page, tcep);
>  	}
>  
> +	pre_process_tce_page(tcep);
> +
>  	proto_tce = TCE_PCI_READ | TCE_PCI_WRITE;
>  
>  	liobn = (u64)be32_to_cpu(maprange->liobn);
> @@ -451,6 +475,8 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
>  		num_tce -= limit;
>  	} while (num_tce > 0 && !rc);
>  
> +	post_process_tce_page(tcep);
> +
>  	/* error cleanup: caller will clear whole range */
>  
>  	local_irq_enable();
> 

-- 
Alexey

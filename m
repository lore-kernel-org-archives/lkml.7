Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBABCC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A12208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GdNRwja+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbfG3PBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:01:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42678 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbfG3PBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:01:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id v15so62888331eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bQWucyIKvCKeKopDX4ZksHy14UtOcimGNYOu7selEmU=;
        b=GdNRwja+/25H4SxUZ4ralc99QLXtPYO2kj4H0jLiarKQZUn/l8l1B/z2ZXWZRqNuZz
         Bo97G25Ewtp9jrs7GZbl+3mcVqn/Z6kURcIxMGDgvQxtCGAakJaf/QdyTAVoApyqsPCi
         +KeelUNoacnfmu1MSDGt1BE4PkOnW93teyfZjh0bIJ++GsJrR+OqNatermEhdUGCzqvs
         MR5irSWphHO6klpLr30FcWHLDfGZR65mQYzA7D2nmY0kJui2TgthhRjXVcKuBE9X5ooQ
         Y2u+Fy9LUIhK3lJN/lDzNl8X1ZwlZ5ztF/YApdnpbYcs7UzifwAgUuDC5YHTQ6AJ8kA+
         CLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bQWucyIKvCKeKopDX4ZksHy14UtOcimGNYOu7selEmU=;
        b=HDwqnO5Dva6Xd8r6J1oHb0MroJqVBUOSwxqZYyJAZWFfEYqe+pmdWbkwC0yBV0Npo0
         EP/CMJg02uExtBFyAr75H7Kbanv2ZJaeaH4X2X5JFiIc7pCYCrR8NjReSLmw47UNSFKx
         IymCdLs6wvyrS3ZasLuoqIvY595XKWf+VnnHAitYPkOJr6XBHwJRLVu8hLwJGBWaJKkO
         ZYKW9PmZOuHMXS2p5TrVy78YS2JX3JJU5/WUk/dWxkGLK+Ws/04TibTcHpZxsbXIh1Jy
         FLJz2RxjQ0l2u8w+VcbLgrCrneEz1UtRzluy0oMCRYpyiShKorteHmBWhaEBYnvs3+zf
         0QBQ==
X-Gm-Message-State: APjAAAVGxDlAU1SrvYg0bWimHDMbte7OgEc/+LJ4WSgrKB1VInus7kpL
        9CDB5A+NN2unyYu2PGSzN/A=
X-Google-Smtp-Source: APXvYqyL2odYUrW+8WuVCn0Ui36foqk2fFzmQK1cuc8eMBoSNxrRogxxj3ymkZEHr7GpPbiBvSWG9w==
X-Received: by 2002:a50:9107:: with SMTP id e7mr102905767eda.280.1564498870080;
        Tue, 30 Jul 2019 08:01:10 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 34sm16475720eds.5.2019.07.30.08.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 08:01:09 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BB4A2100AD0; Tue, 30 Jul 2019 18:01:10 +0300 (+03)
Date:   Tue, 30 Jul 2019 18:01:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, oleg@redhat.com,
        kernel-team@fb.com, william.kucharski@oracle.com,
        srikar@linux.vnet.ibm.com
Subject: Re: [PATCH 2/2] uprobe: collapse THP pmd after removing all uprobes
Message-ID: <20190730150110.yqib7bawsude2vqt@box>
References: <20190729054335.3241150-1-songliubraving@fb.com>
 <20190729054335.3241150-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729054335.3241150-3-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 10:43:35PM -0700, Song Liu wrote:
> After all uprobes are removed from the huge page (with PTE pgtable), it
> is possible to collapse the pmd and benefit from THP again. This patch
> does the collapse by calling khugepaged_add_pte_mapped_thp().
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  kernel/events/uprobes.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 58ab7fc7272a..cc53789fefc6 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -26,6 +26,7 @@
>  #include <linux/percpu-rwsem.h>
>  #include <linux/task_work.h>
>  #include <linux/shmem_fs.h>
> +#include <linux/khugepaged.h>
>  
>  #include <linux/uprobes.h>
>  
> @@ -470,6 +471,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  	struct page *old_page, *new_page;
>  	struct vm_area_struct *vma;
>  	int ret, is_register, ref_ctr_updated = 0;
> +	bool orig_page_huge = false;
>  
>  	is_register = is_swbp_insn(&opcode);
>  	uprobe = container_of(auprobe, struct uprobe, arch);
> @@ -525,6 +527,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  
>  				/* dec_mm_counter for old_page */
>  				dec_mm_counter(mm, MM_ANONPAGES);
> +
> +				if (PageCompound(orig_page))
> +					orig_page_huge = true;
>  			}
>  			put_page(orig_page);
>  		}
> @@ -543,6 +548,10 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  	if (ret && is_register && ref_ctr_updated)
>  		update_ref_ctr(uprobe, mm, -1);
>  
> +	/* try collapse pmd for compound page */
> +	if (!ret && orig_page_huge)
> +		khugepaged_add_pte_mapped_thp(mm, vaddr & HPAGE_PMD_MASK);
> +

IIUC, here you have all locks taken, so you should be able to call
collapse_pte_mapped_thp() directly, shouldn't you?

-- 
 Kirill A. Shutemov

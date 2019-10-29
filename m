Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C1ECA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8560521721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SJIoiuNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfJ2XPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 19:15:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33030 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfJ2XPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:15:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id y39so666196qty.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 16:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NE+Zw6qIAG29XcaEKiuhY2kMU0NwzIi72kMG/yxdslg=;
        b=SJIoiuNaEAHAPdZ1smUdlWpJaRFtJGmuzbGhtDcbpGsiqov181s4IdA6eE5Og4i/py
         F5UVdCHZX7fOdC40THhJagjcQmKuA95T4ZQjaoIVef3hOYLcqNguTTMq2u3Xl/tH2tha
         br1IH75nuO9MYbjiJoYOaySu9UDDgyrIdOKBoQSJ+1B6bdF9eUGeb+TUUVfKYtOCqbMV
         Th2bw8tyrSs8Ip3pPN/D1EvNjvglz1QJx9abISgSIrv0wIU7TU6pG7XSaA3qOhTUh99N
         VK/9UBMCEy5GPkMYqq2EVAoJs5FQAlmS7L7tko+HrTEWC7CbSDc1Wkf7zykv5wys3p+x
         1+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NE+Zw6qIAG29XcaEKiuhY2kMU0NwzIi72kMG/yxdslg=;
        b=XQa72Yc3Y+7Z74hyFCT6BS2nm00pgdySXDOBiN836Nmy7XVHtaW6+Dt0VoCF976KJQ
         0V+UdwXiRrQdrRfXElReQbyKirepLkWB9Uyw1T4metK+Tz75H1n/D0K7EXJHKFDWmyWV
         J4+umys/25LLN1ThmJtUFZKP+nb8GSqPFO784juTBp/sYuv0UWd5e4oNk/Ar0pMTmzce
         fdjk4LJKveNfzGT8givI9cUc5IjcnUuCdXSG9u8n4RN3Ass/qFd0rSJjzQ5Vy58W6RGY
         ZsHwgm9ghXMY7ThVt6RhlYNtBBJ6cUDVdVFK2TFNeD45Q5hzI1g5ShkYdx8WJYd1QVKY
         MDrQ==
X-Gm-Message-State: APjAAAXv3nqQvLJirXp+0e6IbtLsw/DWaZdQhidH9LtbpV6rr0XFT5++
        Z0BgL55qR7ALSlXcBh7n1D6fwA==
X-Google-Smtp-Source: APXvYqyF6aACoObUpIYXhHuAaQcUgrBz2ghQqWz8+b/1UEcpT5willkQxV4mnSpXOzUzECoezZcAcw==
X-Received: by 2002:ac8:5514:: with SMTP id j20mr1980574qtq.241.1572390920822;
        Tue, 29 Oct 2019 16:15:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id a5sm64362qtp.81.2019.10.29.16.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 16:15:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPahr-0001nQ-O4; Tue, 29 Oct 2019 20:15:19 -0300
Date:   Tue, 29 Oct 2019 20:15:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org
Subject: Re: khugepaged might_sleep() warn due to CONFIG_HIGHPTE=y
Message-ID: <20191029231519.GJ6128@ziepe.ca>
References: <20191029201513.GG1208@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029201513.GG1208@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 10:15:13PM +0200, Ville Syrjälä wrote:
> Hi,
> 
> I got some khugepaged spew on a 32bit x86:
> 
> [  217.490026] BUG: sleeping function called from invalid context at include/linux/mmu_notifier.h:346
> [  217.492826] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 25, name: khugepaged
> [  217.495589] INFO: lockdep is turned off.
> [  217.498371] CPU: 1 PID: 25 Comm: khugepaged Not tainted 5.4.0-rc5-elk+ #206
> [  217.501233] Hardware name: System manufacturer P5Q-EM/P5Q-EM, BIOS 2203    07/08/2009
> [  217.501697] Call Trace:
> [  217.501697]  dump_stack+0x66/0x8e
> [  217.501697]  ___might_sleep.cold.96+0x95/0xa6
> [  217.501697]  __might_sleep+0x2e/0x80
> [  217.501697]  collapse_huge_page.isra.51+0x5ac/0x1360
> [  217.501697]  ? __alloc_pages_nodemask+0xec/0xf80
> [  217.501697]  ? __alloc_pages_nodemask+0x191/0xf80
> [  217.501697]  ? trace_hardirqs_on+0x4a/0xf0
> [  217.501697]  khugepaged+0x9a9/0x20f0
> [  217.501697]  ? _raw_spin_unlock+0x21/0x30
> [  217.501697]  ? trace_hardirqs_on+0x4a/0xf0
> [  217.501697]  ? wait_woken+0xa0/0xa0
> [  217.501697]  kthread+0xf5/0x110
> [  217.501697]  ? collapse_pte_mapped_thp+0x3b0/0x3b0
> [  217.501697]  ? kthread_create_worker_on_cpu+0x20/0x20
> [  217.501697]  ret_from_fork+0x2e/0x38
> 
> Looks like it's due to CONFIG_HIGHPTE=y pte_offset_map()->kmap_atomic() vs.
> mmu_notifier_invalidate_range_start().
> 
> My naive idea would be to just reorder those things, but not sure
> if there's some magic ordering constraint here. At least the machine
> still boots when I do it :)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 0a1b4b484ac5..f05d27b7183d 100644
> +++ b/mm/khugepaged.c
> @@ -1028,12 +1028,13 @@ static void collapse_huge_page(struct mm_struct *mm,
>  
>  	anon_vma_lock_write(vma->anon_vma);
>  
> -	pte = pte_offset_map(pmd, address);
> -	pte_ptl = pte_lockptr(mm, pmd);
> -
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
>  				address, address + HPAGE_PMD_SIZE);
>  	mmu_notifier_invalidate_range_start(&range);
> +
> +	pte = pte_offset_map(pmd, address);
> +	pte_ptl = pte_lockptr(mm, pmd);
> +

Since pte and pte_ptl don't leak into invalidate_range_start this
seems reasonable to me..

Good catch with the new debugging!

Jason

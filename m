Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B9BC2D0C1
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 02:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC36F2173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 02:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="L4n3r/SK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfLGCQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 21:16:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38890 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLGCQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 21:16:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id o8so3481845pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 18:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=RvSWSXXOJHTsbagyrlqXQzUh6ihQzraXoeMeWUbMh9I=;
        b=L4n3r/SKDbirhlxphXZ3Qlvdqppwt0kQHNEDpFm9YigZHlC7xxTSFkbUQabywTx6kZ
         cJoPh+w8NtyX8nVl6j1S7oV7jhsR5mWdPAhY/XG5r9KxtE63XfcsoUUS1ZXDfRkvvRvK
         /4bzIkaUN7ixuWBg0YE8VlGaUB6+6BGSuwttA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RvSWSXXOJHTsbagyrlqXQzUh6ihQzraXoeMeWUbMh9I=;
        b=R52BFEMVyN3VpctcjxdaOK9SnGe3E4r+yqcEhnds96KVwI5Nefo9EM5WVD9YMpHsfG
         sMd85iuc2GbZM3vDO9zx3Z4KYoPP7Ili5iBsem3O/vexndoPVoTPUVlME8AEDXMt0bF6
         EiU+iELeSJx8Qj/srVYWCIkGc8n/IpOh4laIETdSZv1T9vnFDwh3VEOfUMJ8WqRCAsiB
         O6Rc6TiRtzrUBzFiS/bSwOjiQ2a6HtL0gmlfU6X1s/svMSJ9TYkJg6mrhmxK6FcUWm1v
         zjSxFFyUgO30bn3aq591IN83SkqK3JRCVJcGaDHWj+Ag4eSSYW5CKFS4fVOv555oWbve
         /A9Q==
X-Gm-Message-State: APjAAAUOaMWESDqDG1A0fNPnSL6KYJzsyVnzTI0OVYOHJ363Eapy8voR
        fnKn8ZYm+nECHEZUV+1yk7X/DQ==
X-Google-Smtp-Source: APXvYqzk7AcyhY9I486phyYFPGuUIWDZIdCoQq62Jt7NSsGDj53Z5nIQbPLR9OmJdVqQemtCoAbKfw==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr4588859plz.295.1575684967444;
        Fri, 06 Dec 2019 18:16:07 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-ac4e-75f4-122e-fbe0.static.ipv6.internode.on.net. [2001:44b8:1113:6700:ac4e:75f4:122e:fbe0])
        by smtp.gmail.com with ESMTPSA id r68sm18641871pfr.78.2019.12.06.18.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 18:16:06 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        aryabinin@virtuozzo.com, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        daniel@iogearbox.net, cai@lca.pw
Subject: Re: [PATCH 1/3] mm: add apply_to_existing_pages helper
In-Reply-To: <20191206163853.cdeb5dc80a8622fb6323a8d2@linux-foundation.org>
References: <20191205140407.1874-1-dja@axtens.net> <20191206163853.cdeb5dc80a8622fb6323a8d2@linux-foundation.org>
Date:   Sat, 07 Dec 2019 13:16:02 +1100
Message-ID: <87r21gdgnx.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Wouldn't apply_to_existing_page_range() be a better name?

I agree with both of those fixups, thanks!

Regards,
Daniel

>
> --- a/include/linux/mm.h~mm-add-apply_to_existing_pages-helper-fix-fix
> +++ a/include/linux/mm.h
> @@ -2621,9 +2621,9 @@ static inline int vm_fault_to_errno(vm_f
>  typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
>  extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
>  			       unsigned long size, pte_fn_t fn, void *data);
> -extern int apply_to_existing_pages(struct mm_struct *mm, unsigned long address,
> -				   unsigned long size, pte_fn_t fn,
> -				   void *data);
> +extern int apply_to_existing_page_range(struct mm_struct *mm,
> +				   unsigned long address, unsigned long size,
> +				   pte_fn_t fn, void *data);
>  
>  #ifdef CONFIG_PAGE_POISONING
>  extern bool page_poisoning_enabled(void);
> --- a/mm/memory.c~mm-add-apply_to_existing_pages-helper-fix-fix
> +++ a/mm/memory.c
> @@ -2184,12 +2184,12 @@ EXPORT_SYMBOL_GPL(apply_to_page_range);
>   * Unlike apply_to_page_range, this does _not_ fill in page tables
>   * where they are absent.
>   */
> -int apply_to_existing_pages(struct mm_struct *mm, unsigned long addr,
> -			    unsigned long size, pte_fn_t fn, void *data)
> +int apply_to_existing_page_range(struct mm_struct *mm, unsigned long addr,
> +				 unsigned long size, pte_fn_t fn, void *data)
>  {
>  	return __apply_to_page_range(mm, addr, size, fn, data, false);
>  }
> -EXPORT_SYMBOL_GPL(apply_to_existing_pages);
> +EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
>  
>  /*
>   * handle_pte_fault chooses page fault handler according to an entry which was
> _

Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453C0C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF4521537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aWygfjPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfFUOFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:05:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43016 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfFUOFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:05:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so6972867qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DkOzjPryuxAAZ6jj5aW+vqBCJ/xdXKjWwEy6q7BhjEk=;
        b=aWygfjPxOlEI1tnMPH+ZEg4lwdm35MlZ9FC2Sv9mNYz1TXYg7zMy65oynguhqHPLHD
         5poTOWoehn2uMjooUllCl96WCJBItvfeaEybY0ihx7Fxw7kb42coN1wbRqEsylbfnfz5
         poQ9cLzRruP/gaTS5r2ivimvPxFxF10jIh6a1t8bY1c5/8nfCSLTPHFwmVvqBcrvoeSR
         IrRjd3ExmNKIoqdYb4sME5daBw+7RTgROqdSMT/mhe4d+vGey9AkE/rEcyeRljT6dNfy
         FwbLskfpDrkSyt1xncxh/ARyaZyhUUMnPNBaOl1L9cqI8FBxyq6cZOpH+4o3AamW6xDj
         GPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DkOzjPryuxAAZ6jj5aW+vqBCJ/xdXKjWwEy6q7BhjEk=;
        b=kkuc/yWWBR+4/YNp5/qvcf1hSdbOVQZ+XM6VhwemqRaaP1Ma9XkcL8x2MN3i0T92jq
         73yfffv6ZoMPVcs7BrbRZKfkJ7MaMQ4o89SbDKs6Ab588E6jFvl0aSrZAr3p4t5nQx33
         0J9IeFltIef7VymPyPqVfWC0B6wP17UlmrZ70P91ROPXht8msbIXpgXAp3uy4TakXz57
         OUsX/02nMa53LNjs/68XzFK+mUqgHAigLm9VvFzI83EKIKAKzUVneNgFpnH8EZu7RBxV
         xhRK6dgdEk11Ucte7KzSjf938Kw8EvGOTyIKGjtsBdqDtrW196Cd9Toaz4HaEI9EfEeo
         8BmQ==
X-Gm-Message-State: APjAAAUBM8douQp8+zsNbfG/lr3UNLXFoUuUJs5xTFwP62LpQDKUVW42
        H+VWtAsIEMm+jnF+ODwARsWI0Q==
X-Google-Smtp-Source: APXvYqzN1Bctip/8rcU9u7A4vdGN+f0/Jibs65Z8bT+DlW7GOUgigVYUV0gNRYHBistcmEEvwVki5g==
X-Received: by 2002:a0c:d610:: with SMTP id c16mr45427150qvj.22.1561125943463;
        Fri, 21 Jun 2019 07:05:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i17sm1269594qkl.71.2019.06.21.07.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 07:05:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1heKAg-0000Jr-7W; Fri, 21 Jun 2019 11:05:42 -0300
Date:   Fri, 21 Jun 2019 11:05:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>, Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/16] MIPS: use the generic get_user_pages_fast code
Message-ID: <20190621140542.GO19891@ziepe.ca>
References: <20190611144102.8848-1-hch@lst.de>
 <20190611144102.8848-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611144102.8848-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:40:50PM +0200, Christoph Hellwig wrote:
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index 4ccb465ef3f2..7d27194e3b45 100644
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -20,6 +20,7 @@
>  #include <asm/cmpxchg.h>
>  #include <asm/io.h>
>  #include <asm/pgtable-bits.h>
> +#include <asm/cpu-features.h>
>  
>  struct mm_struct;
>  struct vm_area_struct;
> @@ -626,6 +627,8 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>  
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> +#define gup_fast_permitted(start, end)	(!cpu_has_dc_aliases)
> +

Today this check is only being done on the get_user_pages_fast() -
after this patch it is also done for __get_user_pages_fast().

Which means __get_user_pages_fast is now non-functional on a range of
MIPS CPUs, but that seems OK as far as I can tell, so:

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

However, looks to me like this patch is also a bug fix for this:

commit 5b167c123b3c3582f62cf1896465019bc40fe526
Author: Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Fri Jun 14 17:10:03 2013 +0000

    MIPS: Fix get_user_page_fast() for mips with cache alias
    
    get_user_pages_fast() is missing cache flushes for MIPS platforms with
    cache aliases.  Filesystem failures observed with DirectIO operations due
    to missing flush_anon_page() that use page coloring logic to work with
    cache aliases. This fix falls through to take slow_irqon path that calls
    get_user_pages() that has required logic for platforms where
    cpu_has_dc_aliases is true.

> -	pgdp = pgd_offset(mm, addr);
> -	do {
> -		pgd_t pgd = *pgdp;
> -
> -		next = pgd_addr_end(addr, end);
> -		if (pgd_none(pgd))
> -			goto slow;
> -		if (!gup_pud_range(pgd, addr, next, gup_flags & FOLL_WRITE,
> -				   pages, &nr))

This is different too, the core code has a p4d layer, but I see that
whole thing gets NOP'd by the compiler as mips uses pgtable-nop4d.h -
right?

Jason

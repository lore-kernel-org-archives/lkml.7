Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE78CA9EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DB221A4A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chLu7Rkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404648AbfJWT2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 15:28:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45202 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403801AbfJWT2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 15:28:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so12701511pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 12:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QJMKuPm1ZdNgJTUIJxAw1L1Yjlm4cw9iye5XkWCnBqw=;
        b=chLu7Rkn1anFUB5doiAWbIOsB5CoPrd/wBLbr21Y99KS80dzYjM8j9Ek9g+rYsL5qp
         6qcFXB0lTKb/2AmjhlXeYkKttXT1kZQcKR7P/nHYw76Onm0ATebaDOneFAYlCZG4qSb3
         z3FY2cfGszWRTwj+LMkwicC0G1XMlwL0q2WIkvhUqY7ZX2UWjwK/MfMMy5+EsC3zy9id
         QUvUxedi+MKaZqfMQsJPVr0H90BvN/z2Gmv8poKMx9O3vPADoxNiE8k7oxaYiALWkbxx
         yUEVaxfOo/SNgB/ttmt7RKICNf7OqeYqpTIVsI2DqJbhgW3a2D/vx1/LetB76c55dgkB
         3x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QJMKuPm1ZdNgJTUIJxAw1L1Yjlm4cw9iye5XkWCnBqw=;
        b=d8ezOoi6Kao2DvhTbMUgR0Zp3j2FS3tel0Gn1HDH2phfJ4oAzEt2N4yFqrxuVlWifq
         Z/Pw2To5KUqsPqA+IJn33tVqUnZg3+GVvm+d+t0A9TLKR+bIHvAQzG+OWJNSl50t/AVM
         p6buMWEwlBv80vvJVMRtl/8pzYHtPvHro9zVFNc8uZKaikvMrCrpakLTm3R35T9Tkg6U
         YNsWCOnjlRZ0xyNimvjjpAlED6lpYJBy7MalQffI3P3lnB53vEJUN6SN88z8PXsnhWx2
         ElF9tYyjfEMUUFFnSC4rsH9nQJw9L94Nvzjq1hqJe+IfH8tN8YvNXitl17GXDdIi3JWH
         tcgA==
X-Gm-Message-State: APjAAAU24+Ip/zX0Q4ak3OroXNvOk70Y5p8FeB8b2yD67huymySs2fmF
        eZ3ucMc1eoIr5l0GtYGSFrBDVw==
X-Google-Smtp-Source: APXvYqy4xhI6y0ND4tiBbrpIZjsepQLlOS6my2AixHG/oB4Scrljr+5IA3zv9Qh4hYChNSBHuA2yRg==
X-Received: by 2002:a65:6456:: with SMTP id s22mr11083996pgv.287.1571858918213;
        Wed, 23 Oct 2019 12:28:38 -0700 (PDT)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id dw19sm58444pjb.27.2019.10.23.12.28.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 12:28:37 -0700 (PDT)
Date:   Wed, 23 Oct 2019 12:28:36 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     hughd@google.com, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, gavin.dg@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [v2 PATCH] mm: thp: handle page cache THP correctly in
 PageTransCompoundMap
In-Reply-To: <1571850304-82802-1-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1910231157570.1088@eggly.anvils>
References: <1571850304-82802-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019, Yang Shi wrote:

> We have usecase to use tmpfs as QEMU memory backend and we would like to
> take the advantage of THP as well.  But, our test shows the EPT is not
> PMD mapped even though the underlying THP are PMD mapped on host.
> The number showed by /sys/kernel/debug/kvm/largepage is much less than
> the number of PMD mapped shmem pages as the below:
> 
> 7f2778200000-7f2878200000 rw-s 00000000 00:14 262232 /dev/shm/qemu_back_mem.mem.Hz2hSf (deleted)
> Size:            4194304 kB
> [snip]
> AnonHugePages:         0 kB
> ShmemPmdMapped:   579584 kB
> [snip]
> Locked:                0 kB
> 
> cat /sys/kernel/debug/kvm/largepages
> 12
> 
> And some benchmarks do worse than with anonymous THPs.
> 
> By digging into the code we figured out that commit 127393fbe597 ("mm:
> thp: kvm: fix memory corruption in KVM with THP enabled") checks if
> there is a single PTE mapping on the page for anonymous THP when
> setting up EPT map.  But, the _mapcount < 0 check doesn't fit to page
> cache THP since every subpage of page cache THP would get _mapcount
> inc'ed once it is PMD mapped, so PageTransCompoundMap() always returns
> false for page cache THP.  This would prevent KVM from setting up PMD
> mapped EPT entry.
> 
> So we need handle page cache THP correctly.  However, when page cache
> THP's PMD gets split, kernel just remove the map instead of setting up
> PTE map like what anonymous THP does.  Before KVM calls get_user_pages()
> the subpages may get PTE mapped even though it is still a THP since the
> page cache THP may be mapped by other processes at the mean time.
> 
> Checking its _mapcount and whether the THP has PTE mapped or not.
> Although this may report some false negative cases (PTE mapped by other
> processes), it looks not trivial to make this accurate.
> 
> With this fix /sys/kernel/debug/kvm/largepage would show reasonable
> pages are PMD mapped by EPT as the below:
> 
> 7fbeaee00000-7fbfaee00000 rw-s 00000000 00:14 275464 /dev/shm/qemu_back_mem.mem.SKUvat (deleted)
> Size:            4194304 kB
> [snip]
> AnonHugePages:         0 kB
> ShmemPmdMapped:   557056 kB
> [snip]
> Locked:                0 kB
> 
> cat /sys/kernel/debug/kvm/largepages
> 271
> 
> And the benchmarks are as same as anonymous THPs.
> 

Fixes: dd78fedde4b9 ("rmap: support file thp")

> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Reported-by: Gang Deng <gavin.dg@linux.alibaba.com>
> Tested-by: Gang Deng <gavin.dg@linux.alibaba.com>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: <stable@vger.kernel.org> 4.8+
> ---
> v2: Adopted the suggestion from Hugh to use _mapcount and compound_mapcount.
>     But I just open coding compound_mapcount to avoid duplicating the
>     definition of compound_mapcount_ptr in two different files.  Since
>     "compound_mapcount" looks self-explained so I'm supposed the open
>     coding would not affect the readability.

No, relying on head[1] is not nice: Matthew's suggestion better.

> 
>  include/linux/page-flags.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index f91cb88..954a877 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -622,12 +622,30 @@ static inline int PageTransCompound(struct page *page)
>   *
>   * Unlike PageTransCompound, this is safe to be called only while
>   * split_huge_pmd() cannot run from under us, like if protected by the
> - * MMU notifier, otherwise it may result in page->_mapcount < 0 false
> + * MMU notifier, otherwise it may result in page->_mapcount check false
>   * positives.
> + *
> + * We have to treat page cache THP differently since every subpage of it
> + * would get _mapcount inc'ed once it is PMD mapped.  But, it may be PTE
> + * mapped in the current process so comparing subpage's _mapcount to
> + * compound_mapcount ot filter out PTE mapped case.

s/ ot / to /

>   */
>  static inline int PageTransCompoundMap(struct page *page)
>  {
> -	return PageTransCompound(page) && atomic_read(&page->_mapcount) < 0;
> +	struct page *head;
> +	int map_count;
> +
> +	if (!PageTransCompound(page))
> +		return 0;
> +
> +	if (PageAnon(page))
> +		return atomic_read(&page->_mapcount) < 0;
> +
> +	head = compound_head(page);
> +	map_count = atomic_read(&page->_mapcount);
> +	/* File THP is PMD mapped and not double mapped */

s/ double / PTE /

> +	return map_count >= 0 &&

You have added a map_count >= 0 test there. Okay, not wrong, but not
necessary, and not consistent with what's returned in the PageAnon
case (if this were called for an unmapped page).

But asking for consistency in this function is asking for too much.
It is *very* specialized to the particular places from which it is
called (doesn't really belong in page-flags.h at all), and just so
long as it gives them the right answer most of the time, and errs
on the safe side the rest of the time, it'll do.

(I don't know if it's ever called on a tail page: it would not crash
if it were, but different tail pages may give different answers.)

> +	       map_count == atomic_read(&head[1].compound_mapcount);
>  }
>  
>  /*
> -- 
> 1.8.3.1
> 
> 

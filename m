Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC77C5B576
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123852146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561677915;
	bh=kNW9UJec5ndIC20H3O0Fi4cKff5mPU8oiMT2u9UKNAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pIPz4cSu6oJBZDcmiE4Obzhs9TApTKyF1bRX1mNhQ3fNzbDjK+25fIlX8g+HY6K4o
	 jD9/wAe/xkizIk/U6NZvHtOvroWjf/uIL+Vezh8VPCIcymXw2s92vJbXN0H5kBD9kz
	 sNVNSqPsUEfzaxpzAre2EmBKUuaIqXZq+z+kqs4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfF0XZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfF0XZN (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:25:13 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F5120B7C;
        Thu, 27 Jun 2019 23:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561677912;
        bh=kNW9UJec5ndIC20H3O0Fi4cKff5mPU8oiMT2u9UKNAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vMJvFxPKezf+akCGBbS2o82bRQ7sHszgHAXZOe3/FHVG9GsJ/sIbmXcG2uVbE1HLh
         CNlsy5NMinvlRYEnkynhONCRaUAGWckCTwiZYlA5C2v43HxFd6ruuGrLMZ1f4QOR47
         oGngagpjO/hSp5S+6GDLPxYyDwe5gdN2ByAsgjso=
Date:   Thu, 27 Jun 2019 16:25:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5] mm/gup: speed up check_and_migrate_cma_pages() on
 huge page
Message-Id: <20190627162511.1cf10f5b04538c955c329408@linux-foundation.org>
In-Reply-To: <1561612545-28997-1-git-send-email-kernelfans@gmail.com>
References: <1561612545-28997-1-git-send-email-kernelfans@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 13:15:45 +0800 Pingfan Liu <kernelfans@gmail.com> wrote:

> Both hugetlb and thp locate on the same migration type of pageblock, since
> they are allocated from a free_list[]. Based on this fact, it is enough to
> check on a single subpage to decide the migration type of the whole huge
> page. By this way, it saves (2M/4K - 1) times loop for pmd_huge on x86,
> similar on other archs.
> 
> Furthermore, when executing isolate_huge_page(), it avoid taking global
> hugetlb_lock many times, and meanless remove/add to the local link list
> cma_page_list.
>

Thanks, looks good to me.  Have any timing measurements been taken?
 
> ...
>
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1336,25 +1336,30 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
>  					struct vm_area_struct **vmas,
>  					unsigned int gup_flags)
>  {
> -	long i;
> +	long i, step;

I'll make these variables unsigned long - to match nr_pages and because
we have no need for them to be negative.

> ...

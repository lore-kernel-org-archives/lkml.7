Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF383C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8515920722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfKZI4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:56:54 -0500
Received: from foss.arm.com ([217.140.110.172]:59738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfKZI4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:56:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 937B330E;
        Tue, 26 Nov 2019 00:56:53 -0800 (PST)
Received: from [10.163.1.41] (unknown [10.163.1.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51BA43F52E;
        Tue, 26 Nov 2019 00:59:54 -0800 (PST)
Subject: Re: [PATCH] mm: khugepaged: add trace status description for
 SCAN_PAGE_HAS_PRIVATE
To:     Yang Shi <yang.shi@linux.alibaba.com>, songliubraving@fb.com,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1574706428-36212-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <729623eb-df56-c436-2ca3-8f73772f539c@arm.com>
Date:   Tue, 26 Nov 2019 14:27:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1574706428-36212-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/2019 11:57 PM, Yang Shi wrote:
> The commit 99cb0dbd47a15d395bf3faa78dc122bc5efe3fc0 ("mm,thp: add

Reduce the commit SHA ID here to just 12 digits instead ?

> read-only THP support for (non-shmem) FS") instroduced a new khugepaged

s/instroduced/introduced/

> scan result: SCAN_PAGE_HAS_PRIVATE, but the corresponding description
> for trance events were not added.

s/trance/trace/

> 
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  include/trace/events/huge_memory.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index dd4db33..d49fbce 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -31,7 +31,8 @@
>  	EM( SCAN_ALLOC_HUGE_PAGE_FAIL,	"alloc_huge_page_failed")	\
>  	EM( SCAN_CGROUP_CHARGE_FAIL,	"ccgroup_charge_failed")	\
>  	EM( SCAN_EXCEED_SWAP_PTE,	"exceed_swap_pte")		\
> -	EMe(SCAN_TRUNCATED,		"truncated")			\
> +	EM( SCAN_TRUNCATED,		"truncated")			\
> +	EMe(SCAN_PAGE_HAS_PRIVATE,	"has_private")			\

Majority of the SCAN_PAGE_* scan results have page_ in the front. Hence we
should just follow same pattern here and make it 'page_has_private' instead.

>  
>  #undef EM
>  #undef EMe
> 

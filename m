Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08563ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF93D2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbfJJA1f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:27:35 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:33851 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732421AbfJJA1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:27:35 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9A0RKQN018137
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Oct 2019 09:27:20 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9A0RK5D006401;
        Thu, 10 Oct 2019 09:27:20 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9A0R49V023354;
        Thu, 10 Oct 2019 09:27:20 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-9297955; Thu, 10 Oct 2019 09:26:20 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0439.000; Thu,
 10 Oct 2019 09:26:19 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
Thread-Topic: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
Thread-Index: AQHVfq1QC/9/3IlYuEK91tWnhgAEnKdSbnGA
Date:   Thu, 10 Oct 2019 00:26:19 +0000
Message-ID: <20191010002619.GB3585@hori.linux.bs1.fc.nec.co.jp>
References: <20191009142435.3975-1-david@redhat.com>
 <20191009142435.3975-3-david@redhat.com>
In-Reply-To: <20191009142435.3975-3-david@redhat.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <B381226EDEBF614A8081151E7F7D2CBD@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 04:24:35PM +0200, David Hildenbrand wrote:
> We should check for pfn_to_online_page() to not access uninitialized
> memmaps. Reshuffle the code so we don't have to duplicate the error
> message.
> 
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory-failure.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 7ef849da8278..e866e6e5660b 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1253,17 +1253,19 @@ int memory_failure(unsigned long pfn, int flags)
>  	if (!sysctl_memory_failure_recovery)
>  		panic("Memory failure on page %lx", pfn);
>  
> -	if (!pfn_valid(pfn)) {
> +	p = pfn_to_online_page(pfn);
> +	if (!p) {
> +		if (pfn_valid(pfn)) {
> +			pgmap = get_dev_pagemap(pfn, NULL);
> +			if (pgmap)
> +				return memory_failure_dev_pagemap(pfn, flags,
> +								  pgmap);
> +		}
>  		pr_err("Memory failure: %#lx: memory outside kernel control\n",
>  			pfn);
>  		return -ENXIO;
>  	}
>  
> -	pgmap = get_dev_pagemap(pfn, NULL);
> -	if (pgmap)
> -		return memory_failure_dev_pagemap(pfn, flags, pgmap);
> -
> -	p = pfn_to_page(pfn);

This change seems to assume that memory_failure_dev_pagemap() is never
called for online pages. Is it an intended behavior?
Or the concept "online pages" is not applicable to zone device pages?

Thanks,
Naoya Horiguchi

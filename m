Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFAFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449D92070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfCNJuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:50:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbfCNJuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:50:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4649F30832CB;
        Thu, 14 Mar 2019 09:50:22 +0000 (UTC)
Received: from localhost (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5A2917CEB;
        Thu, 14 Mar 2019 09:50:21 +0000 (UTC)
Date:   Thu, 14 Mar 2019 17:50:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, keescook@chromium.org, kirill@shutemov.name,
        yamada.masahiro@socionext.com, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, x86@kernel.org, thgarnie@google.com
Subject: Re: [PATCH v4 3/6] mm: Add build time sanity check for struct page
 size
Message-ID: <20190314095019.GA12200@MiWiFi-R3L-srv>
References: <20190314094645.4883-1-bhe@redhat.com>
 <20190314094645.4883-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314094645.4883-4-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 14 Mar 2019 09:50:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/19 at 05:46pm, Baoquan He wrote:
> Size of struct page might be larger than 64 bytes if debug options
> enabled, or fields added for debugging intentionally. Yet an upper
> limit need be added at build time to trigger an alert in case the
> size is too big to boot up system, warning people to check if it's
> be done on purpose in advance.
> 
> Here 1/4 of PAGE_SIZE is chosen since system must have been insane
> with this value. For those systems with PAGE_SIZE larger than 4KB,
> 1KB is simply taken.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Sorry, I forgot adding 'Acked-by' tag here.

> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3eb01dedfb50..eddf96c137f2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -67,6 +67,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/nmi.h>
>  #include <linux/psi.h>
> +#include <linux/sizes.h>
>  
>  #include <asm/sections.h>
>  #include <asm/tlbflush.h>
> @@ -7170,6 +7171,7 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
>  	unsigned long start_pfn, end_pfn;
>  	int i, nid;
>  
> +	BUILD_BUG_ON(sizeof(struct page) > min_t(size_t, SZ_1K, PAGE_SIZE/4));
>  	/* Record where the zone boundaries are */
>  	memset(arch_zone_lowest_possible_pfn, 0,
>  				sizeof(arch_zone_lowest_possible_pfn));
> -- 
> 2.17.2
> 

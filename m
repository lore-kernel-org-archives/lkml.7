Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208A4C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92F92067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564606642;
	bh=2YLpoS+5A5mch8La7KxqgPn9U1A/T0ZKT5pVtOtQM0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cxP0F9YVEs05PGAno8jonwEnWaFNXz5ETref3K2d9gnRd1xEO6UJqSutMimTUTs3M
	 ZNyGKop1PJWcvaavQ/zxLCXCToL5tfLznQAkGWJa4Ijg0uhuiJdXCYpSEw6KFGeGlT
	 Kw//K2OoV4YGcSEOTQtsePJCvXjRe7krQHHdEBrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfGaU5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:57:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59504 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfGaU5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:57:19 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BC89239AE;
        Wed, 31 Jul 2019 20:57:17 +0000 (UTC)
Date:   Wed, 31 Jul 2019 13:57:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] drivers/base/memory.c: Don't store end_section_nr in
 memory blocks
Message-Id: <20190731135715.ddb4fccb5c4ee2f14f84a34a@linux-foundation.org>
In-Reply-To: <20190731122213.13392-1-david@redhat.com>
References: <20190731122213.13392-1-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 14:22:13 +0200 David Hildenbrand <david@redhat.com> wrote:

> Each memory block spans the same amount of sections/pages/bytes. The size
> is determined before the first memory block is created. No need to store
> what we can easily calculate - and the calculations even look simpler now.
> 
> While at it, fix the variable naming in register_mem_sect_under_node() -
> we no longer talk about a single section.
> 
> ...
>
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -40,6 +39,8 @@ int arch_get_memory_phys_device(unsigned long start_pfn);
>  unsigned long memory_block_size_bytes(void);
>  int set_memory_block_size_order(unsigned int order);
>  
> +#define PAGES_PER_MEMORY_BLOCK (memory_block_size_bytes() / PAGE_SIZE)

Please let's not hide function calls inside macros which look like
compile-time constants!  Adding "()" to the macro would be a bit
better.  Making it a regular old inline C function would be better
still.  But I'd suggest just open-coding this at the macro's single
callsite.


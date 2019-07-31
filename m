Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BD0C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEB0204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564612079;
	bh=NtM0VJp7ZYW5WXvNFKc6gk7tzLfsfiMl7jjw07fYd6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KsHShdFwt5Vq8loFcKw1GUsvKAO9/VGF1/b9Qe2wVpttGG/rogNnWcCGiRywCRCui
	 ma3gFNKcnOorbS/B23JsbUZauuq4xaQ+0J7m2aYfifvsgQ5ZfrCaPaLL+vtnfx/yN7
	 2FrkHSdUta0PIX06Eova3TbUPqhaIg/nLpt8zg1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfGaW16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:27:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGaW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:27:58 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BBC45416B;
        Wed, 31 Jul 2019 22:27:55 +0000 (UTC)
Date:   Wed, 31 Jul 2019 15:27:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] fork: Improve error message for corrupted page tables
Message-Id: <20190731152753.b17d9c4418f4bf6815a27ad8@linux-foundation.org>
In-Reply-To: <20190730221820.7738-1-sai.praneeth.prakhya@intel.com>
References: <20190730221820.7738-1-sai.praneeth.prakhya@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019 15:18:20 -0700 Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com> wrote:

> When a user process exits, the kernel cleans up the mm_struct of the user
> process and during cleanup, check_mm() checks the page tables of the user
> process for corruption (E.g: unexpected page flags set/cleared). For
> corrupted page tables, the error message printed by check_mm() isn't very
> clear as it prints the loop index instead of page table type (E.g: Resident
> file mapping pages vs Resident shared memory pages). Hence, improve the
> error message so that it's more informative.
> 
> Without patch:
> --------------
> [  204.836425] mm/pgtable-generic.c:29: bad p4d 0000000089eb4e92(800000025f941467)
> [  204.836544] BUG: Bad rss-counter state mm:00000000f75895ea idx:0 val:2
> [  204.836615] BUG: Bad rss-counter state mm:00000000f75895ea idx:1 val:5
> [  204.836685] BUG: non-zero pgtables_bytes on freeing mm: 20480
> 
> With patch:
> -----------
> [   69.815453] mm/pgtable-generic.c:29: bad p4d 0000000084653642(800000025ca37467)
> [   69.815872] BUG: Bad rss-counter state mm:00000000014a6c03 type:MM_FILEPAGES val:2
> [   69.815962] BUG: Bad rss-counter state mm:00000000014a6c03 type:MM_ANONPAGES val:5
> [   69.816050] BUG: non-zero pgtables_bytes on freeing mm: 20480

Seems useful.

> --- a/include/linux/mm_types_task.h
> +++ b/include/linux/mm_types_task.h
> @@ -44,6 +44,13 @@ enum {
>  	NR_MM_COUNTERS
>  };
>  
> +static const char * const resident_page_types[NR_MM_COUNTERS] = {
> +	"MM_FILEPAGES",
> +	"MM_ANONPAGES",
> +	"MM_SWAPENTS",
> +	"MM_SHMEMPAGES",
> +};

But please let's not put this in a header file.  We're asking the
compiler to put a copy of all of this into every compilation unit which
includes the header.  Presumably the compiler is smart enough not to
do that, but it's not good practice.


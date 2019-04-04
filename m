Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D8AC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083262147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l01mpY8c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oFfS295r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfDDHa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:30:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfDDHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:30:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3564E61842; Thu,  4 Apr 2019 07:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554363024;
        bh=eFb1Phc+myeQ/NOdZyTaAoOXqU1b8biNLp0iv1xEqlk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=l01mpY8cjsYywuvRgRhIJMtZPB/VMvN3qIB/PDEelw9EJVJFnAITcbuzcf1dAq+kJ
         ixPsO/c9uZ0snbsA3b6b6Jr7IRR32uez25Ef4DzreJKVWRLfr/H/Zfr+fr03M7AK/z
         Tg7THweAoptDCAY5yeMwBbLtaM4kfoyg5bJpySgI=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 824EA6155D;
        Thu,  4 Apr 2019 07:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554363022;
        bh=eFb1Phc+myeQ/NOdZyTaAoOXqU1b8biNLp0iv1xEqlk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oFfS295r0yoWB2adTX6rQ1sWHIw36Ol/zHYx7jG4Xp6LC5SXDHcWd1VmZEyafo391
         l8mDjb9ZwT23er8QE3dwtb892/5cVnkKX5W03ybycVUQi8S68I2VG+SBvje80InI6E
         uAtCaA1Oz+r1TkjlHzBL01R3U5QnJGnnqpd4pQs0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 824EA6155D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] mm: __pagevec_lru_add_fn: typo fix
To:     Peng Fan <peng.fan@nxp.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "arunks@codeaurora.org" <arunks@codeaurora.org>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "ldr709@gmail.com" <ldr709@gmail.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
References: <20190402095609.27181-1-peng.fan@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <43a2f07f-1b28-cd85-b37c-af730b446d2e@codeaurora.org>
Date:   Thu, 4 Apr 2019 13:00:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402095609.27181-1-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/2019 3:13 PM, Peng Fan wrote:
> There is no function named munlock_vma_pages, correct it to
> munlock_vma_page.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   mm/swap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index 301ed4e04320..3a75722e68a9 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -867,7 +867,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
>   	SetPageLRU(page);
>   	/*
>   	 * Page becomes evictable in two ways:
> -	 * 1) Within LRU lock [munlock_vma_pages() and __munlock_pagevec()].
> +	 * 1) Within LRU lock [munlock_vma_page() and __munlock_pagevec()].
>   	 * 2) Before acquiring LRU lock to put the page to correct LRU and then
>   	 *   a) do PageLRU check with lock [check_move_unevictable_pages]
>   	 *   b) do PageLRU check before lock [clear_page_mlock]

Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29766C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 19:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A662075E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 19:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L+NGhLD2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TngByBcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfC3TlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 15:41:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40150 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbfC3TlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 15:41:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5086160907; Sat, 30 Mar 2019 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553974864;
        bh=0Zmeq/zPBBJ/BI23WiFWIQT+mEnwWFkYQsnZhLRE44g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L+NGhLD2Dd5726JD3532f30BCsAqUeiLWhkQJ21MC0mr2woS+91GcwgzcwrE1GnXf
         ttcjzQoQhG7cmmI2YvbjoGlvxHsVuj4AMfyfrLR/LvTZUN4f6zujZtTaZK9/CiT7up
         WRTV/y79koSo9Oko/j6mdOn99ceC+fmuHh1jgvrc=
Received: from [10.79.169.97] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3637560790;
        Sat, 30 Mar 2019 19:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553974863;
        bh=0Zmeq/zPBBJ/BI23WiFWIQT+mEnwWFkYQsnZhLRE44g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TngByBcyiksxjRvBdfpXA/kSZdygnCRo4NwrFmhZpO6s24xyfDE01KEBsniv5PHgQ
         54B/T2c7KPeLJZgPyecyRl3M4UFVlznYh+8aXAoSsYJ/iJofjg0dTEqKhyAze55hpX
         SaqC/4sd+cxcU2rlu5ejnhpkVFMDLKT3rUuWM4jA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3637560790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] arm64/vdso: don't leak kernel addresses
To:     Matteo Croce <mcroce@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <20190330184638.16219-1-mcroce@redhat.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <03d00567-2efb-a2e9-e771-bf3bf121a8fa@codeaurora.org>
Date:   Sun, 31 Mar 2019 01:10:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330184638.16219-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/31/2019 12:16 AM, Matteo Croce wrote:
> Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
> two obfuscated kernel pointer are printed at every boot:
>
>      vdso: 2 pages (1 code @ (____ptrval____), 1 data @ (____ptrval____))
>
> Remove the addresses from the print, which turns into a more discrete:
>
>      vdso: 2 pages (1 code, 1 data)
>
> Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh


> ---
>   arch/arm64/kernel/vdso.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 2d419006ad43..fdfee0ef5bc5 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -146,8 +146,8 @@ static int __init vdso_init(void)
>   	}
>   
>   	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
> -	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
> -		vdso_pages + 1, vdso_pages, vdso_start, 1L, vdso_data);
> +	pr_info("vdso: %ld pages (%ld code, %ld data)\n",
> +		vdso_pages + 1, vdso_pages, 1L);
>   
>   	/* Allocate the vDSO pagelist, plus a page for the data. */
>   	vdso_pagelist = kcalloc(vdso_pages + 1, sizeof(struct page *),

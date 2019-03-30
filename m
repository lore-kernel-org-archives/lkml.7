Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CFAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C16F217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="COzkJKPR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="COzkJKPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfC3RmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:42:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbfC3RmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:42:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F38A6049C; Sat, 30 Mar 2019 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553967731;
        bh=s9DH1lhnU4At9ElnJVltMNvm3FhOZ1iX/6ORMr+PCSk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=COzkJKPRRahvkG+CPBnlMF4kDrY2Y4Kyj6+54XoscnBqRSYl2KTEzb12RH+cjKlKT
         bk5hWDDMGDL0SrgX+yALaiIVkBh9b5rJEhiVf97Jy63oaFIW+AwTut70fgmkC07O6G
         CUV6BoJIdMrAn4OiU/UXGKDYM4B3MRGJXu26h/GA=
Received: from [10.79.169.97] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52EDA6087D;
        Sat, 30 Mar 2019 17:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553967731;
        bh=s9DH1lhnU4At9ElnJVltMNvm3FhOZ1iX/6ORMr+PCSk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=COzkJKPRRahvkG+CPBnlMF4kDrY2Y4Kyj6+54XoscnBqRSYl2KTEzb12RH+cjKlKT
         bk5hWDDMGDL0SrgX+yALaiIVkBh9b5rJEhiVf97Jy63oaFIW+AwTut70fgmkC07O6G
         CUV6BoJIdMrAn4OiU/UXGKDYM4B3MRGJXu26h/GA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52EDA6087D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] mm: Fix build warning
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190330054248.28357-1-aneesh.kumar@linux.ibm.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <91e4d2ab-db8c-aaa4-efbf-5df337242d08@codeaurora.org>
Date:   Sat, 30 Mar 2019 23:12:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330054248.28357-1-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/2019 11:12 AM, Aneesh Kumar K.V wrote:
> mm/debug.c: In function ‘dump_mm’:
> include/linux/kern_levels.h:5:18: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 19 has type ‘long int’ [-Wformat=]
>                ~~~^
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Does it come even after this patch ?
https://patchwork.kernel.org/patch/10846421/


Thanks.

Mukesh

> ---
>   mm/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/debug.c b/mm/debug.c
> index c0b31b6c3877..c134e76918dc 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -137,7 +137,7 @@ void dump_mm(const struct mm_struct *mm)
>   		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
>   		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
>   		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
> -		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
> +		"pinned_vm %lx data_vm %lx exec_vm %lx stack_vm %lx\n"
>   		"start_code %lx end_code %lx start_data %lx end_data %lx\n"
>   		"start_brk %lx brk %lx start_stack %lx\n"
>   		"arg_start %lx arg_end %lx env_start %lx env_end %lx\n"

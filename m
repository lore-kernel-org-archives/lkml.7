Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AF8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652F42146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 05:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oKW6wLL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfCUFCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 01:02:01 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19767 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfCUFCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 01:02:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c931ac60002>; Wed, 20 Mar 2019 22:01:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Mar 2019 22:02:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Mar 2019 22:02:00 -0700
Received: from [10.2.174.129] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Mar
 2019 05:01:59 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mike.kravetz@oracle.com>, <osalvador@suse.de>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/isolation: Remove redundant pfn_valid_within() in
 __first_valid_page()
Date:   Wed, 20 Mar 2019 22:01:58 -0700
X-Mailer: MailMate (1.12.4r5614)
Message-ID: <8AB57711-48C0-4D95-BC5F-26B266DC3AE8@nvidia.com>
In-Reply-To: <1553141595-26907-1-git-send-email-anshuman.khandual@arm.com>
References: <1553141595-26907-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; format=flowed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553144518; bh=bJW1lfibx460GLs7/4kPxeRLZSQu6jNulRoV/YOOYrA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=oKW6wLL8SIYSOepyx3b14R6kdmqRVehiwOvpA778xqauC1V2upNgcmefC2W+34QbH
         i+bIcTsBWgXQv1xMFMEH7ELZgKIFp+fquUUZwJXceUlnDLM/oQ+o6omrTppooGA1Nm
         rToCW7g/6tA2QJR9r6qVQZZdG9ENSxvbLk3MY9PyMSczD0HL1mWFYAvy5O6OayphOC
         ljEdKmUcXpkAgFyru6rybaIAblEQdoIxe0XGIoSHrNhu0kkxTnUaB5KUdeqgzkwZfs
         0MXwdxeLIe+RIpfL7V7oKT78FbPe8R4PD8THnBnwfBzUS3jY6UX9p76PkmFJM8OuL1
         DFysyh2YbZRjA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Mar 2019, at 21:13, Anshuman Khandual wrote:

> pfn_valid_within() calls pfn_valid() when CONFIG_HOLES_IN_ZONE making 
> it
> redundant for both definitions (w/wo CONFIG_MEMORY_HOTPLUG) of the 
> helper
> pfn_to_online_page() which either calls pfn_valid() or 
> pfn_valid_within().
> pfn_valid_within() being 1 when !CONFIG_HOLES_IN_ZONE is irrelevant 
> either
> way. This does not change functionality.
>
> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")

I would not say this patch fixes the commit 2ce13640b3f4 from 2017,
because the pfn_valid_within() in pfn_to_online_page() was introduced by
a recent commit b13bc35193d9e last month. :)

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  mm/page_isolation.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index ce323e56b34d..d9b02bb13d60 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -150,8 +150,6 @@ __first_valid_page(unsigned long pfn, unsigned 
> long nr_pages)
>  	for (i = 0; i < nr_pages; i++) {
>  		struct page *page;
>
> -		if (!pfn_valid_within(pfn + i))
> -			continue;
>  		page = pfn_to_online_page(pfn + i);
>  		if (!page)
>  			continue;

This makes sense to me. You can add Reviewed-by: Zi Yan 
<ziy@nvidia.com>.

--
Best Regards,
Yan Zi

Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0715DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D1C214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pMSPpt+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfKKXli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:41:38 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15477 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKKXli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:41:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc9f1730000>; Mon, 11 Nov 2019 15:40:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Nov 2019 15:41:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Nov 2019 15:41:37 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Nov
 2019 23:41:37 +0000
Subject: Re: [PATCH] mm/debug:
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20191111224935.19464-1-rcampbell@nvidia.com>
 <20191111150211.9f75292d8c057769603edfb7@linux-foundation.org>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ccbaea6c-40a0-36a1-6dd9-9ab9d24dd904@nvidia.com>
Date:   Mon, 11 Nov 2019 15:41:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191111150211.9f75292d8c057769603edfb7@linux-foundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573515636; bh=AP5bb6JXF94EJBOxdtfuDPxdSO+VKT8Ph17UVgTs2Cs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pMSPpt+ggPWMSr6gAynKK6fEgc1rRRnvopLh81yexMSlWwmGyxPDAyg9ZTvhVLK67
         m06KzZx/Yzplyw6ya3WdMIXf25XPmiwwQGW4c+PVuuZa3kpeV9KBcbG2UMqQbPeS6q
         mZFGT3JRzG3dMcNdMnGCoekY9t1mudlgrUi+oiSiamhyKS7NJ+tXrbjgnpr5AXLGyt
         w8uRHKDHLJwE0YC4Ej8GoUG7d5r7wpYsXbsIQDM49DV55PKAQhO5d0ry1uBKtfrT9u
         POYfX5n+G7hz2htD+7MFQLyeQbHfORkDypR9206yge3Da+keHc6pKLRpj1w/jOx8TH
         7cEDFN2CF70hQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/19 3:02 PM, Andrew Morton wrote:
> On Mon, 11 Nov 2019 14:49:35 -0800 Ralph Campbell <rcampbell@nvidia.com> wrote:
> 
>> When dumping struct page information, __dump_page() prints the page type
>> with a trailing blank followed by the page flags on a separate line:
>>
>> anon
>> flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)
>>
>> Fix this by using pr_cont() instead of pr_warn() to get a single line:
>>
>> anon flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> ---
>>   mm/debug.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/debug.c b/mm/debug.c
>> index 8345bb6e4769..752c78721ea0 100644
>> --- a/mm/debug.c
>> +++ b/mm/debug.c
>> @@ -87,7 +87,7 @@ void __dump_page(struct page *page, const char *reason)
>>   	}
>>   	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
>>   
>> -	pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
>> +	pr_cont("flags: %#lx(%pGp)\n", page->flags, &page->flags);
>>   
>>   hex_only:
>>   	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
> 
> This is the case if PageAnon || PageKsm || mapping.  If it is, say,
> PageSlab then we effectively do
> 
> 	pr_warn("stuff-with-no-newline");
> 	pr_cont("\n");
> 	pr_cont("flags: ...\n");
> 
> does this work OK?  what facility level will that "flags: " line get?

I don't see a "\n" in the "mapping" case but the
	if (mapping->host && mapping->host->i_dentry.first)
		pr_warn("name:\"%pd\" ", dentry)
would end up on a new line.
Ugh. I guess the dentry name could be fairly long.
I guess I will just convert to using "\n".

AFAIK, there is no locking between pr_warn() and pr_cont() so the latter
could get appended to any facility level. But that isn't a problem I
plan to fix.

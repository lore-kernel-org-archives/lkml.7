Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCD4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4830D21925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AQl5xQY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKLVfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:35:38 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2774 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfKLVfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:35:37 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcb25700000>; Tue, 12 Nov 2019 13:34:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Nov 2019 13:35:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 13:35:36 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 21:35:35 +0000
Subject: Re: [PATCH v3] mm/debug: __dump_page() prints an extra line
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20191112012608.16926-1-rcampbell@nvidia.com>
 <20191112195547.GC31272@redhat.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <06cc3e15-f65a-b582-1e6b-884244768351@nvidia.com>
Date:   Tue, 12 Nov 2019 13:35:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191112195547.GC31272@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573594480; bh=ED+V3GMnzhR8tMwutffCvUwZ4VqLcWUdDXtgiDJ+WFM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AQl5xQY84kBJ8xrqsiU/Vg3yz/UrPNroZgeicRoQmNJLBhootUrtGx4zVosbyuyEj
         HNMPLy34z0akK5/Wt4L2tkV7dNm6RBrXyztd4OA3RmtuVR7687h+HI1u09WqOD6B85
         B75CmPDa9JnPo70EgZ2EeHHKLMNMsMuu0npEpuwRIqRdQBoB7f6skF3BzS2yJUSn5r
         CzKykcIf/rwm9cnz6u4Byct6WRQhkubZzf7LrNU3794pUFQ7qEAcr9ny05YC0fqmSE
         ctXp+3+I6uqqi6U8/WBusf/+yTZBZHa5EGhUz0Gm5TN00B7SuLPLRD4Cke5SkC5FWP
         Bugg97bJkObzg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/12/19 11:55 AM, Jerome Glisse wrote:
> On Mon, Nov 11, 2019 at 05:26:08PM -0800, Ralph Campbell wrote:
>> When dumping struct page information, __dump_page() prints the page type
>> with a trailing blank followed by the page flags on a separate line:
>>
>> anon
>> flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)
>>
>> It looks like the intent was to use pr_cont() for printing "flags:"
>> but pr_cont() usage is discouraged so fix this by extending the format
>> to include the flags into a single line:
>>
>> anon flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)
>>
>> If the page is file backed, the name might be long so use two lines:
>>
>> shmem_aops name:"dev/zero"
>> flags: 0x10000000008000c(uptodate|dirty|swapbacked)
>>
>> Eliminate pr_conf() usage as well for appending compound_mapcount.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> 
> Would be nice to have a changed since v1 v2 ... i was reading my
> inbox in order and i saw Andrew reply after seeing the v2 ... so
> where we at here ?

V3 is the latest and looks like Andrew has queued it for mm.
My bad, I should have had the version changes listed in the cover
letter portion of the email.
Andrew commented on v1, v2 simply fixed the subject line which
was truncated in v1, and v3 is as you see.

Actually, I now see another bug which I'll post separately:
The "if (PageAnon(page))" will always trigger so that
"else if (PageKsm(page))" will never be executed.

>> ---
>>   mm/debug.c | 27 +++++++++++++++------------
>>   1 file changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/debug.c b/mm/debug.c
>> index 8345bb6e4769..772d4cf0691f 100644
>> --- a/mm/debug.c
>> +++ b/mm/debug.c
>> @@ -67,28 +67,31 @@ void __dump_page(struct page *page, const char *reason)
>>   	 */
>>   	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
>>   
>> -	pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx",
>> -		  page, page_ref_count(page), mapcount,
>> -		  page->mapping, page_to_pgoff(page));
>>   	if (PageCompound(page))
>> -		pr_cont(" compound_mapcount: %d", compound_mapcount(page));
>> -	pr_cont("\n");
>> +		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
>> +			"index:%#lx compound_mapcount: %d\n",
>> +			page, page_ref_count(page), mapcount,
>> +			page->mapping, page_to_pgoff(page),
>> +			compound_mapcount(page));
>> +	else
>> +		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
>> +			page, page_ref_count(page), mapcount,
>> +			page->mapping, page_to_pgoff(page));
>>   	if (PageAnon(page))
>> -		pr_warn("anon ");
>> +		pr_warn("anon flags: %#lx(%pGp)\n", page->flags, &page->flags);
>>   	else if (PageKsm(page))
>> -		pr_warn("ksm ");
>> +		pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &page->flags);
>>   	else if (mapping) {
>> -		pr_warn("%ps ", mapping->a_ops);
>>   		if (mapping->host && mapping->host->i_dentry.first) {
>>   			struct dentry *dentry;
>>   			dentry = container_of(mapping->host->i_dentry.first, struct dentry, d_u.d_alias);
>> -			pr_warn("name:\"%pd\" ", dentry);
>> -		}
>> +			pr_warn("%ps name:\"%pd\"\n", mapping->a_ops, dentry);
>> +		} else
>> +			pr_warn("%ps\n", mapping->a_ops);
>> +		pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
>>   	}
>>   	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
>>   
>> -	pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
>> -
>>   hex_only:
>>   	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
>>   			sizeof(unsigned long), page,
>> -- 
>> 2.20.1
>>
>>
> 

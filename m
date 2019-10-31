Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03E1CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E712080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfJaLgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:36:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbfJaLgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:36:52 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D12223E469FC447E53C9;
        Thu, 31 Oct 2019 19:36:48 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 19:36:47 +0800
Message-ID: <5DBAC74E.5080001@huawei.com>
Date:   Thu, 31 Oct 2019 19:36:46 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Borislav Petkov <bp@alien8.de>
CC:     <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() + WARN_ON_ONCE()
References: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com> <20191031110304.GE21133@nazgul.tnic>
In-Reply-To: <20191031110304.GE21133@nazgul.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/31 19:03, Borislav Petkov wrote:
> On Wed, Oct 30, 2019 at 04:57:18PM +0800, zhong jiang wrote:
>> WARN_ONCE is more clear and simpler. Just replace it.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  arch/x86/mm/ioremap.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index a39dcdb..3b74599 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -172,9 +172,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>>  		return NULL;
>>  
>>  	if (!phys_addr_valid(phys_addr)) {
>> -		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
>> -		       (unsigned long long)phys_addr);
>> -		WARN_ON_ONCE(1);
>> +		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
>> +			  (unsigned long long)phys_addr);
> Does
> 	WARN_ONCE(!phys_addr_valid(phys_addr),
> 		  "ioremap: invalid physical address %llx\n",
> 		  (unsigned long long)phys_addr);
>
> work too?
>
Thanks, That is better. Will repost.


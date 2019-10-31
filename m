Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAB6CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED66C20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfJaMlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:41:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5239 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfJaMlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:41:02 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A561FB17EB8437135711;
        Thu, 31 Oct 2019 20:40:59 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 20:40:54 +0800
Message-ID: <5DBAD655.8060108@huawei.com>
Date:   Thu, 31 Oct 2019 20:40:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Joe Perches <joe@perches.com>
CC:     Borislav Petkov <bp@alien8.de>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() + WARN_ON_ONCE()
References: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com>  <20191031110304.GE21133@nazgul.tnic> <5DBAC74E.5080001@huawei.com> <be4803c67e2e1f9e91e59bfd7b23f938619f66e8.camel@perches.com>
In-Reply-To: <be4803c67e2e1f9e91e59bfd7b23f938619f66e8.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/31 20:00, Joe Perches wrote:
> On Thu, 2019-10-31 at 19:36 +0800, zhong jiang wrote:
>> On 2019/10/31 19:03, Borislav Petkov wrote:
>>> On Wed, Oct 30, 2019 at 04:57:18PM +0800, zhong jiang wrote:
>>>> WARN_ONCE is more clear and simpler. Just replace it.
> []
>>>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> []
>>>> @@ -172,9 +172,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>>>>  		return NULL;
>>>>  
>>>>  	if (!phys_addr_valid(phys_addr)) {
>>>> -		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
>>>> -		       (unsigned long long)phys_addr);
>>>> -		WARN_ON_ONCE(1);
>>>> +		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
>>>> +			  (unsigned long long)phys_addr);
>>> Does
>>> 	WARN_ONCE(!phys_addr_valid(phys_addr),
>>> 		  "ioremap: invalid physical address %llx\n",
>>> 		  (unsigned long long)phys_addr);
>>>
>>> work too?
>>>
>> Thanks, That is better. Will repost.
> Perhaps this is not good patch concept as now each
> invalid physical address will not be emitted.
>
> Before:
> 	each invalid physical address printed
> 	one stack dump
>
> After:
> 	one stck dump with first invalid physical address.
>
Yes,  I  has told that. 

How you think my above patch in the mail.  Thanks
>
> .
>



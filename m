Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A146CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761EE2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfJaPyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:54:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727681AbfJaPyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:54:39 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C00F7390A8EFEF16C032;
        Thu, 31 Oct 2019 23:54:30 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 23:54:25 +0800
Message-ID: <5DBB03B0.5060003@huawei.com>
Date:   Thu, 31 Oct 2019 23:54:24 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Borislav Petkov <bp@alien8.de>
CC:     <peterz@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() + WARN_ON_ONCE()
References: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com> <20191031110304.GE21133@nazgul.tnic> <5DBACB61.90809@huawei.com> <20191031154916.GA24152@nazgul.tnic>
In-Reply-To: <20191031154916.GA24152@nazgul.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/31 23:49, Borislav Petkov wrote:
> On Thu, Oct 31, 2019 at 07:54:09PM +0800, zhong jiang wrote:
>> Look at this again, It should not works. Because that will change the logical.
>> if phys_addr_valid is false, we should drop out in time.
> That you can do too:
>
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index a39dcdb5ae34..13f44cc064af 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -171,12 +171,10 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
>  	if (!size || last_addr < phys_addr)
>  		return NULL;
>  
> -	if (!phys_addr_valid(phys_addr)) {
> -		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
> -		       (unsigned long long)phys_addr);
> -		WARN_ON_ONCE(1);
> +	if (WARN_ONCE(!phys_addr_valid(phys_addr),
> +	    "ioremap: invalid physical address %llx\n",
> +	    (unsigned long long)phys_addr))
>  		return NULL;
> -	}
>  
Yep,  WARN_ONCE alway return true in that case.

Thanks,
zhong jiang
>  	__ioremap_check_mem(phys_addr, size, &io_desc);
>  
> ---
>
> I'm not sure whether we care about printing every invalid address, as
> Joe points out. Maybe we do... *shrug*
>



Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B67C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE3B222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389525AbfIZBbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:31:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2783 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbfIZBbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:31:05 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C6A933775E447C566545;
        Thu, 26 Sep 2019 09:31:00 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 09:30:58 +0800
Subject: Re: [PATCH 07/32] x86: Use pr_warn instead of pr_warning
To:     Joe Perches <joe@perches.com>, Robert Richter <rric@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20190920062544.180997-8-wangkefeng.wang@huawei.com>
 <20190920092850.26usohzmatmqrlor@rric.localdomain>
 <7a517b43-7e86-79ba-5954-dd746c309c87@huawei.com>
 <0f291158f7d788c001212bcbb13843fbff571eeb.camel@perches.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <fb21e729-822c-dca6-f867-267c41c94635@huawei.com>
Date:   Thu, 26 Sep 2019 09:30:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0f291158f7d788c001212bcbb13843fbff571eeb.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/20 23:28, Joe Perches wrote:
> On Fri, 2019-09-20 at 19:57 +0800, Kefeng Wang wrote:
>> On 2019/9/20 17:28, Robert Richter wrote:
>>> On 20.09.19 14:25:19, Kefeng Wang wrote:
>>>> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
>>>> pr_warning"), removing pr_warning so all logging messages use a
>>>> consistent <prefix>_warn style. Let's do it.
> []
>>>> diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
> []
>>>> @@ -665,7 +664,7 @@ static __init int init_amd_gatt(struct agp_kern_info *info)
>>>>  
>>>>   nommu:
>>>>  	/* Should not happen anymore */
>>>> -	pr_warning("PCI-DMA: More than 4GB of RAM and no IOMMU\n"
>>>> +	pr_warn("PCI-DMA: More than 4GB of RAM and no IOMMU\n"
>>>>  	       "falling back to iommu=soft.\n");
>>> This indentation should be fixed too, while at it.
>> Will update later, thanks.
> trivia:
>
> likely better as a single line output:
>
> 	pr_warn("PCI-DMA: More than 4GB of RAM and no IOMMU - falling back to iommu=soft\n");

ok, will resend all patches after rc1 with this change and other comment fixes, thanks.

>
>
>
> .
>


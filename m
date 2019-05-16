Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9FFC04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 03:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DA420862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 03:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEPDYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 23:24:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbfEPDYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 23:24:09 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D09F6FAB343E446E4313;
        Thu, 16 May 2019 11:24:07 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 May 2019
 11:24:00 +0800
Subject: Re: [PATCH 4/4] kdump: update Documentation about crashkernel on
 arm64
To:     Bhupesh Sharma <bhsharma@redhat.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <akpm@linux-foundation.org>,
        <ard.biesheuvel@linaro.org>, <rppt@linux.ibm.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <ebiederm@xmission.com>
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <20190507035058.63992-5-chenzhou10@huawei.com>
 <de5b827f-5db2-2280-b848-c5c887b9bb58@redhat.com>
CC:     <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <takahiro.akashi@linaro.org>, <horms@verge.net.au>,
        <linux-arm-kernel@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <168b5c80-9a8b-ee94-9cfb-56e4955958c1@huawei.com>
Date:   Thu, 16 May 2019 11:23:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <de5b827f-5db2-2280-b848-c5c887b9bb58@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/15 13:16, Bhupesh Sharma wrote:
> On 05/07/2019 09:20 AM, Chen Zhou wrote:
>> Now we support crashkernel=X,[high,low] on arm64, update the
>> Documentation.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 268b10a..03a08aa 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -705,7 +705,7 @@
>>               memory region [offset, offset + size] for that kernel
>>               image. If '@offset' is omitted, then a suitable offset
>>               is selected automatically.
>> -            [KNL, x86_64] select a region under 4G first, and
>> +            [KNL, x86_64, arm64] select a region under 4G first, and
>>               fall back to reserve region above 4G when '@offset'
>>               hasn't been specified.
>>               See Documentation/kdump/kdump.txt for further details.
>> @@ -718,14 +718,14 @@
>>               Documentation/kdump/kdump.txt for an example.
>>         crashkernel=size[KMG],high
>> -            [KNL, x86_64] range could be above 4G. Allow kernel
>> +            [KNL, x86_64, arm64] range could be above 4G. Allow kernel
>>               to allocate physical memory region from top, so could
>>               be above 4G if system have more than 4G ram installed.
>>               Otherwise memory region will be allocated below 4G, if
>>               available.
>>               It will be ignored if crashkernel=X is specified.
>>       crashkernel=size[KMG],low
>> -            [KNL, x86_64] range under 4G. When crashkernel=X,high
>> +            [KNL, x86_64, arm64] range under 4G. When crashkernel=X,high
>>               is passed, kernel could allocate physical memory region
>>               above 4G, that cause second kernel crash on system
>>               that require some amount of low memory, e.g. swiotlb
>>
> 
> IMO, it is a good time to update 'Documentation/kdump/kdump.txt' with this patchset itself for both x86_64 and arm64, where we still specify only the old format for 'crashkernel' boot-argument:
> 
> Section: Boot into System Kernel
>          =======================
> 
> On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> ...
> 
> We can update this to add the new crashkernel=size[KMG],low or crashkernel=size[KMG],high format as well.
> 
> Thanks,
> Bhupesh
> 
> .

Sure, we can also update here.

Thanks,
Chen Zhou




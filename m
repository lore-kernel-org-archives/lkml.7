Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F6AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1769B2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbfFLG1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:27:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18137 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfFLG07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:26:59 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 81C41E146AD85FC4BB65;
        Wed, 12 Jun 2019 14:26:54 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.186) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Jun 2019
 14:26:46 +0800
Subject: Re: [PATCH v8 2/7] x86/dma: use IS_ENABLED() to simplify the code
To:     Borislav Petkov <bp@alien8.de>
CC:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        x86 <x86@kernel.org>, linux-ia64 <linux-ia64@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
References: <20190530034831.4184-1-thunder.leizhen@huawei.com>
 <20190530034831.4184-3-thunder.leizhen@huawei.com>
 <20190612051624.GF32652@zn.tnic>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <bd743433-73e9-3cf1-c159-4371abebd989@huawei.com>
Date:   Wed, 12 Jun 2019 14:26:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612051624.GF32652@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/12 13:16, Borislav Petkov wrote:
> On Thu, May 30, 2019 at 11:48:26AM +0800, Zhen Lei wrote:
>> This patch removes the ifdefs around CONFIG_IOMMU_DEFAULT_PASSTHROUGH to
>> improve readablity.
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.

OK, thanks.

> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.
> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/x86/kernel/pci-dma.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
>> index dcd272dbd0a9330..9f2b19c35a060df 100644
>> --- a/arch/x86/kernel/pci-dma.c
>> +++ b/arch/x86/kernel/pci-dma.c
>> @@ -43,11 +43,8 @@
>>   * It is also possible to disable by default in kernel config, and enable with
>>   * iommu=nopt at boot time.
>>   */
>> -#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
>> -int iommu_pass_through __read_mostly = 1;
>> -#else
>> -int iommu_pass_through __read_mostly;
>> -#endif
>> +int iommu_pass_through __read_mostly =
>> +			IS_ENABLED(CONFIG_IOMMU_DEFAULT_PASSTHROUGH);
> 
> Let that line stick out.

OK, I will merge them on the same line.

> 
> Thx.
> 


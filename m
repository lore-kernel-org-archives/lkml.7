Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C664FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20BF2176D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfLSBUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 20:20:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8146 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbfLSBUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 20:20:25 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4843F5B79693D50AF8D0;
        Thu, 19 Dec 2019 09:20:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Dec 2019
 09:20:20 +0800
Subject: Re: [PATCH] powerpc/setup_64: use DEFINE_DEBUGFS_ATTRIBUTE to define
 fops_rfi_flush
To:     Michael Ellerman <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>
References: <20191218020842.186446-1-chenzhou10@huawei.com>
 <8736dhoq0j.fsf@mpe.ellerman.id.au>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Nicolai Stange" <nicstange@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <69722925-d0ab-ab7e-022f-c901ead3989a@huawei.com>
Date:   Thu, 19 Dec 2019 09:20:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <8736dhoq0j.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 2019/12/18 19:02, Michael Ellerman wrote:
> Chen Zhou <chenzhou10@huawei.com> writes:
>> Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE for
>> debugfs files.
>>
>> Semantic patch information:
>> Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
>> imposes some significant overhead as compared to
>> DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
> 
> I know you didn't write this text, but these change logs are not great.
> It doesn't really explain why you're doing it. And it is alarming that
> you're converting *to* a function with "unsafe" in the name.
> 
> The commit that added the script:
> 
>   5103068eaca2 ("debugfs, coccinelle: check for obsolete DEFINE_SIMPLE_ATTRIBUTE() usage")
> 
> Has a bit more explanation.
> 
> Maybe something like this:
> 
>   In order to protect against file removal races, debugfs files created via
>   debugfs_create_file() are wrapped by a struct file_operations at their
>   opening.
>   
>   If the original struct file_operations is known to be safe against removal
>   races already, the proxy creation may be bypassed by creating the files
>   using DEFINE_DEBUGFS_ATTRIBUTE() and debugfs_create_file_unsafe().
> 
> 
> The part that's not explained is why this file is "known to be safe
> against removal races already"?
> 
> It also seems this conversion will make the file no longer seekable,
> because DEFINE_SIMPLE_ATTRIBUTE() uses generic_file_llseek() whereas
> DEFINE_DEBUGFS_ATTRIBUTE() uses no_llseek.
> 
> That is probably fine, but should be mentioned.

Thanks for your explanation. This part indeed should be mentioned.

Chen Zhou

> 
> cheers
> 
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  arch/powerpc/kernel/setup_64.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
>> index 6104917..4b9fbb2 100644
>> --- a/arch/powerpc/kernel/setup_64.c
>> +++ b/arch/powerpc/kernel/setup_64.c
>> @@ -956,11 +956,11 @@ static int rfi_flush_get(void *data, u64 *val)
>>  	return 0;
>>  }
>>  
>> -DEFINE_SIMPLE_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
>>  
>>  static __init int rfi_flush_debugfs_init(void)
>>  {
>> -	debugfs_create_file("rfi_flush", 0600, powerpc_debugfs_root, NULL, &fops_rfi_flush);
>> +	debugfs_create_file_unsafe("rfi_flush", 0600, powerpc_debugfs_root, NULL, &fops_rfi_flush);
>>  	return 0;
>>  }
>>  device_initcall(rfi_flush_debugfs_init);
>> -- 
>> 2.7.4
> 
> .
> 


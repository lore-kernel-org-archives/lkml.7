Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60BAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94352075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfKZJ6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:58:07 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2114 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727397AbfKZJ6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:58:06 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 3CA6618EE8A6A8A0B4E8;
        Tue, 26 Nov 2019 09:58:03 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 26 Nov 2019 09:57:57 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 09:57:57 +0000
Subject: Re: [PATCH] EDAC/ghes: Do not warn when incrementing refcount on 0
To:     Borislav Petkov <bp@alien8.de>,
        Robert Richter <rrichter@marvell.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "huangming23@huawei.com" <huangming23@huawei.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
        "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>
References: <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
 <20191121213628.21244-1-rrichter@marvell.com> <20191122090123.GB6289@zn.tnic>
From:   John Garry <john.garry@huawei.com>
Message-ID: <cf60a616-35e4-3938-3cdd-19ea22deb487@huawei.com>
Date:   Tue, 26 Nov 2019 09:57:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191122090123.GB6289@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2019 09:01, Borislav Petkov wrote:
> On Thu, Nov 21, 2019 at 09:36:57PM +0000, Robert Richter wrote:
>> Following warning from the refcount framework is seen during ghes
>> initialization:
>>
>>   EDAC MC0: Giving out device to module ghes_edac.c controller ghes_edac: DEV ghes (INTERRUPT)
>>   ------------[ cut here ]------------
>>   refcount_t: increment on 0; use-after-free.
>>   WARNING: CPU: 36 PID: 1 at lib/refcount.c:156 refcount_inc_checked+0x44/0x50
>> [...]
>>   Call trace:
>>    refcount_inc_checked+0x44/0x50
>>    ghes_edac_register+0x258/0x388
>>    ghes_probe+0x28c/0x5f0
>>
>> It warns if the refcount is incremented from zero. This warning is
>> reasonable as a kernel object is typically created with a refcount of
>> one and freed once the refcount is zero. Afterwards the object would
>> be "used-after-free".
>>
>> For ghes the refcount is initialized with zero, and that is why this
>> message is seen when initializing the first instance. However,
>> whenever the refcount is zero, the device will be allocated and
>> registered. Since the ghes_reg_mutex protects the refcount and
>> serializes allocation and freeing of ghes devices, a use-after-free
>> cannot happen here.
>>
>> Instead of using refcount_inc() for the first instance, use
>> refcount_set(). This can be used here because the refcount is zero at
>> this point and can not change due to its protection by the mutex.
>>
>> Reported-by: John Garry <john.garry@huawei.com>
>> Tested-by: John Garry <john.garry@huawei.com>

According to kernel dev process Doc, this should be explicitly granted, so:
Tested-by: John Garry <john.garry@huawei.com>

Thanks,
John

>> Signed-off-by: Robert Richter <rrichter@marvell.com>
>> ---
>>   drivers/edac/ghes_edac.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Queued, thanks.
> 


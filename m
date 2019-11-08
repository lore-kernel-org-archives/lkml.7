Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A111FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D67206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfKHQoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:44:30 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2078 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727149AbfKHQo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:44:29 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 41E724EA76087BF488D6;
        Fri,  8 Nov 2019 16:44:27 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 8 Nov 2019 16:44:26 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 8 Nov 2019
 16:44:26 +0000
Subject: Re: [PATCH v2 6/9] Revert "iommu/arm-smmu: Make arm-smmu-v3
 explicitly non-modular"
From:   John Garry <john.garry@huawei.com>
To:     Will Deacon <will@kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20191108151608.20932-1-will@kernel.org>
 <20191108151608.20932-7-will@kernel.org>
 <06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com>
Message-ID: <7e906ed1-ab85-7e25-9b29-5497e98da8d8@huawei.com>
Date:   Fri, 8 Nov 2019 16:44:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2019 16:17, John Garry wrote:
> On 08/11/2019 15:16, Will Deacon wrote:
>> +MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> 
> Hi Will,
> 
>>   static struct platform_driver arm_smmu_driver = {
>>       .driver    = {
>>           .name        = "arm-smmu-v3",
>>           .of_match_table    = of_match_ptr(arm_smmu_of_match),
>> -        .suppress_bind_attrs = true,
> 
> Does this mean that we can now manually unbind this driver from the SMMU 
> device?
> 
> Seems dangerous. Here's what happens for me:
> 
> root@ubuntu:/sys# cd ./bus/platform/drivers/arm-smmu-v3
> ind @ubuntu:/sys/bus/platform/drivers/arm-smmu-v3# echo 
> arm-smmu-v3.0.auto > unbind
> [   77.580351] hisi_sas_v2_hw HISI0162:01: CQE_AXI_W_ERR (0x800) found!
> ho [   78.635473] platform arm-smmu-v3.0.auto: CMD_SYNC timeout at 
> 0x00000146 [hwprod 0x00000146, hwcons 0x00000000]
> 
>>       },
>>       .probe    = arm_smmu_device_probe,
>> +    .remove    = arm_smmu_device_remove,
>>       .shutdown = arm_smmu_device_shutdown,
>>   };
>> -builtin_platform_driver(arm_smmu_driver);
>> +module_platform_driver(arm_smmu_driver);
>> +

BTW, it now looks like it was your v1 series I was testing there, on 
your branch iommu/module. It would be helpful to update for ease of testing.

Thanks,
John


Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DE9206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfK0LE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:04:28 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbfK0LE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:04:28 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3E497451C88F8A6FF950;
        Wed, 27 Nov 2019 11:04:27 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 27 Nov 2019 11:04:26 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 11:04:26 +0000
Subject: Re: [PATCH v3 09/14] iommu/arm-smmu: Prevent forced unbinding of Arm
 SMMU drivers
To:     Saravana Kannan <saravanak@google.com>
CC:     Will Deacon <will@kernel.org>, <iommu@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20191121114918.2293-1-will@kernel.org>
 <20191121114918.2293-10-will@kernel.org>
 <5c91d467-5e59-482b-8f4f-e0cfa3db9028@huawei.com>
 <CAGETcx8Hkta6scFdiG=eQypsQ--jrR1YisaOQATCbMiu+aG8sg@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <af1dc92a-ca98-fb22-835f-5ceb85e86b1b@huawei.com>
Date:   Wed, 27 Nov 2019 11:04:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAGETcx8Hkta6scFdiG=eQypsQ--jrR1YisaOQATCbMiu+aG8sg@mail.gmail.com>
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

On 26/11/2019 20:27, Saravana Kannan wrote:
> On Tue, Nov 26, 2019 at 1:13 AM John Garry <john.garry@huawei.com> wrote:
>>
>> On 21/11/2019 11:49, Will Deacon wrote:
>>> Forcefully unbinding the Arm SMMU drivers is a pretty dangerous operation,
>>> since it will likely lead to catastrophic failure for any DMA devices
>>> mastering through the SMMU being unbound. When the driver then attempts
>>> to "handle" the fatal faults, it's very easy to trip over dead data
>>> structures, leading to use-after-free.
>>>
>>> On John's machine, he reports that the machine was "unusable" due to
>>> loss of the storage controller following a forced unbind of the SMMUv3
>>> driver:
>>>
>>>     | # cd ./bus/platform/drivers/arm-smmu-v3
>>>     | # echo arm-smmu-v3.0.auto > unbind
>>>     | hisi_sas_v2_hw HISI0162:01: CQE_AXI_W_ERR (0x800) found!
>>>     | platform arm-smmu-v3.0.auto: CMD_SYNC timeout at 0x00000146
>>>     | [hwprod 0x00000146, hwcons 0x00000000]
>>>
>>> Prevent this forced unbinding of the drivers by setting "suppress_bind_attrs"
>>> to true.
>>
>> This seems a reasonable approach for now.
>>
>> BTW, I'll give this series a spin this week, which again looks to be
>> your iommu/module branch, excluding the new IORT patch.
> 

Hi Saravana,

> Is this on a platform where of_devlink creates device links between
> the iommu device and its suppliers?I'm guessing no? Because device
> links should for unbinding of all the consumers before unbinding the
> supplier.

I'm only really interested in ACPI, TBH.

> 
> Looks like it'll still allow the supplier to unbind if the consumers
> don't allow unbinding. Is that the case here?

So just unbinding the driver from a device does not delete the device 
nor exit the device from it's IOMMU group - so we keep the reference to 
the SMMU ko. As such, I don't know how to realistically test unloading 
the SMMU ko when we have platform devices involved. Maybe someone can 
enlighten me...

Thanks,
John

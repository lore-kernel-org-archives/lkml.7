Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E68DC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E75214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfKHSA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:00:56 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2081 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfKHSA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:00:56 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 85BA4C7AFACC3CD39223;
        Fri,  8 Nov 2019 18:00:54 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 8 Nov 2019 18:00:54 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 8 Nov 2019
 18:00:53 +0000
Subject: Re: [PATCH v2 6/9] Revert "iommu/arm-smmu: Make arm-smmu-v3
 explicitly non-modular"
To:     Will Deacon <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20191108151608.20932-1-will@kernel.org>
 <20191108151608.20932-7-will@kernel.org>
 <06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com>
 <7e906ed1-ab85-7e25-9b29-5497e98da8d8@huawei.com>
 <20191108164728.GB20866@willie-the-truck>
 <c4cb13d3-3786-2e45-ba57-9965cead9a49@huawei.com>
 <20191108173248.GA22448@willie-the-truck>
 <20191108174846.GA22677@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <95988b60-95e2-7780-5f84-e89e9eee5fce@huawei.com>
Date:   Fri, 8 Nov 2019 18:00:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191108174846.GA22677@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2019 17:48, Will Deacon wrote:
> On Fri, Nov 08, 2019 at 05:32:48PM +0000, Will Deacon wrote:
>> On Fri, Nov 08, 2019 at 05:25:09PM +0000, John Garry wrote:
>>> On 08/11/2019 16:47, Will Deacon wrote:
>>>> On Fri, Nov 08, 2019 at 04:44:25PM +0000, John Garry wrote:
>>>>> BTW, it now looks like it was your v1 series I was testing there, on your
>>>>> branch iommu/module. It would be helpful to update for ease of testing.
>>>>
>>>> Yes, sorry about that. I'll update it now (although I'm not sure it will
>>>> help with this -- I was going to see what happens with other devices such
>>>> as the intel-iommu or storage controllers)
>>>
>>> So I tried your v2 series for this - it has the same issue, as I
>>> anticipated.
>>
>> Right, I'm just not sure how resilient drivers are expected to be to force
>> unbinding like this. You can break lots of stuff with root...
>>
>>> It seems that some iommu drivers do call iommu_device_register(), so maybe a
>>> decent reference. Or simply stop the driver being unbound.
>>
>> I'm not sure what you mean about iommu_device_register() (we call that
>> already), but I guess we can keep the '.suppress_bind_attrs = true' if
>> necessary. I'll have a play on my laptop and see how well that works if
>> you start unbinding stuff.
> 
> So unbinding the nvme driver goes bang:
> 
> [90139.090158] nvme nvme0: failed to set APST feature (-19)
> [90141.966780] Aborting journal on device dm-1-8.
> [90141.967124] Buffer I/O error on dev dm-1, logical block 26247168, lost sync page write
> [90141.967169] JBD2: Error -5 detected when updating journal superblock for dm-1-8.
> [90141.967403] Buffer I/O error on dev dm-1, logical block 0, lost sync page write
> [90141.967454] EXT4-fs (dm-1): I/O error while writing superblock
> [90141.967467] EXT4-fs error (device dm-1): ext4_journal_check_start:61: Detected aborted journal
> [90141.967473] EXT4-fs (dm-1): Remounting filesystem read-only
> [90141.967569] Buffer I/O error on dev dm-1, logical block 0, lost sync page write
> [90141.967682] EXT4-fs (dm-1): I/O error while writing superblock
> 
> and I've not managed to recover the thing yet (it's stuck trying to reboot.)
> 

Not surprised. I guess the device backing your root directory disappeared.

> What state was your system in after unbinding the SMMU?

Unusable again. For me the storage controller backing the root directory 
is compromised by disabling the SMMU unsafely.

Thanks,
John

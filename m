Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ABAC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86EF2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfLYCiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 21:38:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:22133 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfLYCip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:38:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2019 18:38:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,353,1571727600"; 
   d="scan'208";a="417703430"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga005.fm.intel.com with ESMTP; 24 Dec 2019 18:38:43 -0800
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSN?=
 =?UTF-8?Q?=3a_=5bPATCH=5d_iommu/vt-d=3a_Don=27t_reject_nvme_host_due_to_sco?=
 =?UTF-8?Q?pe_mismatch?=
To:     "Jim,Yan" <jimyan@baidu.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
References: <4b77511069cb4fbc982eebaad941cd23@baidu.com>
 <149a454d-96ea-1e25-74d1-04a08f8b261e@linux.intel.com>
 <8fbd6988b0a94c5e9e4b23eed59114dc@baidu.com>
 <273a4cc4-f17b-63a6-177d-9830e683bf52@linux.intel.com>
 <062f5fd1611940b083ec34603eca94e1@baidu.com>
 <46d15bd6-4b50-d0cb-e0b8-763a808c4de8@linux.intel.com>
 <eccacec618c04a58be66809a541a95bf@baidu.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f5ceee32-4a21-a09c-1e1b-d3f0539ace4c@linux.intel.com>
Date:   Wed, 25 Dec 2019 10:37:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <eccacec618c04a58be66809a541a95bf@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/25/19 10:05 AM, Jim,Yan wrote:
> Hi,
> 
>> -----邮件原件-----
>> 发件人: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> 发送时间: 2019年12月25日 10:01
>> 收件人: Jim,Yan <jimyan@baidu.com>; Jerry Snitselaar <jsnitsel@redhat.com>
>> 抄送: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>> 主题: Re: 答复: 答复: 答复: 答复: [PATCH] iommu/vt-d: Don't reject nvme
>> host due to scope mismatch
>>
>> Hi,
>>
>> On 2019/12/25 9:52, Jim,Yan wrote:
>>> Hi,
>>>
>>>> -----邮件原件-----
>>>> 发件人: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>>>> 发送时间: 2019年12月24日 19:27
>>>> 收件人: Jim,Yan <jimyan@baidu.com>; Jerry Snitselaar
>>>> <jsnitsel@redhat.com>
>>>> 抄送: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>>>> 主题: Re: 答复: 答复: 答复: [PATCH] iommu/vt-d: Don't reject nvme host
>> due to
>>>> scope mismatch
>>>>
>>>> Hi,
>>>>
>>>> On 2019/12/24 16:18, Jim,Yan wrote:
>>>>>>>> For both cases, a quirk flag seems to be more reasonable, so that
>>>>>>>> unrelated devices will not be impacted.
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> baolu
>>>>>>> Hi Baolu,
>>>>>>> 	Thanks for your advice. And I modify the patch as follow.
>>>>>> I just posted a patch for both NTG and NVME cases. Can you please
>>>>>> take a
>>>> look?
>>>>>> Does it work for you?
>>>>>>
>>>>>> Best regards,
>>>>>> baolu
>>>>>>
>>>>> I have tested your patch. It does work for me. But I prefer my
>>>>> second version,
>>>> it is more flexible, and may use for similar unknown devices.
>>>>>
>>>>
>>>> I didn't get your point. Do you mind explaining why it's more flexible?
>>>>
>>>> Best regards,
>>>> Baolu
>>> For example, an unknown device has a normal PCI header and bridge scope
>> and a class of PCI_CLASS_BRIDGE_PCI.
>>> These devices do have a class of PCI_BASE_CLASS_BRIDGE in common.
>>
>> This is not a common case. It's only for devices on the marketing and hard for
>> the VT-d users to get it fixed in the OEM firmware.
>>
>> Best regards,
>> Baolu
> 
> Got it. Then I am OK with this patch. I have tested it yesterday. It does work for me.
> Thanks.

Can I add your Tested-by?

Best regards,
baolu

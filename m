Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16072C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFBA206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLWNFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 08:05:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:22004 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbfLWNFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:05:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 05:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="223018527"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.45]) ([10.254.215.45])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2019 05:05:23 -0800
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBpb21tdS92dC1kOiBEb24ndCByZWpl?=
 =?UTF-8?Q?ct_nvme_host_due_to_scope_mismatch?=
To:     "Jim,Yan" <jimyan@baidu.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1576825674-18022-1-git-send-email-jimyan@baidu.com>
 <20191220092327.do34gtk3lcafzr6q@cantor>
 <606767b54ad4410abbdd9d053552074a@baidu.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bbff34ed-1c47-3eed-0bc9-30cfdd3ee90d@linux.intel.com>
Date:   Mon, 23 Dec 2019 21:05:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <606767b54ad4410abbdd9d053552074a@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/12/23 15:59, Jim,Yan wrote:
>> -----邮件原件-----
>> 发件人: Jerry Snitselaar [mailto:jsnitsel@redhat.com]
>> 发送时间: 2019年12月20日 17:23
>> 收件人: Jim,Yan <jimyan@baidu.com>
>> 抄送: joro@8bytes.org; iommu@lists.linux-foundation.org;
>> linux-kernel@vger.kernel.org
>> 主题: Re: [PATCH] iommu/vt-d: Don't reject nvme host due to scope mismatch
>>
>> On Fri Dec 20 19, jimyan wrote:
>>> On a system with an Intel PCIe port configured as a nvme host device,
>>> iommu initialization fails with
>>>
>>>     DMAR: Device scope type does not match for 0000:80:00.0
>>>
>>> This is because the DMAR table reports this device as having scope 2
>>> (ACPI_DMAR_SCOPE_TYPE_BRIDGE):
>>>
>>
>> Isn't that a problem to be fixed in the DMAR table then?
>>
>>> but the device has a type 0 PCI header:
>>> 80:00.0 Class 0600: Device 8086:2020 (rev 06)
>>> 00: 86 80 20 20 47 05 10 00 06 00 00 06 10 00 00 00
>>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
>>> 30: 00 00 00 00 90 00 00 00 00 00 00 00 00 01 00 00
>>>
>>> VT-d works perfectly on this system, so there's no reason to bail out
>>> on initialization due to this apparent scope mismatch. Add the class
>>> 0x600 ("PCI_CLASS_BRIDGE_HOST") as a heuristic for allowing DMAR
>>> initialization for non-bridge PCI devices listed with scope bridge.
>>>
>>> Signed-off-by: jimyan <jimyan@baidu.com>
>>> ---
>>> drivers/iommu/dmar.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c index
>>> eecd6a421667..9faf2f0e0237 100644
>>> --- a/drivers/iommu/dmar.c
>>> +++ b/drivers/iommu/dmar.c
>>> @@ -244,6 +244,7 @@ int dmar_insert_dev_scope(struct
>> dmar_pci_notify_info *info,
>>> 		     info->dev->hdr_type != PCI_HEADER_TYPE_NORMAL) ||
>>> 		    (scope->entry_type == ACPI_DMAR_SCOPE_TYPE_BRIDGE &&
>>> 		     (info->dev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
>>> +			  info->dev->class >> 8 != PCI_CLASS_BRIDGE_HOST &&
>>> 		      info->dev->class >> 8 != PCI_CLASS_BRIDGE_OTHER))) {
>>> 			pr_warn("Device scope type does not match for %s\n",
>>> 				pci_name(info->dev));
>>> --
>>> 2.11.0
>>>
>>> _______________________________________________
>>> iommu mailing list
>>> iommu@lists.linux-foundation.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>>
> Actually this patch is similar to the commit: ffb2d1eb88c3("iommu/vt-d: Don't reject NTB devices due to scope mismatch"). Besides, modifying DMAR table need OEM update BIOS. It is hard to implement.
>

For both cases, a quirk flag seems to be more reasonable, so that
unrelated devices will not be impacted.

Best regards,
baolu

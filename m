Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE55C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A2A20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfHMHjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:39:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:55694 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfHMHjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:39:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 00:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,380,1559545200"; 
   d="scan'208";a="170318857"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2019 00:39:46 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Apply per-device dma_ops
To:     Christoph Hellwig <hch@lst.de>
References: <20190801060156.8564-1-baolu.lu@linux.intel.com>
 <20190801060156.8564-3-baolu.lu@linux.intel.com>
 <20190806064347.GA14906@lst.de>
 <f532a2c3-f73a-85d2-d2ad-37cde02547ce@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f0163adb-f9f9-5c7b-2bf8-2e0f182ffe49@linux.intel.com>
Date:   Tue, 13 Aug 2019 15:38:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f532a2c3-f73a-85d2-d2ad-37cde02547ce@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 8/7/19 11:06 AM, Lu Baolu wrote:
> Hi Christoph,
> 
> On 8/6/19 2:43 PM, Christoph Hellwig wrote:
>> Hi Lu,
>>
>> I really do like the switch to the per-device dma_map_ops, but:
>>
>> On Thu, Aug 01, 2019 at 02:01:55PM +0800, Lu Baolu wrote:
>>> Current Intel IOMMU driver sets the system level dma_ops. This
>>> implementation has at least the following drawbacks: 1) each
>>> dma API will go through the IOMMU driver even the devices are
>>> using identity mapped domains; 2) if user requests to use an
>>> identity mapped domain (a.k.a. bypass iommu translation), the
>>> driver might fall back to dma domain blindly if the device is
>>> not able to address all system memory.
>>
>> This is very clearly a behavioral regression.  The intel-iommu driver
>> has always used the iommu mapping to provide decent support for
>> devices that do not have the full 64-bit addressing capability, and
>> changing this will make a lot of existing setups go slower.
>>
> 
> I agree with you that we should keep the capability and avoid possible
> performance regression on some setups. But, instead of hard-coding this
> in the iommu driver, I prefer a more scalable way.
> 
> For example, the concept of per group default domain type [1] seems to
> be a good choice. The kernel could be statically compiled as by-default
> "pass through" or "translate everything". The per group default domain
> type API could then be used by the privileged user to tweak some of the
> groups for better performance, either by 1) bypassing iommu translation
> for the trusted super-speed devices, or 2) applying iommu translation to
> access the system memory which is beyond the device's address capability
> (without the necessary of using bounce buffer).
> 
> [1] https://www.spinics.net/lists/iommu/msg37113.html
> 

The code that this patch is trying to remove also looks buggy. The check
and replace of domain happens in each DMA API, but there isn't any lock
to serialize them.

Best regards,
Lu Baolu


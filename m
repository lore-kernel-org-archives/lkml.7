Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7567EC10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5C52077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfDWCOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:14:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:17352 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbfDWCOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 22:14:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 19:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,384,1549958400"; 
   d="scan'208";a="339873633"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2019 19:09:37 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v3 08/10] iommu/vt-d: Check whether device requires bounce
 buffer
To:     Christoph Hellwig <hch@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-9-baolu.lu@linux.intel.com>
 <20190422164755.GC31181@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <76e35340-32c3-ee0d-5232-bd8800248402@linux.intel.com>
Date:   Tue, 23 Apr 2019 10:03:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422164755.GC31181@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/23/19 12:47 AM, Christoph Hellwig wrote:
> On Sun, Apr 21, 2019 at 09:17:17AM +0800, Lu Baolu wrote:
>> +static inline bool device_needs_bounce(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = NULL;
>> +
>> +	if (intel_no_bounce)
>> +		return false;
>> +
>> +	if (dev_is_pci(dev))
>> +		pdev = to_pci_dev(dev);
>> +
>> +	return pdev ? pdev->untrusted : false;
>> +}
> 
> Again, this and the option should not be in a specific iommu driver.
> 

The option of whether bounce is ignored should be in the specific iommu
driver. Or any other thought?

Best regards,
Lu Baolu

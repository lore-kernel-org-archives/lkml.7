Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87591C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7313A20659
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfKNFRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 00:17:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:52002 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfKNFRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 00:17:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 21:17:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,302,1569308400"; 
   d="scan'208";a="229995322"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2019 21:17:08 -0800
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 02/10] iommu/vt-d: Use per-device dma_ops
To:     Christoph Hellwig <hch@lst.de>
References: <20190725031717.32317-1-baolu.lu@linux.intel.com>
 <20190725031717.32317-3-baolu.lu@linux.intel.com>
 <20190725054413.GC24527@lst.de>
 <bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com>
 <20190725114348.GA30957@lst.de>
 <a098359a-0f89-6028-68df-9f83718df256@linux.intel.com>
 <20191112071640.GA3343@lst.de>
 <0885617e-8390-6d18-987f-40d49f9f563e@linux.intel.com>
 <20191113070312.GA2735@lst.de> <20191113095353.GA5937@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0ddc8aff-783a-97b9-f5cc-9e27990de278@linux.intel.com>
Date:   Thu, 14 Nov 2019 13:14:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113095353.GA5937@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 11/13/19 5:53 PM, Christoph Hellwig wrote:
> On Wed, Nov 13, 2019 at 08:03:12AM +0100, Christoph Hellwig wrote:
>> Indeed.  And one idea would be to lift the code in the powerpc
>> dma_iommu_ops that check a flag and use the direct ops to the generic
>> dma code and a flag in struct device.  We can then switch the intel
>> iommu ops (and AMD Gart) over to it.
> 
> Let me know what you think of the branch below.  Only compile tested
> and booted on qemu with an emulated intel iommu:
> 
> 	http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-bypass
> 

I took a quick look at the related patches on the branch. Most of them
look good to me. But I would like to understand more about below logic.

static int intel_dma_supported(struct device *dev, u64 mask)
{
	struct device_domain_info *info = dev->archdata.iommu;
	int ret;

	ret = dma_direct_supported(dev, mask);
	if (ret < 0)
		return ret;

	if (!info || info == DUMMY_DEVICE_DOMAIN_INFO ||
			info == DEFER_DEVICE_DOMAIN_INFO) {
		dev->dma_ops_bypass = true;
	} else if (info->domain == si_domain) {
		if (mask < dma_direct_get_required_mask(dev)) {
			dev->dma_ops_bypass = false;
			intel_iommu_set_dma_domain(dev);
			dev_info(dev, "32bit DMA uses non-identity mapping\n");
		} else {
			dev->dma_ops_bypass = true;
		}
	} else {
		dev->dma_ops_bypass = false;
	}

	return 0;
}

Could you please educate me what dma_supported() is exactly for? Will
it always get called during boot? When will it be called?

In above implementation, why do we need to check dma_direct_supported()
at the beginning? And why

	if (!info || info == DUMMY_DEVICE_DOMAIN_INFO ||
			info == DEFER_DEVICE_DOMAIN_INFO) {
		dev->dma_ops_bypass = true;

Best regards,
baolu


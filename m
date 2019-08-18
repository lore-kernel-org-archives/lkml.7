Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFC8C3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 03:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8742089C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 03:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfHRDIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 23:08:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:33107 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfHRDIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 23:08:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Aug 2019 20:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,399,1559545200"; 
   d="scan'208";a="171787363"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2019 20:08:34 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH v6 5/8] iommu: Add bounce page APIs
To:     Christoph Hellwig <hch@lst.de>
References: <20190730045229.3826-1-baolu.lu@linux.intel.com>
 <20190730045229.3826-6-baolu.lu@linux.intel.com>
 <20190814083842.GB22669@8bytes.org>
 <445624e7-eb57-8089-8eb3-8687a65b1258@linux.intel.com>
 <20190815154845.GA18327@8bytes.org>
 <ec1dc4e2-626c-9c12-f17c-b51420fc2e81@linux.intel.com>
 <20190816044613.GC4093@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1eea1895-5063-ff33-1dd3-50371d03b3c8@linux.intel.com>
Date:   Sun, 18 Aug 2019 11:07:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816044613.GC4093@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/16/19 12:46 PM, Christoph Hellwig wrote:
> On Fri, Aug 16, 2019 at 10:45:13AM +0800, Lu Baolu wrote:
>> Okay. I understand that adding these APIs in iommu.c is not a good idea.
>> And, I also don't think merging the bounce buffer implementation into
>> iommu_map() is feasible since iommu_map() is not DMA API centric.
>>
>> The bounce buffer implementation will eventually be part of DMA APIs
>> defined in dma-iommu.c, but currently those APIs are not ready for x86
>> use yet. So I will put them in iommu/vt-d driver for this time being and
>> will move them to dma-iommu.c later.
> 
> I think they are more or less ready actually, we just need more people
> reviewing the conversions.  Tom just reposted the AMD one which will need
> a few more reviews, and he has an older patchset for intel-iommu as well
> that could use a some more eyes.
> 

Good progress and thanks for the update. I prefer that we merge this
patch series first since it addresses the real thunderbolt
vulnerability.

Best regards,
Lu Baolu

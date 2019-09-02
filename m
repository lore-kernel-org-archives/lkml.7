Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738D1C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F32214AE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfIBHRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:17:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:59546 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbfIBHRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:17:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:17:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="381777869"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2019 00:16:57 -0700
Cc:     baolu.lu@linux.intel.com,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "alan.cox@intel.com" <alan.cox@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "pengfei.xu@intel.com" <pengfei.xu@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v8 7/7] iommu/vt-d: Use bounce buffer for untrusted
 devices
To:     David Laight <David.Laight@ACULAB.COM>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190830071718.16613-1-baolu.lu@linux.intel.com>
 <20190830071718.16613-8-baolu.lu@linux.intel.com>
 <4dee1bcef8474ebb95a7826a58bb72aa@AcuMS.aculab.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <90de3797-d961-a3e5-36c9-d8328a3faab0@linux.intel.com>
Date:   Mon, 2 Sep 2019 15:15:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4dee1bcef8474ebb95a7826a58bb72aa@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 8/30/19 9:39 PM, David Laight wrote:
> From: Lu Baolu
>> Sent: 30 August 2019 08:17
> 
>> The Intel VT-d hardware uses paging for DMA remapping.
>> The minimum mapped window is a page size. The device
>> drivers may map buffers not filling the whole IOMMU
>> window. This allows the device to access to possibly
>> unrelated memory and a malicious device could exploit
>> this to perform DMA attacks. To address this, the
>> Intel IOMMU driver will use bounce pages for those
>> buffers which don't fill whole IOMMU pages.
> 
> Won't this completely kill performance?
> 
> I'd expect to see something for dma_alloc_coherent() (etc)
> that tries to give the driver page sized buffers.

Bounce page won't be used if driver request page sized buffers.

> 
> Either that or the driver could allocate page sized buffers
> even though it only passes fragments of these buffers to
> the dma functions (to avoid excessive cache invalidates).

Yes, agreed. One possible solution is to add a dma attribution and the
device driver could hint that the buffer under mapping is part of a page
sized buffer and iommu driver don't need to use bounce buffer for it.
This is in the todo list. We need to figure out which device driver
really needs this.

> 
> Since you have to trust the driver, why not actually trust it?
> 

In thunderbolt case, we trust driver, but we don't trust the hot-added
devices.

Best regards,
Baolu

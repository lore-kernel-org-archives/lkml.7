Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D2C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60EB23427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 14:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfH3O2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 10:28:01 -0400
Received: from foss.arm.com ([217.140.110.172]:33102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfH3O2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:28:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 743A0344;
        Fri, 30 Aug 2019 07:28:00 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A12BC3F703;
        Fri, 30 Aug 2019 07:27:56 -0700 (PDT)
Subject: Re: [PATCH v8 7/7] iommu/vt-d: Use bounce buffer for untrusted
 devices
To:     David Laight <David.Laight@ACULAB.COM>,
        'Lu Baolu' <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "alan.cox@intel.com" <alan.cox@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "pengfei.xu@intel.com" <pengfei.xu@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20190830071718.16613-1-baolu.lu@linux.intel.com>
 <20190830071718.16613-8-baolu.lu@linux.intel.com>
 <4dee1bcef8474ebb95a7826a58bb72aa@AcuMS.aculab.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <af54fa85-440a-52e4-cf6c-d2052ee9f385@arm.com>
Date:   Fri, 30 Aug 2019 15:27:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4dee1bcef8474ebb95a7826a58bb72aa@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2019 14:39, David Laight wrote:
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

Yes it will.

Though hopefully by now we're all well aware that speed and security 
being inversely proportional is the universal truth of modern computing.

> I'd expect to see something for dma_alloc_coherent() (etc)
> that tries to give the driver page sized buffers.

Coherent DMA already works in PAGE_SIZE units under the covers (at least 
in the DMA API implementations relevant here) - that's not an issue. The 
problem is streaming DMA, where we have to give the device access to, 
say, some pre-existing 64-byte data packet, from right in the middle of 
who knows what else. Since we do not necessarily have control over the 
who knows what else, the only universally-practical way to isolate the 
DMA data is to copy it away to some safe sanitised page which we *do* 
control, and make the actual DMA accesses target that.

> Either that or the driver could allocate page sized buffers
> even though it only passes fragments of these buffers to
> the dma functions (to avoid excessive cache invalidates).

Where, since we can't easily second-guess users' systems, "the driver" 
turns out to be every DMA-capable driver, every subsystem-level buffer 
manager, every userspace application which could possibly make use of 
some kind of zero-copy I/O call...

Compared to a single effectively-transparent implementation in a single 
place at the lowest level with a single switch for the user to turn it 
on or off depending on how security-critical their particular system is, 
I know which approach I'd rather review, maintain and rely on.

Robin.

> Since you have to trust the driver, why not actually trust it?
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

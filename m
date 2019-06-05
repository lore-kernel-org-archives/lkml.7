Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EE2C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC33206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfFEGzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:55:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:33713 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfFEGzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:55:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 23:55:49 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga004.jf.intel.com with ESMTP; 04 Jun 2019 23:55:45 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 7/9] iommu/vt-d: Add trace events for domain map/unmap
To:     Steven Rostedt <rostedt@goodmis.org>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
 <20190603011620.31999-8-baolu.lu@linux.intel.com>
 <20190604050122.4a095569@oasis.local.home>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <759e5f85-354c-fdf0-f31d-5df90481d75e@linux.intel.com>
Date:   Wed, 5 Jun 2019 14:48:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604050122.4a095569@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 6/4/19 5:01 PM, Steven Rostedt wrote:
> On Mon,  3 Jun 2019 09:16:18 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
> 
>> +TRACE_EVENT(bounce_unmap_single,
>> +	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
>> +
>> +	TP_ARGS(dev, dev_addr, size),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(dev_name, dev_name(dev))
>> +		__field(dma_addr_t, dev_addr)
>> +		__field(size_t,	size)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(dev_name, dev_name(dev));
>> +		__entry->dev_addr = dev_addr;
>> +		__entry->size = size;
>> +	),
>> +
>> +	TP_printk("dev=%s dev_addr=0x%llx size=%zu",
>> +		  __get_str(dev_name),
>> +		  (unsigned long long)__entry->dev_addr,
>> +		  __entry->size)
>> +);
>> +
>> +TRACE_EVENT(bounce_map_sg,
>> +	TP_PROTO(struct device *dev, unsigned int i, unsigned int nelems,
>> +		 dma_addr_t dev_addr, phys_addr_t phys_addr, size_t size),
>> +
>> +	TP_ARGS(dev, i, nelems, dev_addr, phys_addr, size),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(dev_name, dev_name(dev))
>> +		__field(unsigned int, i)
>> +		__field(unsigned int, last)
>> +		__field(dma_addr_t, dev_addr)
>> +		__field(phys_addr_t, phys_addr)
>> +		__field(size_t,	size)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(dev_name, dev_name(dev));
>> +		__entry->i = i;
>> +		__entry->last = nelems - 1;
>> +		__entry->dev_addr = dev_addr;
>> +		__entry->phys_addr = phys_addr;
>> +		__entry->size = size;
>> +	),
>> +
>> +	TP_printk("dev=%s elem=%u/%u dev_addr=0x%llx phys_addr=0x%llx size=%zu",
>> +		  __get_str(dev_name), __entry->i, __entry->last,
>> +		  (unsigned long long)__entry->dev_addr,
>> +		  (unsigned long long)__entry->phys_addr,
>> +		  __entry->size)
>> +);
>> +
>> +TRACE_EVENT(bounce_unmap_sg,
>> +	TP_PROTO(struct device *dev, unsigned int i, unsigned int nelems,
>> +		 dma_addr_t dev_addr, phys_addr_t phys_addr, size_t size),
>> +
>> +	TP_ARGS(dev, i, nelems, dev_addr, phys_addr, size),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(dev_name, dev_name(dev))
>> +		__field(unsigned int, i)
>> +		__field(unsigned int, last)
>> +		__field(dma_addr_t, dev_addr)
>> +		__field(phys_addr_t, phys_addr)
>> +		__field(size_t,	size)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(dev_name, dev_name(dev));
>> +		__entry->i = i;
>> +		__entry->last = nelems - 1;
>> +		__entry->dev_addr = dev_addr;
>> +		__entry->phys_addr = phys_addr;
>> +		__entry->size = size;
>> +	),
>> +
>> +	TP_printk("dev=%s elem=%u/%u dev_addr=0x%llx phys_addr=0x%llx size=%zu",
>> +		  __get_str(dev_name), __entry->i, __entry->last,
>> +		  (unsigned long long)__entry->dev_addr,
>> +		  (unsigned long long)__entry->phys_addr,
>> +		  __entry->size)
>> +);
> 
> These last two events look identical. Please use the
> DECLARE_EVENT_CLASS() to describe the event and then DEFINE_EVENT() for
> the two events.
> 
> Each TRACE_EVENT() can add up to 5k of data/text, where as a
> DEFINE_EVENT() just adds around 250 bytes.
> 
> (Note, a TRACE_EVENT() is defined as a
> DECLARE_EVENT_CLASS()/DEFINE_EVENT() pair)

Thanks for reviewing. I will rework this patch according to your
comments here.

> 
> -- Steve
> 

Best regards,
Baolu

> 
>> +#endif /* _TRACE_INTEL_IOMMU_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
> 
> 

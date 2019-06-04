Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F1BC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DF724088
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfFDJBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfFDJBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:01:33 -0400
Received: from oasis.local.home (unknown [146.247.46.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08BB24071;
        Tue,  4 Jun 2019 09:01:27 +0000 (UTC)
Date:   Tue, 4 Jun 2019 05:01:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
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
Subject: Re: [PATCH v4 7/9] iommu/vt-d: Add trace events for domain
 map/unmap
Message-ID: <20190604050122.4a095569@oasis.local.home>
In-Reply-To: <20190603011620.31999-8-baolu.lu@linux.intel.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
        <20190603011620.31999-8-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Jun 2019 09:16:18 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:


> +TRACE_EVENT(bounce_unmap_single,
> +	TP_PROTO(struct device *dev, dma_addr_t dev_addr, size_t size),
> +
> +	TP_ARGS(dev, dev_addr, size),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(dev))
> +		__field(dma_addr_t, dev_addr)
> +		__field(size_t,	size)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(dev));
> +		__entry->dev_addr = dev_addr;
> +		__entry->size = size;
> +	),
> +
> +	TP_printk("dev=%s dev_addr=0x%llx size=%zu",
> +		  __get_str(dev_name),
> +		  (unsigned long long)__entry->dev_addr,
> +		  __entry->size)
> +);
> +
> +TRACE_EVENT(bounce_map_sg,
> +	TP_PROTO(struct device *dev, unsigned int i, unsigned int nelems,
> +		 dma_addr_t dev_addr, phys_addr_t phys_addr, size_t size),
> +
> +	TP_ARGS(dev, i, nelems, dev_addr, phys_addr, size),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(dev))
> +		__field(unsigned int, i)
> +		__field(unsigned int, last)
> +		__field(dma_addr_t, dev_addr)
> +		__field(phys_addr_t, phys_addr)
> +		__field(size_t,	size)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(dev));
> +		__entry->i = i;
> +		__entry->last = nelems - 1;
> +		__entry->dev_addr = dev_addr;
> +		__entry->phys_addr = phys_addr;
> +		__entry->size = size;
> +	),
> +
> +	TP_printk("dev=%s elem=%u/%u dev_addr=0x%llx phys_addr=0x%llx size=%zu",
> +		  __get_str(dev_name), __entry->i, __entry->last,
> +		  (unsigned long long)__entry->dev_addr,
> +		  (unsigned long long)__entry->phys_addr,
> +		  __entry->size)
> +);
> +
> +TRACE_EVENT(bounce_unmap_sg,
> +	TP_PROTO(struct device *dev, unsigned int i, unsigned int nelems,
> +		 dma_addr_t dev_addr, phys_addr_t phys_addr, size_t size),
> +
> +	TP_ARGS(dev, i, nelems, dev_addr, phys_addr, size),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(dev))
> +		__field(unsigned int, i)
> +		__field(unsigned int, last)
> +		__field(dma_addr_t, dev_addr)
> +		__field(phys_addr_t, phys_addr)
> +		__field(size_t,	size)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name(dev));
> +		__entry->i = i;
> +		__entry->last = nelems - 1;
> +		__entry->dev_addr = dev_addr;
> +		__entry->phys_addr = phys_addr;
> +		__entry->size = size;
> +	),
> +
> +	TP_printk("dev=%s elem=%u/%u dev_addr=0x%llx phys_addr=0x%llx size=%zu",
> +		  __get_str(dev_name), __entry->i, __entry->last,
> +		  (unsigned long long)__entry->dev_addr,
> +		  (unsigned long long)__entry->phys_addr,
> +		  __entry->size)
> +);

These last two events look identical. Please use the
DECLARE_EVENT_CLASS() to describe the event and then DEFINE_EVENT() for
the two events.

Each TRACE_EVENT() can add up to 5k of data/text, where as a
DEFINE_EVENT() just adds around 250 bytes.

(Note, a TRACE_EVENT() is defined as a
DECLARE_EVENT_CLASS()/DEFINE_EVENT() pair)

-- Steve


> +#endif /* _TRACE_INTEL_IOMMU_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>


Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FFCC31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CF32147A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfFRPmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:42:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39396 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729655AbfFRPme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:42:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EE96F1CCB746BD506137;
        Tue, 18 Jun 2019 23:42:30 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Jun 2019
 23:42:27 +0800
Date:   Tue, 18 Jun 2019 16:42:15 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Eric Auger" <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi L <yi.l.liu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        <Liu@mail.linuxfoundation.org>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 02/22] iommu: Introduce device fault data
Message-ID: <20190618164215.00001772@huawei.com>
In-Reply-To: <1560087862-57608-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-3-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2019 06:44:02 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> Device faults detected by IOMMU can be reported outside the IOMMU
> subsystem for further processing. This patch introduces
> a generic device fault data structure.
> 
> The fault can be either an unrecoverable fault or a page request,
> also referred to as a recoverable fault.
> 
> We only care about non internal faults that are likely to be reported
> to an external subsystem.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

A few trivial nitpicks in here.

Otherwise looks straight forward and sensible to me.

Jonathan
> ---
>  include/linux/iommu.h      |  44 +++++++++++++++++
>  include/uapi/linux/iommu.h | 118 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 162 insertions(+)
>  create mode 100644 include/uapi/linux/iommu.h
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a815cf6..7890a92 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -25,6 +25,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> +#include <uapi/linux/iommu.h>
>  
>  #define IOMMU_READ	(1 << 0)
>  #define IOMMU_WRITE	(1 << 1)
> @@ -49,6 +50,7 @@ struct device;
>  struct iommu_domain;
>  struct notifier_block;
>  struct iommu_sva;
> +struct iommu_fault_event;
>  
>  /* iommu fault flags */
>  #define IOMMU_FAULT_READ	0x0
> @@ -58,6 +60,7 @@ typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
>  			struct device *, unsigned long, int, void *);
>  typedef int (*iommu_mm_exit_handler_t)(struct device *dev, struct iommu_sva *,
>  				       void *);
> +typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);
>  
>  struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be mapped    */
> @@ -301,6 +304,46 @@ struct iommu_device {
>  	struct device *dev;
>  };
>  
> +/**
> + * struct iommu_fault_event - Generic fault event
> + *
> + * Can represent recoverable faults such as a page requests or
> + * unrecoverable faults such as DMA or IRQ remapping faults.
> + *
> + * @fault: fault descriptor
> + * @iommu_private: used by the IOMMU driver for storing fault-specific
> + *                 data. Users should not modify this field before
> + *                 sending the fault response.
> + */
> +struct iommu_fault_event {
> +	struct iommu_fault fault;
> +	u64 iommu_private;
> +};
> +
> +/**
> + * struct iommu_fault_param - per-device IOMMU fault data
> + * @dev_fault_handler: Callback function to handle IOMMU faults at device level
> + * @data: handler private data
> + *

No need for this blank line.  Seems inconsistent with other docs in here.

Also, there is a docs fixup in patch 3 which should be pulled back to here.

> + */
> +struct iommu_fault_param {
> +	iommu_dev_fault_handler_t handler;
> +	void *data;
> +};
> +
> +/**
> + * struct iommu_param - collection of per-device IOMMU data
> + *
> + * @fault_param: IOMMU detected device fault reporting data
> + *
> + * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
> + *	struct iommu_group	*iommu_group;
> + *	struct iommu_fwspec	*iommu_fwspec;
> + */
> +struct iommu_param {
> +	struct iommu_fault_param *fault_param;
Is it actually worth having the indirection of a pointer here as opposed
to just embedding the actual structure?  The null value is used in places
but can just use the handler being null for the same job I think...

It reduces the code needed in patch 3 a bit.

It gets a bit bigger in patch 4, but is still only about 16 bytes.

> +};
> +
>  int  iommu_device_register(struct iommu_device *iommu);
>  void iommu_device_unregister(struct iommu_device *iommu);
>  int  iommu_device_sysfs_add(struct iommu_device *iommu,
> @@ -504,6 +547,7 @@ struct iommu_ops {};
>  struct iommu_group {};
>  struct iommu_fwspec {};
>  struct iommu_device {};
> +struct iommu_fault_param {};
>  
>  static inline bool iommu_present(struct bus_type *bus)
>  {
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> new file mode 100644
> index 0000000..aaa3b6a
> --- /dev/null
> +++ b/include/uapi/linux/iommu.h
> @@ -0,0 +1,118 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * IOMMU user API definitions
> + */
> +
> +#ifndef _UAPI_IOMMU_H
> +#define _UAPI_IOMMU_H
> +
> +#include <linux/types.h>
> +
> +#define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
> +#define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
> +#define IOMMU_FAULT_PERM_EXEC	(1 << 2) /* exec */
> +#define IOMMU_FAULT_PERM_PRIV	(1 << 3) /* privileged */
> +
> +/* Generic fault types, can be expanded IRQ remapping fault */
> +enum iommu_fault_type {
> +	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable fault */
> +	IOMMU_FAULT_PAGE_REQ,		/* page request fault */
> +};
> +
> +enum iommu_fault_reason {
> +	IOMMU_FAULT_REASON_UNKNOWN = 0,
> +
> +	/* Could not access the PASID table (fetch caused external abort) */
> +	IOMMU_FAULT_REASON_PASID_FETCH,
> +
> +	/* PASID entry is invalid or has configuration errors */
> +	IOMMU_FAULT_REASON_BAD_PASID_ENTRY,
> +
> +	/*
> +	 * PASID is out of range (e.g. exceeds the maximum PASID
> +	 * supported by the IOMMU) or disabled.
> +	 */
> +	IOMMU_FAULT_REASON_PASID_INVALID,
> +
> +	/*
> +	 * An external abort occurred fetching (or updating) a translation
> +	 * table descriptor
> +	 */
> +	IOMMU_FAULT_REASON_WALK_EABT,
> +
> +	/*
> +	 * Could not access the page table entry (Bad address),
> +	 * actual translation fault
> +	 */
> +	IOMMU_FAULT_REASON_PTE_FETCH,
> +
> +	/* Protection flag check failed */
> +	IOMMU_FAULT_REASON_PERMISSION,
> +
> +	/* access flag check failed */

Nitpick: Inconsistent capitalization of first word in comment :)

> +	IOMMU_FAULT_REASON_ACCESS,
> +
> +	/* Output address of a translation stage caused Address Size fault */
> +	IOMMU_FAULT_REASON_OOR_ADDRESS,
> +};
> +
> +/**
> + * struct iommu_fault_unrecoverable - Unrecoverable fault data
> + * @reason: reason of the fault, from &enum iommu_fault_reason
> + * @flags: parameters of this fault (IOMMU_FAULT_UNRECOV_* values)
> + * @pasid: Process Address Space ID
> + * @perm: Requested permission access using by the incoming transaction
> + *        (IOMMU_FAULT_PERM_* values)
> + * @addr: offending page address
> + * @fetch_addr: address that caused a fetch abort, if any
> + */
> +struct iommu_fault_unrecoverable {
> +	__u32	reason;
> +#define IOMMU_FAULT_UNRECOV_PASID_VALID		(1 << 0)
> +#define IOMMU_FAULT_UNRECOV_ADDR_VALID		(1 << 1)
> +#define IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID	(1 << 2)
> +	__u32	flags;
> +	__u32	pasid;
> +	__u32	perm;
> +	__u64	addr;
> +	__u64	fetch_addr;
> +};
> +
> +/**
> + * struct iommu_fault_page_request - Page Request data
> + * @flags: encodes whether the corresponding fields are valid and whether this
> + *         is the last page in group (IOMMU_FAULT_PAGE_REQUEST_* values)
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @perm: requested page permissions (IOMMU_FAULT_PERM_* values)
> + * @addr: page address
> + * @private_data: device-specific private information
> + */

Slightly surprised to see this given cover letter says no PRS.
I guess it is part of the original patch rather than intended
for this series.. Not a problem as far as I'm concerned.

> +struct iommu_fault_page_request {
> +#define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
> +#define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
> +#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
> +	__u32	flags;
> +	__u32	pasid;
> +	__u32	grpid;
> +	__u32	perm;
> +	__u64	addr;
> +	__u64	private_data[2];
> +};
> +
> +/**
> + * struct iommu_fault - Generic fault data
> + * @type: fault type from &enum iommu_fault_type
> + * @padding: reserved for future use (should be zero)
> + * @event: Fault event, when @type is %IOMMU_FAULT_DMA_UNRECOV
> + * @prm: Page Request message, when @type is %IOMMU_FAULT_PAGE_REQ
> + */
> +struct iommu_fault {
> +	__u32	type;
> +	__u32	padding;
> +	union {
> +		struct iommu_fault_unrecoverable event;
> +		struct iommu_fault_page_request prm;
> +	};
> +};
> +#endif /* _UAPI_IOMMU_H */



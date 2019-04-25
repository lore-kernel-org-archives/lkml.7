Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5126CC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F3321904
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfDYKR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:17:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfDYKR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:17:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F084C0AF7B5;
        Thu, 25 Apr 2019 10:17:58 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B72E272A3;
        Thu, 25 Apr 2019 10:17:52 +0000 (UTC)
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <4550408f-39ff-7bf9-0072-a0898c6c2f60@redhat.com>
Date:   Thu, 25 Apr 2019 12:17:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 25 Apr 2019 10:17:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe, Jacob,
On 4/24/19 1:31 AM, Jacob Pan wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> Some devices might support multiple DMA address spaces, in particular
> those that have the PCI PASID feature. PASID (Process Address Space ID)
> allows to share process address spaces with devices (SVA), partition a
> device into VM-assignable entities (VFIO mdev) or simply provide
> multiple DMA address space to kernel drivers. Add a global PASID
> allocator usable by different drivers at the same time. Name it I/O ASID
> to avoid confusion with ASIDs allocated by arch code, which are usually
> a separate ID space.
> 
> The IOASID space is global. Each device can have its own PASID space,
> but by convention the IOMMU ended up having a global PASID space, so
> that with SVA, each mm_struct is associated to a single PASID.
> 
> The allocator doesn't really belong in drivers/iommu because some
> drivers would like to allocate PASIDs for devices that aren't managed by
> an IOMMU, using the same ID space as IOMMU. It doesn't really belong in
> drivers/pci either since platform device also support PASID. Add the
> allocator in drivers/base.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/base/Kconfig   |   6 +++
>  drivers/base/Makefile  |   1 +
>  drivers/base/ioasid.c  | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |  40 +++++++++++++++++++
>  4 files changed, 153 insertions(+)
>  create mode 100644 drivers/base/ioasid.c
>  create mode 100644 include/linux/ioasid.h
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 059700e..47c1348 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -182,6 +182,12 @@ config DMA_SHARED_BUFFER
>  	  APIs extension; the file's descriptor can then be passed on to other
>  	  driver.
>  
> +config IOASID
> +	bool
> +	help
> +	  Enable the I/O Address Space ID allocator. A single ID space shared
> +	  between different users.
> +
>  config DMA_FENCE_TRACE
>  	bool "Enable verbose DMA_FENCE_TRACE messages"
>  	depends on DMA_SHARED_BUFFER
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 1574520..aafa2ac 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_PINCTRL) += pinctrl.o
>  obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
>  obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
>  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
> +obj-$(CONFIG_IOASID) += ioasid.o
>  
>  obj-y			+= test/
>  
> diff --git a/drivers/base/ioasid.c b/drivers/base/ioasid.c
> new file mode 100644
> index 0000000..cf122b2
> --- /dev/null
> +++ b/drivers/base/ioasid.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * I/O Address Space ID allocator. There is one global IOASID space, split into
> + * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
> + * free IOASIDs with ioasid_alloc and ioasid_free.
> + */
> +#include <linux/idr.h>
> +#include <linux/ioasid.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +struct ioasid_data {
> +	ioasid_t id;
> +	struct ioasid_set *set;
> +	void *private;
> +	struct rcu_head rcu;
> +};
> +
> +static DEFINE_IDR(ioasid_idr);
> +
> +/**
> + * ioasid_alloc - Allocate an IOASID
> + * @set: the IOASID set
> + * @min: the minimum ID (inclusive)
> + * @max: the maximum ID (exclusive)
> + * @private: data private to the caller
> + *
> + * Allocate an ID between @min and @max (or %0 and %INT_MAX). Return the
I would remove "(or %0 and %INT_MAX)".
> + * allocated ID on success, or INVALID_IOASID on failure. The @private pointer
> + * is stored internally and can be retrieved with ioasid_find().
> + */
> +ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
> +		      void *private)
> +{
> +	int id = -1;
> +	struct ioasid_data *data;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return INVALID_IOASID;
> +
> +	data->set = set;
> +	data->private = private;
> +
> +	idr_preload(GFP_KERNEL);
> +	idr_lock(&ioasid_idr);
> +	data->id = id = idr_alloc(&ioasid_idr, data, min, max, GFP_ATOMIC);
> +	idr_unlock(&ioasid_idr);
> +	idr_preload_end();
> +
> +	if (id < 0) {
> +		kfree(data);
> +		return INVALID_IOASID;
> +	}
> +	return id;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_alloc);
> +
> +/**
> + * ioasid_free - Free an IOASID
> + * @ioasid: the ID to remove
> + */
> +void ioasid_free(ioasid_t ioasid)
> +{
> +	struct ioasid_data *ioasid_data;
> +
> +	idr_lock(&ioasid_idr);
> +	ioasid_data = idr_remove(&ioasid_idr, ioasid);
> +	idr_unlock(&ioasid_idr);
> +
> +	if (ioasid_data)
> +		kfree_rcu(ioasid_data, rcu);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_free);
> +
> +/**
> + * ioasid_find - Find IOASID data
> + * @set: the IOASID set
> + * @ioasid: the IOASID to find
> + * @getter: function to call on the found object
> + *
> + * The optional getter function allows to take a reference to the found object
> + * under the rcu lock. The function can also check if the object is still valid:
> + * if @getter returns false, then the object is invalid and NULL is returned.
> + *
> + * If the IOASID has been allocated for this set, return the private pointer
> + * passed to ioasid_alloc. Otherwise return NULL.
> + */
> +void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
> +		  bool (*getter)(void *))
> +{
> +	void *priv = NULL;
> +	struct ioasid_data *ioasid_data;
> +
> +	rcu_read_lock();
> +	ioasid_data = idr_find(&ioasid_idr, ioasid);
> +	if (ioasid_data && ioasid_data->set == set) {
> +		priv = ioasid_data->private;
> +		if (getter && !getter(priv))
> +			priv = NULL;
> +	}
> +	rcu_read_unlock();
> +
> +	return priv;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_find);
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> new file mode 100644
> index 0000000..6f3655a
> --- /dev/null
> +++ b/include/linux/ioasid.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_IOASID_H
> +#define __LINUX_IOASID_H
> +
> +#define INVALID_IOASID ((ioasid_t)-1)
> +typedef unsigned int ioasid_t;
> +typedef int (*ioasid_iter_t)(ioasid_t ioasid, void *private, void *data);
I don't see it used in this series.
> +
> +struct ioasid_set {
> +	int dummy;
> +};
> +
> +#define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
> +
> +#ifdef CONFIG_IOASID
> +ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
> +		      void *private);
> +void ioasid_free(ioasid_t ioasid);
> +
> +void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
> +		  bool (*getter)(void *));
> +
> +#else /* !CONFIG_IOASID */
> +static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> +				    ioasid_t max, void *private)
> +{
> +	return INVALID_IOASID;
> +}
> +
> +static inline void ioasid_free(ioasid_t ioasid)
> +{
> +}
> +
> +static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
> +				bool (*getter)(void *))
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_IOASID */
> +#endif /* __LINUX_IOASID_H */
> 

Thanks

Eric

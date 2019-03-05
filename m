Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD2C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91D920684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfCEPEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:04:06 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49494 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfCEPEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:04:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 117AB80D;
        Tue,  5 Mar 2019 07:04:05 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F2883F575;
        Tue,  5 Mar 2019 07:04:02 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v4 03/22] iommu: introduce device fault report API
To:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, will.deacon@arm.com, robin.murphy@arm.com
Cc:     marc.zyngier@arm.com, peter.maydell@linaro.org,
        kevin.tian@intel.com, ashok.raj@intel.com, christoffer.dall@arm.com
References: <20190218135504.25048-1-eric.auger@redhat.com>
 <20190218135504.25048-4-eric.auger@redhat.com>
Message-ID: <fb5f84e6-812f-978d-3be1-673b3e9717ad@arm.com>
Date:   Tue, 5 Mar 2019 15:03:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218135504.25048-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2019 13:54, Eric Auger wrote:
[...]> +/**
> + * iommu_register_device_fault_handler() - Register a device fault handler
> + * @dev: the device
> + * @handler: the fault handler
> + * @data: private data passed as argument to the handler
> + *
> + * When an IOMMU fault event is received, call this handler with the fault event
> + * and data as argument. The handler should return 0 on success. If the fault is
> + * recoverable (IOMMU_FAULT_PAGE_REQ), the handler can also complete
> + * the fault by calling iommu_page_response() with one of the following
> + * response code:
> + * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
> + * - IOMMU_PAGE_RESP_INVALID: terminate the fault
> + * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop reporting
> + *   page faults if possible.

The comment refers to function and values that haven't been defined yet.
Either the page_response() patch should come before, or we need to split
this patch.

Something I missed before: if the handler fails (returns != 0) it should
complete the fault by calling iommu_page_response(), if we're not doing
it in iommu_report_device_fault(). It should be indicated in this
comment. It's safe for the handler to call page_response() since we're
not holding fault_param->lock when calling the handler.

> + *
> + * Return 0 if the fault handler was installed successfully, or an error.
> + */
[...]
> +/**
> + * iommu_report_device_fault() - Report fault event to device
> + * @dev: the device
> + * @evt: fault event data
> + *
> + * Called by IOMMU model specific drivers when fault is detected, typically
> + * in a threaded IRQ handler.
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
> +{
> +	int ret = 0;
> +	struct iommu_fault_event *evt_pending;
> +	struct iommu_fault_param *fparam;
> +
> +	/* iommu_param is allocated when device is added to group */
> +	if (!dev->iommu_param | !evt)

Typo: ||

Thanks,
Jean

> +		return -EINVAL;
> +	/* we only report device fault if there is a handler registered */
> +	mutex_lock(&dev->iommu_param->lock);
> +	if (!dev->iommu_param->fault_param ||
> +		!dev->iommu_param->fault_param->handler) {
> +		ret = -EINVAL;
> +		goto done_unlock;
> +	}
> +	fparam = dev->iommu_param->fault_param;
> +	if (evt->fault.type == IOMMU_FAULT_PAGE_REQ &&
> +	    evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE) {
> +		evt_pending = kmemdup(evt, sizeof(struct iommu_fault_event),
> +				GFP_KERNEL);
> +		if (!evt_pending) {
> +			ret = -ENOMEM;
> +			goto done_unlock;
> +		}
> +		mutex_lock(&fparam->lock);
> +		list_add_tail(&evt_pending->list, &fparam->faults);
> +		mutex_unlock(&fparam->lock);
> +	}
> +	ret = fparam->handler(evt, fparam->data);
> +done_unlock:
> +	mutex_unlock(&dev->iommu_param->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_report_device_fault);
[...]

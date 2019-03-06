Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26018C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBC920684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCFXoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:44:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:39716 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCFXoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:44:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 15:44:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,449,1544515200"; 
   d="scan'208";a="123285952"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 06 Mar 2019 15:44:00 -0800
Date:   Wed, 6 Mar 2019 15:46:16 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, yi.l.liu@linux.intel.com,
        will.deacon@arm.com, robin.murphy@arm.com, marc.zyngier@arm.com,
        peter.maydell@linaro.org, kevin.tian@intel.com,
        ashok.raj@intel.com, christoffer.dall@arm.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 03/22] iommu: introduce device fault report API
Message-ID: <20190306154616.648e2523@jacob-builder>
In-Reply-To: <fb5f84e6-812f-978d-3be1-673b3e9717ad@arm.com>
References: <20190218135504.25048-1-eric.auger@redhat.com>
        <20190218135504.25048-4-eric.auger@redhat.com>
        <fb5f84e6-812f-978d-3be1-673b3e9717ad@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019 15:03:41 +0000
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 18/02/2019 13:54, Eric Auger wrote:
> [...]> +/**
> > + * iommu_register_device_fault_handler() - Register a device fault
> > handler
> > + * @dev: the device
> > + * @handler: the fault handler
> > + * @data: private data passed as argument to the handler
> > + *
> > + * When an IOMMU fault event is received, call this handler with
> > the fault event
> > + * and data as argument. The handler should return 0 on success.
> > If the fault is
> > + * recoverable (IOMMU_FAULT_PAGE_REQ), the handler can also
> > complete
> > + * the fault by calling iommu_page_response() with one of the
> > following
> > + * response code:
> > + * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
> > + * - IOMMU_PAGE_RESP_INVALID: terminate the fault
> > + * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop
> > reporting
> > + *   page faults if possible.  
> 
> The comment refers to function and values that haven't been defined
> yet. Either the page_response() patch should come before, or we need
> to split this patch.
> 
> Something I missed before: if the handler fails (returns != 0) it
> should complete the fault by calling iommu_page_response(), if we're
> not doing it in iommu_report_device_fault(). It should be indicated
> in this comment. It's safe for the handler to call page_response()
> since we're not holding fault_param->lock when calling the handler.
> 
If the page request fault is to be reported to a guest, the report
function cannot wait for the completion status. As long as the fault is
injected into the guest, the handler should complete with success. If
the PRQ report fails, IMHO, the caller of iommu_report_device_fault()
should send page_response, perhaps after clean up all partial response
of the group too.

> > + *
> > + * Return 0 if the fault handler was installed successfully, or an
> > error.
> > + */  
> [...]
> > +/**
> > + * iommu_report_device_fault() - Report fault event to device
> > + * @dev: the device
> > + * @evt: fault event data
> > + *
> > + * Called by IOMMU model specific drivers when fault is detected,
> > typically
> > + * in a threaded IRQ handler.
> > + *
> > + * Return 0 on success, or an error.
> > + */
> > +int iommu_report_device_fault(struct device *dev, struct
> > iommu_fault_event *evt) +{
> > +	int ret = 0;
> > +	struct iommu_fault_event *evt_pending;
> > +	struct iommu_fault_param *fparam;
> > +
> > +	/* iommu_param is allocated when device is added to group
> > */
> > +	if (!dev->iommu_param | !evt)  
> 
> Typo: ||
> 
> Thanks,
> Jean
> 
> > +		return -EINVAL;
> > +	/* we only report device fault if there is a handler
> > registered */
> > +	mutex_lock(&dev->iommu_param->lock);
> > +	if (!dev->iommu_param->fault_param ||
> > +		!dev->iommu_param->fault_param->handler) {
> > +		ret = -EINVAL;
> > +		goto done_unlock;
> > +	}
> > +	fparam = dev->iommu_param->fault_param;
> > +	if (evt->fault.type == IOMMU_FAULT_PAGE_REQ &&
> > +	    evt->fault.prm.flags &
> > IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE) {
> > +		evt_pending = kmemdup(evt, sizeof(struct
> > iommu_fault_event),
> > +				GFP_KERNEL);
> > +		if (!evt_pending) {
> > +			ret = -ENOMEM;
> > +			goto done_unlock;
> > +		}
> > +		mutex_lock(&fparam->lock);
> > +		list_add_tail(&evt_pending->list, &fparam->faults);
> > +		mutex_unlock(&fparam->lock);
> > +	}
> > +	ret = fparam->handler(evt, fparam->data);
> > +done_unlock:
> > +	mutex_unlock(&dev->iommu_param->lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_report_device_fault);  
> [...]

[Jacob Pan]

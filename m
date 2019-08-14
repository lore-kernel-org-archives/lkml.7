Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84076C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60797206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfHNRQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:16:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:45982 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbfHNRQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:16:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 10:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="scan'208";a="181628377"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 14 Aug 2019 10:16:49 -0700
Date:   Wed, 14 Aug 2019 10:20:32 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 20/22] iommu/vt-d: Add bind guest PASID support
Message-ID: <20190814102032.5265e1da@jacob-builder>
In-Reply-To: <840a6943-87ab-938f-5f8d-3a2c21e08549@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-21-git-send-email-jacob.jun.pan@linux.intel.com>
        <f183139b-b5a8-f6b5-58e6-f93e01f7be6a@linux.intel.com>
        <20190627132244.351c7426@jacob-builder>
        <840a6943-87ab-938f-5f8d-3a2c21e08549@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2019 10:21:27 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 6/28/19 4:22 AM, Jacob Pan wrote:
> >>> +		}
> >>> +		refcount_set(&svm->refs, 0);
> >>> +		ioasid_set_data(data->hpasid, svm);
> >>> +		INIT_LIST_HEAD_RCU(&svm->devs);
> >>> +		INIT_LIST_HEAD(&svm->list);
> >>> +
> >>> +		mmput(svm->mm);
> >>> +	}
> >>> +	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
> >>> +	if (!sdev) {
> >>> +		ret = -ENOMEM;
> >>> +		goto out;  
> >> I think you need to clean up svm if its device list is empty here,
> >> as you said above:
> >>  
> > No, we come here only if the device list is not empty and the new
> > device to bind is different than any existing device in the list.
> > If we cannot allocate memory for the new device, should not free
> > the existing SVM, right?
> >   
> 
> I'm sorry, but the code doesn't show this. We come here even an svm
> data structure was newly created with an empty device list. I post
> the code below to ensure that we are reading a same piece of code.
> 
Sorry for the delay. You are right, I need to clean up svm if device
list is empty.

Thanks!
>          mutex_lock(&pasid_mutex);
>          svm = ioasid_find(NULL, data->hpasid, NULL);
>          if (IS_ERR(svm)) {
>                  ret = PTR_ERR(svm);
>                  goto out;
>          }
>          if (svm) {
>                  /*
>                   * If we found svm for the PASID, there must be at
>                   * least one device bond, otherwise svm should be
> freed. */
>                  BUG_ON(list_empty(&svm->devs));
> 
>                  for_each_svm_dev() {
>                          /* In case of multiple sub-devices of the
> same pdev assigned, we should
>                           * allow multiple bind calls with the same 
> PASID and pdev.
>                           */
>                          sdev->users++;
>                          goto out;
>                  }
>          } else {
>                  /* We come here when PASID has never been bond to a 
> device. */
>                  svm = kzalloc(sizeof(*svm), GFP_KERNEL);
>                  if (!svm) {
>                          ret = -ENOMEM;
>                          goto out;
>                  }
>                  /* REVISIT: upper layer/VFIO can track host process 
> that bind the PASID.
>                   * ioasid_set = mm might be sufficient for vfio to 
> check pasid VMM
>                   * ownership.
>                   */
>                  svm->mm = get_task_mm(current);
>                  svm->pasid = data->hpasid;
>                  if (data->flags & IOMMU_SVA_GPASID_VAL) {
>                          svm->gpasid = data->gpasid;
>                          svm->flags &= SVM_FLAG_GUEST_PASID;
>                  }
>                  refcount_set(&svm->refs, 0);
>                  ioasid_set_data(data->hpasid, svm);
>                  INIT_LIST_HEAD_RCU(&svm->devs);
>                  INIT_LIST_HEAD(&svm->list);
> 
>                  mmput(svm->mm);
>          }
>          sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
>          if (!sdev) {
>                  ret = -ENOMEM;
>                  goto out;
>          }
>          sdev->dev = dev;
>          sdev->users = 1;
> 
> Best regards,
> Baolu

[Jacob Pan]

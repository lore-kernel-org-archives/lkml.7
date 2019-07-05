Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E208C0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8BF21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfGEC3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 22:29:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:41777 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfGEC3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:29:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 19:29:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,453,1557212400"; 
   d="scan'208";a="248066440"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga001.jf.intel.com with ESMTP; 04 Jul 2019 19:29:05 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
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
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 20/22] iommu/vt-d: Add bind guest PASID support
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1560087862-57608-21-git-send-email-jacob.jun.pan@linux.intel.com>
 <f183139b-b5a8-f6b5-58e6-f93e01f7be6a@linux.intel.com>
 <20190627132244.351c7426@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <840a6943-87ab-938f-5f8d-3a2c21e08549@linux.intel.com>
Date:   Fri, 5 Jul 2019 10:21:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627132244.351c7426@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 6/28/19 4:22 AM, Jacob Pan wrote:
>>> +		}
>>> +		refcount_set(&svm->refs, 0);
>>> +		ioasid_set_data(data->hpasid, svm);
>>> +		INIT_LIST_HEAD_RCU(&svm->devs);
>>> +		INIT_LIST_HEAD(&svm->list);
>>> +
>>> +		mmput(svm->mm);
>>> +	}
>>> +	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
>>> +	if (!sdev) {
>>> +		ret = -ENOMEM;
>>> +		goto out;
>> I think you need to clean up svm if its device list is empty here, as
>> you said above:
>>
> No, we come here only if the device list is not empty and the new
> device to bind is different than any existing device in the list. If we
> cannot allocate memory for the new device, should not free the existing
> SVM, right?
> 

I'm sorry, but the code doesn't show this. We come here even an svm data
structure was newly created with an empty device list. I post the code
below to ensure that we are reading a same piece of code.

         mutex_lock(&pasid_mutex);
         svm = ioasid_find(NULL, data->hpasid, NULL);
         if (IS_ERR(svm)) {
                 ret = PTR_ERR(svm);
                 goto out;
         }
         if (svm) {
                 /*
                  * If we found svm for the PASID, there must be at
                  * least one device bond, otherwise svm should be freed.
                  */
                 BUG_ON(list_empty(&svm->devs));

                 for_each_svm_dev() {
                         /* In case of multiple sub-devices of the same 
pdev assigned, we should
                          * allow multiple bind calls with the same 
PASID and pdev.
                          */
                         sdev->users++;
                         goto out;
                 }
         } else {
                 /* We come here when PASID has never been bond to a 
device. */
                 svm = kzalloc(sizeof(*svm), GFP_KERNEL);
                 if (!svm) {
                         ret = -ENOMEM;
                         goto out;
                 }
                 /* REVISIT: upper layer/VFIO can track host process 
that bind the PASID.
                  * ioasid_set = mm might be sufficient for vfio to 
check pasid VMM
                  * ownership.
                  */
                 svm->mm = get_task_mm(current);
                 svm->pasid = data->hpasid;
                 if (data->flags & IOMMU_SVA_GPASID_VAL) {
                         svm->gpasid = data->gpasid;
                         svm->flags &= SVM_FLAG_GUEST_PASID;
                 }
                 refcount_set(&svm->refs, 0);
                 ioasid_set_data(data->hpasid, svm);
                 INIT_LIST_HEAD_RCU(&svm->devs);
                 INIT_LIST_HEAD(&svm->list);

                 mmput(svm->mm);
         }
         sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
         if (!sdev) {
                 ret = -ENOMEM;
                 goto out;
         }
         sdev->dev = dev;
         sdev->users = 1;

Best regards,
Baolu

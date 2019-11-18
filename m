Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C9BC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AF9222BF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKRScH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:32:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:13370 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfKRScH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:32:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 10:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="217973838"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2019 10:32:06 -0800
Date:   Mon, 18 Nov 2019 10:36:41 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 10/10] iommu/vt-d: Misc macro clean up for SVM
Message-ID: <20191118103641.24e73c7d@jacob-builder>
In-Reply-To: <ac725526-0396-e9c6-196e-b0d1cf5431fe@linux.intel.com>
References: <1573859377-75924-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1573859377-75924-11-git-send-email-jacob.jun.pan@linux.intel.com>
        <ac725526-0396-e9c6-196e-b0d1cf5431fe@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 10:23:34 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 11/16/19 7:09 AM, Jacob Pan wrote:
> > Use combined macros for_each_svm_dev() to simplify SVM device
> > iteration and error checking.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >   drivers/iommu/intel-svm.c | 85
> > ++++++++++++++++++++++------------------------- 1 file changed, 40
> > insertions(+), 45 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 189865501411..a7f67a9da3fc 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -226,6 +226,10 @@ static const struct mmu_notifier_ops
> > intel_mmuops = { static DEFINE_MUTEX(pasid_mutex);
> >   static LIST_HEAD(global_svm_list);
> >   
> > +#define for_each_svm_dev(sdev, svm, dev)		\
> > +	list_for_each_entry(sdev, &svm->devs, list)	\
> > +		if (dev != sdev->dev) {} else  
> 
> "dev" has been reused in "sdev->dev", how about below?
> 
> #define for_each_svm_dev(sdev, svm, d)                  \
>          list_for_each_entry((sdev), &(svm)->devs, list) \
>                  if ((d) != (sdev)->dev) {} else
> 
sounds good. will do.

> Best regards,
> baolu
> 
> 
>  [...]  

[Jacob Pan]

Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47895C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FD020679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfFXX4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:56:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:57752 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbfFXX4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:56:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 16:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="336667312"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 24 Jun 2019 16:56:35 -0700
Date:   Mon, 24 Jun 2019 16:59:51 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Eric Auger" <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 19/22] iommu/vt-d: Clean up for SVM device list
Message-ID: <20190624165951.0646b788@jacob-builder>
In-Reply-To: <20190618174237.00000556@huawei.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-20-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190618174237.00000556@huawei.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 17:42:37 +0100
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Sun, 9 Jun 2019 06:44:19 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Use combined macro for_each_svm_dev() to simplify SVM device
> > iteration.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >  drivers/iommu/intel-svm.c | 79
> > +++++++++++++++++++++++------------------------ 1 file changed, 39
> > insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 9cbcc1f..66d98e1 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -225,6 +225,9 @@ static const struct mmu_notifier_ops
> > intel_mmuops = { 
> >  static DEFINE_MUTEX(pasid_mutex);
> >  static LIST_HEAD(global_svm_list);
> > +#define for_each_svm_dev() \
> > +	list_for_each_entry(sdev, &svm->devs, list)	\
> > +	if (dev == sdev->dev)				\  
> 
> Could we make this macro less opaque and have it take the svm and dev
> as arguments?
> 
sounds good, it makes the code more readable.

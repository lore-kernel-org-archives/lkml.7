Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F03CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 23:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1E622303
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 23:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKRXdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 18:33:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:10129 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfKRXdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 18:33:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 15:33:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="380824660"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2019 15:33:51 -0800
Date:   Mon, 18 Nov 2019 15:38:27 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 08/10] iommu/vt-d: Fix PASID cache flush
Message-ID: <20191118153827.4748c015@jacob-builder>
In-Reply-To: <38c0f6f0-b751-6b23-2292-5f08bdfff5c9@redhat.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1574106153-45867-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <38c0f6f0-b751-6b23-2292-5f08bdfff5c9@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 22:19:03 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> On 11/18/19 8:42 PM, Jacob Pan wrote:
> > Use the correct invalidation descriptor type and granularity.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/intel-pasid.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index 3cb569e76642..ee6ea1bbd917
> > 100644 --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -365,7 +365,8 @@ pasid_cache_invalidation_with_pasid(struct
> > intel_iommu *iommu, {
> >  	struct qi_desc desc;
> >  
> > -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL |
> > QI_PC_PASID(pasid);
> > +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
> > +		QI_PC_PASID(pasid) | QI_PC_TYPE;  
> Hum I am confused
> 
> #define QI_PC_PASID_SEL         (QI_PC_TYPE | QI_PC_GRAN(1))
> 
My mistake. I redefined QI_PC_PASID_SEL and QI_PC_ALL_PASIDS without
QI_PCI_TYPE such that they can be used in the granularity conversion
table. But did not include in this patch. I will drop this patch and
keep it with the next series.

> So the original looks correct to me?
> 
> Thanks
> 
> Eric
> 
> 
> 
> >  	desc.qw1 = 0;
> >  	desc.qw2 = 0;
> >  	desc.qw3 = 0;
> >   
> 

[Jacob Pan]

Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31BEC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69317208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfEMWNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:13:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:56853 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfEMWNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:13:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 15:13:45 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 13 May 2019 15:13:44 -0700
Date:   Mon, 13 May 2019 15:16:37 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 02/16] iommu: Introduce cache_invalidate API
Message-ID: <20190513151637.79c273e2@jacob-builder>
In-Reply-To: <1a5a5fad-ed21-5c79-9a9e-ff21fadfb95f@arm.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556922737-76313-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <d32d3d19-11c9-4af9-880b-bb8ebefd4f7f@redhat.com>
        <44d5ba37-a9e9-cc7a-2a3a-d32b840afa29@arm.com>
        <7807afe9-efab-9f48-4ca0-2332a7a54950@redhat.com>
        <1a5a5fad-ed21-5c79-9a9e-ff21fadfb95f@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 18:09:48 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 13/05/2019 17:50, Auger Eric wrote:
> >> struct iommu_inv_pasid_info {
> >> #define IOMMU_INV_PASID_FLAGS_PASID	(1 << 0)
> >> #define IOMMU_INV_PASID_FLAGS_ARCHID	(1 << 1)
> >> 	__u32	flags;
> >> 	__u32	archid;
> >> 	__u64	pasid;
> >> };  
> > I agree it does the job now. However it looks a bit strange to do a
> > PASID based invalidation in my case - SMMUv3 nested stage - where I
> > don't have any PASID involved.
> > 
> > Couldn't we call it context based invalidation then? A context can
> > be tagged by a PASID or/and an ARCHID.  
> 
> I think calling it "context" would be confusing as well (I shouldn't
> have used it earlier), since VT-d uses that name for device table
> entries (=STE on Arm SMMU). Maybe "addr_space"?
> 
I am still struggling to understand what ARCHID is after scanning
through SMMUv3.1 spec. It seems to be a constant for a given SMMU. Why
do you need to pass it down every time? Could you point to me the
document or explain a little more on ARCHID use cases.
We have three fileds called pasid under this struct
iommu_cache_invalidate_info{}
Gets confusing :)
> Thanks,
> Jean
> 
> > 
> > Domain invalidation would invalidate all the contexts belonging to
> > that domain.
> > 
> > Thanks
> > 
> > Eric  

[Jacob Pan]

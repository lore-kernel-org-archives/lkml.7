Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCADC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8952168B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfENRwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:52:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:51000 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbfENRwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:52:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 10:52:16 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga006.fm.intel.com with ESMTP; 14 May 2019 10:52:16 -0700
Date:   Tue, 14 May 2019 10:55:09 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
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
Message-ID: <20190514105509.7865ebc0@jacob-builder>
In-Reply-To: <5d2c0279-7fa9-3d11-9999-583f9ed329ba@redhat.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556922737-76313-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <d32d3d19-11c9-4af9-880b-bb8ebefd4f7f@redhat.com>
        <44d5ba37-a9e9-cc7a-2a3a-d32b840afa29@arm.com>
        <7807afe9-efab-9f48-4ca0-2332a7a54950@redhat.com>
        <1a5a5fad-ed21-5c79-9a9e-ff21fadfb95f@arm.com>
        <1edd45e6-4da3-e393-36b2-9e63cd5f7607@redhat.com>
        <4094baf1-6cf5-a33b-4717-08ced0673c50@arm.com>
        <5d2c0279-7fa9-3d11-9999-583f9ed329ba@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 13:02:47 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jean,
> 
> On 5/14/19 12:42 PM, Jean-Philippe Brucker wrote:
> > On 14/05/2019 08:46, Auger Eric wrote:  
> >> Hi Jean,
> >>
> >> On 5/13/19 7:09 PM, Jean-Philippe Brucker wrote:  
> >>> On 13/05/2019 17:50, Auger Eric wrote:  
> >>>>> struct iommu_inv_pasid_info {
> >>>>> #define IOMMU_INV_PASID_FLAGS_PASID	(1 << 0)
> >>>>> #define IOMMU_INV_PASID_FLAGS_ARCHID	(1 << 1)
> >>>>> 	__u32	flags;
> >>>>> 	__u32	archid;
> >>>>> 	__u64	pasid;
> >>>>> };  
> >>>> I agree it does the job now. However it looks a bit strange to
> >>>> do a PASID based invalidation in my case - SMMUv3 nested stage -
> >>>> where I don't have any PASID involved.
> >>>>
> >>>> Couldn't we call it context based invalidation then? A context
> >>>> can be tagged by a PASID or/and an ARCHID.  
> >>>
> >>> I think calling it "context" would be confusing as well (I
> >>> shouldn't have used it earlier), since VT-d uses that name for
> >>> device table entries (=STE on Arm SMMU). Maybe "addr_space"?  
> >> yes you're right. Well we already pasid table table terminology so
> >> we can use it here as well - as long as we understand what purpose
> >> it serves ;-) - So OK for iommu_inv_pasid_info.
> >>
> >> I think Jean understood we would keep pasid standalone field in  
> I meant Jacob here.
> >> iommu_cache_invalidate_info's union. I understand the struct
> >> iommu_inv_pasid_info now would replace it, correct?  
> 
> Thank you for the confirmation.
> 
Yes, I agree to replace the standalone __64 pasid with this struct.
Looks more inline with address selective info., Just to double confirm
the new struct.

Jean, will you put this in your sva/api repo?

struct iommu_cache_invalidate_info {
#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
	__u32	version;
/* IOMMU paging structure cache */
#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /* Device IOTLB
*/
#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID cache */
#define IOMMU_CACHE_TYPE_NR		(3)
	__u8	cache;
	__u8	granularity;
	__u8	padding[2];
	union {
		struct iommu_inv_pasid_info pasid_info;
		struct iommu_inv_addr_info addr_info;
	};
};




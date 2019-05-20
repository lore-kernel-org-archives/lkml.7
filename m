Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12027C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4905206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfETTTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:19:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:8432 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfETTTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:19:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 12:19:45 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 20 May 2019 12:19:45 -0700
Date:   Mon, 20 May 2019 12:22:41 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 09/16] iommu: Introduce guest PASID bind function
Message-ID: <20190520122241.0db13f14@jacob-builder>
In-Reply-To: <20190516091429.6d06f7e1@jacob-builder>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556922737-76313-10-git-send-email-jacob.jun.pan@linux.intel.com>
        <d652546a-c6ca-1cc6-1924-b016bd81a792@arm.com>
        <20190516091429.6d06f7e1@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2019 09:14:29 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> On Thu, 16 May 2019 15:14:40 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
> > Hi Jacob,
> > 
> > On 03/05/2019 23:32, Jacob Pan wrote:  
> > > +/**
> > > + * struct gpasid_bind_data - Information about device and guest
> > > PASID binding
> > > + * @gcr3:	Guest CR3 value from guest mm
> > > + * @pasid:	Process address space ID used for the guest mm
> > > + * @addr_width:	Guest address width. Paging mode can also
> > > be derived.
> > > + */
> > > +struct gpasid_bind_data {
> > > +	__u64 gcr3;
> > > +	__u32 pasid;
> > > +	__u32 addr_width;
> > > +	__u32 flags;
> > > +#define	IOMMU_SVA_GPASID_SRE	BIT(0) /* supervisor
> > > request */
> > > +	__u8 padding[4];
> > > +};    
> > 
> > Could you wrap this structure into a generic one like we now do for
> > bind_pasid_table? It would make the API easier to extend, because if
> > we ever add individual PASID bind on Arm (something I'd like to do
> > for virtio-iommu, eventually) it will have different parameters, as
> > our PASID table entry has a lot of fields describing the page table
> > format.
> > 
> > Maybe something like the following would do?
> > 
> > struct gpasid_bind_data {
> > #define IOMMU_GPASID_BIND_VERSION_1 1
> > 	__u32 version;
> > #define IOMMU_GPASID_BIND_FORMAT_INTEL_VTD	1
> > 	__u32 format;
> > 	union {
> > 		// the current gpasid_bind_data:
> > 		struct gpasid_bind_intel_vtd vtd;
> > 	};
> > };
> >   

Could you review the struct below? I am trying to extract the
common fileds as much as possible. Didn't do exactly as you suggested
to keep vendor specific data in separate struct under the same union.

Also, can you review the v3 ioasid allocator common code patches? I am
hoping we can get the common code in v5.3 so that we can focus on the
vendor specific part. The common code should include bind_guest_pasid
and ioasid allocator.
https://lkml.org/lkml/2019/5/3/787
https://lkml.org/lkml/2019/5/3/780

Thanks,

Jacob


/**
 * struct gpasid_bind_data_vtd - Intel VT-d specific data on device and guest
 * SVA binding.
 *
 * @flags:	VT-d PASID table entry attributes
 * @pat:	Page attribute table data to compute effective memory type
 * @emt:	Extended memory type
 *
 * Only guest vIOMMU selectable and effective options are passed down to
 * the host IOMMU.
 */
struct gpasid_bind_data_vtd {
#define	IOMMU_SVA_VTD_GPASID_SRE	BIT(0) /* supervisor request */
#define	IOMMU_SVA_VTD_GPASID_EAFE	BIT(1) /* extended access enable */
#define	IOMMU_SVA_VTD_GPASID_PCD	BIT(2) /* page-level cache disable */
#define	IOMMU_SVA_VTD_GPASID_PWT	BIT(3) /* page-level write through */
#define	IOMMU_SVA_VTD_GPASID_EMTE	BIT(4) /* extended memory type enable */
#define	IOMMU_SVA_VTD_GPASID_CD		BIT(5) /* PASID-level cache disable */
	__u64 flags;
	__u32 pat;
	__u32 emt;
};

/**
 * struct gpasid_bind_data - Information about device and guest PASID binding
 * @version:	Version of this data structure
 * @format:	PASID table entry format
 * @flags:	Additional information on guest bind request
 * @gpgd:	Guest page directory base of the guest mm to bind
 * @hpasid:	Process address space ID used for the guest mm in host IOMMU
 * @gpasid:	Process address space ID used for the guest mm in guest IOMMU
 * @addr_width:	Guest address width. Paging mode can also be derived.
 * @vtd:	Intel VT-d specific data
 */
struct gpasid_bind_data {
#define IOMMU_GPASID_BIND_VERSION_1	1
	__u32 version;
#define IOMMU_PASID_FORMAT_INTEL_VTD	1
	__u32 format;
#define	IOMMU_SVA_GPASID_VAL	BIT(1) /* guest PASID valid */
	__u64 flags;
	__u64 gpgd;
	__u64 hpasid;
	__u64 gpasid;
	__u32 addr_width;
	/* Vendor specific data */
	union {
		struct gpasid_bind_data_vtd vtd;
	};
};


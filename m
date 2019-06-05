Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A14C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B5F2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfFEIw7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:52:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:5302 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEIw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:52:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 01:52:57 -0700
X-ExtLoop1: 1
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 01:52:57 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 5 Jun 2019 01:51:47 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.137]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.153]) with mapi id 14.03.0415.000;
 Wed, 5 Jun 2019 16:51:45 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: RE: [PATCH v2 2/4] iommu: Introduce device fault data
Thread-Topic: [PATCH v2 2/4] iommu: Introduce device fault data
Thread-Index: AQHVGhzpdp8RFw2/OU64MEW+KDLfp6aJ93gAgALLAvA=
Date:   Wed, 5 Jun 2019 08:51:45 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19CA6A9EE@SHSMSX104.ccr.corp.intel.com>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
        <20190603145749.46347-3-jean-philippe.brucker@arm.com>
 <20190603150842.11070cfd@jacob-builder>
In-Reply-To: <20190603150842.11070cfd@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWQ0ODQxZDgtOWQ2Ni00NTkxLThlZmItZTgyMzM0MTliZTNiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZWJVU25wanM3dHNndlwvK2pnS3RUQmdhcUQ1eFdERDZCXC9SVXhRY1V0bGZnRFlyakNsR01cL3NiSThVWHlWa0RLSSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan
> Sent: Tuesday, June 4, 2019 6:09 AM
> 
> On Mon,  3 Jun 2019 15:57:47 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
> > +/**
> > + * struct iommu_fault_page_request - Page Request data
> > + * @flags: encodes whether the corresponding fields are valid and
> > whether this
> > + *         is the last page in group (IOMMU_FAULT_PAGE_REQUEST_*
> > values)
> > + * @pasid: Process Address Space ID
> > + * @grpid: Page Request Group Index
> > + * @perm: requested page permissions (IOMMU_FAULT_PERM_* values)
> > + * @addr: page address
> > + * @private_data: device-specific private information
> > + */
> > +struct iommu_fault_page_request {
> > +#define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
> > +#define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
> > +#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
> > +	__u32	flags;
> > +	__u32	pasid;
> > +	__u32	grpid;
> > +	__u32	perm;
> > +	__u64	addr;
> > +	__u64	private_data[2];
> > +};
> > +
> 
> Just a thought, for non-identity G-H PASID management. We could pass on
> guest PASID in PRQ to save a lookup in QEMU. In this case, QEMU
> allocate a GPASID for vIOMMU then a host PASID for pIOMMU. QEMU has a
> G->H lookup. When PRQ comes in to the pIOMMU with HPASID, IOMMU
> driver
> can retrieve GPASID from the bind data then report to the guest via
> VFIO. In this case QEMU does not need to do a H->G PASID lookup.
> 
> Should we add a gpasid field here? or we can add a flag and field
> later, up to you.
> 

Can private_data serve this purpose? It's better not introducing
gpasid awareness within host IOMMU driver. It is just a user-level
data associated with a PASID when binding happens. Kernel doesn't
care the actual meaning, simply record it and then return back to user 
space later upon device fault. Qemu interprets the meaning as gpasid
in its own context. otherwise usages may use it for other purpose.

Thanks
Kevin

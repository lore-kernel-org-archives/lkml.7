Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5694CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240AB20830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfJ2SEZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:04:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:8865 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfJ2SEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:04:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 11:04:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,244,1569308400"; 
   d="scan'208";a="205539600"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Oct 2019 11:04:23 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 29 Oct 2019 11:04:23 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 29 Oct 2019 11:04:23 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.63]) with mapi id 14.03.0439.000;
 Wed, 30 Oct 2019 02:04:21 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH v7 09/11] iommu/vt-d: Add bind guest PASID support
Thread-Topic: [PATCH v7 09/11] iommu/vt-d: Add bind guest PASID support
Thread-Index: AQHViqRYHs7rkU/ej0S5OBwc0DBZHqdq78JwgAApg4CABHtLgIAAIj+AgAGQXhCAAASFgIAAo3FA
Date:   Tue, 29 Oct 2019 18:04:21 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5DED74@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1571946904-86776-10-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDDA6@SHSMSX104.ccr.corp.intel.com>
        <20191025103337.1e51c0c9@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D5DB7B8@SHSMSX104.ccr.corp.intel.com>
        <20191028090231.4777c6a9@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D5DE3D3@SHSMSX104.ccr.corp.intel.com>
 <20191029091139.7ddc155f@jacob-builder>
In-Reply-To: <20191029091139.7ddc155f@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmE4OGFlZDgtNGZlZS00MmRiLWI3NzYtNDg3NDdkMDM2ZDA5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibnNGWXh6M0NMZUVPdVpWWjV6WE9PWEFwTnBxc29wY2JmN1lVNjhyS3lUU1kyUk9YaUU3S3BmTm9hRmFBV25xdiJ9
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

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Wednesday, October 30, 2019 12:12 AM
> 
> On Tue, 29 Oct 2019 07:57:21 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> > > Sent: Tuesday, October 29, 2019 12:03 AM
> > >
> > > On Mon, 28 Oct 2019 06:03:36 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >
> > > > > > > +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> > > > > > > +	.sva_unbind_gpasid	=
> > > > > > > intel_svm_unbind_gpasid, +#endif
> > > > > >
> > > > > > again, pure PASID management logic should be separated from
> > > > > > SVM.
> > > > > I am not following, these two functions are SVM functionality,
> > > > > not pure PASID management which is already separated in
> > > > > ioasid.c
> > > >
> > > > I should say pure "scalable mode" logic. Above callbacks are not
> > > > related to host SVM per se. They are serving gpasid requests from
> > > > guest side, thus part of generic scalable mode capability.
> > > Got your point, but we are sharing data structures with host SVM,
> > > it is very difficult and inefficient to separate the two.
> >
> > I don't think difficulty is the reason against such direction. We
> > need do things right. :-) I'm fine with putting it in a TODO list,
> > but at least need the right information in the 1st place to tell that
> > current way is just a short-term approach, and we should revisit
> > later.
> I guess the fundamental question is: Should the scalable mode logic,
> i.e. guest SVA at PASID granu device, be perceived as part of the
> overall SVA functionality?

guest SVA != guest scalable mode. I'm not sure whether the definition
of SVA has been changed. but iirc it simply means shared virtual
memory usage i.e. sharing CPU page table with device. But with
scalable mode, you can have PASID tagged 1st-level for whatever
usage, guest IOVA, guest SVA, guest nested GPA, etc.

> 
> My view is yes, we shall share SVA and gSVA whenever we can.

sharing is based on scalable mode, not based on sva itself.

> 
> The longer term, which I am working on right now, is to converge
> intel_svm_bind_mm to the generic iommu_sva_bind_device() and use
> common
> data structures as well. It is conceivable that these common structures
> span across hardware architectures, also guest vs host SVA usages.
> 
> i.e. iommu_ops have
> iommu_sva_bind_gpasid() for SM/gSVA
> iommu_sva_bind_device() for native SVA
> 
> Or I am missing your point completely?

since sva is already used in VFIO for broader purpose, it's fine to leave
the name there. But again, it's incorrect to tie iommu_sva_bind_gpasid
under CONFIG_INTEL_IOMMU_SVM. The former is for SM, while the
latter is only for SVA. As long as host IOMMU is in scalable mode, 
bind_gpasid can be supported. If you want a config option, then it should
be a new one instead of IOMMU_SVM.

Thanks
Kevin

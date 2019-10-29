Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D941CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8CF2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390305AbfJ2QHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:07:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:62698 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390135AbfJ2QHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:07:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 09:07:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,244,1569308400"; 
   d="scan'208";a="283283458"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 29 Oct 2019 09:07:14 -0700
Date:   Tue, 29 Oct 2019 09:11:39 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 09/11] iommu/vt-d: Add bind guest PASID support
Message-ID: <20191029091139.7ddc155f@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5DE3D3@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1571946904-86776-10-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D5CDDA6@SHSMSX104.ccr.corp.intel.com>
        <20191025103337.1e51c0c9@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D5DB7B8@SHSMSX104.ccr.corp.intel.com>
        <20191028090231.4777c6a9@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D5DE3D3@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 07:57:21 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> > Sent: Tuesday, October 29, 2019 12:03 AM
> > 
> > On Mon, 28 Oct 2019 06:03:36 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >   
> > > > > > +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> > > > > > +	.sva_unbind_gpasid	=
> > > > > > intel_svm_unbind_gpasid, +#endif  
> > > > >
> > > > > again, pure PASID management logic should be separated from
> > > > > SVM. 
> > > > I am not following, these two functions are SVM functionality,
> > > > not pure PASID management which is already separated in
> > > > ioasid.c  
> > >
> > > I should say pure "scalable mode" logic. Above callbacks are not
> > > related to host SVM per se. They are serving gpasid requests from
> > > guest side, thus part of generic scalable mode capability.  
> > Got your point, but we are sharing data structures with host SVM,
> > it is very difficult and inefficient to separate the two.  
> 
> I don't think difficulty is the reason against such direction. We
> need do things right. :-) I'm fine with putting it in a TODO list,
> but at least need the right information in the 1st place to tell that
> current way is just a short-term approach, and we should revisit
> later.
I guess the fundamental question is: Should the scalable mode logic,
i.e. guest SVA at PASID granu device, be perceived as part of the
overall SVA functionality?

My view is yes, we shall share SVA and gSVA whenever we can.

The longer term, which I am working on right now, is to converge
intel_svm_bind_mm to the generic iommu_sva_bind_device() and use common
data structures as well. It is conceivable that these common structures
span across hardware architectures, also guest vs host SVA usages.

i.e. iommu_ops have
iommu_sva_bind_gpasid() for SM/gSVA
iommu_sva_bind_device() for native SVA

Or I am missing your point completely?

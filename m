Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1511AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6A6218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfB1SvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:51:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:8331 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfB1SvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:51:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 10:51:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,424,1544515200"; 
   d="scan'208";a="142462554"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 28 Feb 2019 10:51:07 -0800
Date:   Thu, 28 Feb 2019 10:53:20 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Message-ID: <20190228105320.65e8b771@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19C9687D8@SHSMSX104.ccr.corp.intel.com>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
        <20190220142759.33308-2-jean-philippe.brucker@arm.com>
        <20190226111743.GK20740@8bytes.org>
        <20190227134129.51ad42ac@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19C9687D8@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 01:10:55 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> > Sent: Thursday, February 28, 2019 5:41 AM
> > 
> > On Tue, 26 Feb 2019 12:17:43 +0100
> > Joerg Roedel <joro@8bytes.org> wrote:
> >   
> > >
> > > How about a 'struct iommu_sva' with an iommu-private definition
> > > that is returned by this function:
> > >
> > > 	struct iommu_sva *iommu_sva_bind_device(struct device
> > > *dev, struct mm_struct *mm);
> > >  
> > Just trying to understand how to use this API.
> > So if we bind the same mm to two different devices, we should get
> > two different iommu_sva handle, right?
> > I think intel-svm still needs a flag argument for supervisor pasid
> > etc. Other than that, I think both interface should work for vt-d.
> > 
> > Another question is that for nested SVA, we will need to bind guest
> > mm. Do you think we should try to reuse this or have it separate? I
> > am working on a separate API for now.
> >   
> 
> It has to be different. Host doesn't know guest mm.
> 
> Also note that from virtualization p.o.v we just focus on 'nested
> translation' in host side. The 1st level may point to guest CPU
> page table (SVA), or IOVA page table. In that manner, the API
> (as currently defined in your series) is purely about setting up
> nested translation on VFIO assigned device. 
>
Sounds good, will keep them separate.

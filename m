Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8077BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5364E20850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfB1VNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:13:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:24451 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfB1VNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:13:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 13:13:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,424,1544515200"; 
   d="scan'208";a="278724699"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2019 13:13:36 -0800
Date:   Thu, 28 Feb 2019 13:15:49 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, kevin.tian@intel.com,
        ashok.raj@intel.com, baolu.lu@linux.intel.com,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Message-ID: <20190228131549.6c0e5fad@jacob-builder>
In-Reply-To: <20190228140950.GD1594@8bytes.org>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
        <20190220142759.33308-2-jean-philippe.brucker@arm.com>
        <20190226111743.GK20740@8bytes.org>
        <20190227134129.51ad42ac@jacob-builder>
        <20190228140950.GD1594@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 15:09:50 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> Hi Jacob,
> 
> On Wed, Feb 27, 2019 at 01:41:29PM -0800, Jacob Pan wrote:
> > On Tue, 26 Feb 2019 12:17:43 +0100
> > Joerg Roedel <joro@8bytes.org> wrote:  
> 
> > Just trying to understand how to use this API.
> > So if we bind the same mm to two different devices, we should get
> > two different iommu_sva handle, right?
> > I think intel-svm still needs a flag argument for supervisor pasid
> > etc. Other than that, I think both interface should work for vt-d.  
> 
> I second Jean's question here, is supervisor pasid still needed with
> scalable mode? What is the use-case and which mm_struct will be used
> for supervisor accesses?
> 
I will delegate this to Ashok.

> > Another question is that for nested SVA, we will need to bind guest
> > mm. Do you think we should try to reuse this or have it separate? I
> > am working on a separate API for now.  
> 
> I think a separate API makes more sense. It could be somehow fit into
> this as well, but having it separate is cleaner. And we already have
> separate API for aux-domains, so this would be just another extension
> of the IOMMU-API for using PASIDs.
> 
Agreed.
> 
> > > 	int iommu_sva_get_pasid(struct iommu_sva *handle);  
> > If multiple bind to the same mm gets multiple handles, this API
> > should retrieve the same pasid for different handle?  
> 
> It can return the same handle if we store the pasid in the mm_struct,
> for example ...
> > Just curious why making the handle private instead of returning the
> > pasid value in the handle?  
> 
> ... which is also the reason why I prefer the accessor function, it
> allows to have the pasid not in the iommu_sva handle, but to retrieve
> it from somewhere else (like the mm_struct).
make sense, more flexible storage and controlled access too. thanks for
explaining.


Jacob

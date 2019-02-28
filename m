Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA708C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952992064A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbfB1WEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:04:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:4402 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfB1WEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:04:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 14:04:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,424,1544515200"; 
   d="scan'208";a="142681023"
Received: from araj-mobl1.jf.intel.com ([10.7.201.27])
  by orsmga001.jf.intel.com with ESMTP; 28 Feb 2019 14:04:49 -0800
Date:   Thu, 28 Feb 2019 14:04:49 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, alex.williamson@redhat.com,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Message-ID: <20190228220449.GA12682@araj-mobl1.jf.intel.com>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
 <20190220142759.33308-2-jean-philippe.brucker@arm.com>
 <20190226111743.GK20740@8bytes.org>
 <20190227134129.51ad42ac@jacob-builder>
 <20190228140950.GD1594@8bytes.org>
 <20190228131549.6c0e5fad@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228131549.6c0e5fad@jacob-builder>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 01:15:49PM -0800, Jacob Pan wrote:
> On Thu, 28 Feb 2019 15:09:50 +0100
> Joerg Roedel <joro@8bytes.org> wrote:
> 
> > Hi Jacob,
> > 
> > On Wed, Feb 27, 2019 at 01:41:29PM -0800, Jacob Pan wrote:
> > > On Tue, 26 Feb 2019 12:17:43 +0100
> > > Joerg Roedel <joro@8bytes.org> wrote:  
> > 
> > > Just trying to understand how to use this API.
> > > So if we bind the same mm to two different devices, we should get
> > > two different iommu_sva handle, right?
> > > I think intel-svm still needs a flag argument for supervisor pasid
> > > etc. Other than that, I think both interface should work for vt-d.  
> > 
> > I second Jean's question here, is supervisor pasid still needed with
> > scalable mode? What is the use-case and which mm_struct will be used
> > for supervisor accesses?
> > 
> I will delegate this to Ashok.

Supervisor PASID is still required for some kernel clients. Some of our
IB folks had asked for it. Current implementation uses init_mm, but
we know this is dangerous. Plus since the kernel has no support for
mmu_notifiers for kernel memory we were not able to invalidate
device tlb after memory was freed.

Suppose we could just build regular page-tables much like how the map/unmap
does today, but bind it with a Supervisor PASID. This way we don't open
up the kimono to the device, but only open select portions on request.

we haven't spent enough time on it lately, but will focus once the core
pieces are completed for the baseline support for Scalable mode.

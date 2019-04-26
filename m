Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451AFC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DD4206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfDZQ4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:56:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:64090 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfDZQ4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:56:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 09:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,398,1549958400"; 
   d="scan'208";a="134668457"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2019 09:56:03 -0700
Date:   Fri, 26 Apr 2019 09:58:46 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
Message-ID: <20190426095846.76a68f1f@jacob-builder>
In-Reply-To: <20190426122115.GA29449@infradead.org>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190424061903.GB30717@infradead.org>
        <20190425111912.0e15eb7d@jacob-builder>
        <856b0457-bd2f-c2af-fdeb-45fe0bd3136b@arm.com>
        <20190426122115.GA29449@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 05:21:15 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Apr 26, 2019 at 12:47:43PM +0100, Jean-Philippe Brucker wrote:
> > >> On Tue, Apr 23, 2019 at 04:31:06PM -0700, Jacob Pan wrote:  
> > >>> The allocator doesn't really belong in drivers/iommu because
> > >>> some drivers would like to allocate PASIDs for devices that
> > >>> aren't managed by an IOMMU, using the same ID space as IOMMU.
> > >>> It doesn't really belong in drivers/pci either since platform
> > >>> device also support PASID. Add the allocator in
> > >>> drivers/base.    
> > >>
> > >> I'd still add it to drivers/iommu, just selectable separately
> > >> from the core iommu code..  
> > > Perhaps I misunderstood. If a driver wants to use IOASIDs w/o
> > > iommu subsystem even turned on, how could selecting from the core
> > > iommu code help? Could you elaborate on "selectable"?  
> > 
> > How about doing the same as CONFIG_IOMMU_IOVA? The code is in
> > drivers/iommu but can be selected by non-IOMMU_API users,
> > independently of CONFIG_IOMMU_SUPPORT. It's true that this
> > allocator will mostly be used by IOMMU drivers.  
> 
> That is exactly what I meant!

Make sense, will do that in the next round. Thanks!

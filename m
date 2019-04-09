Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CEDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA66820857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDIRiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:38:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:55250 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfDIRiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:38:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 10:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,330,1549958400"; 
   d="scan'208";a="335248361"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 09 Apr 2019 10:37:56 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDuh1-0006Nb-1D; Tue, 09 Apr 2019 20:37:55 +0300
Date:   Tue, 9 Apr 2019 20:37:55 +0300
From:   Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@linux.intel.com>, Liu@smile.fi.intel.com,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 08/18] iommu: Introduce cache_invalidate API
Message-ID: <20190409173755.GX9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-9-git-send-email-jacob.jun.pan@linux.intel.com>
 <20190409100718.GE9224@smile.fi.intel.com>
 <20190409094328.03731c3c@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409094328.03731c3c@jacob-builder>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 09:43:28AM -0700, Jacob Pan wrote:
> On Tue, 9 Apr 2019 13:07:18 +0300
> Andriy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Apr 08, 2019 at 04:59:23PM -0700, Jacob Pan wrote:

> > > +int iommu_cache_invalidate(struct iommu_domain *domain, struct
> > > device *dev,
> > > +			   struct iommu_cache_invalidate_info
> > > *inv_info) +{
> > > +	int ret = 0;  
> > 
> > Redundant assignment.
> > 
> I am not a security expert but initialization of local variable can be
> more secure.
> I was looking at this talk.
> https://outflux.net/slides/2018/lss/danger.pdf
> https://cwe.mitre.org/data/definitions/457.html

I hardly see any of these applied to your case here.
Care to show what I'm missing?

> > > +	if (unlikely(!domain->ops->cache_invalidate))
> > > +		return -ENODEV;
> > > +
> > > +	ret = domain->ops->cache_invalidate(domain, dev, inv_info);
> > > +
> > > +	return ret;
> > > +}  

-- 
With Best Regards,
Andy Shevchenko



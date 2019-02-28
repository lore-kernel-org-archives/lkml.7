Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D05FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC632133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbfB1OJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:09:52 -0500
Received: from 8bytes.org ([81.169.241.247]:55970 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbfB1OJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:09:51 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6F0494A3; Thu, 28 Feb 2019 15:09:50 +0100 (CET)
Date:   Thu, 28 Feb 2019 15:09:50 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, kevin.tian@intel.com,
        ashok.raj@intel.com, baolu.lu@linux.intel.com,
        alex.williamson@redhat.com
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Message-ID: <20190228140950.GD1594@8bytes.org>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
 <20190220142759.33308-2-jean-philippe.brucker@arm.com>
 <20190226111743.GK20740@8bytes.org>
 <20190227134129.51ad42ac@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227134129.51ad42ac@jacob-builder>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On Wed, Feb 27, 2019 at 01:41:29PM -0800, Jacob Pan wrote:
> On Tue, 26 Feb 2019 12:17:43 +0100
> Joerg Roedel <joro@8bytes.org> wrote:

> Just trying to understand how to use this API.
> So if we bind the same mm to two different devices, we should get two
> different iommu_sva handle, right?
> I think intel-svm still needs a flag argument for supervisor pasid etc.
> Other than that, I think both interface should work for vt-d.

I second Jean's question here, is supervisor pasid still needed with
scalable mode? What is the use-case and which mm_struct will be used for
supervisor accesses?

> Another question is that for nested SVA, we will need to bind guest mm.
> Do you think we should try to reuse this or have it separate? I am
> working on a separate API for now.

I think a separate API makes more sense. It could be somehow fit into
this as well, but having it separate is cleaner. And we already have
separate API for aux-domains, so this would be just another extension of
the IOMMU-API for using PASIDs.


> > 	int iommu_sva_get_pasid(struct iommu_sva *handle);
> If multiple bind to the same mm gets multiple handles, this API should
> retrieve the same pasid for different handle?

It can return the same handle if we store the pasid in the mm_struct,
for example ...
> Just curious why making the handle private instead of returning the
> pasid value in the handle?

... which is also the reason why I prefer the accessor function, it
allows to have the pasid not in the iommu_sva handle, but to retrieve it
from somewhere else (like the mm_struct).

Regards,

	Joerg

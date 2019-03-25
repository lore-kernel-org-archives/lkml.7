Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D79C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0A22087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfCYOoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:44:17 -0400
Received: from 8bytes.org ([81.169.241.247]:59014 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbfCYOoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:44:16 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7B27A22D; Mon, 25 Mar 2019 15:44:14 +0100 (CET)
Date:   Mon, 25 Mar 2019 15:44:13 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        baolu.lu@linux.intel.com, alex.williamson@redhat.com,
        zhangfei.gao@foxmail.com
Subject: Re: [PATCH v2 1/1] iommu: Bind process address spaces to devices
Message-ID: <20190325144241.GC25350@8bytes.org>
References: <20190320150258.3240-1-jean-philippe.brucker@arm.com>
 <20190320150258.3240-2-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320150258.3240-2-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jean-Philippe,

thanks for the patch, I think we are on the finish line with this
interface. Just one small question below.

On Wed, Mar 20, 2019 at 03:02:58PM +0000, Jean-Philippe Brucker wrote:
> +int iommu_sva_set_ops(struct iommu_sva *handle,
> +		      const struct iommu_sva_ops *sva_ops)
> +{
> +	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
> +
> +	if (!ops || !ops->sva_set_ops)
> +		return -ENODEV;
> +
> +	return ops->sva_set_ops(handle, sva_ops);
> +}

What is the purpose of the sva_set_ops call-back in iommu-ops? Is the
IOMMU driver supposed to do some extra setup work with the provided ops?
Otherwise we can just store the pointer in 'struct iommu_sva' without
calling into the iommu driver.


Regards,

	Joerg

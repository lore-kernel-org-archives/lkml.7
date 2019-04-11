Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8498C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04812077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDKP2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:28:05 -0400
Received: from 8bytes.org ([81.169.241.247]:34190 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfDKP2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:28:05 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4FA40451; Thu, 11 Apr 2019 17:28:03 +0200 (CEST)
Date:   Thu, 11 Apr 2019 17:28:03 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        baolu.lu@linux.intel.com, zhangfei.gao@foxmail.com
Subject: Re: [PATCH v3 1/1] iommu: Bind process address spaces to devices
Message-ID: <20190411152803.GB29810@8bytes.org>
References: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
 <20190410151516.47754-2-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410151516.47754-2-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:15:16PM +0100, Jean-Philippe Brucker wrote:
>  drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h |  70 ++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+)

Applied to the api-features branch for now, thanks Jean-Philippe!

'for now' because I have a question below.

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ed6738c358ca..87fe1cddd817 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -51,10 +51,13 @@ struct device;
>  struct iommu_domain;
>  struct notifier_block;
>  struct iommu_fault_event;
> +struct iommu_sva;

The iommu_fault_event doesn't yet exist in my tree, is this patch based
on something else I need besided Lu Baolus work? I got quite some
conflicts while applying the patch because of this.

> + * @sva_set_ops: Set ops for a SVA handle

I also removed this line.

Regards,

	Joerg

Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAB4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1812070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 23:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfCNXcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 19:32:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:17815 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfCNXcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 19:32:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 16:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,479,1544515200"; 
   d="scan'208";a="142162534"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 14 Mar 2019 16:32:40 -0700
Date:   Thu, 14 Mar 2019 16:35:01 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     James Sewart <jamessewart@arista.com>
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 7/7] iommu/vt-d: Remove lazy allocation of domains
Message-ID: <20190314163501.2f414a78@jacob-builder>
In-Reply-To: <F4D76093-3F9F-4184-9F92-191A01126D0F@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
        <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
        <F4D76093-3F9F-4184-9F92-191A01126D0F@arista.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 11:59:36 +0000
James Sewart <jamessewart@arista.com> wrote:

>  
> -	domain = get_valid_domain_for_dev(dev);
> +	domain = find_domain(dev);
>  	if (!domain)
>  		return DMA_MAPPING_ERROR;
>  
> @@ -3914,7 +3624,7 @@ static int intel_map_sg(struct device *dev,
> struct scatterlist *sglist, int nele if (iommu_no_mapping(dev))
>  		return intel_nontranslate_map_sg(dev, sglist,
> nelems, dir); 
> -	domain = get_valid_domain_for_dev(dev);
> +	domain = find_domain(dev);
This patchset looks like a very good clean up, I am wondering why we
can't use the generic iommu_get_domain_for_dev() here, since VT-d has a
default DMA domain after your patch.

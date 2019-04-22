Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25805C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AF1214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfDVQrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:47:36 -0400
Received: from verein.lst.de ([213.95.11.211]:40554 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfDVQrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:47:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 29FD568AFE; Mon, 22 Apr 2019 18:47:21 +0200 (CEST)
Date:   Mon, 22 Apr 2019 18:47:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH v3 07/10] iommu/vt-d: Keep swiotlb on if bounce page is
 necessary
Message-ID: <20190422164720.GB31181@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com> <20190421011719.14909-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421011719.14909-8-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 09:17:16AM +0800, Lu Baolu wrote:
> +static inline bool platform_has_untrusted_device(void)
>  {
> +	bool has_untrusted_device = false;
>  	struct pci_dev *pdev = NULL;
>  
>  	for_each_pci_dev(pdev) {
>  		if (pdev->untrusted) {
> +			has_untrusted_device = true;
>  			break;
>  		}
>  	}
>  
> +	return has_untrusted_device;

This shouldn't really be in the intel-iommu driver, should it?
This probably should be something like pci_has_untrusted_devices
and be moved to the PCI code.

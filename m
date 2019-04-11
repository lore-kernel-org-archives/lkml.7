Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C867CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9972184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDKMtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:49:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:20813 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbfDKMtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:49:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 05:49:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,337,1549958400"; 
   d="scan'208";a="148342663"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2019 05:48:59 -0700
Date:   Thu, 11 Apr 2019 20:33:14 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: afu: Pass the correct device to
 dma_mapping_error()
Message-ID: <20190411123314.GA19198@hao-dev>
References: <20190410215327.8024-1-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410215327.8024-1-swood@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:53:27PM -0500, Scott Wood wrote:
> dma_mapping_error() was being called on a different device struct than
> what was passed to map/unmap.  Besides rendering the error checking
> ineffective, it caused a debug splat with CONFIG_DMA_API_DEBUG.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>

Hi Scott,

Looks good to me. Thanks for catching this issue.

Acked-by: Wu Hao <hao.wu@intel.com>

Hao

> ---
>  drivers/fpga/dfl-afu-dma-region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index e18a786fc943..cd68002ac097 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -399,7 +399,7 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
>  				    region->pages[0], 0,
>  				    region->length,
>  				    DMA_BIDIRECTIONAL);
> -	if (dma_mapping_error(&pdata->dev->dev, region->iova)) {
> +	if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region->iova)) {
>  		dev_err(&pdata->dev->dev, "failed to map for dma\n");
>  		ret = -EFAULT;
>  		goto unpin_pages;
> -- 
> 1.8.3.1

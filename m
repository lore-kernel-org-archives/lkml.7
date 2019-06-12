Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C70C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6045420874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437932AbfFLPSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:18:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:5808 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407138AbfFLPSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:18:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 08:18:24 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.10.37.186])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2019 08:18:24 -0700
Message-ID: <1560354254.22001.3.camel@intel.com>
Subject: Re: [PATCH 5/6] dma: mic_x100_dma: no need to check return value of
 debugfs_create functions
From:   Sudeep Dutt <sudeep.dutt@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>, dan.j.williams@intel.com,
        vkoul@kernel.org, Ashutosh Dixit <ashutosh.dixit@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 12 Jun 2019 08:44:14 -0700
In-Reply-To: <20190612122557.24158-5-gregkh@linuxfoundation.org>
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
         <20190612122557.24158-5-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.12.11 (3.12.11-15.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-12 at 14:25 +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 

Thanks Greg.

Reviewed-by: Sudeep Dutt <sudeep.dutt@intel.com>

> Cc: Sudeep Dutt <sudeep.dutt@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/dma/mic_x100_dma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/mic_x100_dma.c b/drivers/dma/mic_x100_dma.c
> index 6a91e28d537d..584e09661507 100644
> --- a/drivers/dma/mic_x100_dma.c
> +++ b/drivers/dma/mic_x100_dma.c
> @@ -728,10 +728,8 @@ static int mic_dma_driver_probe(struct mbus_device *mbdev)
>  	if (mic_dma_dbg) {
>  		mic_dma_dev->dbg_dir = debugfs_create_dir(dev_name(&mbdev->dev),
>  							  mic_dma_dbg);
> -		if (mic_dma_dev->dbg_dir)
> -			debugfs_create_file("mic_dma_reg", 0444,
> -					    mic_dma_dev->dbg_dir, mic_dma_dev,
> -					    &mic_dma_reg_fops);
> +		debugfs_create_file("mic_dma_reg", 0444, mic_dma_dev->dbg_dir,
> +				    mic_dma_dev, &mic_dma_reg_fops);
>  	}
>  	return 0;
>  }



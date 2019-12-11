Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDBAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72E52173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576064575;
	bh=6KjxzfVLAoUXt6yCuyJGQsbZXfDjjfZdoEGj/7xAFwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H3aIOeIa9m5nrARTPZtNLbCo491qVfrpXzQvsNrWSGL8FcrOpOsyQxRVzco8xHp/I
	 LRppJADngz7e18bU+q4a3a1E2dy+GCUzrzGxnPPJic0y2aikdMPzRD2cv60DnW62O3
	 luq7tV00Y3wIHPfvwmRGgE/G7rU8v6+55QH39+sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfLKLmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbfLKLmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:42:53 -0500
Received: from localhost (unknown [171.76.100.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443762073D;
        Wed, 11 Dec 2019 11:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576064573;
        bh=6KjxzfVLAoUXt6yCuyJGQsbZXfDjjfZdoEGj/7xAFwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Br0+MtwRTdi/snyt2rZP3odMEKcpSeZx4LJlZzqmw+Uyfbg7u4G4oboGukomiSde4
         1ygUsRc54BqDgNjRvPo9aMALRrsBLLjLKyYR9mKkDOnGfMZNooeoRh04fSGZkarPEu
         C3HAGZHiXfjxDg1J4HS2/ut/zLfftTwYsnL/o2vg=
Date:   Wed, 11 Dec 2019 17:12:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v4 05/11] soundwire: intel: update interfaces between
 ASoC and SoundWire
Message-ID: <20191211114247.GI2536@vkoul-mobl>
References: <20191209235520.18727-1-pierre-louis.bossart@linux.intel.com>
 <20191209235520.18727-6-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209235520.18727-6-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-19, 17:55, Pierre-Louis Bossart wrote:

> @@ -138,8 +126,6 @@ static struct sdw_intel_ctx
>  		pdevinfo.name = "int-sdw";
>  		pdevinfo.id = i;
>  		pdevinfo.fwnode = acpi_fwnode_handle(adev);
> -		pdevinfo.data = &link->res;
> -		pdevinfo.size_data = sizeof(link->res);
>  
>  		pdev = platform_device_register_full(&pdevinfo);
>  		if (IS_ERR(pdev)) {
> @@ -224,10 +210,8 @@ EXPORT_SYMBOL(sdw_intel_init);

This is still exported

>  struct sdw_intel_res {
> +	int count;
>  	void __iomem *mmio_base;
>  	int irq;
>  	acpi_handle handle;
>  	struct device *parent;
>  	const struct sdw_intel_ops *ops;
> -	void *arg;
> +	struct device *dev;
> +	u32 link_mask;
>  };
>  
> -void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res);

But prototype removed, so i think this is a miss in the series, can you
fix that up

-- 
~Vinod

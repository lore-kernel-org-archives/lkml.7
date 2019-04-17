Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FFDC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB30B217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYejCAh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbfDQVX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:23:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42707 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:23:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so84648plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tFG1dKMvW+HPD4mls9EAj4JD5bu3y4AR4L9Q6nwDU0A=;
        b=IYejCAh88t58WM0Dfj1QRmUr/oG03sB3SzoztT8K+WoSqhqW1OJ+vTbKe1bxswzk3K
         is4y376W5pedxqvtn79295Gu2iqLYX8/wSgBoSQWCH1pL/xjtypwfhJD5/+26PBl3o+o
         iIgXWGIHcicmI+upwWqBtGZTRYtDd9mq/zH0tJfO8Eoe+sPoa7lWQxnhYpNaBu/tJXjD
         vHCyjbEYmP65NXw5/w00qISPnfXMwXrjFPysJ26dbCM6uUvS+hMLUW3cfQGt4sHuTl92
         xgVPLQ+121mGZLYOoz3DuEy82gF4wnn5DHH1JUZ+Aq98yZvHOFqGyfQdiWbE+nY7Xpup
         ut8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tFG1dKMvW+HPD4mls9EAj4JD5bu3y4AR4L9Q6nwDU0A=;
        b=P71veidOdWOkWd9SfRq7zT8slGKyz5u77U1zgl89r7Bl4c+QvQnlsUqVe2IU4ZQMzi
         uLBEPljl/IqUAzQYOefIs4DTcEP6zIH0Ygpsh2iU+fT8NBsDJoxFEOkYgA8sEsLU2dmj
         USmXk72FHhLm45GLttbyZO6KFrb7sJNnBR5rSWliBRigaqiJDeNBblZxeYU2lw5Lkl2X
         GaaTYg56pJWcPcIsgi+zfU4UdtbZeuIl9SGJdTl5igTlB8YCyRyQ5jV1qIyvxeOvm9GD
         rDbMKXVx17OlBWkFh7j6kVxVk2EwlldeP2KWM9+nWBPjeMRTfsmE4NVaY66woasXBpnJ
         wuiQ==
X-Gm-Message-State: APjAAAWpDHpBCnxioGrpe2Jy1tfF5kNKyKmvmaC5GaLn8OpVbQlBh73l
        Oriu+YPc/ULbaAU4tLbWe4zGXw==
X-Google-Smtp-Source: APXvYqzbtdGCO5HPxzEyr02sJxG3Yy+gwfQ+stojexAEAu/sAmWOYbSvpaN3hVjZoKI4jp64c761xw==
X-Received: by 2002:a17:902:59c5:: with SMTP id d5mr91348888plj.104.1555536208361;
        Wed, 17 Apr 2019 14:23:28 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w3sm125095pfn.179.2019.04.17.14.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 14:23:27 -0700 (PDT)
Date:   Wed, 17 Apr 2019 15:23:25 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 08/36] coresight: tmc: Clean up device specific data
Message-ID: <20190417212325.GC14163@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-9-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-9-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:03:51PM +0100, Suzuki K Poulose wrote:
> In preparation to use a consistent device naming scheme,
> clean up the device link tracking in replicator driver.
> Use the "coresight" device instead of the "real" parent device
> for all internal purposes. All other requests (e.g, power management,
> DMA operations) must use the "real" device which is the parent device.
> 
> Since the CATU driver also uses the TMC-SG infrastructure, update
> the callers to ensure they pass the appropriate device argument
> for the tables.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c    |  5 ++--
>  drivers/hwtracing/coresight/coresight-tmc-etf.c |  9 +++---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 40 ++++++++++++++-----------
>  drivers/hwtracing/coresight/coresight-tmc.c     | 38 +++++++++++------------
>  drivers/hwtracing/coresight/coresight-tmc.h     |  1 -
>  5 files changed, 47 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index f2a6a8d..ba3c005 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -328,19 +328,18 @@ static int catu_alloc_etr_buf(struct tmc_drvdata *tmc_drvdata,
>  			      struct etr_buf *etr_buf, int node, void **pages)
>  {
>  	struct coresight_device *csdev;
> -	struct device *catu_dev;
>  	struct tmc_sg_table *catu_table;
>  	struct catu_etr_buf *catu_buf;
>  
>  	csdev = tmc_etr_get_catu_device(tmc_drvdata);
>  	if (!csdev)
>  		return -ENODEV;
> -	catu_dev = csdev->dev.parent;
>  	catu_buf = kzalloc(sizeof(*catu_buf), GFP_KERNEL);
>  	if (!catu_buf)
>  		return -ENOMEM;
>  
> -	catu_table = catu_init_sg_table(catu_dev, node, etr_buf->size, pages);
> +	catu_table = catu_init_sg_table(&csdev->dev, node,
> +					etr_buf->size, pages);
>  	if (IS_ERR(catu_table)) {
>  		kfree(catu_buf);
>  		return PTR_ERR(catu_table);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index a5f053f..6f60606 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -251,7 +251,6 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev,
>  			       u32 mode, void *data)
>  {
>  	int ret;
> -	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
>  	switch (mode) {
>  	case CS_MODE_SYSFS:
> @@ -269,7 +268,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev,
>  	if (ret)
>  		return ret;
>  
> -	dev_dbg(drvdata->dev, "TMC-ETB/ETF enabled\n");
> +	dev_dbg(&csdev->dev, "TMC-ETB/ETF enabled\n");
>  	return 0;
>  }
>  
> @@ -292,7 +291,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
>  
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> -	dev_dbg(drvdata->dev, "TMC-ETB/ETF disabled\n");
> +	dev_dbg(&csdev->dev, "TMC-ETB/ETF disabled\n");
>  }
>  
>  static int tmc_enable_etf_link(struct coresight_device *csdev,
> @@ -314,7 +313,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
>  	if (!ret)
> -		dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
> +		dev_dbg(&csdev->dev, "TMC-ETF enabled\n");
>  	return ret;
>  }
>  
> @@ -334,7 +333,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
>  	drvdata->mode = CS_MODE_DISABLED;
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> -	dev_dbg(drvdata->dev, "TMC-ETF disabled\n");
> +	dev_dbg(&csdev->dev, "TMC-ETF disabled\n");
>  }
>  
>  static void *tmc_alloc_etf_buffer(struct coresight_device *csdev, int cpu,
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index f684283..0911f9c 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -153,10 +153,11 @@ static void tmc_pages_free(struct tmc_pages *tmc_pages,
>  			   struct device *dev, enum dma_data_direction dir)
>  {
>  	int i;
> +	struct device *real_dev = dev->parent;

I would have kept the 'dev' as it is quite obvious from the dev->parent that we
are getting a reference on the parent.  That is just my opinion and it is
entirely up to you.

>  
>  	for (i = 0; i < tmc_pages->nr_pages; i++) {
>  		if (tmc_pages->daddrs && tmc_pages->daddrs[i])
> -			dma_unmap_page(dev, tmc_pages->daddrs[i],
> +			dma_unmap_page(real_dev, tmc_pages->daddrs[i],
>  					 PAGE_SIZE, dir);
>  		if (tmc_pages->pages && tmc_pages->pages[i])
>  			__free_page(tmc_pages->pages[i]);
> @@ -184,6 +185,7 @@ static int tmc_pages_alloc(struct tmc_pages *tmc_pages,
>  	int i, nr_pages;
>  	dma_addr_t paddr;
>  	struct page *page;
> +	struct device *real_dev = dev->parent;
>  
>  	nr_pages = tmc_pages->nr_pages;
>  	tmc_pages->daddrs = kcalloc(nr_pages, sizeof(*tmc_pages->daddrs),
> @@ -207,8 +209,8 @@ static int tmc_pages_alloc(struct tmc_pages *tmc_pages,
>  			page = alloc_pages_node(node,
>  						GFP_KERNEL | __GFP_ZERO, 0);
>  		}
> -		paddr = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
> -		if (dma_mapping_error(dev, paddr))
> +		paddr = dma_map_page(real_dev, page, 0, PAGE_SIZE, dir);
> +		if (dma_mapping_error(real_dev, paddr))
>  			goto err;
>  		tmc_pages->daddrs[i] = paddr;
>  		tmc_pages->pages[i] = page;
> @@ -295,7 +297,7 @@ static int tmc_alloc_data_pages(struct tmc_sg_table *sg_table, void **pages)
>   * and data buffers. TMC writes to the data buffers and reads from the SG
>   * Table pages.
>   *
> - * @dev		- Device to which page should be DMA mapped.
> + * @dev		- Coresight device to which page should be DMA mapped.
>   * @node	- Numa node for mem allocations
>   * @nr_tpages	- Number of pages for the table entries.
>   * @nr_dpages	- Number of pages for Data buffer.
> @@ -339,13 +341,13 @@ void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
>  {
>  	int i, index, start;
>  	int npages = DIV_ROUND_UP(size, PAGE_SIZE);
> -	struct device *dev = table->dev;
> +	struct device *real_dev = table->dev->parent;
>  	struct tmc_pages *data = &table->data_pages;
>  
>  	start = offset >> PAGE_SHIFT;
>  	for (i = start; i < (start + npages); i++) {
>  		index = i % data->nr_pages;
> -		dma_sync_single_for_cpu(dev, data->daddrs[index],
> +		dma_sync_single_for_cpu(real_dev, data->daddrs[index],
>  					PAGE_SIZE, DMA_FROM_DEVICE);
>  	}
>  }
> @@ -354,11 +356,11 @@ void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
>  void tmc_sg_table_sync_table(struct tmc_sg_table *sg_table)
>  {
>  	int i;
> -	struct device *dev = sg_table->dev;
> +	struct device *real_dev = sg_table->dev->parent;
>  	struct tmc_pages *table_pages = &sg_table->table_pages;
>  
>  	for (i = 0; i < table_pages->nr_pages; i++)
> -		dma_sync_single_for_device(dev, table_pages->daddrs[i],
> +		dma_sync_single_for_device(real_dev, table_pages->daddrs[i],
>  					   PAGE_SIZE, DMA_TO_DEVICE);
>  }
>  
> @@ -581,6 +583,7 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>  				  void **pages)
>  {
>  	struct etr_flat_buf *flat_buf;
> +	struct device *real_dev = drvdata->csdev->dev.parent;
>  
>  	/* We cannot reuse existing pages for flat buf */
>  	if (pages)
> @@ -590,7 +593,7 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>  	if (!flat_buf)
>  		return -ENOMEM;
>  
> -	flat_buf->vaddr = dma_alloc_coherent(drvdata->dev, etr_buf->size,
> +	flat_buf->vaddr = dma_alloc_coherent(real_dev, etr_buf->size,
>  					     &flat_buf->daddr, GFP_KERNEL);
>  	if (!flat_buf->vaddr) {
>  		kfree(flat_buf);
> @@ -598,7 +601,7 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>  	}
>  
>  	flat_buf->size = etr_buf->size;
> -	flat_buf->dev = drvdata->dev;
> +	flat_buf->dev = &drvdata->csdev->dev;
>  	etr_buf->hwaddr = flat_buf->daddr;
>  	etr_buf->mode = ETR_MODE_FLAT;
>  	etr_buf->private = flat_buf;
> @@ -608,9 +611,10 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>  static void tmc_etr_free_flat_buf(struct etr_buf *etr_buf)
>  {
>  	struct etr_flat_buf *flat_buf = etr_buf->private;
> +	struct device *real_dev = flat_buf->dev->parent;
>  
>  	if (flat_buf && flat_buf->daddr)
> -		dma_free_coherent(flat_buf->dev, flat_buf->size,
> +		dma_free_coherent(real_dev, flat_buf->size,
>  				  flat_buf->vaddr, flat_buf->daddr);
>  	kfree(flat_buf);
>  }
> @@ -657,8 +661,9 @@ static int tmc_etr_alloc_sg_buf(struct tmc_drvdata *drvdata,
>  				void **pages)
>  {
>  	struct etr_sg_table *etr_table;
> +	struct device *dev = &drvdata->csdev->dev;
>  
> -	etr_table = tmc_init_etr_sg_table(drvdata->dev, node,
> +	etr_table = tmc_init_etr_sg_table(dev, node,
>  					  etr_buf->size, pages);
>  	if (IS_ERR(etr_table))
>  		return -ENOMEM;
> @@ -813,9 +818,10 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
>  	bool has_etr_sg, has_iommu;
>  	bool has_sg, has_catu;
>  	struct etr_buf *etr_buf;
> +	struct device *dev = &drvdata->csdev->dev;
>  
>  	has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
> -	has_iommu = iommu_get_domain_for_dev(drvdata->dev);
> +	has_iommu = iommu_get_domain_for_dev(dev->parent);
>  	has_catu = !!tmc_etr_get_catu_device(drvdata);
>  
>  	has_sg = has_catu || has_etr_sg;
> @@ -853,7 +859,7 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
>  		return ERR_PTR(rc);
>  	}
>  
> -	dev_dbg(drvdata->dev, "allocated buffer of size %ldKB in mode %d\n",
> +	dev_dbg(dev, "allocated buffer of size %ldKB in mode %d\n",
>  		(unsigned long)size >> 10, etr_buf->mode);
>  	return etr_buf;
>  }
> @@ -1148,7 +1154,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  		tmc_etr_free_sysfs_buf(free_buf);
>  
>  	if (!ret)
> -		dev_dbg(drvdata->dev, "TMC-ETR enabled\n");
> +		dev_dbg(&csdev->dev, "TMC-ETR enabled\n");
>  
>  	return ret;
>  }
> @@ -1217,7 +1223,7 @@ static void *tmc_alloc_etr_buffer(struct coresight_device *csdev,
>  	etr_perf = tmc_etr_setup_perf_buf(drvdata, cpu_to_node(cpu),
>  					  nr_pages, pages, snapshot);
>  	if (IS_ERR(etr_perf)) {
> -		dev_dbg(drvdata->dev, "Unable to allocate ETR buffer\n");
> +		dev_dbg(&csdev->dev, "Unable to allocate ETR buffer\n");
>  		return NULL;
>  	}
>  
> @@ -1411,7 +1417,7 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
>  
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> -	dev_dbg(drvdata->dev, "TMC-ETR disabled\n");
> +	dev_dbg(&csdev->dev, "TMC-ETR disabled\n");
>  }
>  
>  static const struct coresight_ops_sink tmc_etr_sink_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index c6a5462..819873a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -30,7 +30,7 @@ void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>  	/* Ensure formatter, unformatter and hardware fifo are empty */
>  	if (coresight_timeout(drvdata->base,
>  			      TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
> -		dev_err(drvdata->dev,
> +		dev_err(&drvdata->csdev->dev,
>  			"timeout while waiting for TMC to be Ready\n");
>  	}
>  }
> @@ -47,7 +47,7 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
>  	/* Ensure flush completes */
>  	if (coresight_timeout(drvdata->base,
>  			      TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
> -		dev_err(drvdata->dev,
> +		dev_err(&drvdata->csdev->dev,
>  		"timeout while waiting for completion of Manual Flush\n");
>  	}
>  
> @@ -81,7 +81,7 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
>  	}
>  
>  	if (!ret)
> -		dev_dbg(drvdata->dev, "TMC read start\n");
> +		dev_dbg(&drvdata->csdev->dev, "TMC read start\n");
>  
>  	return ret;
>  }
> @@ -103,7 +103,7 @@ static int tmc_read_unprepare(struct tmc_drvdata *drvdata)
>  	}
>  
>  	if (!ret)
> -		dev_dbg(drvdata->dev, "TMC read end\n");
> +		dev_dbg(&drvdata->csdev->dev, "TMC read end\n");
>  
>  	return ret;
>  }
> @@ -120,7 +120,7 @@ static int tmc_open(struct inode *inode, struct file *file)
>  
>  	nonseekable_open(inode, file);
>  
> -	dev_dbg(drvdata->dev, "%s: successfully opened\n", __func__);
> +	dev_dbg(&drvdata->csdev->dev, "%s: successfully opened\n", __func__);
>  	return 0;
>  }
>  
> @@ -150,12 +150,13 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
>  		return 0;
>  
>  	if (copy_to_user(data, bufp, actual)) {
> -		dev_dbg(drvdata->dev, "%s: copy_to_user failed\n", __func__);
> +		dev_dbg(&drvdata->csdev->dev,
> +			"%s: copy_to_user failed\n", __func__);
>  		return -EFAULT;
>  	}
>  
>  	*ppos += actual;
> -	dev_dbg(drvdata->dev, "%zu bytes copied\n", actual);
> +	dev_dbg(&drvdata->csdev->dev, "%zu bytes copied\n", actual);
>  
>  	return actual;
>  }
> @@ -170,7 +171,7 @@ static int tmc_release(struct inode *inode, struct file *file)
>  	if (ret)
>  		return ret;
>  
> -	dev_dbg(drvdata->dev, "%s: released\n", __func__);
> +	dev_dbg(&drvdata->csdev->dev, "%s: released\n", __func__);
>  	return 0;
>  }
>  
> @@ -330,24 +331,22 @@ const struct attribute_group *coresight_tmc_groups[] = {
>  	NULL,
>  };
>  
> -static inline bool tmc_etr_can_use_sg(struct tmc_drvdata *drvdata)
> +static inline bool tmc_etr_can_use_sg(struct device *dev)
>  {
> -	return fwnode_property_present(drvdata->dev->fwnode,
> -				       "arm,scatter-gather");
> +	return fwnode_property_present(dev->fwnode, "arm,scatter-gather");
>  }
>  
>  /* Detect and initialise the capabilities of a TMC ETR */
> -static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
> -			     u32 devid, void *dev_caps)
> +static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
>  {
>  	int rc;
> -
>  	u32 dma_mask = 0;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
>  
>  	/* Set the unadvertised capabilities */
>  	tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
>  
> -	if (!(devid & TMC_DEVID_NOSCAT) && tmc_etr_can_use_sg(drvdata))
> +	if (!(devid & TMC_DEVID_NOSCAT) && tmc_etr_can_use_sg(parent))
>  		tmc_etr_set_cap(drvdata, TMC_ETR_SG);
>  
>  	/* Check if the AXI address width is available */
> @@ -365,15 +364,15 @@ static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
>  	case 44:
>  	case 48:
>  	case 52:
> -		dev_info(drvdata->dev, "Detected dma mask %dbits\n", dma_mask);
> +		dev_info(parent, "Detected dma mask %dbits\n", dma_mask);
>  		break;
>  	default:
>  		dma_mask = 40;
>  	}
>  
> -	rc = dma_set_mask_and_coherent(drvdata->dev, DMA_BIT_MASK(dma_mask));
> +	rc = dma_set_mask_and_coherent(parent, DMA_BIT_MASK(dma_mask));
>  	if (rc)
> -		dev_err(drvdata->dev, "Failed to setup DMA mask: %d\n", rc);
> +		dev_err(parent, "Failed to setup DMA mask: %d\n", rc);
>  	return rc;
>  }
>  
> @@ -403,7 +402,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (!drvdata)
>  		goto out;
>  
> -	drvdata->dev = &adev->dev;
>  	dev_set_drvdata(dev, drvdata);
>  
>  	/* Validity for the resource is already checked by the AMBA core */
> @@ -446,7 +444,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  		desc.type = CORESIGHT_DEV_TYPE_SINK;
>  		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>  		desc.ops = &tmc_etr_cs_ops;
> -		ret = tmc_etr_setup_caps(drvdata, devid,
> +		ret = tmc_etr_setup_caps(dev, devid,
>  					 coresight_get_uci_data(id));
>  		if (ret)
>  			goto out;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 487c537..3eeadcf 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -175,7 +175,6 @@ struct etr_buf {
>   */
>  struct tmc_drvdata {
>  	void __iomem		*base;
> -	struct device		*dev;

Please clean up the structure documentation.

With that and regardless of what you decide to do about the 'real_dev':

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	struct coresight_device	*csdev;
>  	struct miscdevice	miscdev;
>  	spinlock_t		spinlock;
> -- 
> 2.7.4
> 

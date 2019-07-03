Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D70C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D292189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562169423;
	bh=8sDRuxzVq2abiEwYVIPCR4YAVFz6RmVtRL+Dk6P3bu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bz0y6NZ+dH/V9rWpuv5wO8E5n99IJE3PO9BD3UxEgW9Q/uZ4wBIUeTP0BwYafVITh
	 QxlyfxCh17NICuDDV61QbJcQuGdSxtxuew3CPw2IfgVmLr0hTjgcAezR/CcUeol093
	 bqaustXTOlBEf0QUnjXuKGwh5fLq3yi32LcFc0o0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfGCP5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfGCP5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:57:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B17C2189E;
        Wed,  3 Jul 2019 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562169420;
        bh=8sDRuxzVq2abiEwYVIPCR4YAVFz6RmVtRL+Dk6P3bu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vuh/W8X8SfYgBePbTkK5auwenE8GY23rGHtVn5BCp0sS8SuAfK0cQyqaN+8/3nAJ1
         bqFkOBUKapIx3/6norZyOwhYZEhYhu2TfkSsNWASMKaTja0PCNQztz6HkTr/F3ugkl
         hTe4TsIKmf/uGHsTla/yCE6SqocMDt0x010y/YY0=
Date:   Wed, 3 Jul 2019 17:56:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [GIT PULL 8/9] intel_th: msu-sink: An example msu buffer driver
Message-ID: <20190703155658.GB32438@kroah.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
 <20190627125152.54905-9-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627125152.54905-9-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 03:51:51PM +0300, Alexander Shishkin wrote:
> This patch adds an example "sink" MSU buffer driver, which consumes trace
> data from MSC buffers.
> 
> Functionally, it acts similarly to "multi" mode with automatic window
> switching.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hwtracing/intel_th/Makefile   |   3 +
>  drivers/hwtracing/intel_th/msu-sink.c | 127 ++++++++++++++++++++++++++
>  2 files changed, 130 insertions(+)
>  create mode 100644 drivers/hwtracing/intel_th/msu-sink.c
> 
> diff --git a/drivers/hwtracing/intel_th/Makefile b/drivers/hwtracing/intel_th/Makefile
> index d9252fa8d9ca..b63eb8f309ad 100644
> --- a/drivers/hwtracing/intel_th/Makefile
> +++ b/drivers/hwtracing/intel_th/Makefile
> @@ -20,3 +20,6 @@ intel_th_msu-y			:= msu.o
>  
>  obj-$(CONFIG_INTEL_TH_PTI)	+= intel_th_pti.o
>  intel_th_pti-y			:= pti.o
> +
> +obj-$(CONFIG_INTEL_TH_MSU)	+= intel_th_msu_sink.o
> +intel_th_msu_sink-y		:= msu-sink.o
> diff --git a/drivers/hwtracing/intel_th/msu-sink.c b/drivers/hwtracing/intel_th/msu-sink.c
> new file mode 100644
> index 000000000000..d2bdd4da6f14
> --- /dev/null
> +++ b/drivers/hwtracing/intel_th/msu-sink.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * An example software sink buffer driver for Intel TH MSU.
> + *
> + * Copyright (C) 2019 Intel Corporation.
> + */
> +
> +#include <linux/intel_th.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +
> +#define MAX_SGTS 16
> +
> +struct msu_sink_private {
> +	struct device	*dev;
> +	struct sg_table **sgts;
> +	unsigned int	nr_sgts;
> +};
> +
> +static void *msu_sink_assign(struct device *dev, int *mode)
> +{
> +	struct msu_sink_private *priv;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return NULL;
> +
> +	priv->sgts = kcalloc(MAX_SGTS, sizeof(void *), GFP_KERNEL);
> +	if (!priv->sgts) {
> +		kfree(priv);
> +		return NULL;
> +	}
> +
> +	priv->dev = dev;
> +	*mode = MSC_MODE_MULTI;
> +
> +	return priv;
> +}
> +
> +static void msu_sink_unassign(void *data)
> +{
> +	struct msu_sink_private *priv = data;
> +
> +	kfree(priv->sgts);
> +	kfree(priv);
> +}
> +
> +/* See also: msc.c: __msc_buffer_win_alloc() */
> +static int msu_sink_alloc_window(void *data, struct sg_table **sgt, size_t size)
> +{
> +	struct msu_sink_private *priv = data;
> +	unsigned int nents;
> +	struct scatterlist *sg_ptr;
> +	void *block;
> +	int ret, i;
> +
> +	if (priv->nr_sgts == MAX_SGTS)
> +		return -ENOMEM;
> +
> +	nents = DIV_ROUND_UP(size, PAGE_SIZE);
> +
> +	ret = sg_alloc_table(*sgt, nents, GFP_KERNEL);
> +	if (ret)
> +		return -ENOMEM;
> +
> +	priv->sgts[priv->nr_sgts++] = *sgt;
> +
> +	for_each_sg((*sgt)->sgl, sg_ptr, nents, i) {
> +		block = dma_alloc_coherent(priv->dev->parent->parent,
> +					   PAGE_SIZE, &sg_dma_address(sg_ptr),
> +					   GFP_KERNEL);
> +		sg_set_buf(sg_ptr, block, PAGE_SIZE);
> +	}
> +
> +	return nents;
> +}
> +
> +/* See also: msc.c: __msc_buffer_win_free() */
> +static void msu_sink_free_window(void *data, struct sg_table *sgt)
> +{
> +	struct msu_sink_private *priv = data;
> +	struct scatterlist *sg_ptr;
> +	int i;
> +
> +	for_each_sg(sgt->sgl, sg_ptr, sgt->nents, i) {
> +		dma_free_coherent(priv->dev->parent->parent, PAGE_SIZE,
> +				  sg_virt(sg_ptr), sg_dma_address(sg_ptr));
> +	}
> +
> +	sg_free_table(sgt);
> +	priv->nr_sgts--;
> +}
> +
> +static int msu_sink_ready(void *data, struct sg_table *sgt, size_t bytes)
> +{
> +	struct msu_sink_private *priv = data;
> +
> +	intel_th_msc_window_unlock(priv->dev, sgt);
> +
> +	return 0;
> +}
> +
> +static const struct msu_buffer_driver sink_bdrv = {
> +	.name		= "sink",
> +	.owner		= THIS_MODULE,

Ah, there you use it.

No, don't.  Use the "modern" way of not requiring code to ever set this
and use the compiler to do it for you.  Look at any of the normal bus
registering driver functions for how this is done.

thanks,

greg k-h

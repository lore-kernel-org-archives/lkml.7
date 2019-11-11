Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8C9C17447
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C075214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aO1pYj4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfKKWxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:53:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33134 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfKKWxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:53:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id h27so10458105pgn.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 14:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cF+kR6xsVwH35d1QqLaTXYy4+HEUDaOIESU4P7iHRtE=;
        b=aO1pYj4MkHkxduoNCSqMXEfZxxhcUs1S8q6sUS/KJRCnHdOlHPlJdbHsNMKhKR6c7A
         KkVSNrPIuDk6fpx3p/uux/iyZU0XJJqd8IVXCuA5pxd5F8gVJvAip6yi4P1yxxDdONnb
         6/beBj5zXM6CovgLtxwrqTsNjW3o7J/Gv8tSZIWomWjXKxxNyWZJT5c4kjPHI+dbLOYW
         JLpstynb4Ee4HTTUDOnIGk8Rfu4dWaeWDJmsN2UVAC31HR0+Xq0ZriLgJeW5Fqkjdn+j
         9x7pTLDPtkChLGDLS/fylcPlXhRahfKFUEw0yc90UNkyaonc8jMvK0Tu5SPdB8BJQ++h
         +o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cF+kR6xsVwH35d1QqLaTXYy4+HEUDaOIESU4P7iHRtE=;
        b=BIqoUoc79JLSt0nfxdSGrprqqiYooxDWJn/DyOr/BZy4SdXt5Jjv+w593Bu5iVL2Z3
         iMnZDHSBgQGDcqKO0HIQz0wpcabepMPWn1MgbPCJAjL4ZAnF/jbHDnbsachc7MfvheS/
         ftJ8haGdqzyzbnks7EGnsyQkMC/+1H9cLHz5d+Cerxq4ZgZbmaZa5obUu5ie0xAASMK3
         Qvrch/zGc2vLgq3lu6bvXSq/m9PV8M1fNt+VgzNdGhohoKIOKB5IcBe2aTjAVct2MwTZ
         xYBP7t91MnUSbOd0gxx+AnXW1Rm8XFUqlWIs3zYM0L0rMOxhLW6l2medBLDbhbUnl1Si
         AVyA==
X-Gm-Message-State: APjAAAXEX2bDbc09I/ARJH1qr+j7PHi6cRDK3psOHvd6pFsKFv432oem
        CllrCAbp0osgPArZJBb+lCb90Q==
X-Google-Smtp-Source: APXvYqzxfZwwefoN4j1Y9CQYe+KLK1YaNyxodIP9nrACCgiBkSSCrDlh5D6SGNhfRTBYcFr2HBoD2w==
X-Received: by 2002:a63:7247:: with SMTP id c7mr31695489pgn.311.1573512798854;
        Mon, 11 Nov 2019 14:53:18 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j17sm4450041pfr.2.2019.11.11.14.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 14:53:18 -0800 (PST)
Date:   Mon, 11 Nov 2019 14:53:16 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Erin Lo <erin.lo@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v20 2/4] remoteproc/mediatek: add SCP support for mt8183
Message-ID: <20191111225316.GC3108315@builder>
References: <20191014075812.181942-1-pihsun@chromium.org>
 <20191014075812.181942-3-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014075812.181942-3-pihsun@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Oct 00:58 PDT 2019, Pi-Hsun Shih wrote:
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
[..]
> +/**
> + * struct share_obj - SRAM buffer shared with
> + *		      AP and SCP

Please unwrap this line

> + *
> + * @id:		IPI id
> + * @len:	share buffer length
> + * @share_buf:	share buffer data
> + */
> +struct share_obj {

Please make this struct name slightly less generic, e.g. mtk_share_obj
should be fine.

> +	u32 id;
> +	u32 len;
> +	u8 share_buf[SCP_SHARE_BUFFER_SIZE];
> +};
> +
> +void scp_memcpy_aligned(void __iomem *dst, const void *src, unsigned int len);
> +void scp_ipi_lock(struct mtk_scp *scp, u32 id);
> +void scp_ipi_unlock(struct mtk_scp *scp, u32 id);
> +
> +#endif
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
[..]
> +struct platform_device *scp_get_pdev(struct platform_device *pdev)

I'm unable to find a patch that calls this, but I assume you're only
using the returned struct platform_device * in order to call the other
exported functions in this driver.

If this is the case I would suggest that you return a struct mtk_scp *
instead, as this makes your API cleaner and prevents confusion about
what platform_device could/should be passed in.

Note that you don't need to disclose the struct mtk_scp to your clients,
just add a "struct mtk_scp;" in include/remoteproc/mtk_scp.h and your
clients can pass this pointer around.

> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *scp_node;
> +	struct platform_device *scp_pdev;
> +
> +	scp_node = of_parse_phandle(dev->of_node, "mediatek,scp", 0);
> +	if (!scp_node) {
> +		dev_err(dev, "can't get SCP node\n");
> +		return NULL;
> +	}
> +
> +	scp_pdev = of_find_device_by_node(scp_node);
> +	if (WARN_ON(!scp_pdev)) {
> +		dev_err(dev, "SCP pdev failed\n");
> +		of_node_put(scp_node);
> +		return NULL;
> +	}
> +
> +	return scp_pdev;
> +}
> +EXPORT_SYMBOL_GPL(scp_get_pdev);
[..]
> +static irqreturn_t scp_irq_handler(int irq, void *priv)
> +{
> +	struct mtk_scp *scp = priv;
> +	u32 scp_to_host;
> +	int ret;
> +
> +	ret = clk_prepare_enable(scp->clk);
> +	if (ret) {
> +		dev_err(scp->dev, "failed to enable clocks\n");
> +		return IRQ_NONE;
> +	}
> +
> +	scp_to_host = readl(scp->reg_base + MT8183_SCP_TO_HOST);
> +	if (scp_to_host & MT8183_SCP_IPC_INT_BIT)
> +		scp_ipi_handler(scp);
> +	else
> +		scp_wdt_handler(scp, scp_to_host);
> +
> +	/*
> +	 * Ensure that all writes to SRAM are committed before another
> +	 * interrupt.
> +	 */
> +	mb();

writel() should ensure the ordering, is this not sufficient?

> +	/* SCP won't send another interrupt until we set SCP_TO_HOST to 0. */
> +	writel(MT8183_SCP_IPC_INT_BIT | MT8183_SCP_WDT_INT_BIT,
> +	       scp->reg_base + MT8183_SCP_TO_HOST);
> +	clk_disable_unprepare(scp->clk);
> +
> +	return IRQ_HANDLED;
> +}
[..]
> +static int scp_map_memory_region(struct mtk_scp *scp)
> +{
> +	int ret;
> +
> +	ret = of_reserved_mem_device_init_by_idx(scp->dev, scp->dev->of_node,
> +						 0);

As you're passing 0, just use of_reserved_mem_device_init().

> +	if (ret) {
> +		dev_err(scp->dev,
> +			"%s:of_reserved_mem_device_init_by_idx(0) failed:(%d)",
> +			__func__, ret);

Please don't use __func__ in your error messages, make this "failed to
assign memory-region: %d\n");

> +		return -ENOMEM;
> +	}
> +
> +	/* Reserved SCP code size */
> +	scp->dram_size = MAX_CODE_SIZE;
> +	scp->cpu_addr = dma_alloc_coherent(scp->dev, scp->dram_size,
> +					   &scp->phys_addr, GFP_KERNEL);

Don't you have a problem with that the reserved memory region must be
8MB for this allocation to succeed? If so, consider using devm_ioremap
or similar to map the region.

> +	if (!scp->cpu_addr)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void scp_unmap_memory_region(struct mtk_scp *scp)
> +{
> +	dma_free_coherent(scp->dev, scp->dram_size, scp->cpu_addr,
> +			  scp->phys_addr);
> +	of_reserved_mem_device_release(scp->dev);
> +}
> +
> +static int scp_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct mtk_scp *scp;
> +	struct rproc *rproc;
> +	struct resource *res;
> +	char *fw_name = "scp.img";
> +	int ret, i;
> +
> +	rproc = rproc_alloc(dev,
> +			    np->name,
> +			    &scp_ops,
> +			    fw_name,
> +			    sizeof(*scp));
> +	if (!rproc) {
> +		dev_err(dev, "unable to allocate remoteproc\n");
> +		return -ENOMEM;
> +	}
> +
> +	scp = (struct mtk_scp *)rproc->priv;
> +	scp->rproc = rproc;
> +	scp->dev = dev;
> +	platform_set_drvdata(pdev, scp);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
> +	scp->sram_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR((__force void *)scp->sram_base)) {
> +		dev_err(dev, "Failed to parse and map sram memory\n");
> +		ret = PTR_ERR((__force void *)scp->sram_base);
> +		goto free_rproc;
> +	}
> +	scp->sram_size = resource_size(res);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	scp->reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR((__force void *)scp->reg_base)) {
> +		dev_err(dev, "Failed to parse and map cfg memory\n");
> +		ret = PTR_ERR((__force void *)scp->reg_base);
> +		goto free_rproc;
> +	}
> +
> +	ret = scp_map_memory_region(scp);
> +	if (ret)
> +		goto free_rproc;
> +
> +	scp->clk = devm_clk_get(dev, "main");
> +	if (IS_ERR(scp->clk)) {
> +		dev_err(dev, "Failed to get clock\n");
> +		ret = PTR_ERR(scp->clk);
> +		goto release_dev_mem;
> +	}
> +
> +	ret = clk_prepare_enable(scp->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clocks\n");
> +		goto release_dev_mem;
> +	}
> +
> +	mutex_init(&scp->send_lock);
> +	for (i = 0; i < SCP_IPI_MAX; i++)
> +		mutex_init(&scp->ipi_desc[i].lock);

Move this chunk up above the platform_get_resource_byname(), so that
it's clear that  clk_prepare_enable/clk_disable_unprepare() wraps the
scp_ipi_init().

Also double check that you're hitting destroy_mutex: when necessary.

> +
> +	ret = scp_ipi_init(scp);
> +	clk_disable_unprepare(scp->clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to init ipi\n");
> +		goto release_dev_mem;
> +	}
> +
> +	/* register SCP initialization IPI */
> +	ret = scp_ipi_register(pdev,
> +			       SCP_IPI_INIT,
> +			       scp_init_ipi_handler,
> +			       scp);
> +	if (ret) {
> +		dev_err(dev, "Failed to register IPI_SCP_INIT\n");
> +		goto release_dev_mem;
> +	}
> +
> +	init_waitqueue_head(&scp->run.wq);
> +	init_waitqueue_head(&scp->ack_wq);
> +
> +	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0), NULL,
> +					scp_irq_handler, IRQF_ONESHOT,
> +					pdev->name, scp);
> +
> +	if (ret) {
> +		dev_err(dev, "failed to request irq\n");
> +		goto destroy_mutex;
> +	}
> +
> +	ret = rproc_add(rproc);
> +	if (ret)
> +		goto destroy_mutex;
> +
> +	return ret;
> +
> +destroy_mutex:
> +	for (i = 0; i < SCP_IPI_MAX; i++)
> +		mutex_destroy(&scp->ipi_desc[i].lock);
> +	mutex_destroy(&scp->send_lock);
> +release_dev_mem:
> +	scp_unmap_memory_region(scp);
> +free_rproc:
> +	rproc_free(rproc);
> +
> +	return ret;
> +}
> +
> +static int scp_remove(struct platform_device *pdev)
> +{
> +	struct mtk_scp *scp = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < SCP_IPI_MAX; i++)
> +		mutex_destroy(&scp->ipi_desc[i].lock);
> +	mutex_destroy(&scp->send_lock);

rproc_del() serves as a synchronization point for when callbacks
shouldn't be called anymore, so destroy your mutexes after that.

> +	rproc_del(scp->rproc);
> +	rproc_free(scp->rproc);
> +	scp_unmap_memory_region(scp);
> +
> +	return 0;
> +}
> +
[..]
> diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
[..]
> +/*
> + * Copy src to dst, where dst is in SCP SRAM region.

Please format this as kerneldoc.

> + * Since AP access of SCP SRAM don't support byte write, this always write a
> + * full word at a time, and may cause some extra bytes to be written at the
> + * beginning & ending of dst.
> + */
> +void scp_memcpy_aligned(void __iomem *dst, const void *src, unsigned int len)
> +{
> +	void __iomem *ptr;
> +	u32 val;
> +	unsigned int i = 0;
> +
> +	if (!IS_ALIGNED((unsigned long)dst, 4)) {
> +		ptr = (void __iomem *)ALIGN_DOWN((unsigned long)dst, 4);
> +		i = 4 - (dst - ptr);
> +		val = readl_relaxed(ptr);
> +		memcpy((u8 *)&val + (4 - i), src, i);
> +		writel_relaxed(val, ptr);
> +	}
> +
> +	while (i + 4 <= len) {
> +		val = *((u32 *)(src + i));
> +		writel_relaxed(val, dst + i);
> +		i += 4;
> +	}

Afaict above reimplements __iowrite32_copy().

> +	if (i < len) {
> +		val = readl_relaxed(dst + i);
> +		memcpy(&val, src + i, len - i);
> +		writel_relaxed(val, dst + i);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(scp_memcpy_aligned);
> +
[..]
> +int scp_ipi_send(struct platform_device *pdev,
> +		 u32 id,
> +		 void *buf,
> +		 unsigned int len,
> +		 unsigned int wait)
> +{
[..]
> +	scp->ipi_id_ack[id] = false;
> +	/*
> +	 * Ensure that all writes to SRAM are committed before sending the
> +	 * interrupt to SCP.
> +	 */
> +	mb();

Again, isn't the implicit barrier in writel enough?

> +	/* send the command to SCP */
> +	writel(MT8183_HOST_IPC_INT_BIT, scp->reg_base + MT8183_HOST_TO_SCP);
[..]
> diff --git a/include/linux/remoteproc/mtk_scp.h b/include/linux/remoteproc/mtk_scp.h
[..]
> +/**
> + * scp_ipi_register - register an ipi function

Parenthesis on this, i.e. "scp_ipi_register() - register an ipi function"

> + *
> + * @pdev:	SCP platform device
> + * @id:		IPI ID
> + * @handler:	IPI handler
> + * @priv:	private data for IPI handler
> + *
> + * Register an ipi function to receive ipi interrupt from SCP.
> + *
> + * Return: Return 0 if ipi registers successfully, otherwise it is failed.
> + */

Please move the kerneldoc to the implementation instead.

Regards,
Bjorn

Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF847C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5052632B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mgCgRfQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEaDpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:45:08 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:43274 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfEaDpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559274307; x=1590810307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UIwdMV/ZvahHI0nYgAbL/aF+9fcUeB4vVN59ORlDahU=;
  b=mgCgRfQFNmHPdx3yObmwpqmTxEdOGPXBlRS39Cd3KG2WkPx80/sHcSxV
   D2GL/ymUCxQNvpeusbKTdsZP0+sN54h1cTHwrtH/JE2pho0JUEzQSuTR2
   zexfimtI4PnWOhh97AadQUw7IXvCjREIVB0Y4X3p97QW6TuaIZSaqJc17
   U=;
X-IronPort-AV: E=Sophos;i="5.60,533,1549929600"; 
   d="scan'208";a="404442620"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 31 May 2019 03:45:04 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 06C21A27B1;
        Fri, 31 May 2019 03:45:03 +0000 (UTC)
Received: from EX13D04UEA002.ant.amazon.com (10.43.61.61) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 31 May 2019 03:45:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D04UEA002.ant.amazon.com (10.43.61.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 31 May 2019 03:45:03 +0000
Received: from localhost (10.85.16.145) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 31 May 2019 03:45:03 +0000
Date:   Thu, 30 May 2019 20:45:02 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Eddie James <eajames@linux.ibm.com>
CC:     <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>
Subject: Re: [PATCH v3 5/8] drivers/soc: xdma: Add PCI device configuration
 sysfs
Message-ID: <20190531034502.GH17772@u40b0340c692b58f6553c.ant.amazon.com>
References: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
 <1559153408-31190-6-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1559153408-31190-6-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 01:10:05PM -0500, Eddie James wrote:
> The AST2500 has two PCI devices embedded. The XDMA engine can use either
> device to perform DMA transfers. Users need the capability to choose
> which device to use. This commit therefore adds two sysfs files that
> toggle the AST2500 and XDMA engine between the two PCI devices.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/soc/aspeed/aspeed-xdma.c | 103 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 100 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
> index 39f6545..ddd5e1e 100644
> --- a/drivers/soc/aspeed/aspeed-xdma.c
> +++ b/drivers/soc/aspeed/aspeed-xdma.c
> @@ -143,6 +143,7 @@ struct aspeed_xdma {
>  	void *cmdq_vga_virt;
>  	struct gen_pool *vga_pool;
>  
> +	char pcidev[4];
>  	struct miscdevice misc;
>  };
>  
> @@ -165,6 +166,10 @@ struct aspeed_xdma_client {
>  	SCU_PCIE_CONF_VGA_EN_IRQ | SCU_PCIE_CONF_VGA_EN_DMA |
>  	SCU_PCIE_CONF_RSVD;
>  
> +static char *_pcidev = "vga";
> +module_param_named(pcidev, _pcidev, charp, 0600);
> +MODULE_PARM_DESC(pcidev, "Default PCI device used by XDMA engine for DMA ops");
> +
>  static void aspeed_scu_pcie_write(struct aspeed_xdma *ctx, u32 conf)
>  {
>  	u32 v = 0;
> @@ -512,7 +517,7 @@ static int aspeed_xdma_release(struct inode *inode, struct file *file)
>  	.release		= aspeed_xdma_release,
>  };
>  
> -static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
> +static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx, u32 conf)
>  {
>  	int rc;
>  	u32 scu_conf = 0;
> @@ -522,7 +527,7 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
>  	const u32 vga_sizes[4] = { 0x800000, 0x1000000, 0x2000000, 0x4000000 };
>  	void __iomem *sdmc_base = ioremap(0x1e6e0000, 0x100);
>  
> -	aspeed_scu_pcie_write(ctx, aspeed_xdma_vga_pcie_conf);
> +	aspeed_scu_pcie_write(ctx, conf);
>  
>  	regmap_read(ctx->scu, SCU_STRAP, &scu_conf);
>  	ctx->vga_size = vga_sizes[FIELD_GET(SCU_STRAP_VGA_MEM, scu_conf)];
> @@ -598,10 +603,91 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
>  	return rc;
>  }
>  
> +static int aspeed_xdma_change_pcie_conf(struct aspeed_xdma *ctx, u32 conf)
> +{
> +	int rc;
> +
> +	mutex_lock(&ctx->start_lock);
> +	rc = wait_event_interruptible_timeout(ctx->wait,
> +					      !test_bit(XDMA_IN_PRG,
> +							&ctx->flags),
> +					      msecs_to_jiffies(1000));
> +	if (rc < 0) {
> +		mutex_unlock(&ctx->start_lock);
> +		return -EINTR;
> +	}
> +
> +	/* previous op didn't complete, wake up waiters anyway */
> +	if (!rc)
> +		wake_up_interruptible_all(&ctx->wait);
> +
> +	reset_control_assert(ctx->reset);
> +	msleep(10);
> +
> +	aspeed_scu_pcie_write(ctx, conf);
> +	msleep(10);
> +
> +	reset_control_deassert(ctx->reset);
> +	msleep(10);
> +
> +	aspeed_xdma_init_eng(ctx);
> +
> +	mutex_unlock(&ctx->start_lock);
> +
> +	return 0;
> +}
> +
> +static int aspeed_xdma_pcidev_to_conf(struct aspeed_xdma *ctx,
> +				      const char *pcidev, u32 *conf)
> +{
> +	if (!strcasecmp(pcidev, "vga")) {
> +		*conf = aspeed_xdma_vga_pcie_conf;
> +		return 0;
> +	}
> +
> +	if (!strcasecmp(pcidev, "bmc")) {
> +		*conf = aspeed_xdma_bmc_pcie_conf;
> +		return 0;
> +	}

strncasecmp()?

> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t aspeed_xdma_show_pcidev(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
> +
> +	return snprintf(buf, PAGE_SIZE - 1, "%s", ctx->pcidev);
> +}
> +
> +static ssize_t aspeed_xdma_store_pcidev(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	u32 conf;
> +	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
> +	int rc = aspeed_xdma_pcidev_to_conf(ctx, buf, &conf);
> +
> +	if (rc)
> +		return rc;
> +
> +	rc = aspeed_xdma_change_pcie_conf(ctx, conf);
> +	if (rc)
> +		return rc;
> +
> +	strcpy(ctx->pcidev, buf);

should we use strncpy() instead?

> +	return count;
> +}
> +static DEVICE_ATTR(pcidev, 0644, aspeed_xdma_show_pcidev,
> +		   aspeed_xdma_store_pcidev);
> +
>  static int aspeed_xdma_probe(struct platform_device *pdev)
>  {
>  	int irq;
>  	int rc;
> +	u32 conf;
>  	struct resource *res;
>  	struct device *dev = &pdev->dev;
>  	struct aspeed_xdma *ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> @@ -657,7 +743,14 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
>  
>  	msleep(10);
>  
> -	rc = aspeed_xdma_init_mem(ctx);
> +	if (aspeed_xdma_pcidev_to_conf(ctx, _pcidev, &conf)) {
> +		conf = aspeed_xdma_vga_pcie_conf;
> +		strcpy(ctx->pcidev, "vga");
> +	} else {
> +		strcpy(ctx->pcidev, _pcidev);
> +	}

same...

> +
> +	rc = aspeed_xdma_init_mem(ctx, conf);
>  	if (rc) {
>  		reset_control_assert(ctx->reset);
>  		return rc;
> @@ -682,6 +775,8 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
>  		return rc;
>  	}
>  
> +	device_create_file(dev, &dev_attr_pcidev);

Should we consider using one of the default attributes here instead of device_create_file()?
http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/

BTW, was this ABI documented? Is this the same file documented in patch 2?

> +
>  	return 0;
>  }
>  
> @@ -689,6 +784,8 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
>  {
>  	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
>  
> +	device_remove_file(ctx->dev, &dev_attr_pcidev);
> +
>  	misc_deregister(&ctx->misc);
>  	gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
>  		      XDMA_CMDQ_SIZE);
> -- 
> 1.8.3.1
> 

-- 
All the best,
Eduardo Valentin

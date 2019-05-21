Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAE9C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD08D21783
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="jW1u63ms";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ncP9gO4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfEUDWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 23:22:21 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38389 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbfEUDWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 23:22:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 52AF7221CF;
        Mon, 20 May 2019 23:22:19 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 20 May 2019 23:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=UVgcWUJS9f40pxdUbWT1JD35Tkgldj9
        6FABjCh189ug=; b=jW1u63ms9YqIXPLEzx3rKlhLLDYvaYJxmannWvpNLBK18iN
        5DyozbtufVn1iI+hKFkA/HZIgLt9Y9zYp8VoPnTE+L1u/x6sxHgYm+akZeoXT4/Y
        JUJOmeTz8b9if0YvFyNZ/FIXpv3Rn4fShcODEA7mi2oWsHpiBx7xJE0Dbm6eJK3c
        q6Mo0QCZ6S2KbZJgONjuvsH4gYl5fNi/opfsdFbSPrGkaXIn/zi8Cf6kEAsanIx2
        +tUIriiMRO/sdPoq4sCbx7MMdpGo4mm/rsm2GbzkJVQLPaNGAJVhMJwRKrRzxR/S
        KXuAbZk84wcHhA8GFb8Zuel23LcFQtczR5SmbuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=UVgcWU
        JS9f40pxdUbWT1JD35Tkgldj96FABjCh189ug=; b=ncP9gO4BlWGhaNUDfq1aBb
        tkkOO1eVuMkadaj9BqRwpX+PufKn+Ow/xekCqyyw2ZzY4nhFJOVSqL9f9wb2yvCM
        W0/aA+XWD5j5oQ9gbZJIqj35cF2qiaUQaXgtr/Dp85LsS5SyTVbVFdlZpz/mlNbW
        sKruVrqr7XifqjwWH3CobFrtb7gDrJ+sLS7buaxUp8+QCxfpVfwE3zqDd9Bxv2xL
        JTuH7JpUnuNrubu4Q4B2vyDJ7BdGBbvr+82/cbKhiMfCzNAvRYqTh79gPvwMEdZ6
        5yNGPvByATdY1WXzGdFtzIRrnLOTVOCukSytANm911KdK5zTNXP0+tFlm6UINcsw
        ==
X-ME-Sender: <xms:6W7jXKNvTtpOTFyrad9YVX8RIPrgIVg46wYky7wFYNh6DTezF3R3XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtledgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:6W7jXGraUVmHsZOZe8vx8p_8-9747PQvB1G_ZzxcQsz04VGlHSwISQ>
    <xmx:6W7jXJUiXEbaHEdLJ3Ky_h4oZ3HVqRlD4IXrcKwmatmYWTUlG7AoOg>
    <xmx:6W7jXDF6GQ_io9EglVQ11dFMxJXkd1LqPT5XGOxTN261HCWztjKziw>
    <xmx:627jXAIN5F0KWrJ09QA8bgk-Q8CZkJEHvJUI2NXQJpGDIQDEYmLp-A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9D2677C1B1; Mon, 20 May 2019 23:22:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-550-g29afa21-fmstable-20190520v1
Mime-Version: 1.0
Message-Id: <e7592bb9-c455-4eca-9c42-2ab16d04a57f@www.fastmail.com>
In-Reply-To: <1558383565-11821-5-git-send-email-eajames@linux.ibm.com>
References: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com>
 <1558383565-11821-5-git-send-email-eajames@linux.ibm.com>
Date:   Tue, 21 May 2019 12:52:17 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Rob Herring" <robh+dt@kernel.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, "Joel Stanley" <joel@jms.id.au>
Subject: =?UTF-8?Q?Re:_[PATCH_v2_4/7]_drivers/soc:_xdma:_Add_PCI_device_configura?=
 =?UTF-8?Q?tion_sysfs?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 May 2019, at 05:51, Eddie James wrote:
> The AST2500 has two PCI devices embedded. The XDMA engine can use either
> device to perform DMA transfers. Users need the capability to choose
> which device to use. This commit therefore adds two sysfs files that
> toggle the AST2500 and XDMA engine between the two PCI devices.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/soc/aspeed/aspeed-xdma.c | 64 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/soc/aspeed/aspeed-xdma.c 
> b/drivers/soc/aspeed/aspeed-xdma.c
> index 2162ca0..002b571 100644
> --- a/drivers/soc/aspeed/aspeed-xdma.c
> +++ b/drivers/soc/aspeed/aspeed-xdma.c
> @@ -667,6 +667,64 @@ static void aspeed_xdma_free_vga_blks(struct 
> aspeed_xdma *ctx)
>  	}
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
> +static ssize_t aspeed_xdma_use_bmc(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	int rc;
> +	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
> +
> +	rc = aspeed_xdma_change_pcie_conf(ctx, aspeed_xdma_bmc_pcie_conf);
> +	return rc ?: count;
> +}
> +static DEVICE_ATTR(use_bmc, 0200, NULL, aspeed_xdma_use_bmc);
> +
> +static ssize_t aspeed_xdma_use_vga(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	int rc;
> +	struct aspeed_xdma *ctx = dev_get_drvdata(dev);
> +
> +	rc = aspeed_xdma_change_pcie_conf(ctx, aspeed_xdma_vga_pcie_conf);
> +	return rc ?: count;
> +}
> +static DEVICE_ATTR(use_vga, 0200, NULL, aspeed_xdma_use_vga);
> +
>  static int aspeed_xdma_probe(struct platform_device *pdev)
>  {
>  	int irq;
> @@ -745,6 +803,9 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
>  		return rc;
>  	}
>  
> +	device_create_file(dev, &dev_attr_use_bmc);
> +	device_create_file(dev, &dev_attr_use_vga);

Two attributes is a broken approach IMO. This gives the false representation of 4
states (neither, vga, bmc, both) when really there are only two (vga and bmc). I
think we should have one attribute that reacts to "vga" and "bmc" writes.

Andrew

> +
>  	return 0;
>  }
>  
> @@ -752,6 +813,9 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
>  {
>  	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
>  
> +	device_remove_file(ctx->dev, &dev_attr_use_vga);
> +	device_remove_file(ctx->dev, &dev_attr_use_bmc);
> +
>  	misc_deregister(&ctx->misc);
>  
>  	aspeed_xdma_free_vga_blks(ctx);
> -- 
> 1.8.3.1
> 
>

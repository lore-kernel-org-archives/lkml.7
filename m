Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E100C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A66F243AC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Bqih8YLn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LZC8KP36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbfE3EC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:02:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57365 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbfE3ECM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:02:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DAB2C21FA7;
        Thu, 30 May 2019 00:02:10 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 30 May 2019 00:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=qyIi9G9ln+NMQWurPQHYWug6XmoD14N
        6qzo4ZOFsaOY=; b=Bqih8YLnL2VC2g+8JAzRNlikdAjAGB7W19vPi3fcYrRVV7e
        o/CrIuGMifez0eB8jpJNdT/3Ft6BTkjteYu/PwkWi01a8DKDkcxN1P3pn6oMKBFs
        QRvzEDSWFKBrsCoa3SRTzrFKDibbndeWhntyz4zOaSlwIpq0ectk3a025ay5jSQT
        IXXQO64v5jlt5iGoKPVKlIiiOZ4lbqqrmriyFTSQ0U+UvHVVzQFcBX0oatx8djiK
        aiFoiK4XTJ0+WlhzIQIWgdlROF+y+cWorvXm6ky2NC8EEBB24O/kx6NDl1ihPd3n
        1LqP34eLwfFJJKdtc2FrWTctonW4g1OYa3kQ7Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qyIi9G
        9ln+NMQWurPQHYWug6XmoD14N6qzo4ZOFsaOY=; b=LZC8KP36MjQNGAwMOKxclA
        pMXHy4rTEv/bM4O19IlKlhkg9CFwS42Cx2e4A5D0hbprPIJbPeWhiNmWO5Otx2s/
        aqemrxMMLW0cIC0iI+fsUjAEiacuz7Wm6SxDcUGaZZxjqYYObOHR7ziyUESY3io5
        H1RMZP6OGTEjHBJLIF1gQ4q78rAzWB50aXrpJTDcqn+FWmmlGpUk3eszmyrvUlSA
        xrpmD1q12nFIBQ8Fs6ZEt26rRxykBm0jnLLTmUJkvwaatyjkMX2BcDcycnU17kam
        tTR+n0YwzNrDn+6ejRMleun6pKTb6oOosyUqte84SY+tThZ1MghWLd1mVFYJvp6w
        ==
X-ME-Sender: <xms:wVXvXLxY60qWGyq1NkgwT9ZIUo-I84eI-TfgQ3hHyPRM5wXt2YSXTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddvkedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:wVXvXLFrjku1qhknIzEIpz4qiDiCkouHHrUfCykEWlCaNsp_vmcZKw>
    <xmx:wVXvXAt51U9RjzmNfIFa_u7Y_fZHKFovUOxOk4pE4HNwTbv88Jlykg>
    <xmx:wVXvXPXDjBNLjDSJDw3ZueJ9r8XapTg_fk_y9387Y9eiOVhV8gyJQQ>
    <xmx:wlXvXA0uNKJw6-La1QmRmdQMkjtYDAyVdfVWexWCs1Ko-T3eNXa3TA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 33313E00A1; Thu, 30 May 2019 00:02:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-555-g49357e1-fmstable-20190528v2
Mime-Version: 1.0
Message-Id: <fe36fbac-e29c-4210-9af2-defca62e9c2a@www.fastmail.com>
In-Reply-To: <20190529172103.1130525-1-vijaykhemka@fb.com>
References: <20190529172103.1130525-1-vijaykhemka@fb.com>
Date:   Thu, 30 May 2019 13:32:08 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Vijay Khemka" <vijaykhemka@fb.com>,
        "Joel Stanley" <joel@jms.id.au>,
        "Patrick Venture" <venture@google.com>,
        "Olof Johansson" <olof@lixom.net>, "Arnd Bergmann" <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     "Sai Dasari" <sdasari@fb.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] soc: aspeed: lpc-ctrl: make parameter optional
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 May 2019, at 02:51, Vijay Khemka wrote:
> Makiing

Typo here, but I'd prefer to see this patch go in, so

> memory-region and flash as optional parameter in device
> tree if user needs to use these parameter through ioctl then
> need to define in devicetree.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c | 58 +++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c 
> b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> index a024f8042259..aca13779764a 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> @@ -68,6 +68,7 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, 
> unsigned int cmd,
>  		unsigned long param)
>  {
>  	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
> +	struct device *dev = file->private_data;
>  	void __user *p = (void __user *)param;
>  	struct aspeed_lpc_ctrl_mapping map;
>  	u32 addr;
> @@ -90,6 +91,12 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, 
> unsigned int cmd,
>  		if (map.window_id != 0)
>  			return -EINVAL;
>  
> +		/* If memory-region is not described in device tree */
> +		if (!lpc_ctrl->mem_size) {
> +			dev_dbg(dev, "Didn't find reserved memory\n");
> +			return -ENXIO;
> +		}
> +
>  		map.size = lpc_ctrl->mem_size;
>  
>  		return copy_to_user(p, &map, sizeof(map)) ? -EFAULT : 0;
> @@ -126,9 +133,18 @@ static long aspeed_lpc_ctrl_ioctl(struct file 
> *file, unsigned int cmd,
>  			return -EINVAL;
>  
>  		if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
> +			if (!lpc_ctrl->pnor_size) {
> +				dev_dbg(dev, "Didn't find host pnor flash\n");
> +				return -ENXIO;
> +			}
>  			addr = lpc_ctrl->pnor_base;
>  			size = lpc_ctrl->pnor_size;
>  		} else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
> +			/* If memory-region is not described in device tree */
> +			if (!lpc_ctrl->mem_size) {
> +				dev_dbg(dev, "Didn't find reserved memory\n");
> +				return -ENXIO;
> +			}
>  			addr = lpc_ctrl->mem_base;
>  			size = lpc_ctrl->mem_size;
>  		} else {
> @@ -196,17 +212,17 @@ static int aspeed_lpc_ctrl_probe(struct 
> platform_device *pdev)
>  	if (!lpc_ctrl)
>  		return -ENOMEM;
>  
> +	/* If flash is described in device tree then store */
>  	node = of_parse_phandle(dev->of_node, "flash", 0);
>  	if (!node) {
> -		dev_err(dev, "Didn't find host pnor flash node\n");
> -		return -ENODEV;
> -	}
> -
> -	rc = of_address_to_resource(node, 1, &resm);
> -	of_node_put(node);
> -	if (rc) {
> -		dev_err(dev, "Couldn't address to resource for flash\n");
> -		return rc;
> +		dev_dbg(dev, "Didn't find host pnor flash node\n");
> +	} else {
> +		rc = of_address_to_resource(node, 1, &resm);
> +		of_node_put(node);
> +		if (rc) {
> +			dev_err(dev, "Couldn't address to resource for flash\n");
> +			return rc;
> +		}
>  	}
>  
>  	lpc_ctrl->pnor_size = resource_size(&resm);
> @@ -214,22 +230,22 @@ static int aspeed_lpc_ctrl_probe(struct 
> platform_device *pdev)
>  
>  	dev_set_drvdata(&pdev->dev, lpc_ctrl);
>  
> +	/* If memory-region is described in device tree then store */
>  	node = of_parse_phandle(dev->of_node, "memory-region", 0);
>  	if (!node) {
> -		dev_err(dev, "Didn't find reserved memory\n");
> -		return -EINVAL;
> -	}
> +		dev_dbg(dev, "Didn't find reserved memory\n");
> +	} else {
> +		rc = of_address_to_resource(node, 0, &resm);
> +		of_node_put(node);
> +		if (rc) {
> +			dev_err(dev, "Couldn't address to resource for reserved memory\n");
> +			return -ENXIO;
> +		}
>  
> -	rc = of_address_to_resource(node, 0, &resm);
> -	of_node_put(node);
> -	if (rc) {
> -		dev_err(dev, "Couldn't address to resource for reserved memory\n");
> -		return -ENOMEM;
> +		lpc_ctrl->mem_size = resource_size(&resm);
> +		lpc_ctrl->mem_base = resm.start;
>  	}
>  
> -	lpc_ctrl->mem_size = resource_size(&resm);
> -	lpc_ctrl->mem_base = resm.start;
> -
>  	lpc_ctrl->regmap = syscon_node_to_regmap(
>  			pdev->dev.parent->of_node);
>  	if (IS_ERR(lpc_ctrl->regmap)) {
> @@ -258,8 +274,6 @@ static int aspeed_lpc_ctrl_probe(struct 
> platform_device *pdev)
>  		goto err;
>  	}
>  
> -	dev_info(dev, "Loaded at %pr\n", &resm);
> -
>  	return 0;
>  
>  err:
> -- 
> 2.17.1
> 
>

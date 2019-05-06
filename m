Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0970BC04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 04:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE2F2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 04:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="BvJ/3C+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d8zTvlnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfEFEY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 00:24:28 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40443 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbfEFEY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 00:24:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EBAE720F51;
        Mon,  6 May 2019 00:24:23 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 06 May 2019 00:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=vvpSEtd/71ILYVnxht0QzJ3t9KHpGOA
        BdcYTEMQnFnY=; b=BvJ/3C+IsTJlE3JZt+akWqhUuurfqr85XWkuxTk6XWvc6Hv
        I8HzRy+inMg56yezGMfICg/mgb3mqTkwZLPVony1rsYhtnP7FsMCYEJj/rQIOIxz
        OT2H4eZY7JPqWWeUPGdjdscfM+rFkg0IXkPF8V5MAXpGWVzM9RW27pEE4BgOjPHN
        E8VxiveMfbOiA8NdCMGfKpLddsSZQ3/Y1YfUQ61Zras2yLtv1BTs09Fq9PLs6lEb
        VMmqnmisGj9al8vfqEM07fJkqzxx8VrATkxhXL69FVLU2Xla1Pmwak6li+seetqD
        yx+efktSd04jw5c9MY9VS3JXIc70cQ0zmsizP+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vvpSEt
        d/71ILYVnxht0QzJ3t9KHpGOABdcYTEMQnFnY=; b=d8zTvlnKIZ99YD0EcU/6CB
        1YKJz0mMB4fMvN7y5nBCWVhKz6Ralyn8SlVkVmqZhbJZw0fiUXMxISgRHjkduc4a
        8Y+7zl5c3MV8nQar/k/Mq0omEGBnpx7DioVlNLd/G25cV4EjT3r4R4Nwaan6FCbd
        y69UD4gwAstyKz0nLp/K5OxO/qSfF7IQnBWmCLUIWJR48rERnCnTAP3tZky+EweK
        c/B9sCW1PuHXZ9CJ92E9UpWsGWy5uSmjKIfDAtnyt67r7zm1DssWos9WW+8r3E7E
        3uaK345q2GAUq+hBLsJIUL/tEoRg5aCH+tBeDeqv6YRl6jTM0QhIMIZ9ImCpOoug
        ==
X-ME-Sender: <xms:9bbPXDTXQERiByBN7ueIdBBWGKvLLTvpXXdEP1Cnvg_5Mg4PkSlylw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrjeeigdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:9bbPXJowtklksSLCrnL19NWbqRExZANDMYdik5fxSZLkpyT_n-xOUQ>
    <xmx:9bbPXBZWgZ_X03aerpo-O4DjS7RPwOeK7H_13mUcLdE11qyCFmEEkQ>
    <xmx:9bbPXES6tGlFSKWnBE2VVcXNh8oo8zCxVotneQCYb4EwQ3L3nXTdTg>
    <xmx:97bPXBrQC5vH8uH97yfNiXOmXjuTHF4XBvRWl6di87l-C-HnXC3_Lw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 66C437C6D9; Mon,  6 May 2019 00:24:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-449-gfb3fc5a-fmstable-20190430v1
Mime-Version: 1.0
Message-Id: <76491a70-01ca-4308-a09e-4f223ac49ebd@www.fastmail.com>
In-Reply-To: <20190503181336.579877-1-vijaykhemka@fb.com>
References: <20190503181336.579877-1-vijaykhemka@fb.com>
Date:   Mon, 06 May 2019 00:24:13 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Vijay Khemka" <vijaykhemka@fb.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Joel Stanley" <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     sdasari@fb.com
Subject: Re: [PATCH v2] misc: aspeed-lpc-ctrl: Correct return values
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 May 2019, at 03:43, Vijay Khemka wrote:
> Corrected some of return values with appropriate meanings and reported
> relevant messages as debug information.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Thanks for the fixes, this looks okay now. However, was there a reason for
not squashing change into your previous patch that introduced the issues
this fixes? That hasn't been applied yet either as far as I'm aware. I'd prefer
we do that and submit a single, good patch if we can.

Andrew

> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c 
> b/drivers/misc/aspeed-lpc-ctrl.c
> index 332210e06e98..aca13779764a 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -93,8 +93,8 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, 
> unsigned int cmd,
>  
>  		/* If memory-region is not described in device tree */
>  		if (!lpc_ctrl->mem_size) {
> -			dev_err(dev, "Didn't find reserved memory\n");
> -			return -EINVAL;
> +			dev_dbg(dev, "Didn't find reserved memory\n");
> +			return -ENXIO;
>  		}
>  
>  		map.size = lpc_ctrl->mem_size;
> @@ -134,16 +134,16 @@ static long aspeed_lpc_ctrl_ioctl(struct file 
> *file, unsigned int cmd,
>  
>  		if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
>  			if (!lpc_ctrl->pnor_size) {
> -				dev_err(dev, "Didn't find host pnor flash\n");
> -				return -EINVAL;
> +				dev_dbg(dev, "Didn't find host pnor flash\n");
> +				return -ENXIO;
>  			}
>  			addr = lpc_ctrl->pnor_base;
>  			size = lpc_ctrl->pnor_size;
>  		} else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
>  			/* If memory-region is not described in device tree */
>  			if (!lpc_ctrl->mem_size) {
> -				dev_err(dev, "Didn't find reserved memory\n");
> -				return -EINVAL;
> +				dev_dbg(dev, "Didn't find reserved memory\n");
> +				return -ENXIO;
>  			}
>  			addr = lpc_ctrl->mem_base;
>  			size = lpc_ctrl->mem_size;
> @@ -239,7 +239,7 @@ static int aspeed_lpc_ctrl_probe(struct 
> platform_device *pdev)
>  		of_node_put(node);
>  		if (rc) {
>  			dev_err(dev, "Couldn't address to resource for reserved memory\n");
> -			return -ENOMEM;
> +			return -ENXIO;
>  		}
>  
>  		lpc_ctrl->mem_size = resource_size(&resm);
> -- 
> 2.17.1
> 
>

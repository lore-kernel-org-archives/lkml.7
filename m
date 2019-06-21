Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BFFC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6428B2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="fkcN1lTY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OU/hxIS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfFUB44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:56:56 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52109 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbfFUB44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:56:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B623021D51;
        Thu, 20 Jun 2019 21:56:54 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 20 Jun 2019 21:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=tLnRWlmzorgr7oKoK51UGqpEXN0boNS
        Id1GRxNsS9NQ=; b=fkcN1lTYXoeI9cd1gv23+GmPU7rKDAEo5/cI5mfSNr40Q7n
        gIfBDgarfShvxosHbI0W3rcClWGnRrPfdAUwhwY2R3l9H09hj0ZHICKn9oreGeK/
        2a+a1T7VEfwWxmSDbEf1Yv8SATvOzETurjMP3K2pXUy4LHbjh4hXJf9Fa1zcF7o5
        gXV62LwFZqvBIYQzWaukLiYahO0j3/r6QJY+MG87w/mUaxBelxaQRkzxTnKAuH+h
        DyIs7HK5md5iidQ8Ua8Or3anzFgPu5lW11rHntro4DZaMUrKfoCmwCqaDrT/YvxN
        D+mnUptyWTXfuY3zsmGWBjSU5WL90wKMCyvSrUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=tLnRWl
        mzorgr7oKoK51UGqpEXN0boNSId1GRxNsS9NQ=; b=OU/hxIS7HchVNs+fLkNXjr
        6kIkNsjLC8r66mB71V3KWKMeiPcuTvOGvIiMOVUnPAFCA4tyinQELMwqtAKkwSAv
        suHFuInCTfunqg+dsPFuxS56Qm9iMx//c/HUeAYeH0ksPyRCsYa33ztaYyHMK26N
        rSL8RCryB3Jb0Aq3lNqjXcDvgxV71C5OWN3QpvZI5Y/gLMnupJ5h8UV44ptilABe
        t60qa0rJiPGQsraVcXVu5R12//8oFRiU1pqDOP1ikvSnrOj0CYQsJ7BazwpqSDxa
        67q6rZAFjxzUlwogZdCp6oyImyLQIc8b2KKlJVL7WcwrYI5Q10/IQClAPPDrJf+Q
        ==
X-ME-Sender: <xms:ZTkMXQJULOYGGAlG-9bxfc6vOkU6HmFXRkcsZ7hs665fWX4Ztg6Oug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrtdehgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfrrghrrg
    hmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghr
    ufhiiigvpedt
X-ME-Proxy: <xmx:ZTkMXY-e64CPx0slVhQw1CIgHJ60s0RwilgiiX10KkqhVXpqU_au1w>
    <xmx:ZTkMXSCubGC1MkugeHViY-Otddbgb_XyTR4CCDiFhYRN2IgMmSrx4g>
    <xmx:ZTkMXSroZZNWI3TBnO4rVikVkz4it3z9E2KMIjWp6U9EVkwy5GQZWw>
    <xmx:ZjkMXaLYIooj5bFey-EiXfXDvK0kiLOnI3jQCL00bttaaXKyLGJE5Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4DC85E00A1; Thu, 20 Jun 2019 21:56:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-728-g133121a-fmstable-20190620v1
Mime-Version: 1.0
Message-Id: <e321507a-13d1-4eb8-ac7a-53c75a9d9842@www.fastmail.com>
In-Reply-To: <20190620091738.14683-1-joel@jms.id.au>
References: <20190620091738.14683-1-joel@jms.id.au>
Date:   Fri, 21 Jun 2019 11:26:52 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Joel Stanley" <joel@jms.id.au>,
        "Vijay Khemka" <vijaykhemka@fb.com>
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: aspeed: lpc-ctrl: Fix probe error handling
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2019, at 18:47, Joel Stanley wrote:
> gcc warns that a mising "flash" phandle node leads to undefined
> behavior later:
> 
> drivers/soc/aspeed/aspeed-lpc-ctrl.c: In function 
> 'aspeed_lpc_ctrl_probe':
> drivers/soc/aspeed/aspeed-lpc-ctrl.c:201:18: error: '*((void 
> *)&resm+8)' may be used uninitialized in this function 
> [-Werror=maybe-uninitialized]
> 
> Only set the flash base and size if we find a phandle in the device
> tree.

Ugh, yeah. Not sure how I missed that. Thanks for fixing it.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c 
> b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> index aca13779764a..eee26c2d8b52 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> @@ -223,10 +223,11 @@ static int aspeed_lpc_ctrl_probe(struct 
> platform_device *pdev)
>  			dev_err(dev, "Couldn't address to resource for flash\n");
>  			return rc;
>  		}
> +
> +		lpc_ctrl->pnor_size = resource_size(&resm);
> +		lpc_ctrl->pnor_base = resm.start;
>  	}
>  
> -	lpc_ctrl->pnor_size = resource_size(&resm);
> -	lpc_ctrl->pnor_base = resm.start;
>  
>  	dev_set_drvdata(&pdev->dev, lpc_ctrl);
>  
> -- 
> 2.20.1
> 
>

Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62282C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241F8213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="MTl+yWOr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VxbUEzqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDIAhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:37:31 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47189 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfDIAhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:37:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F9D421C24;
        Mon,  8 Apr 2019 20:37:30 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 08 Apr 2019 20:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=f9RwzQqPo5j7n7ddChrv8cOMRFN+ZZI
        aVeFFe5q3WO8=; b=MTl+yWOr9dvkBR6nhyaQ7Vs4JZAjE1UyNMsKMPtAX6HrQRQ
        WscM1CVVjuBgnjaHUMcBy+f8iXaDgjHcOJ3ZSkItqPhsd/Igfd60yTZ8B3WLSyig
        +QuwVEaxUpKmvqZKxH37mf3ZI4OepCu6DXJCkMeEH9yw5rrxESjNR4sX0627nZR4
        0IdESGa6zpKxjaSY6R1MYs05Ve02OG8kSlcDdAlBH95ozYPtKVTyRwcxavW3Va6k
        8G+DrsuVVm7tIYm8kgxbri8Gbsl80P91n2k5YxMX7txPOzMErT00/boEGUzGnHUF
        kjEm1LmwVFWdaZo1IhpScxXHsr9vh/Lykc8wsww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=f9RwzQ
        qPo5j7n7ddChrv8cOMRFN+ZZIaVeFFe5q3WO8=; b=VxbUEzqzaEyOoavWuVqvP7
        3lwTscvwT9qbyE/KWDJ1CIou5fHDjnXDDpB/20f5uW7DpPg5RrOQ0gFpkOKXELmi
        q8Rv8WRFmVmhCkNaHH/lmUaF0oWDgFW5szJozHl1z9Uj4FlkaL8rB3giJl1dhTxe
        T+Pn+czC64Q3NHLFbcsKiA5Zkf6ydj3A2xwsgRcxA25F6qcWfudg8lu+mOWQ85bK
        lb0IFs2JVvHtcjvaWGlHveweCtXi8I5eWcipgWaGbhGD/WiU+ihVNIPQZj0dvFIV
        BFKdOGb9wfhhxZ5rrZibKLTmOhYKGD6w6uxk6H6+VNGoRxrB1aOMj0FhM1oC5low
        ==
X-ME-Sender: <xms:SemrXNZXLYSlphhJhwk6wXC4XwVmPcUGqmWdNRlekyrItd3O_Fgmxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucffohhmrg
    hinhepghhithhhuhgsrdgtohhmnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgv
    fiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:SemrXLUHZKZZKOs0RNkS231OV9eqj0i_0MD2k5aAStecvMfE8C5ycQ>
    <xmx:SemrXFA4T3o6x28fDOqLmNUDRaM3qmfrmSXss2OjSdobUUrIKi11rw>
    <xmx:SemrXCwSya5g0chLidhhRxXguER-KjW3AgPq38NHlWvrjkluZlcOLw>
    <xmx:SumrXEs27SKcgcft9PKzebBx06L4uDIGwq6p8qK97JCl__JUG8RKAg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 356607C1B9; Mon,  8 Apr 2019 20:37:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-329-gf4aae99-fmstable-20190329v1
Mime-Version: 1.0
X-Me-Personality: 52947553
Message-Id: <2b039e4a-1f21-4297-a499-d8f764844693@www.fastmail.com>
In-Reply-To: <1554752326-13319-4-git-send-email-linux@roeck-us.net>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
 <1554752326-13319-4-git-send-email-linux@roeck-us.net>
Date:   Mon, 08 Apr 2019 20:37:28 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Wim Van Sebroeck" <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Joel Stanley" <joel@jms.id.au>
Subject: =?UTF-8?Q?Re:_[PATCH_03/22]_watchdog:_aspeed=5Fwdt:_Use_'dev'_instead_of?=
 =?UTF-8?Q?_dereferencing_it_repeatedly?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Apr 2019, at 05:09, Guenter Roeck wrote:
> Introduce local variable 'struct device *dev' and use it instead of
> dereferencing it repeatedly.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/aspeed_wdt.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index f09333fd54b4..34117745c65f 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -187,6 +187,7 @@ static const struct watchdog_info aspeed_wdt_info = {
>  
>  static int aspeed_wdt_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	const struct aspeed_wdt_config *config;
>  	const struct of_device_id *ofdid;
>  	struct aspeed_wdt *wdt;
> @@ -196,7 +197,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	u32 status;
>  	int ret;
>  
> -	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>  	if (!wdt)
>  		return -ENOMEM;

Looks like it's missed this one somehow?

wdt->base = devm_ioremap_resource(&pdev->dev, res); 

Otherwise,

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

>  
> @@ -212,12 +213,12 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	wdt->wdd.info = &aspeed_wdt_info;
>  	wdt->wdd.ops = &aspeed_wdt_ops;
>  	wdt->wdd.max_hw_heartbeat_ms = WDT_MAX_TIMEOUT_MS;
> -	wdt->wdd.parent = &pdev->dev;
> +	wdt->wdd.parent = dev;
>  
>  	wdt->wdd.timeout = WDT_DEFAULT_TIMEOUT;
> -	watchdog_init_timeout(&wdt->wdd, 0, &pdev->dev);
> +	watchdog_init_timeout(&wdt->wdd, 0, dev);
>  
> -	np = pdev->dev.of_node;
> +	np = dev->of_node;
>  
>  	ofdid = of_match_node(aspeed_wdt_of_table, np);
>  	if (!ofdid)
> @@ -286,11 +287,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  		u32 max_duration = config->ext_pulse_width_mask + 1;
>  
>  		if (duration == 0 || duration > max_duration) {
> -			dev_err(&pdev->dev, "Invalid pulse duration: %uus\n",
> -					duration);
> +			dev_err(dev, "Invalid pulse duration: %uus\n",
> +				duration);
>  			duration = max(1U, min(max_duration, duration));
> -			dev_info(&pdev->dev, "Pulse duration set to %uus\n",
> -					duration);
> +			dev_info(dev, "Pulse duration set to %uus\n",
> +				 duration);
>  		}
>  
>  		/*
> @@ -312,9 +313,9 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>  	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
>  		wdt->wdd.bootstatus = WDIOF_CARDRESET;
>  
> -	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
> +	ret = devm_watchdog_register_device(dev, &wdt->wdd);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to register\n");
> +		dev_err(dev, "failed to register\n");
>  		return ret;
>  	}
>  
> -- 
> 2.7.4
> 
>

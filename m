Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85D3C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8108F206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKMS42x4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfDZOQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:16:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40120 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfDZOQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:16:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id d31so1698736pgl.7;
        Fri, 26 Apr 2019 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tir7SnBnfr/XF97ydPG18V+eRaue4+SKDKSBbqDKBhA=;
        b=LKMS42x4Zc1pjS1qCA8TsF8d/46IKZulZRw2rTtuHKXEGktLPcqFbsgdYPfyQjudHQ
         6/PstUIl4AgHtI9qugdQJK8JnwvohQ104h/K69PFU8qF0+7GWoBLT669lG4ySS68iCs4
         g5G5lNN/mdKNBswBJ2PLmGTY9y9qh+5bLsZ/kttYvahI7TIRs0Wyd3ykTOdAkjpAzH6u
         aey6N9NuJTTMzXEIMWjbexs5NuUtvNab095El9SPS4MaCSEhkJh01lQjZS9yO5uGS/dK
         qCEdMKw+yT4QsNWbsaii+JMpDHZ2IwKMq5O1L+jkOFa+cwYxrbVBb8L1uklNXN51esTJ
         MvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tir7SnBnfr/XF97ydPG18V+eRaue4+SKDKSBbqDKBhA=;
        b=Kb2+U+RWOQ8T58afWfXuyRnkE4oxAZd6lLXhZvggwu+1uWXKTMrXDodIOuovJoZEZm
         tsgsN2aiQS04HUXdiqRwt2lAtRzvNOmW1+TrHagAncW03rFP7w8fokKr+XWsJtivPUJ7
         igAbz6OZrmLG7kKaCNz6pG3sghpplCO+X3v9nu62zxrvoYxdT482IBFTn4G0S3kWO0ZC
         BzlRRi34vwQZUbfZX/6ohnwQdrvv/Lpi6ceM3Wa647sQQTJE4HJ/sywUcW7/7PTb9fO0
         ewBYnTPFOJ0LkjOe0FtXFJZ/jw/7tIhqse/g+bH+M5jRAeiBPMATneiXF9kNg/QUUUqS
         ypLw==
X-Gm-Message-State: APjAAAUmyj2qqKwGQWAf/SAak8X7sivoVUBIQ/D5lj/hmxTQBboTc9hB
        +be/U5hUxXUjNs7J5vMFIfw=
X-Google-Smtp-Source: APXvYqyq9MZTGy6XHIHbb3+8/8JmCmI4WFpmfpsOH5lDIYKmMWlqDE6H1r3xvBkwtLGIS2igB4SN6w==
X-Received: by 2002:a65:5682:: with SMTP id v2mr14825221pgs.100.1556288214107;
        Fri, 26 Apr 2019 07:16:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r5sm10285213pgv.52.2019.04.26.07.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 07:16:52 -0700 (PDT)
Date:   Fri, 26 Apr 2019 07:16:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] watchdog: stm32: add dynamic prescaler support
Message-ID: <20190426141651.GA1715@roeck-us.net>
References: <1556286075-29496-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556286075-29496-1-git-send-email-ludovic.Barre@st.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 03:41:15PM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch allows to define the max prescaler by compatible.
> To set a large range of timeout, the prescaler should be set
> dynamically (from the timeout request) to improve the resolution
> in order to have a timeout close to the expected value.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/watchdog/stm32_iwdg.c | 70 +++++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index e00e3b3..91d0a89 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -34,18 +34,10 @@
>  #define KR_KEY_EWA	0x5555 /* write access enable */
>  #define KR_KEY_DWA	0x0000 /* write access disable */
>  
> -/* IWDG_PR register bit values */
> -#define PR_4		0x00 /* prescaler set to 4 */
> -#define PR_8		0x01 /* prescaler set to 8 */
> -#define PR_16		0x02 /* prescaler set to 16 */
> -#define PR_32		0x03 /* prescaler set to 32 */
> -#define PR_64		0x04 /* prescaler set to 64 */
> -#define PR_128		0x05 /* prescaler set to 128 */
> -#define PR_256		0x06 /* prescaler set to 256 */
> +#define PR_SHIFT	2
>  
>  /* IWDG_RLR register values */
> -#define RLR_MIN		0x07C /* min value supported by reload register */
> -#define RLR_MAX		0xFFF /* max value supported by reload register */
> +#define RLR_MAX		GENMASK(11, 0) /* max value of reload register */
>  
>  /* IWDG_SR register bit mask */
>  #define FLAG_PVU	BIT(0) /* Watchdog prescaler value update */
> @@ -55,15 +47,28 @@
>  #define TIMEOUT_US	100000
>  #define SLEEP_US	1000
>  
> -#define HAS_PCLK	true
> +struct stm32_iwdg_data {
> +	bool has_pclk;
> +	u32 max_prescaler;
> +};
> +
> +static const struct stm32_iwdg_data stm32_iwdg_data = {
> +	.has_pclk = false,
> +	.max_prescaler = 256,
> +};
> +
> +static const struct stm32_iwdg_data stm32mp1_iwdg_data = {
> +	.has_pclk = true,
> +	.max_prescaler = 1024,
> +};
>  
>  struct stm32_iwdg {
>  	struct watchdog_device	wdd;
> +	const struct stm32_iwdg_data *data;
>  	void __iomem		*regs;
>  	struct clk		*clk_lsi;
>  	struct clk		*clk_pclk;
>  	unsigned int		rate;
> -	bool			has_pclk;
>  };
>  
>  static inline u32 reg_read(void __iomem *base, u32 reg)
> @@ -80,21 +85,30 @@ static int stm32_iwdg_start(struct watchdog_device *wdd)
>  {
>  	struct stm32_iwdg *wdt = watchdog_get_drvdata(wdd);
>  	u32 val = FLAG_PVU | FLAG_RVU;
> -	u32 reload;
> +	u32 timeout, presc, iwdg_rlr, iwdg_pr;
>  	int ret;
>  
>  	dev_dbg(wdd->parent, "%s\n", __func__);
>  
> -	/* prescaler fixed to 256 */
> -	reload = clamp_t(unsigned int, ((wdd->timeout * wdt->rate) / 256) - 1,
> -			 RLR_MIN, RLR_MAX);
> +	timeout = clamp_t(unsigned int, wdd->timeout,
> +			  wdd->min_timeout, wdd->max_hw_heartbeat_ms / 1000);
> +
> +	if (timeout != wdd->timeout)
> +		dev_warn(wdd->parent, "timeout skrinked to %d\n", timeout);
> +

Valid values for timeout should be set in the set_timeout function,
not here. As such, there is no need for this warning. More specifically,
if the selected timeout is between min_timeout and max_hw_heartbeat_ms,
and the hardware can not meet the exact requested value, the set_timeout
function should adjust wdd->timeout value accordingly.

Example: The requested timeout is 55 seconds, but the hardware can
only support either 32 or 64 seconds. The set_timeout function should
then set wdd->timeout to either 32 or 64.

Furthermore, this is a valid condition. For example, the timeout could
be set for one hour (or day), and the maximum heartbeat could be one
minute. In that situation, the watchdog core handles heartbeat/ping
requests. Again, this does not warrant a warning.

On top of all that, if the hardware can not set a minimum timeout of
1 second, min_timeout should not be set to 1 second. It should be set
to the actual minimum supportable value if that value is larger than
1 second.

> +	presc = DIV_ROUND_UP(timeout * wdt->rate, RLR_MAX + 1);
> +
> +	/* The prescaler is align on power of 2 and start at 2 ^ PR_SHIFT. */
> +	presc = roundup_pow_of_two(presc);
> +	iwdg_pr = presc <= 1 << PR_SHIFT ? 0 : ilog2(presc) - PR_SHIFT;
> +	iwdg_rlr = ((timeout * wdt->rate) / presc) - 1;
>  
>  	/* enable write access */
>  	reg_write(wdt->regs, IWDG_KR, KR_KEY_EWA);
>  
>  	/* set prescaler & reload registers */
> -	reg_write(wdt->regs, IWDG_PR, PR_256); /* prescaler fix to 256 */
> -	reg_write(wdt->regs, IWDG_RLR, reload);
> +	reg_write(wdt->regs, IWDG_PR, iwdg_pr);
> +	reg_write(wdt->regs, IWDG_RLR, iwdg_rlr);
>  	reg_write(wdt->regs, IWDG_KR, KR_KEY_ENABLE);
>  
>  	/* wait for the registers to be updated (max 100ms) */
> @@ -150,7 +164,7 @@ static int stm32_iwdg_clk_init(struct platform_device *pdev,
>  	}
>  
>  	/* optional peripheral clock */
> -	if (wdt->has_pclk) {
> +	if (wdt->data->has_pclk) {
>  		wdt->clk_pclk = devm_clk_get(&pdev->dev, "pclk");
>  		if (IS_ERR(wdt->clk_pclk)) {
>  			dev_err(&pdev->dev, "Unable to get pclk clock\n");
> @@ -191,8 +205,8 @@ static const struct watchdog_ops stm32_iwdg_ops = {
>  };
>  
>  static const struct of_device_id stm32_iwdg_of_match[] = {
> -	{ .compatible = "st,stm32-iwdg", .data = (void *)!HAS_PCLK },
> -	{ .compatible = "st,stm32mp1-iwdg", .data = (void *)HAS_PCLK },
> +	{ .compatible = "st,stm32-iwdg", .data = &stm32_iwdg_data },
> +	{ .compatible = "st,stm32mp1-iwdg", .data = &stm32mp1_iwdg_data },
>  	{ /* end node */ }
>  };
>  MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
> @@ -200,20 +214,17 @@ MODULE_DEVICE_TABLE(of, stm32_iwdg_of_match);
>  static int stm32_iwdg_probe(struct platform_device *pdev)
>  {
>  	struct watchdog_device *wdd;
> -	const struct of_device_id *match;
>  	struct stm32_iwdg *wdt;
>  	struct resource *res;
>  	int ret;
>  
> -	match = of_match_device(stm32_iwdg_of_match, &pdev->dev);
> -	if (!match)
> -		return -ENODEV;
> -
>  	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>  	if (!wdt)
>  		return -ENOMEM;
>  
> -	wdt->has_pclk = match->data;
> +	wdt->data = of_device_get_match_data(&pdev->dev);
> +	if (!wdt->data)
> +		return -ENODEV;
>  
>  	/* This is the timer base. */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -231,8 +242,9 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
>  	wdd = &wdt->wdd;
>  	wdd->info = &stm32_iwdg_info;
>  	wdd->ops = &stm32_iwdg_ops;
> -	wdd->min_timeout = ((RLR_MIN + 1) * 256) / wdt->rate;
> -	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * 256 * 1000) / wdt->rate;
> +	wdd->min_timeout = 1;

Is this guaranteed to be no larger than 1 under all circumstances ?

[ Not that the old code was necessarily correct - it might have set
  min_timeout to 0 if wdt->rate is high ]

> +	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * wdt->data->max_prescaler *
> +				    1000) / wdt->rate;
>  	wdd->parent = &pdev->dev;
>  
>  	watchdog_set_drvdata(wdd, wdt);
> -- 
> 2.7.4
> 

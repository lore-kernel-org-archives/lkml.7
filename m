Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E808C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075BA2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rwLBvu3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDJGii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:38:38 -0400
Received: from mail-eopbgr820072.outbound.protection.outlook.com ([40.107.82.72]:25441
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728589AbfDJGih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb9hYO32udLR9Byt/n0kyWn08pEXi9gopClqugvZe7s=;
 b=rwLBvu3vnAOnqKH8dpQSo6qCHEE0zknZ/jXcNfS3F7fxhiZG8EgoYYLkK73d8RVlO5hugTqanp+dMXuQzM7RYoXUVNWHZ4emdsHRdz5M4mxrHtVLbIalwNW2/QqUMvLWvTnBVxm46kqcZPsdtDcExVMLXxpwgN5UuNuG2BRAM9U=
Received: from SN4PR0201CA0016.namprd02.prod.outlook.com
 (2603:10b6:803:2b::26) by CY1PR02MB2011.namprd02.prod.outlook.com
 (2a01:111:e400:c5ab::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.14; Wed, 10 Apr
 2019 06:38:34 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by SN4PR0201CA0016.outlook.office365.com
 (2603:10b6:803:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.14 via Frontend
 Transport; Wed, 10 Apr 2019 06:38:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Wed, 10 Apr 2019 06:38:27 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45951 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hE6sM-00059j-Uo; Tue, 09 Apr 2019 23:38:26 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hE6sH-0001k5-Rt; Tue, 09 Apr 2019 23:38:21 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x3A6cG4W028511;
        Tue, 9 Apr 2019 23:38:16 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hE6sC-0001iw-8y; Tue, 09 Apr 2019 23:38:16 -0700
Subject: Re: [PATCH 10/23] watchdog: of_xilinx_wdt: Convert to use device
 managed functions and other improvements
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
 <1554830641-9247-11-git-send-email-linux@roeck-us.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <85e92d6f-5521-af0a-f6e0-b3411b7cd8e9@xilinx.com>
Date:   Wed, 10 Apr 2019 08:38:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554830641-9247-11-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(189003)(199004)(76176011)(478600001)(47776003)(356004)(2486003)(36756003)(966005)(8676002)(65826007)(110136005)(26005)(316002)(54906003)(63266004)(2906002)(65806001)(58126008)(230700001)(106466001)(77096007)(65956001)(186003)(81166006)(305945005)(31696002)(6306002)(81156014)(229853002)(4326008)(446003)(31686004)(107886003)(8936002)(36386004)(426003)(9786002)(11346002)(336012)(476003)(6246003)(2616005)(64126003)(23676004)(50466002)(126002)(44832011)(5660300002)(486006)(106002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB2011;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91ef6565-1cd2-4ddb-f649-08d6bd7f23a0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:CY1PR02MB2011;
X-MS-TrafficTypeDiagnostic: CY1PR02MB2011:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB20119C14CD080D0E9FF99919C62E0@CY1PR02MB2011.namprd02.prod.outlook.com>
X-Forefront-PRVS: 00032065B2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8aWUnD0IVrqbwsv/HbdOYaeUJcxIC423vTohjvI4PrPUh2SXNSaeU8Pk3ERFh9FWLx7vtphpiF04aVM6NgpwgWF3JZRPZcxhz27DQuwOMldQVeJKNJnG+8sm3uuv/hiqvrXeiWv9HsD305k2/sM87DitiCprBWfWRV2ahk+pztZ5rICExW65EywWE2DoEe1e+r4vC/3y/ed9SjhGnNBDXl0QiqFopUG3MgYu6jws/M9Xg6GtY2pXRCZKdbJMyoX0O0Y9lVdjIHSqW1hyDk4xHIGiz4HP1yqSgXN2mn/wbW69ALpsIvlQDOMXdrU0LV3WQp5iU5RNpBkQYQGzlNc6YhqdvLBCKvDTihAkTJPCYaDRj52EP57CjtWJiWScpw3xs6AlBz0TSzdGk85iqPfhAh0ogkmy0iW9RIwuGw5hwUE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2019 06:38:27.3549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ef6565-1cd2-4ddb-f649-08d6bd7f23a0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB2011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 04. 19 19:23, Guenter Roeck wrote:
> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Drop assignments to otherwise unused variables
> - Drop empty remove function
> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
> - Introduce local variable 'struct device *dev' and use it instead of
>   dereferencing it repeatedly
> - Use devm_watchdog_register_driver() to register watchdog device
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/of_xilinx_wdt.c | 58 ++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index 5c977164b3e5..03786992b701 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -151,41 +151,46 @@ static u32 xwdt_selftest(struct xwdt_device *xdev)
>  		return XWT_TIMER_FAILED;
>  }
>  
> +static void xwdt_clk_disable_unprepare(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
>  static int xwdt_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	int rc;
>  	u32 pfreq = 0, enable_once = 0;
>  	struct xwdt_device *xdev;
>  	struct watchdog_device *xilinx_wdt_wdd;
>  
> -	xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL);
> +	xdev = devm_kzalloc(dev, sizeof(*xdev), GFP_KERNEL);
>  	if (!xdev)
>  		return -ENOMEM;
>  
>  	xilinx_wdt_wdd = &xdev->xilinx_wdt_wdd;
>  	xilinx_wdt_wdd->info = &xilinx_wdt_ident;
>  	xilinx_wdt_wdd->ops = &xilinx_wdt_ops;
> -	xilinx_wdt_wdd->parent = &pdev->dev;
> +	xilinx_wdt_wdd->parent = dev;
>  
>  	xdev->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(xdev->base))
>  		return PTR_ERR(xdev->base);
>  
> -	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-interval",
> +	rc = of_property_read_u32(dev->of_node, "xlnx,wdt-interval",
>  				  &xdev->wdt_interval);
>  	if (rc)
> -		dev_warn(&pdev->dev,
> -			 "Parameter \"xlnx,wdt-interval\" not found\n");
> +		dev_warn(dev, "Parameter \"xlnx,wdt-interval\" not found\n");
>  
> -	rc = of_property_read_u32(pdev->dev.of_node, "xlnx,wdt-enable-once",
> +	rc = of_property_read_u32(dev->of_node, "xlnx,wdt-enable-once",
>  				  &enable_once);
>  	if (rc)
> -		dev_warn(&pdev->dev,
> +		dev_warn(dev,
>  			 "Parameter \"xlnx,wdt-enable-once\" not found\n");
>  
>  	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
>  
> -	xdev->clk = devm_clk_get(&pdev->dev, NULL);
> +	xdev->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(xdev->clk)) {
>  		if (PTR_ERR(xdev->clk) != -ENOENT)
>  			return PTR_ERR(xdev->clk);
> @@ -196,10 +201,10 @@ static int xwdt_probe(struct platform_device *pdev)
>  		 */
>  		xdev->clk = NULL;
>  
> -		rc = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> +		rc = of_property_read_u32(dev->of_node, "clock-frequency",
>  					  &pfreq);
>  		if (rc)
> -			dev_warn(&pdev->dev,
> +			dev_warn(dev,
>  				 "The watchdog clock freq cannot be obtained\n");
>  	} else {
>  		pfreq = clk_get_rate(xdev->clk);
> @@ -218,44 +223,34 @@ static int xwdt_probe(struct platform_device *pdev)
>  
>  	rc = clk_prepare_enable(xdev->clk);
>  	if (rc) {
> -		dev_err(&pdev->dev, "unable to enable clock\n");
> +		dev_err(dev, "unable to enable clock\n");
>  		return rc;
>  	}
> +	rc = devm_add_action_or_reset(dev, xwdt_clk_disable_unprepare,
> +				      xdev->clk);
> +	if (rc)
> +		return rc;
>  
>  	rc = xwdt_selftest(xdev);
>  	if (rc == XWT_TIMER_FAILED) {
> -		dev_err(&pdev->dev, "SelfTest routine error\n");
> -		goto err_clk_disable;
> +		dev_err(dev, "SelfTest routine error\n");
> +		return rc;
>  	}
>  
> -	rc = watchdog_register_device(xilinx_wdt_wdd);
> +	rc = devm_watchdog_register_device(dev, xilinx_wdt_wdd);
>  	if (rc) {
> -		dev_err(&pdev->dev, "Cannot register watchdog (err=%d)\n", rc);
> -		goto err_clk_disable;
> +		dev_err(dev, "Cannot register watchdog (err=%d)\n", rc);
> +		return rc;
>  	}
>  
>  	clk_disable(xdev->clk);
>  
> -	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
> +	dev_info(dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
>  		 xdev->base, xilinx_wdt_wdd->timeout);
>  
>  	platform_set_drvdata(pdev, xdev);
>  
>  	return 0;
> -err_clk_disable:
> -	clk_disable_unprepare(xdev->clk);
> -
> -	return rc;
> -}
> -
> -static int xwdt_remove(struct platform_device *pdev)
> -{
> -	struct xwdt_device *xdev = platform_get_drvdata(pdev);
> -
> -	watchdog_unregister_device(&xdev->xilinx_wdt_wdd);
> -	clk_disable_unprepare(xdev->clk);
> -
> -	return 0;
>  }
>  
>  /**
> @@ -303,7 +298,6 @@ MODULE_DEVICE_TABLE(of, xwdt_of_match);
>  
>  static struct platform_driver xwdt_driver = {
>  	.probe       = xwdt_probe,
> -	.remove      = xwdt_remove,
>  	.driver = {
>  		.name  = WATCHDOG_NAME,
>  		.of_match_table = xwdt_of_match,
> 

Looks good to me. I would prefer to do it via 3 patches but I will let
Wim to comment.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

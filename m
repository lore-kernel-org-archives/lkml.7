Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B1C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D280D20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TCR/1wyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfDCHKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:10:09 -0400
Received: from mail-eopbgr800040.outbound.protection.outlook.com ([40.107.80.40]:53076
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfDCHKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wtd58djzrEJ5M0IzswZrjE70ArMqaB4xz43QJxytryY=;
 b=TCR/1wyzFpQi0JGbPXU6aFzHUGkptyh+HTAoZbRzKWdFvKBzZzhYqj4rRJujLFeXyGXKBFyzXQ0GXvfE36C3DX0XljdBKJA+zMNuCLIjDvVZ4kXOWC4SMayazQ7if8A8HtBKQILXW+WcwGzZzmC2SVhQXarNpPkREIMcwb9Wdos=
Received: from BN7PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:20::27)
 by SN6PR02MB5246.namprd02.prod.outlook.com (2603:10b6:805:70::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.16; Wed, 3 Apr
 2019 07:10:02 +0000
Received: from SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN7PR02CA0014.outlook.office365.com
 (2603:10b6:408:20::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.16 via Frontend
 Transport; Wed, 3 Apr 2019 07:10:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT021.mail.protection.outlook.com (10.152.72.144) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Wed, 3 Apr 2019 07:10:00 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54945 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hBa24-0006cg-0W; Wed, 03 Apr 2019 00:10:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hBa1y-00031z-Sx; Wed, 03 Apr 2019 00:09:54 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x3379iFq021456;
        Wed, 3 Apr 2019 00:09:44 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hBa1o-000314-1D; Wed, 03 Apr 2019 00:09:44 -0700
Subject: Re: [PATCH] watchdog: Convert to use devm_platform_ioremap_resource
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Barry Song <baohua@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
References: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <4fe758d6-b617-ec8e-0b85-9daa02d28a8d@xilinx.com>
Date:   Wed, 3 Apr 2019 09:09:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554231713-14137-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(199004)(189003)(6246003)(81166006)(36386004)(31686004)(6666004)(486006)(77096007)(11346002)(478600001)(446003)(65956001)(58126008)(64126003)(2616005)(336012)(106466001)(54906003)(47776003)(316002)(65806001)(50466002)(8936002)(229853002)(106002)(9786002)(8676002)(186003)(44832011)(26005)(4326008)(76176011)(7416002)(476003)(426003)(110136005)(126002)(81156014)(2906002)(63266004)(31696002)(230700001)(5660300002)(2486003)(305945005)(356004)(65826007)(23676004)(36756003)(15866825006)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5246;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4bf98a9-5f5a-43fc-0923-08d6b80363a9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:SN6PR02MB5246;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5246:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB5246D1324A923E5F00989F40C6570@SN6PR02MB5246.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0996D1900D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZJ4M5mleF4l3wXuR2NYPrURluDmWrt0UwLLyxxAZA8zwCsuo7stFEd6n2Ua9KNIrrBZSv7nug8VvbWe/JW4hW+LSym61fKmmyg2HCJfOIbim/5w70KefHdAdzvN0H/W3KEeb3/e1moY44OyqH4pT1bVOmJ6yIczc/P6VGtomQpebBK19LAb0fWKZ6O90Ne2449lEVICg7AkpUV9OUtQJbJmhUm2pOQQbRwcQj8uIcUyGz6E694Gh7wQQkEaIyom5KaK6IG0fmHjt3Nok1TJDBynBTxOwJdr6GwAGcN4jtlEYa+mKANTqjuGKHvqcrmb5kG8XfFuROAGxjqHB1B7yeqtzCDbS/9sSp16yaazpPATbGo2TVh1ohwUDqbyMHSnVluV94ONM1/jSoKOqA7UoVBFM06Ik5lmS81YuXW5vd94=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2019 07:10:00.5520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bf98a9-5f5a-43fc-0923-08d6b80363a9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 04. 19 21:01, Guenter Roeck wrote:
> Use devm_platform_ioremap_resource to reduce source code size,
> improve readability, and reduce the likelyhood of bugs.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patch.
> 
> @r@
> identifier res, pdev;
> expression a;
> expression index;
> expression e;
> @@
> 
> <+...
> - res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> - a = devm_ioremap_resource(e, res);
> + a = devm_platform_ioremap_resource(pdev, index);
> ...+>
> 
> @depends on r@
> identifier r.res;
> @@
> - struct resource *res;
>   ... when != res
> 
> @@
> identifier res, pdev;
> expression index;
> expression a;
> @@
> - struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> - a = devm_ioremap_resource(&pdev->dev, res);
> + a = devm_platform_ioremap_resource(pdev, index);
> 
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Keguang Zhang <keguang.zhang@gmail.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Avi Fishman <avifishman70@gmail.com>
> Cc: Nancy Yuen <yuenn@google.com>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/asm9260_wdt.c    | 4 +---
>  drivers/watchdog/aspeed_wdt.c     | 4 +---
>  drivers/watchdog/at91sam9_wdt.c   | 4 +---
>  drivers/watchdog/ath79_wdt.c      | 4 +---
>  drivers/watchdog/atlas7_wdt.c     | 4 +---
>  drivers/watchdog/bcm7038_wdt.c    | 4 +---
>  drivers/watchdog/bcm_kona_wdt.c   | 4 +---
>  drivers/watchdog/cadence_wdt.c    | 4 +---
...
>  drivers/watchdog/of_xilinx_wdt.c  | 4 +---

Acked-by: Michal Simek <michal.simek@xilinx.com> (cadence/xilinx wdts)

Thanks,
Michal


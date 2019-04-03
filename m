Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49656C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048A7206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1d9I94k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfDCPvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:51:33 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:33260 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfDCPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:51:32 -0400
Received: by mail-ed1-f46.google.com with SMTP id q3so15410549edg.0;
        Wed, 03 Apr 2019 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=MA32h7aFO/879tVdiX+oQPBANq76aYxNUZ33jElq0y4=;
        b=H1d9I94kNfQwiFsT0cLGNVg2KZhdytpVCw+IMBYIK0OTikCEc9xQM1Nm3N5Y5a5ULG
         rcfny0qwFIfZfrCuq6DNDTupkcD6t3WJ2at1KLZqHGpWR6s7IZnPutZJYlZ6Vfi9Mupm
         qD7Z5VINlsBD3nkQ50NoMwm01ez/r/EhQ+9csmrPo+MGlv27lzJT7VHl7ccsOESxZJy6
         VnIa8StZ0EyudnCRf8d5RxrwiaQDWNr87tWt45KXtKUBDmGEjQn7c1lGo2ge16RZj2cQ
         uSdT/rRQXZVUeiyuCUc3uhTlxulXXtRGSOXbWEF0Zbr4NR6JCp+cWV95Z8ilZI0JUP9i
         RoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=MA32h7aFO/879tVdiX+oQPBANq76aYxNUZ33jElq0y4=;
        b=t/u9SO57rc5l9Vf5R4X+gk4AqRLsbi8N8K8QT8jLYjbqBt5REfwb/38f5xX3SkbibK
         7WuxhPftgfM31ONvctA/woGLoHgsw7ixX+fDs9u6zbZwvqFZaTkDEOYqj9O5iXOWlkeD
         3kYp5Ma4hbk8LHlQi98mo5MWw77ke+gA9q5ugYrAU3aKC30k+J06SXwZSP/F8SHNNNVW
         oR+kNlRKhK0bB7Cdu6244b8iwZTstTYpx2Bs7Dcv87hsXvk3OBi7v9dF8U4A74UO64l2
         fdDwPV7slHCANRI7h7CrrwP9MFswcKTZ3Al0q7qMqhKNN2rBZ7OdfNe+vCfqwHHkeOqD
         CUIg==
X-Gm-Message-State: APjAAAVcPA/s5q4rAwnWL8DDacGpFSjSSBSYUbiSnWekOAACv9y0a3BD
        fFpnggurlnU+fXkFwngyz2o=
X-Google-Smtp-Source: APXvYqzr/4+hd8vIaZfb0yeH5uDyq5ek3tvyQXcbtSecLebakmwrqTqHgMjW4Y+3y1CP8p1W4Fw2MQ==
X-Received: by 2002:a50:c404:: with SMTP id v4mr257208edf.146.1554306689764;
        Wed, 03 Apr 2019 08:51:29 -0700 (PDT)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id y27sm3287025edb.67.2019.04.03.08.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 08:51:28 -0700 (PDT)
Subject: Re: Issues with i.MX SPI DMA transfers
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>, Han Xu <han.xu@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
 <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
 <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <197990d4-b1e2-8db9-0cb7-87b860f23bd7@gmail.com>
 <VI1PR04MB4543DEA3C0CED159C472E85F89570@VI1PR04MB4543.eurprd04.prod.outlook.com>
From:   Igor Plyatov <plyatov@gmail.com>
Message-ID: <fbb4850d-f63f-d384-1a85-1f4c5c077af6@gmail.com>
Date:   Wed, 3 Apr 2019 18:51:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB4543DEA3C0CED159C472E85F89570@VI1PR04MB4543.eurprd04.prod.outlook.com>
Content-Type: multipart/mixed;
 boundary="------------5BABD21665BA13795C52B506"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5BABD21665BA13795C52B506
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Robin,


> Please apply the attached patch which is based on linux-next commit 
> 05d08e2995cbe6efdb993482ee0d38a77040861a.
> Please notice it has already contained two sdma patches revert - "ad0d92d7ba6a" and "25aaa75df1e6"

1) Yours source code is same as mine with exception of SDMA description 
for eCSPI in Device Tree.

I have changed Device Tree for i.MX6Q/DL as in attached patch and 
finally SPI interfaces operate more or less.

My patch revert back patches df07101e1c4a29e820df02f9989a066988b160e6 
and dd4b487b32a3571fdcc66062e661e3a3e360e35b. It is strange, because 
they are merged into mainline while ago. Maybe they are valid for some 
specific variant of i.MX SOC?

"More or less" means I have come to state described in first e-mail of 
this e-mail thread. Byte duplication (ERR009165) happens very often for 
eCSPI5 interface operating through DMA.

Test Conditions:
1.1. Interface under test is eCSPI1 or eCSPI5;
1.2. Four exemplars of "burn-neon" (CPU burn) executes in background to 
have 100% load for all 4 CPU cores (source code taken from 
https://raw.githubusercontent.com/ssvb/cpuburn-arm/dd5c5ba58d2b0b23cfab4a286f9d3f5510000f20/cpuburn-a8.S 
and https://hardwarebug.org/files/burn.S);
1.3. PC has running "ping -f embedded_device" to have network activity 
around 1 MiB/s Rx and Tx;
1.4. One exemplar of "spidev_test -D /dev/spidevX.0 -s FREQUENCY -b 8 -S 
512 -I 1000000 -l" executes at different frequencies;

Test Results for eCSPI1:
21 MHz    - success;
20 MHz    - success;
...
16 MHz    - success;
...
  8 MHz    - success;

Test Results for eCSPI5:
21 MHz    - failed;
20 MHz    - failed;
19 MHz    - failed;
...
12 MHz    - failed;
11 MHz    - failed;
10 MHz    - failed;
  9 MHz    - failed;
  8 MHz    - failed;
  7 MHz    - failed;
  6 MHz    - failed;
  5 MHz    - failed;
  4 MHz    - success.

Maybe it is worth to dump content of registers for eCSPI1 and eCSPI5 to 
compare them? I can do this if you will describe how to make it.

Maybe I'm wrong, but I suppose incorrect clock source for eCSPI5. Looks 
like it is worth to check correctness of driver "clk-imx6q.c" or 
something else responsible for eCSPI5 clock.


2) I want to improve description and replace magic numbers by constants 
in Device Tree for SDMA. I mean strings like "dmas = <&sdma 11 7 1>, 
<&sdma 12 7 2>;"?

So, finally Device Tree will have strings like

dmas = <&sdma SOME_DEF_A IMX_DMATYPE_.. DMA_PRIO_..>, <&sdma SOME_DEF_B 
IMX_DMATYPE_.. DMA_PRIO_..>;

I think, this will stop black magic manipulations for SDMA in Device 
Tree, by various developers.

Does first digit means "DMA request/event ID"? Where to find more info 
about this?

Does second digit means "enum sdma_peripheral_type"?

Does third digit means "enum imx_dma_prio"?

Where can I find description of difference between IMX_DMATYPE_CSPI (MCU 
domain CSPI) and IMX_DMATYPE_CSPI_SP (Shared CSPI)? Googling does not 
help too much.

Best wishes.
--
Igor Plyatov

--------------5BABD21665BA13795C52B506
Content-Type: text/x-patch;
 name="0001-Bugfix-for-incorrect-eCSPI-SDMA-numbers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Bugfix-for-incorrect-eCSPI-SDMA-numbers.patch"

From 2aa277ff36998b805cec803b23d9c746a2a107b7 Mon Sep 17 00:00:00 2001
From: Igor Plyatov <plyatov@gmail.com>
Date: Wed, 3 Apr 2019 14:51:17 +0300
Subject: [PATCH] Bugfix for incorrect eCSPI SDMA numbers.

* This revert back commits df07101e1c4a29e820df02f9989a066988b160e6 and
  dd4b487b32a3571fdcc66062e661e3a3e360e35b, because they lead to kernel
  errors like
  "spi_master spi4: I/O Error in DMA RX
   spidev spi4.1: SPI transfer failed: -110."
  Tested on i.MX6 Quad/DualLite SOC.

Signed-off-by: Igor Plyatov <plyatov@gmail.com>
---
 arch/arm/boot/dts/imx6q.dtsi   | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index d038f4117024..7175898f854e 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -172,7 +172,7 @@
 					clocks = <&clks IMX6Q_CLK_ECSPI5>,
 						 <&clks IMX6Q_CLK_ECSPI5>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 11 8 1>, <&sdma 12 8 2>;
+					dmas = <&sdma 11 7 1>, <&sdma 12 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 2eb4c779298b..36c48a18e39a 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -338,7 +338,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
 						 <&clks IMX6QDL_CLK_ECSPI1>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 3 8 1>, <&sdma 4 8 2>;
+					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -352,7 +352,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
 						 <&clks IMX6QDL_CLK_ECSPI2>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 5 8 1>, <&sdma 6 8 2>;
+					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -366,7 +366,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
 						 <&clks IMX6QDL_CLK_ECSPI3>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 7 8 1>, <&sdma 8 8 2>;
+					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
@@ -380,7 +380,7 @@
 					clocks = <&clks IMX6QDL_CLK_ECSPI4>,
 						 <&clks IMX6QDL_CLK_ECSPI4>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 9 8 1>, <&sdma 10 8 2>;
+					dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};
-- 
2.17.1


--------------5BABD21665BA13795C52B506--

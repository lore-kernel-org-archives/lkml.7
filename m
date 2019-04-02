Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B8BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3249D20882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4q9zGz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfDBMPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:15:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34546 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDBMPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:15:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id y18so8830672lfe.1;
        Tue, 02 Apr 2019 05:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=MpipC4t45SUSxJlSqxC97QRjjazEpnKVbEGeYhl+rtI=;
        b=B4q9zGz6JUufwX4GgV4IW6VasoHnQA1mT9S4HmGIHAjryWa4oa5Q2ihQ5v72/RhkIN
         KtrqfLAf5Ixrx2RyLuaHms1EkCS9XyzRjMdhwo9sQTie+p8oUEu1z37ieA3e+N7dw0+q
         +jcBDeeHSbwlZi5K6wD8igJn+bj0enZpirn4TJbeqJAHI+cUsnm25mAMBBwrY0zad5Jj
         X6lg3w5EY1Es+VKLzM4BRzFXT7fjE3GUNU0DjmOkXZyaGkjUaR6vMiB/ZdLw6CeLefIA
         ZBZ3TxR95K8pm4tGdfX3uGnPG8G2l8/76Wsgd4ccnefHmSzYUZRUvVLYUR9cAqvgyD0a
         8dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=MpipC4t45SUSxJlSqxC97QRjjazEpnKVbEGeYhl+rtI=;
        b=h0JlMoBTTCnhGh4S7F8Q+NQBim5ieR1xwQwVPw7pUY1/SyV/FayiEBxJCO97VmTElJ
         gDWShJk0A8AnUh1yO5z0Sis7lqzWnfmgZILzjJhGZBmQSVXv6XzxLT5J2XMEwzEYk0zT
         G2aEXLCe/JJLILRtjX5mdgRoDJXLR6/rNbjeH9kAi31LHFYglkNhLeSgPy2fqB8Y0HPD
         9IQlVyVNx1Ax2arPMCoGKKpCzP/wFDatzGFaHcrGq2KGPWnR5N0M6ChD7tZpI1IjV8Sg
         2imCsgHl6Kv6JAonk1kFwg8IcomoxgFOQUd/s6RQNIqm26BOtx+Q13lvA8u9B+5TkxTY
         vo/w==
X-Gm-Message-State: APjAAAXcaE8gokuYqBfy8dwvnm+Z/X1+Zf1CPTd2dp6dniToMgPQWFro
        ZQS4EELAI7vEX91KbgMIeUE=
X-Google-Smtp-Source: APXvYqwVFFd34LH/Q1Kt5O3AdtyCNDcsUyxyelaRhz51eNWdhucXcAM7UUa8GF/2lvUckqI9UZGi9A==
X-Received: by 2002:ac2:5305:: with SMTP id c5mr11019951lfh.153.1554207329173;
        Tue, 02 Apr 2019 05:15:29 -0700 (PDT)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id j2sm2445111lfm.56.2019.04.02.05.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 05:15:28 -0700 (PDT)
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
From:   Igor Plyatov <plyatov@gmail.com>
Message-ID: <197990d4-b1e2-8db9-0cb7-87b860f23bd7@gmail.com>
Date:   Tue, 2 Apr 2019 15:15:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
Content-Type: multipart/mixed;
 boundary="------------99BBD45BC3E8DDAF16FF0AFC"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------99BBD45BC3E8DDAF16FF0AFC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Robin,

>> now I have reverted patch ad0d92d7ba6a.
>> Patches 0001-dma-engine-imx-sdma-add-mcu_2_ecspi-script.patch and
>> 0002-spi-spi-imx-fix-ERR009165.patch are applied.
>>
>>
>> Kernel log show messages
>>
>> [   29.202639] imx-sdma 20ec000.sdma: loaded firmware 3.3
>> [   29.238595] spi_imx 2008000.spi: probed
>> [   29.242802] spi_imx 200c000.spi: probed
>> [   29.245217] spi_imx 2018000.spi: probed
>>
>> SPI DMA transfers still not work.
>>
>> If I test 32 byte transfers, then they work fine. But 64 byte transfers
>> fails always and I see error messages
>>
>> root@cr7:~# spidev_test -D /dev/spidev4.1 -s 1200000 -b 8 -S 64 -I 1 -l
>> spi mode: 0x20
>> bits per word: 8
>> max speed: 1200000 Hz (1200 KHz)
>> [  423.686736] spi_master spi4: I/O Error in DMA RX
>> [  423.691392] spidev spi4.1: SPI transfer failed: -110
>> [  423.696382] spi_master spi4: failed to transfer one message from queue
>> can't send spi message: Connection timed out
>> Aborted (core dumped)
>>
>> I suppose, transfers shorter then 64 bytes made with help of PIO.
>>
>> Robin, is there any chance for you to find some time and look at this
>> issue again?
> I have quick test with spidev_test loopback, but didn't meet your error,
> Is your code the almost latest code in linux-next as mine?
>
> root@imx6qpdlsolox:~# cat /proc/interrupts | grep sdma
>   48:         37       GPC   2 Level     sdma
>   -lt@imx6qpdlsolox:~# ./spidev_test -D /dev/spidev0.0 -s 1200000 -b 8 -S 64 -I 1 -l
> spi mode: 0x20
> bits per word: 8
> max speed: 1200000 Hz (1200 KHz)
> root@imx6qpdlsolox:~# cat /proc/interrupts | grep sdma
>   48:         43       GPC   2 Level     sdma
> ./spidev_test -D /dev/spidev0.0 -s 1200000 -b 8 -S 512 -I 1 -l
> spi mode: 0x20
> bits per word: 8
> max speed: 1200000 Hz (1200 KHz)
> total: tx 0.5KB, rx 0.5KB


My previous test results based on kernel from "main" branch of 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git.

Now I have tested kernel from "main" branch of 
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git.

Its latest commit is 05d08e2995cbe6efdb993482ee0d38a77040861a.

Additionally, I have reverted patch ad0d92d7ba6a and apply yours patches 
0001-dma-engine-imx-sdma-add-mcu_2_ecspi-script.patch and 
0002-spi-spi-imx-fix-ERR009165.patch.

Difference between 05d08e2995cbe6efdb993482ee0d38a77040861a and current 
state of drivers attached as spi-and-sdma-drivers.diff.

SPI driver still not work. It has same result as from my previous email.

Looks as you use either different GIT branch of kernel or you have 
forget to say me about some patch.

Best wishes.

--

Igor Plyatov


--------------99BBD45BC3E8DDAF16FF0AFC
Content-Type: text/x-patch;
 name="spi-and-sdma-drivers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="spi-and-sdma-drivers.diff"

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 5f3c1378b90e..908507fa9526 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -377,7 +377,6 @@ struct sdma_channel {
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
-	bool				context_loaded;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
 };
@@ -913,6 +912,9 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		emi_2_per = sdma->script_addrs->mcu_2_ata_addr;
 		break;
 	case IMX_DMATYPE_CSPI:
+		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
+		break;
 	case IMX_DMATYPE_EXT:
 	case IMX_DMATYPE_SSI:
 	case IMX_DMATYPE_SAI:
@@ -976,9 +978,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int ret;
 	unsigned long flags;
 
-	if (sdmac->context_loaded)
-		return 0;
-
 	if (sdmac->direction == DMA_DEV_TO_MEM)
 		load_address = sdmac->pc_from_device;
 	else if (sdmac->direction == DMA_DEV_TO_DEV)
@@ -1021,8 +1020,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
 
-	sdmac->context_loaded = true;
-
 	return ret;
 }
 
@@ -1062,7 +1059,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 	sdmac->desc = NULL;
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 	vchan_dma_desc_free_list(&sdmac->vc, &head);
-	sdmac->context_loaded = false;
 }
 
 static int sdma_disable_channel_async(struct dma_chan *chan)
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 09c9a1edb2c6..27578158d922 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -585,8 +585,9 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
 	spi_imx->spi_bus_clk = clk;
 
+	/* ERR009165: work in XHC mode as PIO */
 	if (spi_imx->usedma)
-		ctrl |= MX51_ECSPI_CTRL_SMC;
+		ctrl &= ~MX51_ECSPI_CTRL_SMC;
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
@@ -1265,10 +1266,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 {
 	int ret;
 
-	/* use pio mode for i.mx6dl chip TKT238285 */
-	if (of_machine_is_compatible("fsl,imx6dl"))
-		return 0;
-
 	spi_imx->wml = spi_imx->devtype_data->fifo_size / 2;
 
 	/* Prepare for TX DMA: */
diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
index 6eaa53cef0bd..f794fee8fc0f 100644
--- a/include/linux/platform_data/dma-imx-sdma.h
+++ b/include/linux/platform_data/dma-imx-sdma.h
@@ -51,6 +51,7 @@ struct sdma_script_start_addrs {
 	/* End of v2 array */
 	s32 zcanfd_2_mcu_addr;
 	s32 zqspi_2_mcu_addr;
+	s32 mcu_2_ecspi_addr;
 	/* End of v3 array */
 };
 

--------------99BBD45BC3E8DDAF16FF0AFC--

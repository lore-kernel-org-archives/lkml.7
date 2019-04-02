Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F93DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DE82070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faRnzKB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfDBHUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:20:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41312 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBHUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:20:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so2178067lja.8;
        Tue, 02 Apr 2019 00:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pco4MTqs2xxgcSHHdU1koP29sUUcMScs/RtlSPm6gPA=;
        b=faRnzKB6jXfUsEfqf1HmcugWcx8CDFz0GuXplh8nA3IswlH/cV0VsWRN7A7QxNfio4
         v5Q0RM/Gxl+Uy1Se+OfVccqMGrwQ+PMsQyBzDPEnOQy0neEvDOKYv3tVV/PXq12WXq6Z
         MHLbKUmCUSJFUtZBV2q5nIMkjuie8wushawnwCTM4CtZU5B8juasPJ9KWERwRewGH1C1
         oo+hsxfEy+PaAiZpyfILhdQjaQgIH3n+PNPkYeqhigcioAKYNXb0azdQJKD2oIl4/xmV
         OkhmhPuja6wI9yBLcjNsjS1K+OGIFcgDOzMjpTz8mEBeDLGJIXAszzRJ+R9XOwDqRhKL
         R2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pco4MTqs2xxgcSHHdU1koP29sUUcMScs/RtlSPm6gPA=;
        b=m6MlZMu1T9DAGN20FTN71mcrHZCpk0v/AFZdN8HoBdZXJ7/4hBS6ctxurwYI9DCiOO
         SBwD2VnyUME79jcSwOhlygcptqXtGz1ayVUF9HoZbrRyPPHQv7Bt6lJzu7aqSz9Eoyvf
         GGWbY/BKxk6AgQwKfLKwMg3ML+4kAVNKAYTTW3YinLICzXzvpAaCRF+TEiRI85UZQUTl
         J6pbSXiIPgJs1x52zMnF2Mr7G+r6tNrSm6e5gOwsdh2iiZF82cFUXJNqte+8C1wjpIcI
         LNyf0uigXFCWmV3nbMYSAM0jLrfbKRdQ4NVK8Tna55iHl+zLIuFcdyKxy7t5wjsGwmDt
         +UAA==
X-Gm-Message-State: APjAAAX5RtR2atjlhZuXkZrFb28PCjBVS0IOLdQA0YAzCMBzRjHBqEtV
        hocfQ87hszMPbC7ju7Gj20g=
X-Google-Smtp-Source: APXvYqyKflGbmb1w//3AutvualxPGAGXIFtDo/2Uj0QTr+pZP2esVeL5CD3FeXeXP0JDlxGwvhCqjw==
X-Received: by 2002:a2e:3506:: with SMTP id z6mr37301910ljz.72.1554189630089;
        Tue, 02 Apr 2019 00:20:30 -0700 (PDT)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id e2sm2302627lfc.75.2019.04.02.00.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 00:20:29 -0700 (PDT)
Subject: Re: Issues with i.MX SPI DMA transfers
To:     Robin Gong <yibin.gong@nxp.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
From:   Igor Plyatov <plyatov@gmail.com>
Message-ID: <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
Date:   Tue, 2 Apr 2019 10:20:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Robin Gong,


>> Sorry...below another sdma patch(ad0d92d7ba6a) need to be reverted, 
>> because spi driver may dynamically change burst length.


now I have reverted patch ad0d92d7ba6a.

Patches 0001-dma-engine-imx-sdma-add-mcu_2_ecspi-script.patch and 
0002-spi-spi-imx-fix-ERR009165.patch are applied.


Kernel log show messages

[   29.202639] imx-sdma 20ec000.sdma: loaded firmware 3.3
[   29.238595] spi_imx 2008000.spi: probed
[   29.242802] spi_imx 200c000.spi: probed
[   29.245217] spi_imx 2018000.spi: probed

SPI DMA transfers still not work.

If I test 32 byte transfers, then they work fine. But 64 byte transfers 
fails always and I see error messages

root@cr7:~# spidev_test -D /dev/spidev4.1 -s 1200000 -b 8 -S 64 -I 1 -l
spi mode: 0x20
bits per word: 8
max speed: 1200000 Hz (1200 KHz)
[  423.686736] spi_master spi4: I/O Error in DMA RX
[  423.691392] spidev spi4.1: SPI transfer failed: -110
[  423.696382] spi_master spi4: failed to transfer one message from queue
can't send spi message: Connection timed out
Aborted (core dumped)

I suppose, transfers shorter then 64 bytes made with help of PIO.

Robin, is there any chance for you to find some time and look at this 
issue again?

Best wishes.
--
Igor Plyatov

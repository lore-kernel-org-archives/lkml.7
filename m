Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A46C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2808720700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0UUG+ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfC1LGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:06:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36066 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1LGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:06:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so16167551ljg.3;
        Thu, 28 Mar 2019 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9zbeI7l5bnpaoj/Q6TqFXOcWMvxU6MDYlXf5emuANOc=;
        b=J0UUG+maTZnFJ3zLc6sdG6S50V3AsU2AyEJdaX4udTSrAW7yFWN2KTjrk4QMT0PSps
         XJLpAY2eA6JXbejkEklAUat0nqza4iDoKdMhQxfBaXzOZe4jkE7iyECHWBV33sVNw6pG
         t3JZZYwBJCqyXp8lJQOjOvOQFSdcDFTPHhleV8U18MxDzk0So20qRT7rvcTmrrkevhhT
         MOV7B+x/Jdm8RtD/UHhz9sM4NwcuYpmWIvftkuZ07LNA/SzGCfTlBnypk/3NJYBKn8gS
         LPDAVp22CLd7yeMnKsEpMB0jxgCtnUqFrwblLRfC+dSN1gcaL1Y3iKN4uU2LwHfQBcXg
         Bi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9zbeI7l5bnpaoj/Q6TqFXOcWMvxU6MDYlXf5emuANOc=;
        b=IniM9GkcXsc/2EUkjzaSMJ7mm06cVXoFG8kPMCPRYBdwUBgitE6VM4UM9BbGhIw//E
         r7NosOT98u6FvGNwaGiZXcMcd5pshzqiJJ7jsqFBuosID5QGpz9eKVjLjnIYJsRpMKb6
         GsGw1tV4PRpm0X8om+nxu1wwD7WGNj+rhz5ycLdAdsCWNlvTvSHXMweM9bb26eomlVIU
         jtdsKyLSHmnik9q+eUJoaj31CWRGO1oaBVpLdHvK96vckVAqcGh/ov3KgFOl3ZeRUDya
         V0vMZTYg4sqve954UCLksCP0/MsgY3Y0clmdMRNwtmducAwLGbMq0UMki+zvKaVR2eFY
         AMlA==
X-Gm-Message-State: APjAAAW8ijatRCFQSdl8q61LKukyYcYhf/rb4YfCpso8Dii/VB5grorf
        oGBohtprjReChl5zgWEXLDs=
X-Google-Smtp-Source: APXvYqyBwXHrwmP9hv/3kCzYCaMg/MOs5iyAmFnGi0QhXMsNUupKosP2uinKUFRyCPx6sXJUk6SLgw==
X-Received: by 2002:a2e:219:: with SMTP id 25mr19141796ljc.34.1553771162223;
        Thu, 28 Mar 2019 04:06:02 -0700 (PDT)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id f18sm5064780lja.91.2019.03.28.04.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 04:06:01 -0700 (PDT)
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
From:   Igor Plyatov <plyatov@gmail.com>
Message-ID: <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
Date:   Thu, 28 Mar 2019 14:05:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Robin,

I have applied patches 
0001-dma-engine-imx-sdma-add-mcu_2_ecspi-script.patch, 
0002-spi-spi-imx-fix-ERR009165.patch and made testing.

Results are following:

root@cr7:~# spidev_test -D /dev/spidev0.0 -s 12000000 -b 8 -S 512 -I 
10000000000 -l
spi mode: 0x20
bits per word: 8
max speed: 12000000 Hz (12000 KHz)
[  133.987798] spi_imx 2008000.spi: I/O Error in DMA TX
[  133.992810] spidev spi0.0: SPI transfer failed: -110
[  133.997860] spi_master spi0: failed to transfer one message from queue
can't send spi message: Connection timed out
Aborted (core dumped)

root@cr7:~# spidev_test -D /dev/spidev1.0 -s 12000000 -b 8 -S 512 -I 
10000000000 -l
spi mode: 0x20
bits per word: 8
max speed: 12000000 Hz (12000 KHz)
[  483.530815] spi_imx 200c000.spi: I/O Error in DMA TX
[  483.535825] spidev spi1.0: SPI transfer failed: -110
[  483.540873] spi_master spi1: failed to transfer one message from queue
can't send spi message: Connection timed out
Aborted (core dumped)

root@cr7:~# spidev_test -D /dev/spidev4.0 -s 12000000 -b 8 -S 512 -I 
10000000000 -l
spi mode: 0x20
bits per word: 8
max speed: 12000000 Hz (12000 KHz)
[   94.228774] spi_imx 2018000.spi: I/O Error in DMA TX
[   94.233788] spidev spi4.0: SPI transfer failed: -110
[   94.238837] spi_master spi4: failed to transfer one message from queue
can't send spi message: Connection timed out
Aborted (core dumped)

Best wishes.

--

Igor Plyatov


> Hi Igor,
> 	Please have a try with the attached patch, assume you have already used the sdma firmware
>  From https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma/sdma-imx6q.bin
>> -----Original Message-----
>> From: Igor Plyatov <plyatov@gmail.com>
>> Sent: 2019年3月28日 15:04
>> To: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-spi@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Fabio Estevam
>> <festevam@gmail.com>; Pengutronix Kernel Team <kernel@pengutronix.de>;
>> Sascha Hauer <s.hauer@pengutronix.de>; Shawn Guo
>> <shawnguo@kernel.org>; Mark Brown <broonie@kernel.org>;
>> dmaengine@vger.kernel.org; Vinod Koul <vkoul@kernel.org>; Dan Williams
>> <dan.j.williams@intel.com>; Andy Duan <fugang.duan@nxp.com>; Han Xu
>> <han.xu@nxp.com>; Robin Gong <yibin.gong@nxp.com>; Clark Wang
>> <xiaoning.wang@nxp.com>
>> Subject: Re: Issues with i.MX SPI DMA transfers
>>
>> Dear Uwe,
>>
>>
>>> Hello Igor,
>>>
>>> On Wed, Mar 27, 2019 at 08:40:00PM +0300, Igor Plyatov wrote:
>>>> please, help to resolve two issues with SPI DMA transfers at i.MX6Q
>>>> platform.
>>>>
>>>> First issue is
>>>>    [ 4465.008003] spi_master spi0: I/O Error in DMA RX
>>>>
>>>> Second issue is duplication for one of received bytes.
>>>>
>>>> Probably, these issues related to each one.
>>> This is probably the same problem I hit some time ago. Check ERR009165
>>> in the errata. You either need to disable DMA or need a fixed
>>> sdma-Script.
>> disabling of DMA is not an option, because high throughput required for SPI bus
>> to communicate with DSPs.
>>
>> I'm aware of ERR009165, but as I write some minutes earlier to list,
>> spi0 (alias for ecspi1) and spi1 (alias for ecspi2) work flawless, while
>> spi4 (alias for ecspi5) fails very fast.
>>
>> Does same SDMA script used for all SPI interfaces or scripts are different?
>>
>> Best wishes.
>>
>> --
>>
>> Igor Plyatov

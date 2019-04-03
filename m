Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563F4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9A220700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhnN5Xpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDCRNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:13:55 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:43767 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfDCRNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:13:55 -0400
Received: by mail-ed1-f43.google.com with SMTP id d26so15596943ede.10;
        Wed, 03 Apr 2019 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0+WratJVKBqjwoVboZcV3B8hBCKWgpk6T5kZ4RRKM/Q=;
        b=rhnN5XpefR/Nnz1py0JbR1vG6YnVZDIlb6BX45bF2K2IWoRON7Uq69W41OiqKyRDb3
         yJrPIVfIQGUHV1uaXMMNFUutW1bIxpKDrMe8r2JfNkqmRhBfyulMLbdweN0ZIsXCadKM
         BU9jdXDoxJiOrYOw0D+TlnCFnu+qXd6U+be/h/feUVxMWg/6Z1Pza+pKkoocpHbaejqh
         232OXpMA2gEOq5MDdSWV4J6kXiPZDjhu4vCrbsA8TYTydhLD0SYYfXSiARjDYIsUQ8Wm
         3JU+fu3YS3Ci2Sa4znUXBb37d3Qfzsf4f0yL9CKnM7P50KC8asX8dwV4qM7/N6jbD1y9
         qUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0+WratJVKBqjwoVboZcV3B8hBCKWgpk6T5kZ4RRKM/Q=;
        b=seUA4+bKEI0DweRba2z2FS+IrYoT80AgJX4tAt/M3NSFBeDi/Nk0f2e3xiEX3FebDJ
         r4zq7yTq8GYnQ7Cbe8b8S4tx2yUy/f3baZMSsbXVNtFsuQj04lBldr7PdznspA4MQKL6
         28CTBj2g/kBgyiGY6WYvSl97d5P7hj+PlY9T/2CYRzYG3RRSuBq2DhSHI9GB9cn1EvJp
         OjWDuupbMKXWZ3XfusBKFk/okLP9dpi3ToWVTDDos8Tau+3tLSrJfraEGUql+3spPXtc
         WWgeaivNRowV61U8NrtDuwqvmn4cvI4dJQkDDtyZ4GlAgCEOl0mib3Ea1RuKhV8oidW/
         4DtA==
X-Gm-Message-State: APjAAAXKRxmdE0wh34/c+9/qw4xvmkly18rlNa432wdvfSzf9C9LZuc7
        U5qdoRW3XbfGgMfvc4a4XQU=
X-Google-Smtp-Source: APXvYqz5IHQGhCq5sRBa7ozS/ZgzPN6fTcQr3S6y1VC8LlJMELhGEGKP7LKyyLCxB2spYT/Pr93xfA==
X-Received: by 2002:a50:f4ee:: with SMTP id v43mr509082edm.25.1554311633091;
        Wed, 03 Apr 2019 10:13:53 -0700 (PDT)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id a25sm5140614edc.55.2019.04.03.10.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:13:52 -0700 (PDT)
From:   Igor Plyatov <plyatov@gmail.com>
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
Message-ID: <7739e283-799c-7dac-2bcd-fbf17fd4fb93@gmail.com>
Date:   Wed, 3 Apr 2019 20:13:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB4543DEA3C0CED159C472E85F89570@VI1PR04MB4543.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Robin,

I have made additional tests on another exemplar of board with 
absolutely same hardware.

The spidev_test failed on eCSPI2 and eCSPI5 interfaces, but works 
successfully on eCSPI1 interface.

So, it looks, issue does not correspond to fixed interface number.

This is generic issue of i.MX6 SOC and hardly broken eCSPI interface 
number can change from SOC chip to chip.

Do you have any idea how to improve situation with eCSPI in DMA mode?

Best wishes.
--
Igor Plyatov



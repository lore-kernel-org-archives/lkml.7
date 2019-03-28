Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48706C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152072173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obRSs92j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfC1HE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:04:26 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38991 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfC1HEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:04:25 -0400
Received: by mail-lj1-f170.google.com with SMTP id l7so16619977ljg.6;
        Thu, 28 Mar 2019 00:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=++Ok3oXtfB9kV66SMuSQbHitfXqKIJTKrn/zYU25Okk=;
        b=obRSs92j0RvuqIuKlmxe1YCUnraqFUKZB9818+uEGYJTKlnP7aKOMhGWiJ2Fs3WJGC
         U3TXSm59lAijEyNCb+DhEOzBh702r0hMb84CzaE6o1Lr1/QUroTSeokuYWEUAM4WS6Xd
         y7ohfkFCvynuqhYKzZ6OqcnJdKyM6Gzgd9W+wzK5f899xWOMbE8gTv4EK3a8qZGVCjCg
         okZ547InmNoIl8BwG9F+2OB/svr6LH8NiK+TFbX4g8mxHJS2MYEf2/tlmUVL0lzkq1eb
         EdO0laefxXUv8y0Ds8ST6qmeTxTeGuMdn74Y9TVyyXh9qqGjJbQFDQjTBobdZHwu/JEQ
         K4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=++Ok3oXtfB9kV66SMuSQbHitfXqKIJTKrn/zYU25Okk=;
        b=cGOsWt8YG7FOUQWvZ1CYm2Z4ZCDGIM6MFHQpVhEMUObweWLI6i7erxavpc/5VEgy6k
         Gl4/ezhagrImBLnrQ2wuGinqzAThdNr15JmG+MBiGNWZNgvAgEzgBr0ItPnr+B0/ZiK5
         ZxXCoYnxJFv8VP7ClF2tJ0VM2AdtitdsjoDdfCVRhJpPCSOIe0A0GlKwyPrzyu1OY2Q2
         60KtsAxzrTOFXHUlt1KoxOYbX/Jsdd1pX8a6FLClH+mxhJEhtcIHQo6pqbQHtQvSRM4E
         n/zH3VCXsgEBK/b0R0HdRuAL5MDJjvJXXL9WGQgxgqWnPDtADDqu1aOI7DAixPFdHHLt
         XWxw==
X-Gm-Message-State: APjAAAXBra3XHjVFIUJ6MnvJB9mu7R6xo0Irp2ZQsh69I9i5pf+svIKC
        V1Wldf4eo9HXL/66qgt1jRE=
X-Google-Smtp-Source: APXvYqzcCXgCN1GxrvCaXs/iOJ0KTXzWG5o+ADkJxN9nCjSwMs5oA9tdkSh8CpssavPInuIDhmlQ1w==
X-Received: by 2002:a2e:968c:: with SMTP id q12mr21789304lji.36.1553756663541;
        Thu, 28 Mar 2019 00:04:23 -0700 (PDT)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id m10sm4897594lfk.57.2019.03.28.00.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 00:04:22 -0700 (PDT)
Subject: Re: Issues with i.MX SPI DMA transfers
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Duan <fugang.duan@nxp.com>, Han Xu <han.xu@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
From:   Igor Plyatov <plyatov@gmail.com>
Message-ID: <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
Date:   Thu, 28 Mar 2019 10:04:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Uwe,


> Hello Igor,
>
> On Wed, Mar 27, 2019 at 08:40:00PM +0300, Igor Plyatov wrote:
>> please, help to resolve two issues with SPI DMA transfers at i.MX6Q
>> platform.
>>
>> First issue is
>>   [ 4465.008003] spi_master spi0: I/O Error in DMA RX
>>
>> Second issue is duplication for one of received bytes.
>>
>> Probably, these issues related to each one.
> This is probably the same problem I hit some time ago. Check ERR009165
> in the errata. You either need to disable DMA or need a fixed
> sdma-Script.

disabling of DMA is not an option, because high throughput required for 
SPI bus to communicate with DSPs.

I'm aware of ERR009165, but as I write some minutes earlier to list, 
spi0 (alias for ecspi1) and spi1 (alias for ecspi2) work flawless, while 
spi4 (alias for ecspi5) fails very fast.

Does same SDMA script used for all SPI interfaces or scripts are different?

Best wishes.

--

Igor Plyatov


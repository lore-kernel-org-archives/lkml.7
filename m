Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5B1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009F82075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLo1TDYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfC2L5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:57:35 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:34579 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbfC2L5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:57:34 -0400
Received: by mail-lf1-f41.google.com with SMTP id y18so1273336lfe.1;
        Fri, 29 Mar 2019 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UxqzVk38c+GJJsWsUlprWQg4BUILBlTuCmKayqnS9eo=;
        b=vLo1TDYHmpe4mTFm/9AdDzGvwhdry5SNtYkBwnQuEfPv2ueD0TippdkQYn9KqdCqSa
         34HwchYudq9UAWzzheXwMZ/avCq114CDmN6+ezavZR6Dh9Zi1nB2v38A1dTLUPc1I5qI
         FD61PC9il4DQLODQvLBZL3Sb9dV60EuumEBBQrLhgHM7ZwvceY7zzSdMniHHskX5U2/L
         B6HY+z5oj69L7f3chSxefDtb0JS67d/DCFjhJdjrHOMG5gkaxNmcySFmr4StRFxG9R8Z
         V/ymCa7NZT9xoh7TROjjsVt89Xr5T0s9WqMkIL0SDwZrcMd5LEJL/Bqe0mwAjNRWwk3C
         2rTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UxqzVk38c+GJJsWsUlprWQg4BUILBlTuCmKayqnS9eo=;
        b=iN31A4AdSsDsf17grb/q4okfInJGA/9V8WDXVCFA2aTICtzvMh/f6Ka2eghW6Rme3g
         aiispXb74aFrL6HVLR8cw1p3RVBf3LXc1zLPqIqG83SvytEb4l7Dw1Par3TFTdpeJtzP
         dxe+YONzj8JRg78OtzssIt9QwutLjyuAiB9wf5vpp4TQdXpzdWx4Om9bwU8z2qgCS895
         SvCb3gnTn88z59Wtv/jWKqMIfG2T+4zTX690CcWLU+PeJBJKBan0JIOvVo+H9Uljn+uC
         gkfcTw9+SeHgGY8uBQwZbI5hd9EdImm1GM+b3Odxd/J6a8/oU4agzrjuU+Ttuf6diqAK
         rIeA==
X-Gm-Message-State: APjAAAVOllUCyR8H+x4piCOEsbht56Lh1y1RJUW49dsrlsC/mdPpQ6zF
        7wopUyuwufRYPDD/v8B0rf8=
X-Google-Smtp-Source: APXvYqy8M4YP8VH9Aa9MNtuhJaqRWmRwV//vz3nRRSIe4OjU4GXPwCBP9WxpDI4snyrT9FBOV0NEqQ==
X-Received: by 2002:ac2:5381:: with SMTP id g1mr24499999lfh.130.1553860652385;
        Fri, 29 Mar 2019 04:57:32 -0700 (PDT)
Received: from [192.168.1.10] ([95.174.107.249])
        by smtp.gmail.com with ESMTPSA id b14sm321282ljf.53.2019.03.29.04.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 04:57:31 -0700 (PDT)
Subject: Re: Issues with i.MX SPI DMA transfers
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andy Duan <fugang.duan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <20190328082231.zg4emm66mpbbfb6c@pengutronix.de>
From:   Igor Plyatov <plyatov@gmail.com>
Message-ID: <3aa00772-8a62-3da3-c4ed-281dc93cc597@gmail.com>
Date:   Fri, 29 Mar 2019 14:57:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328082231.zg4emm66mpbbfb6c@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Uwe,

> On Thu, Mar 28, 2019 at 10:04:21AM +0300, Igor Plyatov wrote:
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
>> disabling of DMA is not an option, because high throughput required for SPI
>> bus to communicate with DSPs.
> Is this a theoretical reasoning, or is that backed by testing? People
> here on the list already said things like:
>
> 	The eCSPI appears to insert a 4 bit pause after each word in DMA
> 	mode, not done in PIO mode, which can make DMA transfers 50%
> 	slower than PIO.
>
> You might want to read the thread
> https://marc.info/?l=linux-spi&m=155191201208766&w=2
> .

SPI throughput depends from transfer mode (PIO or DMA), OS load and OS 
version.

For example, Linux-4.9.87 has quite bad results for SPI throughput when 
PIO transfer used and OS highly loaded by other processes. Throughput 
varies from 2700 kbps to 0.8 kbps and this is totally unacceptable for 
my application, where streaming of DSP data required.

Linux-5.1.0-rc2 has much better performance of SPI with PIO transfers. 
Throughput varies within 10%.

>> I'm aware of ERR009165, but as I write some minutes earlier to list, spi0
>> (alias for ecspi1) and spi1 (alias for ecspi2) work flawless, while spi4
>> (alias for ecspi5) fails very fast.
> As the issue is a timing race, it might depend on things like length of
> the SPI lines, load on the data lines and other electrical properties.
> So you might just be happy that spi0 and spi1 don't show the issue for
> you. Or you didn't apply the "right" work load yet.

This e-mail thread discuss operation of SPI only in loopback mode. So, 
real lines of SPI does not used. SPI module of SOC has connected MOSI 
and MISO lines internally, while MISO disconnected from SOC pad. So, 
electrical characteristics of SPI lines are not important at all.

Best wishes.

--

Igor Plyatov


Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BEEC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3DE206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5/2pYfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfDZKpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:45:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37675 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZKpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:45:34 -0400
Received: by mail-io1-f65.google.com with SMTP id a23so2579455iot.4;
        Fri, 26 Apr 2019 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ASocMNns/G25VLbDiL5+NIU5DvHGQ0D5/JnzdFnoRHQ=;
        b=p5/2pYfbVmyiyR37POcWPp+ZECYRDuDmbGw5zs1Mt/n0ByawMFyxzAFP/QBxpP56+k
         Vh4aoX6vWFm0VaAsPeKQp0vpiBTsJvFDXOXHFU3ThOqS6IsOTifqGOq1q01VC0tPB1XI
         taToBXwzUpipDZPEQZjHQ9DRbxQRrnPW3bB7j1pflmQ6/+U0Bu8mKsCmSYRETnBYaL7g
         ozWC3F3miS2ncszLEUes3or4axe0NLT72Jiq7HcxifKAYmqQ47e9JL+ORAbatrtnWpPA
         Hv8ntgCmpsJlmfGxCEVr568cubBpyCDnLl7CjTxzYt6NCipr64U3f6nQvi6EzsJO04jk
         JZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ASocMNns/G25VLbDiL5+NIU5DvHGQ0D5/JnzdFnoRHQ=;
        b=RhR8IqwQWbpp31DDO2bTbXRecVoJlanMha9D7yWFmR9Bq5GkHG6Ocow6xWmiXG8/8t
         McoZXMXxuYmH9B2w8AW3GUuo0MOlWRiV7NDd9KYhlI+h3GgpDdHq9x23xSLB2fgGq9zc
         wy2jXP05wzXtNuOuOBFhWx5M4RE5DlcIR9T+3eujEqNb7R6wVIbzXOOChH/zGOIeY5z0
         wC2CXSMtFxFZqUhbnIDUAFYxZZJA0zE9Ld37LTtjwwtYmhLtg1IYtyUvT9PW6mYzbZT2
         6lAkypiq9TxPqjVvkMseVvWhVYmK58tg6sDWJhiPzcG4xr5M+2U/x9x8WMTojwKehjDp
         OejA==
X-Gm-Message-State: APjAAAUhqHR1JTV7AnliEoNQZYXE+4Hs6xeK//c/LCupbIw1CTvj45bc
        /he2erTXzilI6cjSFaixVta8SYBd
X-Google-Smtp-Source: APXvYqzIBUXzFY83oSrH41eUiKqksHn91f6rs+h9Dzzaqb/mZiSzIVdjyyEwF38ZA91GHJJtII+bPg==
X-Received: by 2002:a6b:f008:: with SMTP id w8mr17782341ioc.251.1556275533964;
        Fri, 26 Apr 2019 03:45:33 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id q207sm1334974itc.37.2019.04.26.03.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 03:45:33 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra: Use relaxed versions of readl/writel
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190424231708.21219-1-digetx@gmail.com>
 <d789f1bc-44d1-abf6-a046-7cf835416e8f@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4a315b63-bc71-3c3e-f1ae-8638bcf4033d@gmail.com>
Date:   Fri, 26 Apr 2019 13:45:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d789f1bc-44d1-abf6-a046-7cf835416e8f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.04.2019 12:52, Jon Hunter пишет:
> 
> On 25/04/2019 00:17, Dmitry Osipenko wrote:
>> The readl/writel functions are inserting memory barrier in order to
>> ensure that memory stores are completed. On Tegra20 and Tegra30 this
>> results in L2 cache syncing which isn't a cheapest operation. The
>> tegra20-apb-dma driver doesn't need to synchronize generic memory
>> accesses, hence use the relaxed versions of the functions.
> 
> Do you mean device-io accesses here as this is not generic memory?

Yes. The IOMEM accesses within are always ordered and uncached, while
generic memory accesses are out-of-order and cached.

> Although there may not be any issues with this change, I think I need a
> bit more convincing that we should do this given that we have had it
> this way for sometime and I would not like to see us introduce any
> regressions as this point without being 100% certain we would not.
> Ideally, if I had some good extensive tests I could run to hammer the
> DMA for all configurations with different combinations of channels
> running simultaneously then we could test this, but right now I don't :-(
> 
> Have you ...
> 1. Tested both cyclic and scatter-gather transfers?
> 2. Stress tested simultaneous transfers with various different
>    configurations?
> 3. Quantified the actual performance benefit of this change so we can
>    understand how much of a performance boost this offers?

Actually I found a case where this change causes a problem, I'm seeing
I2C transfer timeout for touchscreen and it breaks the touch input.
Indeed, I haven't tested this patch very well.

And the fix is this:

@@ -1592,6 +1592,8 @@ static int tegra_dma_runtime_suspend(struct device
*dev)
 						  TEGRA_APBDMA_CHAN_WCOUNT);
 	}

+	dsb();
+
 	clk_disable_unprepare(tdma->dma_clk);

 	return 0;


Apparently the problem is that CLK/DMA (PPSB/APB) accesses are
incoherent and CPU disables clock before writes are reaching DMA controller.

I'd say that cyclic and scatter-gather transfers are now tested. I also
made some more testing of simultaneous transfers.

Quantifying performance probably won't be easy to make as the DMA
read/writes are not on any kind of code's hot-path.

Jon, are you still insisting about to drop this patch or you will be
fine with the v2 that will have the dsb() in place?

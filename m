Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C93C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D68206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBbv+e3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfDZMSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:18:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44200 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZMSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:18:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id h16so2694045ljg.11;
        Fri, 26 Apr 2019 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fhsC2MGG8gZkeYum9RWjuPd2fagCwcScqipgCvCkRLs=;
        b=SBbv+e3beBYOTPC88KnOHBgXvvKu676qrWhPBk/I8T45C3PYVyfO0fm1xWLCO/yIB5
         QZ32mLdK+oRlzJzC7tkI6fqyicVZTjsC7rObkwJgxinN67tSVz5UsAKtQsUHxmmNDeG3
         bq/xoGPoRd4OUqamjdwb00ec3pNm9KQmzPN22cQMThorUtVgx1qE74d7445VDh9CkJPD
         nBviLphNR79zv/fuUm5I+7S+3FSLy7P/8Knqi9237S83d7MhEsp0oRQfJ0buA5rcsjXR
         4uC+YtKQhWwKHLNXtBIPQvXROMOnR6RfFciClD5i+FFwzPKFsMCtwX6+9S3ux4geqz3A
         iPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fhsC2MGG8gZkeYum9RWjuPd2fagCwcScqipgCvCkRLs=;
        b=pewmLtCPDKOkwmqGCVotDOQVVFRuJmpgkoBpZSlJp6oHK7HSKdVgLoZBmnlb5/B4KA
         HKbzC1PoGYnHyupXYGMWDUBaF3m8QgT8boReFA86mlvyrmO2Jm91JvcaPXnpIVfH6lee
         zFbdieet6dhHMVL36aWQPhL8rMPrNWlCJoI5wjvzONE5hQr//4W4rPgD0FLzo1XqqzNK
         5jqPePVjXuhv5t7DiJeeOxwNbxgvYK0Df0uCJu5jTVP7ujFcUW4RsdQE1asbKgC1k7Sh
         HMcpfTf/qCGKTfznnLNIxn73X9TxBju737hfC9WNcV2HeG0lrjcjgvvRsBBDhyZprTFH
         Jhxg==
X-Gm-Message-State: APjAAAVJjB8h6aKn1lqwzXnnThLB+JJe8nzEm98mqb7VN6ZjZ/lwuZ0m
        XL7v6FG/0dbden5gG+tyHBvAuPB/
X-Google-Smtp-Source: APXvYqy9R6a01JS5V6UiVPNXQcLWr1Tsw3cEK9WyWvYE1pePxKbQ+zHhFtHWdM+gonxqTFFMlxF2Lg==
X-Received: by 2002:a2e:3009:: with SMTP id w9mr9559125ljw.14.1556281122478;
        Fri, 26 Apr 2019 05:18:42 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id e14sm6182163ljk.45.2019.04.26.05.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 05:18:41 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra: Use relaxed versions of readl/writel
To:     Jon Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190424231708.21219-1-digetx@gmail.com>
 <d789f1bc-44d1-abf6-a046-7cf835416e8f@nvidia.com>
 <4a315b63-bc71-3c3e-f1ae-8638bcf4033d@gmail.com>
 <bff59709-426b-32d2-08eb-d8f51cd7d5c1@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <49392c02-6dcc-9a95-0035-27c4c0d14820@gmail.com>
Date:   Fri, 26 Apr 2019 15:18:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bff59709-426b-32d2-08eb-d8f51cd7d5c1@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.04.2019 14:13, Jon Hunter пишет:
> 
> On 26/04/2019 11:45, Dmitry Osipenko wrote:
>> 26.04.2019 12:52, Jon Hunter пишет:
>>>
>>> On 25/04/2019 00:17, Dmitry Osipenko wrote:
>>>> The readl/writel functions are inserting memory barrier in order to
>>>> ensure that memory stores are completed. On Tegra20 and Tegra30 this
>>>> results in L2 cache syncing which isn't a cheapest operation. The
>>>> tegra20-apb-dma driver doesn't need to synchronize generic memory
>>>> accesses, hence use the relaxed versions of the functions.
>>>
>>> Do you mean device-io accesses here as this is not generic memory?
>>
>> Yes. The IOMEM accesses within are always ordered and uncached, while
>> generic memory accesses are out-of-order and cached.
>>
>>> Although there may not be any issues with this change, I think I need a
>>> bit more convincing that we should do this given that we have had it
>>> this way for sometime and I would not like to see us introduce any
>>> regressions as this point without being 100% certain we would not.
>>> Ideally, if I had some good extensive tests I could run to hammer the
>>> DMA for all configurations with different combinations of channels
>>> running simultaneously then we could test this, but right now I don't :-(
>>>
>>> Have you ...
>>> 1. Tested both cyclic and scatter-gather transfers?
>>> 2. Stress tested simultaneous transfers with various different
>>>    configurations?
>>> 3. Quantified the actual performance benefit of this change so we can
>>>    understand how much of a performance boost this offers?
>>
>> Actually I found a case where this change causes a problem, I'm seeing
>> I2C transfer timeout for touchscreen and it breaks the touch input.
>> Indeed, I haven't tested this patch very well.
>>
>> And the fix is this:
>>
>> @@ -1592,6 +1592,8 @@ static int tegra_dma_runtime_suspend(struct device
>> *dev)
>>  						  TEGRA_APBDMA_CHAN_WCOUNT);
>>  	}
>>
>> +	dsb();
>> +
>>  	clk_disable_unprepare(tdma->dma_clk);
>>
>>  	return 0;
>>
>>
>> Apparently the problem is that CLK/DMA (PPSB/APB) accesses are
>> incoherent and CPU disables clock before writes are reaching DMA controller.
>>
>> I'd say that cyclic and scatter-gather transfers are now tested. I also
>> made some more testing of simultaneous transfers.
>>
>> Quantifying performance probably won't be easy to make as the DMA
>> read/writes are not on any kind of code's hot-path.
> 
> So why make the change?

For consistency.

>> Jon, are you still insisting about to drop this patch or you will be
>> fine with the v2 that will have the dsb() in place?
> 
> If we can't quantify the performance gain, then it is difficult to
> justify the change. I would also be concerned if that is the only place
> we need an explicit dsb.

Maybe it won't hurt to add dsb to the ISR as well. But okay, let's drop
this patch for now.

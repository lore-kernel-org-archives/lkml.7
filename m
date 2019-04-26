Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DE5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024D1206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMDAuekB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfDZMmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:42:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33437 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZMmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:42:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id f23so2844316ljc.0;
        Fri, 26 Apr 2019 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mwkoqM03m7stCPVN4VzB/e7FsGvkrHcL5mCmY6iA8cU=;
        b=uMDAuekB4P9GUDB1G/ezxsm+pFB5WGCrB9AXmH/YgR6NVvCZqLeeHfPgDbE5qwZwVt
         cJ/IXaIfURkaFwyqhp+/VUVij7NNCd1RL0OMjL0s3b39wG4rBYwihxP0MYXn1GHnGUeY
         Ue+VbnA5izBl57YJmy7HgHuFXBeVTVWqz8P/o5Tq0LtcV50W+EL4jM4pQdaUTWvyFtb8
         mDYMUF5+M4PvZS8qZkmmWUykn/+cWlhWne5Qzpov4c3fgkpQteJ2QkANWgpzXYqWCHw/
         rG5JPvkmQoPuQcuH32DAEdkEcMTjrwEuPTY22Ea8pKoRSNMxiqyTkcmZoWZq/XzOxYw+
         HbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mwkoqM03m7stCPVN4VzB/e7FsGvkrHcL5mCmY6iA8cU=;
        b=JwfTI/CbIPIN02AhQ9YM185DKpXneqhpZE1RDkR9hQyeDu9/FUjTca/mne0vPtgyZX
         RWYlI9+jZ+aMdsHvg5OYRAxyQ9ZGKqTpbdeoBFYb4Pj8Wk9pTcHgdM0bkPeJv0LpvNKn
         rJ0TkrnQGk5EvvLZKaMcEkNQT6NVM3gDhJvYFKFWU5nyDq7DqYKqKogpiQ8KxHe3s8/S
         +Kpwlu7AcfUcNki95HQj5e2msd0y1klgKHHOE+tV1Eqm5f6mNWN1eRgMzMrQpt4y+5cG
         3BeirVkfKUB8MIRpTrroH+qZSr2aLAjKRthhlyrsw8DuYjp/q3/1cCcEYcLGYwhUJ+J6
         upXg==
X-Gm-Message-State: APjAAAXG1czGWvpbQLPuSHcMuTFpBsJt1zjiduCLV3RP5Zk9+xTug0HF
        QW37Iiww3shEnNSRd7Ox/Lrb9ccG
X-Google-Smtp-Source: APXvYqyhWtnYMl6ceXOKk1SINLp252CGZyANfSP6ns/+HnWBe8EK5YJbZCbT0lLumy7BWAgvrNZZ3A==
X-Received: by 2002:a2e:9ed3:: with SMTP id h19mr24788635ljk.129.1556282559057;
        Fri, 26 Apr 2019 05:42:39 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id y19sm5558427lfb.24.2019.04.26.05.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 05:42:38 -0700 (PDT)
Subject: Re: [PATCH v1] dmaengine: tegra: Use relaxed versions of readl/writel
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <49392c02-6dcc-9a95-0035-27c4c0d14820@gmail.com>
Message-ID: <242863b9-b75e-4b37-178a-5aa03e56d3e1@gmail.com>
Date:   Fri, 26 Apr 2019 15:42:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <49392c02-6dcc-9a95-0035-27c4c0d14820@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.04.2019 15:18, Dmitry Osipenko пишет:
> 26.04.2019 14:13, Jon Hunter пишет:
>>
>> On 26/04/2019 11:45, Dmitry Osipenko wrote:
>>> 26.04.2019 12:52, Jon Hunter пишет:
>>>>
>>>> On 25/04/2019 00:17, Dmitry Osipenko wrote:
>>>>> The readl/writel functions are inserting memory barrier in order to
>>>>> ensure that memory stores are completed. On Tegra20 and Tegra30 this
>>>>> results in L2 cache syncing which isn't a cheapest operation. The
>>>>> tegra20-apb-dma driver doesn't need to synchronize generic memory
>>>>> accesses, hence use the relaxed versions of the functions.
>>>>
>>>> Do you mean device-io accesses here as this is not generic memory?
>>>
>>> Yes. The IOMEM accesses within are always ordered and uncached, while
>>> generic memory accesses are out-of-order and cached.
>>>
>>>> Although there may not be any issues with this change, I think I need a
>>>> bit more convincing that we should do this given that we have had it
>>>> this way for sometime and I would not like to see us introduce any
>>>> regressions as this point without being 100% certain we would not.
>>>> Ideally, if I had some good extensive tests I could run to hammer the
>>>> DMA for all configurations with different combinations of channels
>>>> running simultaneously then we could test this, but right now I don't :-(
>>>>
>>>> Have you ...
>>>> 1. Tested both cyclic and scatter-gather transfers?
>>>> 2. Stress tested simultaneous transfers with various different
>>>>    configurations?
>>>> 3. Quantified the actual performance benefit of this change so we can
>>>>    understand how much of a performance boost this offers?
>>>
>>> Actually I found a case where this change causes a problem, I'm seeing
>>> I2C transfer timeout for touchscreen and it breaks the touch input.
>>> Indeed, I haven't tested this patch very well.
>>>
>>> And the fix is this:
>>>
>>> @@ -1592,6 +1592,8 @@ static int tegra_dma_runtime_suspend(struct device
>>> *dev)
>>>  						  TEGRA_APBDMA_CHAN_WCOUNT);
>>>  	}
>>>
>>> +	dsb();
>>> +
>>>  	clk_disable_unprepare(tdma->dma_clk);
>>>
>>>  	return 0;
>>>
>>>
>>> Apparently the problem is that CLK/DMA (PPSB/APB) accesses are
>>> incoherent and CPU disables clock before writes are reaching DMA controller.
>>>
>>> I'd say that cyclic and scatter-gather transfers are now tested. I also
>>> made some more testing of simultaneous transfers.
>>>
>>> Quantifying performance probably won't be easy to make as the DMA
>>> read/writes are not on any kind of code's hot-path.
>>
>> So why make the change?
> 
> For consistency.
> 
>>> Jon, are you still insisting about to drop this patch or you will be
>>> fine with the v2 that will have the dsb() in place?
>>
>> If we can't quantify the performance gain, then it is difficult to
>> justify the change. I would also be concerned if that is the only place
>> we need an explicit dsb.
> 
> Maybe it won't hurt to add dsb to the ISR as well. But okay, let's drop
> this patch for now.
> 

Jon, it occurred to me that there still should be a problem with the
writel() ordering in the driver because writel() ensures that memory
stores are completed *before* the write occurs and hence translates into
iowmb() + writel_relaxed() [0]. Thus the last write will always happen
asynchronously in regards to clk accesses.

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/include/asm/io.h#n311

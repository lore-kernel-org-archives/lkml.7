Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D18CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C125D2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="THmwsyEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389848AbfJWHcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:32:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33890 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389118AbfJWHcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:32:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so15694237wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 00:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VYLri5pd2Odae8b/vTSpf0oA1mpoNknFR1w47s8PBLE=;
        b=THmwsyEX6n3Rzwii3QOMvb4P/flUezKTsJ0430eRbjc2bd+SQ7LQbl+/7fTxo7LWyB
         ewOve+4DIus64qNSeehvPem4Ki1GKTjhVaNMLAW/E02ZmcfL4VHIrLygljRzVQe+QbXE
         vNSaz4YeepYegoI95sZNAxsE1VsxMSoI5ycTvS0Qjah2bfXvTb092J5zUhQK38fyekyE
         /LSfVDkF0trPfRNwlnPG6Zr2pRJ/McufW5r4O0vfPPNSpojo5yAbIz5sU4FGU8RBn7ks
         b2YPzmnRW/hVYUsNYf9Krdck70amaYNAvCXegVVInS/PNk2rH/g0oUsDdq2UtW8Pc78B
         pU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VYLri5pd2Odae8b/vTSpf0oA1mpoNknFR1w47s8PBLE=;
        b=KyRkRQIDaGd2csRQYQR9LVKDvMpg+prfk2wcHrooB3w3pgoHqOiN+4z5sU7XZ7c+0S
         wakukiUUEvJemiWf/7ZJ56gVrzqe150iRTOpIEBSS844K5rNPf9ll5BkPG/nE1PFcn+/
         8keigt6dK5Kfq2Jtxj2p2m84EW4E90SjZLCflGxTg7Ca//fU4bO84JmyaivIlPXFa4Fu
         atDU6c7qNt4GdbXqIOB7HHO1LdzkZzomP8GLLm5pj0aB+OwEasRqH5UNtOmoQHZSONVF
         L7pRCoYLT1KNx8PkIr1odCMEda6NA9ogDSVMVmZo1//YPpqEtg7OXcxlNjOtn7moZBMO
         bHLA==
X-Gm-Message-State: APjAAAVorLH8awUWknpIYyWX8HSi92qmzLgliMSKLNeQRXmAuJNjKHF2
        /W0vhcg15QX56fgwwQMZsyP/yQ==
X-Google-Smtp-Source: APXvYqzlMuR1EOQHTBp8eR0UGZyg6ZcumnwYn7xiS9/ynhb9xU1dYHtdOTAqRBYM+KJwPdfbORfMnw==
X-Received: by 2002:adf:d190:: with SMTP id v16mr7237205wrc.64.1571815952571;
        Wed, 23 Oct 2019 00:32:32 -0700 (PDT)
Received: from [10.1.3.173] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n1sm24689409wrg.67.2019.10.23.00.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 00:32:32 -0700 (PDT)
Subject: Re: [PATCH v13 0/5] DMA-BUF Heaps (destaging ION)
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        Christoph Hellwig <hch@infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
References: <20191021190310.85221-1-john.stultz@linaro.org>
 <be7286c7-3e67-4ffb-73b1-2622391d7c15@baylibre.com>
 <CALAqxLVjp-qNyy8wjG+fJYQqafK5Fsf8rpb3bNe3_p0X9VLjRg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <b6319fec-8536-a7d1-ee26-cd47438218b0@baylibre.com>
Date:   Wed, 23 Oct 2019 09:32:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLVjp-qNyy8wjG+fJYQqafK5Fsf8rpb3bNe3_p0X9VLjRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2019 17:56, John Stultz wrote:
> On Tue, Oct 22, 2019 at 1:21 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi John,
>>
>> On 21/10/2019 21:03, John Stultz wrote:
>>> Lucky number 13! :)
>>>
>>> Last week in v12 I had re-added some symbol exports to support
>>> later patches I have pending to enable loading heaps from
>>> modules. He reminded me that back around v3 (its been awhile!) I
>>> had removed those exports due to concerns about the fact that we
>>> don't support module removal.
>>>
>>> So I'm respinning the patches, removing the exports again. I'll
>>> submit a patch to re-add them in a later series enabling moduels
>>> which can be reviewed indepently.
>>>
>>> With that done, lets get on to the boilerplate!
>>>
>>> The patchset implements per-heap devices which can be opened
>>> directly and then an ioctl is used to allocate a dmabuf from the
>>> heap.
>>>
>>> The interface is similar, but much simpler then IONs, only
>>> providing an ALLOC ioctl.
>>>
>>> Also, I've provided relatively simple system and cma heaps.
>>>
>>> I've booted and tested these patches with AOSP on the HiKey960
>>> using the kernel tree here:
>>>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
>>
>> Do you have a 4.19 tree with the changes ? I tried but the xarray idr replacement
>> is missing... so I can't test with our android-amlogic-bmeson-4.19 tree.
>>
>> If you can provide, I'll be happy to test the serie and the gralloc changes.
> 
> Unfortunately I don't have a 4.19 version of dmabuf heaps (all the
> work has been done this year, post 4.19). I'm planning to backport to
> 5.4 for AOSP, but I've not really thought about 4.19. Most likely I
> won't have time to look at it until after the changes are upstream and
> the 5.4 backport is done.
> 
> Is the bmeson tree likely to only stay at 4.19? Or will it move forward?

No idea, I don't have any details on the future plans.
Since we did an upstream-first support, 90% will be available on the future android-5.4 tree anyway.

Neil

> 
> thanks
> -john
> 


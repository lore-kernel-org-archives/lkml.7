Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB71C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AF5206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="A0CPH/SJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfDZLNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:13:41 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12126 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZLNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:13:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc2e7ea0001>; Fri, 26 Apr 2019 04:13:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 26 Apr 2019 04:13:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 26 Apr 2019 04:13:40 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 11:13:38 +0000
Subject: Re: [PATCH v1] dmaengine: tegra: Use relaxed versions of readl/writel
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190424231708.21219-1-digetx@gmail.com>
 <d789f1bc-44d1-abf6-a046-7cf835416e8f@nvidia.com>
 <4a315b63-bc71-3c3e-f1ae-8638bcf4033d@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bff59709-426b-32d2-08eb-d8f51cd7d5c1@nvidia.com>
Date:   Fri, 26 Apr 2019 12:13:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4a315b63-bc71-3c3e-f1ae-8638bcf4033d@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556277227; bh=O/GAZj9r0fT77AziCi8BIUhr0zpYSUaCjsqVbQvWxNo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=A0CPH/SJVtOlSPOSszQYDZd0C6X66NRGXuSvxP1l6gaQHKYJsaWAQQTIGERJntQ6b
         zJz4XL/eXrb7+xdLsMLJwLTn2aKAzUAkouWMo2HyQdp+EWdkNX1BXp6hbnhIJOMrci
         99uFOEL9QIS5Q9FTXJ4AY/4xUfFGjscNEJmIvUKipqDQgwWVf6xxhrFa+LfGC8pQx9
         uPXrcvA8OPW4auaVU7TO24A9TGE/8sPKJhMtWYFojYv3ahB/BmwMxS3rhwNE3YO/H2
         DY9AqT19P2a0sx2de0gnzyPOPrc9ZITUyWabrukDRR9ke5qZP8E0Y09IoKIqX/I78o
         D2sT4UENqIXPg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/04/2019 11:45, Dmitry Osipenko wrote:
> 26.04.2019 12:52, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 25/04/2019 00:17, Dmitry Osipenko wrote:
>>> The readl/writel functions are inserting memory barrier in order to
>>> ensure that memory stores are completed. On Tegra20 and Tegra30 this
>>> results in L2 cache syncing which isn't a cheapest operation. The
>>> tegra20-apb-dma driver doesn't need to synchronize generic memory
>>> accesses, hence use the relaxed versions of the functions.
>>
>> Do you mean device-io accesses here as this is not generic memory?
>=20
> Yes. The IOMEM accesses within are always ordered and uncached, while
> generic memory accesses are out-of-order and cached.
>=20
>> Although there may not be any issues with this change, I think I need a
>> bit more convincing that we should do this given that we have had it
>> this way for sometime and I would not like to see us introduce any
>> regressions as this point without being 100% certain we would not.
>> Ideally, if I had some good extensive tests I could run to hammer the
>> DMA for all configurations with different combinations of channels
>> running simultaneously then we could test this, but right now I don't :-=
(
>>
>> Have you ...
>> 1. Tested both cyclic and scatter-gather transfers?
>> 2. Stress tested simultaneous transfers with various different
>>    configurations?
>> 3. Quantified the actual performance benefit of this change so we can
>>    understand how much of a performance boost this offers?
>=20
> Actually I found a case where this change causes a problem, I'm seeing
> I2C transfer timeout for touchscreen and it breaks the touch input.
> Indeed, I haven't tested this patch very well.
>=20
> And the fix is this:
>=20
> @@ -1592,6 +1592,8 @@ static int tegra_dma_runtime_suspend(struct device
> *dev)
>  						  TEGRA_APBDMA_CHAN_WCOUNT);
>  	}
>=20
> +	dsb();
> +
>  	clk_disable_unprepare(tdma->dma_clk);
>=20
>  	return 0;
>=20
>=20
> Apparently the problem is that CLK/DMA (PPSB/APB) accesses are
> incoherent and CPU disables clock before writes are reaching DMA controll=
er.
>=20
> I'd say that cyclic and scatter-gather transfers are now tested. I also
> made some more testing of simultaneous transfers.
>=20
> Quantifying performance probably won't be easy to make as the DMA
> read/writes are not on any kind of code's hot-path.

So why make the change?
> Jon, are you still insisting about to drop this patch or you will be
> fine with the v2 that will have the dsb() in place?

If we can't quantify the performance gain, then it is difficult to
justify the change. I would also be concerned if that is the only place
we need an explicit dsb.

Cheers
Jon

--=20
nvpublic

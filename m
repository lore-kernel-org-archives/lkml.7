Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE94C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960262070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="H+g4mn/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfFFOgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:36:19 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5556 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbfFFOgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:36:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf924d60001>; Thu, 06 Jun 2019 07:36:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 07:36:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 07:36:07 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 14:36:05 +0000
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sameer Pujar <spujar@nvidia.com>, Vinod Koul <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <tiwai@suse.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <mkumard@nvidia.com>, linux-tegra <linux-tegra@vger.kernel.org>
References: <1556623828-21577-1-git-send-email-spujar@nvidia.com>
 <20190502060446.GI3845@vkoul-mobl.Dlink>
 <e852d576-9cc2-ed42-1a1a-d696112c88bf@nvidia.com>
 <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <ed95f03a-bbe7-ad62-f2e1-9bfe22ec733a@ti.com>
 <4cab47d0-41c3-5a87-48e1-d7f085c2e091@nvidia.com>
 <8a5b84db-c00b-fff4-543f-69d90c245660@nvidia.com>
 <3f836a10-eaf3-f59b-7170-6fe937cf2e43@ti.com>
 <a36302fc-3173-070b-5c97-7d2c55d5e2cc@nvidia.com>
 <a08bec36-b375-6520-eff4-3d847ddfe07d@ti.com>
 <4593f37c-5e89-8559-4e80-99dbfe4235de@nvidia.com>
 <deae510a-f6ae-6a51-2875-a7463cac9169@gmail.com>
 <71795bb0-2b8f-2b58-281c-e7e15bca3164@gmail.com>
 <2eab4777-79b8-0aea-c22f-ac9d11284889@nvidia.com>
Message-ID: <e24a26d8-6355-bac0-eeba-8d8ce8d5f985@nvidia.com>
Date:   Thu, 6 Jun 2019 15:36:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2eab4777-79b8-0aea-c22f-ac9d11284889@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559831766; bh=bZC1r6hpGzpazTCXU3NxX7cEb071qrcPb86jInbwR9w=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=H+g4mn/zDmvqcyiPtE/D2NuQmi3sR1KdEP4bHv66Kgh8Pa8HfT5wX3uLyJGon/eMG
         NNl/ryQ48lk+CRVbhaVMCZegfFzUYGLwuRmrgtLIH+5FDfSoDAfKHK1zowhWbJsgzZ
         28RWTkkQLcwxQnnEVbroZgs4PZHfvDj3nANbuyr1+PFetshYhcl4P9t/Vxd4FS5j5q
         yv5DEKNS/hcz13BzT6rn3H6PAH37Tj+Gojepi9pZUgiYfDVUI0cTHs54mErZUQHGy8
         8xtAFQWMwUPG+N/7HfkkXk80uc2eLRIc/vq4/XWl5rBIo2WzOi+zViSBbg6DmsEgfk
         JqPUPvy7lyvIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/06/2019 15:26, Jon Hunter wrote:

...

>>> If I understood everything correctly, the FIFO buffer is shared among
>>> all of the ADMA clients and hence it should be up to the ADMA driver to
>>> manage the quotas of the clients. So if there is only one client that
>>> uses ADMA at a time, then this client will get a whole FIFO buffer, but
>>> once another client starts to use ADMA, then the ADMA driver will have
>>> to reconfigure hardware to split the quotas.
>>>
>>
>> You could also simply hardcode the quotas per client in the ADMA driver
>> if the quotas are going to be static anyway.
> 
> Essentially this is what we have done so far, but Sameer is looking for
> a way to make this more programmable/flexible. We can always do that if
> there is no other option indeed. However, seems like a good time to see
> if there is a better way.

My thoughts on resolving this, in order of preference, would be ...

1. Add a new 'fifo_size' variable as Sameer is proposing.
2. Update the ADMA driver to use src/dst_maxburst as the fifo size and
   then have the ADMA driver set a suitable burst size for its burst
   size.
3. Resort to a static configuration.

I can see that #1 only makes sense if others would find it useful,
otherwise #2, may give us enough flexibility for now.

Cheers
Jon

-- 
nvpublic

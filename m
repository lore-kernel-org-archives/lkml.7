Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A316C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEBC2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aZpKIHzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfDZJwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:52:20 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5976 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfDZJwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:52:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc2d4d90000>; Fri, 26 Apr 2019 02:52:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Apr 2019 02:52:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Apr 2019 02:52:19 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 09:52:17 +0000
Subject: Re: [PATCH v1] dmaengine: tegra: Use relaxed versions of readl/writel
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190424231708.21219-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d789f1bc-44d1-abf6-a046-7cf835416e8f@nvidia.com>
Date:   Fri, 26 Apr 2019 10:52:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424231708.21219-1-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556272345; bh=QOZLdR2lD8/lHPVcDQMaWidLRGULKACQlNQH2+6obcE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aZpKIHzM03vyqkp1zj3rvxPPJKNVuJZnSre0OhNHCSX5nHmutzs5LXO32h235RUc1
         FNrk4ULuaLoOc/7pmjirYH0AajET9/aS+aDitcT8c2Rr12jtce2XdKE6/dlaz/Cw/E
         +rpQH6AcU9hRT5dSXBIlMRGRcO2g9ly3yaHjEjNRsmI9Ch8T9sApDqz0y5M/F4RmnS
         0Ect3WQtONs017lRyaUtMlpawqKAknAwRITBhKVanQevtqeoSgBaLezRjE4u7cCmmg
         u2vUwuVguO+AasRwBuxg3G1z3elCb8UEHvCYiMTYcX+VQgmiV5JNwxwiMQ8tBRQzPt
         X73B6t83daEbQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/04/2019 00:17, Dmitry Osipenko wrote:
> The readl/writel functions are inserting memory barrier in order to
> ensure that memory stores are completed. On Tegra20 and Tegra30 this
> results in L2 cache syncing which isn't a cheapest operation. The
> tegra20-apb-dma driver doesn't need to synchronize generic memory
> accesses, hence use the relaxed versions of the functions.

Do you mean device-io accesses here as this is not generic memory?

Although there may not be any issues with this change, I think I need a
bit more convincing that we should do this given that we have had it
this way for sometime and I would not like to see us introduce any
regressions as this point without being 100% certain we would not.
Ideally, if I had some good extensive tests I could run to hammer the
DMA for all configurations with different combinations of channels
running simultaneously then we could test this, but right now I don't :-(

Have you ...
1. Tested both cyclic and scatter-gather transfers?
2. Stress tested simultaneous transfers with various different
   configurations?
3. Quantified the actual performance benefit of this change so we can
   understand how much of a performance boost this offers?

Cheers
Jon

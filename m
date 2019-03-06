Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD8AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98851206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="V2q8WL1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfCFOAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:00:10 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19183 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCFOAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:00:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7fd2680000>; Wed, 06 Mar 2019 06:00:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Mar 2019 06:00:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Mar 2019 06:00:08 -0800
Received: from [10.21.26.179] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Mar
 2019 14:00:07 +0000
Subject: Re: [PATCH] [v2] gpu: host1x: avoid IOMMU_API build error
To:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Dmitry Osipenko <digetx@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190306135800.3982681-1-arnd@arndb.de>
From:   Mikko Perttunen <mperttunen@nvidia.com>
Message-ID: <6692ec53-fb2f-e15c-88fe-33d13e0def8d@nvidia.com>
Date:   Wed, 6 Mar 2019 16:00:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306135800.3982681-1-arnd@arndb.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551880808; bh=7tRrNXQTVhlRutsG0a5Nw3nJ5mnC0eiT6MFCYJwDZa4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=V2q8WL1AAyCJwtQWb1UTAuLe69R0M37JmzV8O0nYKdimNIzXNA96K3bG8j0YnhqFc
         +30PpD7IbQIv4OOOpNqHHU2Jff5YiKAhXKJ/2o+oehtkX3VLBDjEzMnyvRbDtdHCuW
         Iy9SxWCGugnE+30fW2Pc6TS1nE8taT2CiuRiOGFuXVLyarxe670vG8aAxJea7u6i/l
         XfeAxBDurwGyCu5aiPwEyM1Kd/XTlvE4ivV8sjHfIDQa9o65lgES0d56ui7Rx8NwGD
         YKJkOXmyXdSxuC4wjZAIfig+jWvnQCTL2iEH3B5zkuDP6rF6iqFJRu0ZvrcWpjGZlc
         lG0a3ZTnCNTrQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.3.2019 15.57, Arnd Bergmann wrote:
> When the iommu API is disabled, the host1x driver fails to build:
> 
> drivers/gpu/host1x/hw/channel_hw.c: In function 'host1x_channel_set_streamid':
> drivers/gpu/host1x/hw/channel_hw.c:118:30: error: implicit declaration of function 'dev_iommu_fwspec_get'; did you mean 'iommu_fwspec_free'? [-Werror=implicit-function-declaration]
>    struct iommu_fwspec *spec = dev_iommu_fwspec_get(channel->dev->parent);
>                                ^~~~~~~~~~~~~~~~~~~~
>                                iommu_fwspec_free
> drivers/gpu/host1x/hw/channel_hw.c:118:30: error: initialization of 'struct iommu_fwspec *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> drivers/gpu/host1x/hw/channel_hw.c:119:23: error: 'struct iommu_fwspec' has no member named 'ids'
>    u32 sid = spec ? spec->ids[0] & 0xffff : 0x7f;
>                         ^~
> cc1: all warnings being treated as errors
> 
> As Mikko explains, we should program SMMU bypass (0x7f) if that
> happens.
> 
> Fixes: de5469c21ff9 ("gpu: host1x: Program the channel stream ID")
> Suggested-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> v2: fall back to 0x7f sid
> ---
>   drivers/gpu/host1x/hw/channel_hw.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/channel_hw.c
> index 27101c04a827..0c0eb43abf65 100644
> --- a/drivers/gpu/host1x/hw/channel_hw.c
> +++ b/drivers/gpu/host1x/hw/channel_hw.c
> @@ -115,8 +115,12 @@ static inline void synchronize_syncpt_base(struct host1x_job *job)
>   static void host1x_channel_set_streamid(struct host1x_channel *channel)
>   {
>   #if HOST1X_HW >= 6
> +	u32 sid = 0x7f;
> +#ifdef CONFIG_IOMMU_API
>   	struct iommu_fwspec *spec = dev_iommu_fwspec_get(channel->dev->parent);
> -	u32 sid = spec ? spec->ids[0] & 0xffff : 0x7f;
> +	if (spec)
> +		sid = spec->ids[0] & 0xffff;
> +#endif
>   
>   	host1x_ch_writel(channel, sid, HOST1X_CHANNEL_SMMU_STREAMID);
>   #endif
> 

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

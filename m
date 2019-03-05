Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB3BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AF8206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FcAUd0LN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfCELoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:44:17 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5340 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCELoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:44:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7e610f0001>; Tue, 05 Mar 2019 03:44:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 05 Mar 2019 03:44:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 05 Mar 2019 03:44:14 -0800
Received: from [10.21.26.179] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Mar
 2019 11:44:12 +0000
Subject: Re: [PATCH] gpu: host1x: avoid IOMMU_API build error
To:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190304195338.989221-1-arnd@arndb.de>
From:   Mikko Perttunen <mperttunen@nvidia.com>
Message-ID: <b966e099-d908-c5a6-6080-beced36a39d9@nvidia.com>
Date:   Tue, 5 Mar 2019 13:44:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304195338.989221-1-arnd@arndb.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551786255; bh=ufJ1OfEmAWiLDLY1sYbxqQ/CUmKibqR2ymASNMyZjXU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FcAUd0LNSfebuintIHHryj0t7+pbws+b+734Y6gFpgAAwtm5fAKIBczssMRCrQtE1
         E0XUuyHEnSLb1UNioLhaSLFrCc1n7fcBgyU3w+R0xDwL6Cj5el7/ZiDIf/GvkmQaJo
         51gdFf8Mxje6hU4LGIT+ukgGC76vSdztph3Om+lF7ZXEaN+QEoOcatYkhFxdDK1RF0
         dCgkNkb8+nDy6PWT5sxGzUb3rUCX78+xdlOW2OtU0VYcpoHnYBMttBR9y+wkgnr3fb
         Pe1xqFnYhZplC58nJDebdg0OpglKfB2xz75W2HZkS47oNY9QqWBNJFCZwqC9Vxj83A
         wmGSi7PyHbqRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.3.2019 21.53, Arnd Bergmann wrote:
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
> Fixes: de5469c21ff9 ("gpu: host1x: Program the channel stream ID")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/host1x/hw/channel_hw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/channel_hw.c
> index 27101c04a827..738dccf4ee3f 100644
> --- a/drivers/gpu/host1x/hw/channel_hw.c
> +++ b/drivers/gpu/host1x/hw/channel_hw.c
> @@ -114,7 +114,7 @@ static inline void synchronize_syncpt_base(struct host1x_job *job)
>   
>   static void host1x_channel_set_streamid(struct host1x_channel *channel)
>   {
> -#if HOST1X_HW >= 6
> +#if HOST1X_HW >= 6 && defined(CONFIG_IOMMU_API)
>   	struct iommu_fwspec *spec = dev_iommu_fwspec_get(channel->dev->parent);
>   	u32 sid = spec ? spec->ids[0] & 0xffff : 0x7f;
>   
> 

We should always program the stream ID - if IOMMU API is not enabled 
then 0x7f (SMMU bypass) should always be programmed.

Mikko

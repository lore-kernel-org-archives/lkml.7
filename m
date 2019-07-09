Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E259FC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B718021670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dx1hthAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfGIQ1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:27:36 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18027 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:27:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d24c07c0000>; Tue, 09 Jul 2019 09:27:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 09 Jul 2019 09:27:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 09 Jul 2019 09:27:35 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jul
 2019 16:27:34 +0000
Subject: Re: [PATCH v1] drm/tegra: Fix gpiod_get_from_of_node() regression
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190705151139.19032-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9425f0e8-36ec-76cb-b177-fa486fcafc19@nvidia.com>
Date:   Tue, 9 Jul 2019 17:27:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705151139.19032-1-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562689660; bh=eiMzdExQqfXSHcpxt0RmPgRZdbS5a+9W8kuVpeJfT2c=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dx1hthAf1o0tT3KQdGbZYxZ3xITziFcwzhbVcVlCGqjCi/pXXZcY0f+Juxw7JzeXG
         eiFsootJn9+BVTyUxsLp+tS5HJ/z4SOR2RK5TL4kr+1ia/YIBULICdwqpC9HJbidxl
         PEHODPxSDzE/aBh3WSRjb0ntsQf+Y8d2VnwvDfbCaT/4+AcZGz5v423d3smJzDiXp0
         1JaK5aMrkeeRNdhkArKkkVN2wLWgseC1bXG5S6MUKrBCcA2ZtNKfUZuBDIHKXoUvpY
         yRqpsCiQnPZ/FSqdzYqCaBcj8EU/lovtZkh6h7CJKsB1y6kKEs1LFV/gQd4yt43MJN
         U+eLjK17qMMTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/07/2019 16:11, Dmitry Osipenko wrote:
> That function now returns ERR_PTR instead of NULL if "hpd-gpio" is not
> present in device-tree. The offending patch missed to adapt the Tegra's
> DRM driver for the API change.
> 
> Fixes: 025bf37725f1 ("gpio: Fix return value mismatch of function gpiod_get_from_of_node()")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/output.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
> index 274cb955e2e1..471d33809cd4 100644
> --- a/drivers/gpu/drm/tegra/output.c
> +++ b/drivers/gpu/drm/tegra/output.c
> @@ -126,8 +126,12 @@ int tegra_output_probe(struct tegra_output *output)
>  						       "nvidia,hpd-gpio", 0,
>  						       GPIOD_IN,
>  						       "HDMI hotplug detect");
> -	if (IS_ERR(output->hpd_gpio))
> -		return PTR_ERR(output->hpd_gpio);
> +	if (IS_ERR(output->hpd_gpio)) {
> +		if (PTR_ERR(output->hpd_gpio) == -ENOENT)
> +			output->hpd_gpio = NULL;
> +		else
> +			return PTR_ERR(output->hpd_gpio);
> +	}
>  
>  	if (output->hpd_gpio) {
>  		err = gpiod_to_irq(output->hpd_gpio);
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

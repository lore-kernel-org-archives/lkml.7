Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EA4206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WvYGtiCi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kglmUE+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfDAMt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:49:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43670 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAMt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:49:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4689961382; Mon,  1 Apr 2019 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554122965;
        bh=ySEDvBf1py517o32EDmhBE2KYnJjP7qKsflXFqgItZ0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WvYGtiCidsZq9TFOQu3JIocFW0zdQCyq06eWR34/82Q9rr+yllH1JmWlrOBVcLBOh
         i9NmOQ1uzKIddoLBYcm8LjLeUQ5NIZNbr/IcKIukJrB6POA/kzmZD2VjopS/uReBPc
         JUMfX5YIRAKGx4gWtcnwUq3I3l4paDDgosjesM6M=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3AAC860DAA;
        Mon,  1 Apr 2019 12:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554122959;
        bh=ySEDvBf1py517o32EDmhBE2KYnJjP7qKsflXFqgItZ0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kglmUE+iNPg0MMZbPGn49rwGJpcstsHPFnY+7jKAPkYTZMF9J3R7l+7UYD0Cn6m8v
         jvnVtSb/fd6RYFM8XTzWPEYT3HsGVcC3ikI0ts3WWTMO0fDChlwkabtLOkXn7A7OlZ
         LPPp1etSOStJX66G/dzBeYeUp2LkpY7JZDnu/s3c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3AAC860DAA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 02/12] drm/tegra: rgb: add missing of_node_put after
 of_device_is_available
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
 <1550928043-14889-3-git-send-email-Julia.Lawall@lip6.fr>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <d1555267-5ddd-fc31-ccee-769834728828@codeaurora.org>
Date:   Mon, 1 Apr 2019 18:19:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1550928043-14889-3-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/23/2019 6:50 PM, Julia Lawall wrote:
> Add an of_node_put when a tested device node is not available.
>
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
>
> // <smpl>
> @@
> identifier f;
> local idexpression e;
> expression x;
> @@
>
> e = f(...);
> ... when != of_node_put(e)
>      when != x = e
>      when != e = x
>      when any
> if (<+...of_device_is_available(e)...+>) {
>    ... when != of_node_put(e)
> (
>    return e;
> |
> + of_node_put(e);
>    return ...;
> )
> }
> // </smpl>
>
> Fixes: d8f4a9eda0067 ("drm: Add NVIDIA Tegra20 support")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
>
> ---
>   drivers/gpu/drm/tegra/rgb.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff -u -p a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
> --- a/drivers/gpu/drm/tegra/rgb.c
> +++ b/drivers/gpu/drm/tegra/rgb.c
> @@ -221,8 +221,10 @@ int tegra_dc_rgb_probe(struct tegra_dc *
>   	int err;
>   
>   	np = of_get_child_by_name(dc->dev->of_node, "rgb");
> -	if (!np || !of_device_is_available(np))
> +	if (!np || !of_device_is_available(np)) {
> +		of_node_put(np);
>   		return -ENODEV;
> +	}
>   
>   	rgb = devm_kzalloc(dc->dev, sizeof(*rgb), GFP_KERNEL);
>   	if (!rgb)
>

Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A1EC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F912067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgAILb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:31:57 -0500
Received: from foss.arm.com ([217.140.110.172]:57524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730701AbgAILbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:31:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04B3C328;
        Thu,  9 Jan 2020 03:31:53 -0800 (PST)
Received: from [10.1.194.52] (e112269-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B627A3F871;
        Thu,  9 Jan 2020 03:31:51 -0800 (PST)
Subject: Re: [PATCH RFT v1 2/3] drm/panfrost: call
 dev_pm_opp_of_remove_table() in all error-paths
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        tomeu.vizoso@collabora.com, robh@kernel.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, robin.murphy@arm.com
References: <20200107230626.885451-1-martin.blumenstingl@googlemail.com>
 <20200107230626.885451-3-martin.blumenstingl@googlemail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <394ef595-198a-3cd1-968e-2182098da92a@arm.com>
Date:   Thu, 9 Jan 2020 11:31:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200107230626.885451-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2020 23:06, Martin Blumenstingl wrote:
> If devfreq_recommended_opp() fails we need to undo
> dev_pm_opp_of_add_table() by calling dev_pm_opp_of_remove_table() (just
> like we do it in the other error-path below).
> 
> Fixes: f3ba91228e8e91 ("drm/panfrost: Add initial panfrost driver")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index 1471588763ce..170f6c8c9651 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -93,8 +93,10 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
>  	cur_freq = clk_get_rate(pfdev->clock);
>  
>  	opp = devfreq_recommended_opp(dev, &cur_freq, 0);
> -	if (IS_ERR(opp))
> +	if (IS_ERR(opp)) {
> +		dev_pm_opp_of_remove_table(dev);
>  		return PTR_ERR(opp);
> +	}
>  
>  	panfrost_devfreq_profile.initial_freq = cur_freq;
>  	dev_pm_opp_put(opp);
> 


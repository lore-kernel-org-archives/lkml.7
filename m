Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66903C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE972054F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfIYJZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:25:58 -0400
Received: from foss.arm.com ([217.140.110.172]:45080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729025AbfIYJZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:25:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DDBD1570;
        Wed, 25 Sep 2019 02:25:28 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9044C3F694;
        Wed, 25 Sep 2019 02:25:27 -0700 (PDT)
Subject: Re: [PATCH v2] drm/panfrost: Reduce the amount of logs on deferred
 probe
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190923171222.9256-1-krzk@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <a738d0d8-a1a9-5ffb-a858-0c3336339f46@arm.com>
Date:   Wed, 25 Sep 2019 10:25:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190923171222.9256-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2019 18:12, Krzysztof Kozlowski wrote:
> There is no point to print deferred probe (and its failures to get
> resources) as an error.  Also there is no need to print regulator errors
> twice.
> 
> In case of multiple probe tries this would pollute the dmesg.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Steven Price <steven.price@arm.com>

> 
> ---
> 
> Changes since v1:
> 1. Remove second error message from calling panfrost_regulator_init().
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 46b0b02e4289..287c6ba314d9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -95,7 +95,9 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
>  		pfdev->regulator = NULL;
>  		if (ret == -ENODEV)
>  			return 0;
> -		dev_err(pfdev->dev, "failed to get regulator: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(pfdev->dev, "failed to get regulator: %d\n",
> +				ret);
>  		return ret;
>  	}
>  
> @@ -133,10 +135,8 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>  	}
>  
>  	err = panfrost_regulator_init(pfdev);
> -	if (err) {
> -		dev_err(pfdev->dev, "regulator init failed %d\n", err);
> +	if (err)
>  		goto err_out0;
> -	}
>  
>  	err = panfrost_reset_init(pfdev);
>  	if (err) {
> 


Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47739C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF9D214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMAPs3R+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfLKHJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:09:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34837 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfLKHJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:09:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id s10so1052596plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 23:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mw1m7ZX6r1K+ymHABV5ItgLTm+mVsRBoTGueokW36qI=;
        b=rMAPs3R+esIjZdpo1ueKrYQgBgvGLiaqfirFkDuGPFWYiCfByGGNwnZUnQWgLPFMc8
         vukk1lfwIQaBOKsmvnunKBl9JKPpD+M0eAeD+VGnRiJ+4FAnQ1zqv+V/9pQ16qCm/VIC
         oc2lAMaLORTO9zNuIFhWLae5Bw/hVsFjbhkbqPVPV6BRb1yoDZrcdtkdhN363XazOI8k
         jpZgHxXNYUpb7gDR40Ck7+XdAAuMOEBiD4FztiC3jVmHtBiz7z/abxY+/+piYKN62VK+
         IKe77mGxcPuq/upvhQNpVamGZMsBYODTv8+jiKoV8jFc5pgrlhN4pyG5Rxxiw3T66nOd
         4n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mw1m7ZX6r1K+ymHABV5ItgLTm+mVsRBoTGueokW36qI=;
        b=VFE8WrYylyXQ7LmvC4mzoOj+LXDI3DCydhovTpK8qYFzVdjVJTNtbdW5TwNVtgXJ25
         DNfI9VTjloxDSWaiWMA+1CzTuNM4DX5KD3QYnemMTiE4GK51K/NJvuxzRCvXSqDj/cjO
         V8Q2ZdxCuGDFZ0LjDHyxCBeAJCJBbTwHzxdTec63I6DmtmUPki4CqJ9Uow8MRzaVRDLB
         2ZNRsCMLOVpsEKKc4tURGStEUjieXEmuJDHOmvQpKhQXAOhDN+Sfbicus2JNAYp/9Tw0
         AWKfyd5dV9fO2eKWNfqezXrMHVGf7m0sGyaTQcDY/P0ZFKbttiQvfOVxxjqvPbPkGIAJ
         Cqyg==
X-Gm-Message-State: APjAAAUJbJKrxvLis1YKcIArr/bc7vGjccurMEsZPYv57cpJ1mubulcE
        H45Li9prQLc98ZKHNczAvlHwjA==
X-Google-Smtp-Source: APXvYqzH7A/k3hcWyCu54U7eOMxE0oC51dR4FqfA0CwxE8VJnJ0z14NuV83kl328IojF27XTQhS5PA==
X-Received: by 2002:a17:90b:150:: with SMTP id em16mr1796042pjb.123.1576048151628;
        Tue, 10 Dec 2019 23:09:11 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o7sm1577093pfg.138.2019.12.10.23.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 23:09:10 -0800 (PST)
Date:   Tue, 10 Dec 2019 23:09:08 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, mka@chromium.org,
        swboyd@chromium.org, evgreen@chromium.org, dianders@chromium.org
Subject: Re: [PATCH 1/2] pinctrl: qcom: sc7180: Add GPIO wakeup interrupt map
Message-ID: <20191211070908.GG3143381@builder>
References: <1572419178-5750-1-git-send-email-mkshah@codeaurora.org>
 <1572419178-5750-2-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572419178-5750-2-git-send-email-mkshah@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30 Oct 00:06 PDT 2019, Maulik Shah wrote:

> GPIOs that can be configured as wakeup sources, have their
> interrupt lines routed to PDC interrupt controller.
> 
> Provide the interrupt map of the GPIO to its wakeup capable
> interrupt parent.
> 
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

@Linus, please take this patch through your tree and I'll take patch 2
through the arm tree.

Regards,
Bjorn

> ---
>  drivers/pinctrl/qcom/pinctrl-sc7180.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7180.c b/drivers/pinctrl/qcom/pinctrl-sc7180.c
> index 6399c8a..8a2b97c 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sc7180.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sc7180.c
> @@ -1097,6 +1097,22 @@ static const struct msm_pingroup sc7180_groups[] = {
>  	[126] = SDC_QDSD_PINGROUP(sdc2_data, 0x97b000, 9, 0),
>  };
>  
> +static const struct msm_gpio_wakeirq_map sc7180_pdc_map[] = {
> +	{0, 40}, {3, 50}, {4, 42}, {5, 70}, {6, 41}, {9, 35},
> +	{10, 80}, {11, 51}, {16, 20}, {21, 55}, {22, 90}, {23, 21},
> +	{24, 61}, {26, 52}, {28, 36}, {30, 100}, {31, 33}, {32, 81},
> +	{33, 62}, {34, 43}, {36, 91}, {37, 53}, {38, 63}, {39, 72},
> +	{41, 101}, {42, 7}, {43, 34}, {45, 73}, {47, 82}, {49, 17},
> +	{52, 109}, {53, 102}, {55, 92}, {56, 56}, {57, 57}, {58, 83},
> +	{59, 37}, {62, 110}, {63, 111}, {64, 74}, {65, 44}, {66, 93},
> +	{67, 58}, {68, 112}, {69, 32}, {70, 54}, {72, 59}, {73, 64},
> +	{74, 71}, {78, 31}, {82, 30}, {85, 103}, {86, 38}, {87, 39},
> +	{88, 45}, {89, 46}, {90, 47}, {91, 48}, {92, 60}, {93, 49},
> +	{94, 84}, {95, 94}, {98, 65}, {101, 66}, {104, 67}, {109, 104},
> +	{110, 68}, {113, 69}, {114, 113}, {115, 108}, {116, 121},
> +	{117, 114}, {118, 119},
> +};
> +
>  static const struct msm_pinctrl_soc_data sc7180_pinctrl = {
>  	.pins = sc7180_pins,
>  	.npins = ARRAY_SIZE(sc7180_pins),
> @@ -1107,6 +1123,8 @@ static const struct msm_pinctrl_soc_data sc7180_pinctrl = {
>  	.ngpios = 120,
>  	.tiles = sc7180_tiles,
>  	.ntiles = ARRAY_SIZE(sc7180_tiles),
> +	.wakeirq_map = sc7180_pdc_map,
> +	.nwakeirq_map = ARRAY_SIZE(sc7180_pdc_map),
>  };
>  
>  static int sc7180_pinctrl_probe(struct platform_device *pdev)
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

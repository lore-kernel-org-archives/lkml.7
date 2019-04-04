Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4C2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5442075D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tf9QUJcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDDDEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:04:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38209 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfDDDEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:04:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so470521pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MjaOzq+g/8LmN5rRFtYDMoQPtaWLs7MmGr4DGlt5QHY=;
        b=tf9QUJcI7/hNl0nSTKcV1FBXZyGK9kdOTu8mFstixruv/DIgotT685xPnC+TLv2r+I
         AuKak5BWiVSZ3pFUwZnvIEsCG/O2Wjx6Mv2E89yV6e90KiLgy4/+t/l2M4bQARfBL1zy
         Br1+exfzaS2q27BAhv+NJ/BWrp4qelwwcwZR4F2zVFKdiIDVhL8Po2vDOHwRZ/WtunNC
         z/XaFVIZBXuQ7+5ii1kTZY26Oc9aeI9j6hvWSW9S1BFsw5bqFDDL5wxYoiH2H+k5lQiY
         Eli8rVMmxb3PpmPZbvMpt+x3guM7/q7uJN9kVjmD21CB49Z/BFqesAEAk/OKAOPNvWq/
         KLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MjaOzq+g/8LmN5rRFtYDMoQPtaWLs7MmGr4DGlt5QHY=;
        b=e48pK2hYBcwa20/0w7dQUh3vzPpxKwx+Qmbz3hxPPDz7wtV83Mv5owMN3sJ+9ekjqA
         NDYOTHfdOUI/AHZIFgiXrwIiW7nl2CcuiZGfO6LY+JTi0Dc++9KWYbrcY6QjXva4cZyo
         RwLUjQWx1MyouTog2Tj1Z5sR72i5wgcbU8/kfiIIVtx67kWGG8hYLEJ3fDjTTXAvjsHN
         CrIMeFa8iEqNzt6A4JiEfRCuHepqV7Zs0/RCS/FlMLJ/BwLghvsY2snGw1Txxz7OCPOi
         pNZ/RxxBsgUTv+nS0baKvH21QteVrzH7jZG+HvzODmc0GmT2lV0DIVmfQEAu6RebydUP
         SI6A==
X-Gm-Message-State: APjAAAUjZbaCLUkbdo3uRmMbApKnZnVRCVs1JaDTZLVorly9X6pSGJw2
        4QvXHyLXInoZOEPObb36sbXdcQ==
X-Google-Smtp-Source: APXvYqydlipsje0ltlwwSAFrqNqr3xet0cWELQXfu2dH6vEhY2L3QRlTl4VrI3tDMs0LYTCxOzCAOQ==
X-Received: by 2002:a63:cc0a:: with SMTP id x10mr3180776pgf.179.1554347071316;
        Wed, 03 Apr 2019 20:04:31 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id m10sm19385880pgq.42.2019.04.03.20.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:04:30 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] dt-bindings: rockchip-thermal: Support the PX30
 SoC compatible
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
References: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
 <1554100985-11385-3-git-send-email-zhangqing@rock-chips.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <54ec9ef5-5295-4ea0-2d61-e386609cd993@linaro.org>
Date:   Thu, 4 Apr 2019 05:04:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554100985-11385-3-git-send-email-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 08:43, Elaine Zhang wrote:
> Add a new compatible for thermal founding on PX30 SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> index 43d744e5305e..c6aac9bcacf1 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> @@ -2,6 +2,7 @@
>  
>  Required properties:
>  - compatible : should be "rockchip,<name>-tsadc"
> +   "rockchip,px30-tsadc":   found on PX30 SoCs
>     "rockchip,rv1108-tsadc": found on RV1108 SoCs
>     "rockchip,rk3228-tsadc": found on RK3228 SoCs
>     "rockchip,rk3288-tsadc": found on RK3288 SoCs

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


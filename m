Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45624C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3422072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fepTE0HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfLQSV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:21:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40080 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfLQSV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:21:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so7994881pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 10:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qkSZEp2LsinKzRtMJteSGld5vsa6OFgl+t86XDP5eEU=;
        b=fepTE0HUb5CxTHXBrBY/0AvfYJMMrP1gat9cDME0DI3EuyUd6j3bN1pQjn/LoB/JX5
         FplU4s+GxX6xCAMCsdFs+w4PxLGsCGR+K+4ZqqrwKaj22+Inf0SCofnPXxQ81SobXr0V
         FYwTUqXsz/LtG/3rJsZz934fXOd2gNEXg8QK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qkSZEp2LsinKzRtMJteSGld5vsa6OFgl+t86XDP5eEU=;
        b=b1rKj5/EgYBRhcZ8zw8JAOw3o9x9L59OucKkho1tkueSPggen7nC+23ZZeXN7UVc9g
         gF/y736WNGWTeiTegknLghQzj9aU18U3NKQz7SAInUaoMXZShklkyHQKqNI/mdbUDkKj
         D/D7y6xpUE69pEjzHpqmBfytkhZY6ZL3i9qHiYofUY2+qRu+DEipa3FDCJoL24eFddQA
         clODf9bRvEDbPV1hERVxHzj1lhq9hJCnUMClL+JcxITRYxhktAzyeCtEXPVtmasGVjtj
         6uWGFloVkTsQxHdKZdph2b8423lX5MvcnqQPUmej7PFLEiaLCU4q5JOc+w51w3YIP8V5
         kXVw==
X-Gm-Message-State: APjAAAXbGtCkaopP/1yxriyGr5W5GBGxuVCMcbvkzNjKsgn6Oiy0Z+bp
        45wrGpgFunQ8Z8r06maPPKcy6Q==
X-Google-Smtp-Source: APXvYqxIHPlHk6frzgBdbcR7f5i/RUbydfwrku2XtLrzXZ5HNuusSXKMYkvaNahnG8jdCyClazvg1w==
X-Received: by 2002:a63:a555:: with SMTP id r21mr23297365pgu.158.1576606916432;
        Tue, 17 Dec 2019 10:21:56 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 73sm27711835pgc.13.2019.12.17.10.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 10:21:55 -0800 (PST)
Date:   Tue, 17 Dec 2019 10:21:54 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Dikshita Agarwal <dikshita@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
Subject: Re: [PATCH] arm64: dts: sc7180: Enable video node
Message-ID: <20191217182154.GU228856@google.com>
References: <1576569218-24817-1-git-send-email-dikshita@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1576569218-24817-1-git-send-email-dikshita@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Dec 17, 2019 at 01:23:38PM +0530, Dikshita Agarwal wrote:
> This is a preparation gerrit to enable video node for sc7180.

gerrit is a code review tool, please change to something like
"Add venus video codec node for sc7180"

> This change depends on patch series Venus new features.

Notes like this should not be part of the commit message, but put
below '---'. It would also be good to include a link to the series,
I suppose it's
https://patchwork.kernel.org/project/linux-arm-msm/list/?series=213439

> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 52a5861..ccf9ef5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1297,6 +1297,34 @@
>  
>  			#freq-domain-cells = <1>;
>  		};
> +
> +		venus: video-codec@aa00000 {
> +			compatible = "qcom,sc7180-venus";

This compatible string is not listed in the bindings
(Documentation/devicetree/bindings/media/qcom,venus.txt), nor
in the driver.


Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A2EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAC920856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y9kZMsLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfH1AfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 20:35:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46436 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1AfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 20:35:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id o3so125506plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 17:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=p/xKMf91NHzy0WlAWs4lcoTEVmOFdZZtOJqmJt+BEVM=;
        b=Y9kZMsLAt6r2839OEjhuxLXzBmxLN6LJT+/TCeQYDAmWYJlIpefK9p5SsrXSbQLDLz
         Fj4ec63JhGiLE4Z2UcQVaQWDe2/HTMLvtaNr/rf/b8v9Nx7k6Fs7jarGwg3uVdjGgQJB
         grytQU3H7FCne85uR/9PHWd7v5/FZKEaOhpN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=p/xKMf91NHzy0WlAWs4lcoTEVmOFdZZtOJqmJt+BEVM=;
        b=ZtITZbYJEadNq1Q5qcgorkTeyxl/8JnNq3Au6U5VpCdK7LyAP0LrL3Sd0/mEmQ45rw
         zSTTf2/BpExcREHGLlEQ6auJP4bthZ+abuq5mpWM5mUixrUtzn4cNoHwxMlGIqP+Gyyu
         WU8Ss2502FGCPMLcDCyYOv/O5QxM5jXSBPFDmELSS6RwlMcxYOQ/VTOU+hNkA9i9EV1e
         dExqwnVPuqntLX0EHw4+L9J9bhUQqSikmG5fUp9jPKx8fwpuz65OZ6c9VN7jwGd2Og/r
         azUyBxcH0njqU7QuZ44/p8XmT6jBF/74pr+2eVBGF8dp1TrfpE+QKGQqtSYB9YZe61Yg
         JnLA==
X-Gm-Message-State: APjAAAWBjAoMHOb9F/w+71rmfD/knbUVkb0T88ND/mTmTiMpF5ktbcwP
        fv6bwYePcgzwEX1TF1+88NvbBg==
X-Google-Smtp-Source: APXvYqzF3wUk+u0gCKoeJlLnPRZ9wzng+YxN5ZdpbBQ1/sRdvIj8II0FPhwsbXO9ltpir6S3A3JyQQ==
X-Received: by 2002:a17:902:426:: with SMTP id 35mr1692923ple.192.1566952522894;
        Tue, 27 Aug 2019 17:35:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s7sm515296pfb.138.2019.08.27.17.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 17:35:22 -0700 (PDT)
Message-ID: <5d65cc4a.1c69fb81.376b6.2486@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1cb5ab682bce53d32f3a73b5b29cc6c3e800bfcc.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org> <1cb5ab682bce53d32f3a73b5b29cc6c3e800bfcc.1566907161.git.amit.kucheria@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: Re: [PATCH v2 09/15] arm64: dts: msm8996: thermal: Add interrupt support
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, masneyb@onstation.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 27 Aug 2019 17:35:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-08-27 05:14:05)
> Register upper-lower interrupts for each of the two tsens controllers.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 60 ++++++++++++++-------------
>  1 file changed, 32 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/=
qcom/msm8996.dtsi
> index 96c0a481f454e..bb763b362c162 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -175,8 +175,8 @@
> =20
>         thermal-zones {
>                 cpu0-thermal {
> -                       polling-delay-passive =3D <250>;
> -                       polling-delay =3D <1000>;
> +                       polling-delay-passive =3D <0>;
> +                       polling-delay =3D <0>;

Is it really necessary to change the configuration here to be 0 instead
of some number? Why can't we detect that there's an interrupt and then
ignore these properties?


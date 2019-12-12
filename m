Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5739BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D6B214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RubV1aPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbfLLV4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:56:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34637 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbfLLV4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:56:36 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so162079pln.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 13:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:cc:to:subject:user-agent:date;
        bh=Y/oDdJ9vaWTmHiBd0BBwMYbpseDwIlnPRcsdk/YIhLw=;
        b=RubV1aPPV5MwZZB/p/A8BudPeStmQcqRDXmYeQ8QKYBpnAMHf0K7SV3hzoDQ/r6oZ+
         IbedmlCILDuARAk4qRlr21vSCi9GxzU/l4/lctCO8uVEY2XQFbV0NQh/yEe87bK5mSQm
         ysYWhI1tp91fz7Jkq4CMTDU9khX/1ZTUZ4ROE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:cc:to:subject
         :user-agent:date;
        bh=Y/oDdJ9vaWTmHiBd0BBwMYbpseDwIlnPRcsdk/YIhLw=;
        b=b0+zMAjAQede/kOLo23pZftRl3vOkQOeEVRoN2hVw8AaaI+juNNnd3i0ytIwS1IKsn
         /UV7SNlWN+Vc376+NbMra7AQeOLk43xsngkIripeUvLpVjqEMGkCXyERwDR81FPAg0XC
         saw/1UF8ZxqThgao1eWRdPfCmMVtR7z/LD73fd12k6PN0tqzbfAbxO/L+bXxhqx6tIeA
         xb9Q/1v1fj0FvKrckvwkk4ynLAwuBt7m/+yfdznPQ+/Iq+KAToAL/YNKKEsm7nD2VKrC
         u5cc/Z9JEBqWSS0fUO36+sg7Y4H/2/49yNLovAsRCoxDh2I1II2ErN3c3ChROq/gzwFN
         6Ipw==
X-Gm-Message-State: APjAAAWH8ytygIbtefhVJsfSzlALXhLeg2dETl0e+hcpQIL7ZTBEtQof
        UzPxm4vZ+D1H4RaCirFF8L275w==
X-Google-Smtp-Source: APXvYqz81olZWLtTn67DezSPYTgvw0RojAmwLUKcy3D/XaEdu4BjmslxBAyek/pCmP7dI15yJs9fDg==
X-Received: by 2002:a17:902:8ecc:: with SMTP id x12mr11900974plo.286.1576187796085;
        Thu, 12 Dec 2019 13:56:36 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p16sm7888003pgi.50.2019.12.12.13.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:56:35 -0800 (PST)
Message-ID: <5df2b793.1c69fb81.2d816.4046@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191212113540.3.Ia530e4065ca81f55ac8f89a400f6a0a084ff6712@changeid>
References: <20191212193544.80640-1-dianders@chromium.org> <20191212113540.3.Ia530e4065ca81f55ac8f89a400f6a0a084ff6712@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/7] arm64: dts: qcom: sc7180: Add "#clock-cells" property to usb_1_ssphy
User-Agent: alot/0.8.1
Date:   Thu, 12 Dec 2019 13:56:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-12-12 11:35:39)
> Running "dtbs_check" yells:
>   '#clock-cells' is a dependency of 'clock-output-names'
>=20
> ...and sure enough the bindings say we should have "#clock-cells".
> Add it.
>=20
> Fixes: 0b766e7fe5a2 ("arm64: dts: qcom: sc7180: Add USB related nodes")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Good catch!

Reviewed-by: Stephen Boyd <swboyd@chromium.org>


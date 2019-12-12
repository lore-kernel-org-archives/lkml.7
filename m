Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002A0C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62FA214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Me63d7qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfLLV4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:56:16 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37103 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730891AbfLLV4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:56:15 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep17so115573pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 13:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:cc:to:subject:user-agent:date;
        bh=1+ZIvHvmCyKt057OWZyz3mdVfLxXDjQp5yfeuJKgfxs=;
        b=Me63d7qnsea9LVO3h8EfbZKwC1ALHFkhhrwK/c7UBPS7XcyuMkjBCVB4KwX5Gx1SWx
         KEEZXAyj1c+JqD5Z/DvQwjzNgW1jYIGzgqOoIlCkJBCXv2MP/Ud2/Rl6JNHNByjftP45
         Lh/cMvVWcwSvbo85VV4bk/jYp9ec8bMGVAFiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:cc:to:subject
         :user-agent:date;
        bh=1+ZIvHvmCyKt057OWZyz3mdVfLxXDjQp5yfeuJKgfxs=;
        b=Zis/xgssy+DhiVlv/BezSV+r8H8t0zpAjL+CbGubmpxRWmAd96+erA7HvDiR+aSJ+W
         8ScEQwkFK4mG/V8ZNPPIG7mZQOQtrC1B04+LDrgB8pwD0vZg07wtPzldguN7pi0TueuF
         ZGOKTyvrNMDUI0g23n51Qj2KteppoGfv+xc3U7wovPn00z8RUmsifgZl+s/2LA3gltNH
         rwx42IiVKRmBMr3KAYEHinuvNEnuyRQfDJN/neab4Y2kvSW9dpeSAiVFj87eKT2Knn5z
         ndKMCc12JidE/7sOLbIuULizPA/7glpkbyE9FqyWD96tZKnegXcC03cx6ciXrMfb+yB2
         wQ7w==
X-Gm-Message-State: APjAAAVWu8K1ZcyTPuHGvfJmS70PezKQfTMHtpZynLBMGdDtZGcoXkyz
        E2ggFK2RtFgA/m1VYhet8+tg8g==
X-Google-Smtp-Source: APXvYqw70mhIdtNKRnTb5Z7HcuPx1N9jKpPJisSnELw9YFnYK2+lnPb/2WXEkI0va3N7MBPby2PwFg==
X-Received: by 2002:a17:902:8ecc:: with SMTP id x12mr11899532plo.286.1576187774943;
        Thu, 12 Dec 2019 13:56:14 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d26sm7624486pgv.66.2019.12.12.13.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 13:56:14 -0800 (PST)
Message-ID: <5df2b77e.1c69fb81.15e56.4084@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191212113540.2.Ibad7d3b0bea02957e89047942c61cc6c0aa61715@changeid>
References: <20191212193544.80640-1-dianders@chromium.org> <20191212113540.2.Ibad7d3b0bea02957e89047942c61cc6c0aa61715@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, mka@chromium.org,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/7] arm64: dts: qcom: sc7180: Rename gic-its node to msi-controller
User-Agent: alot/0.8.1
Date:   Thu, 12 Dec 2019 13:56:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-12-12 11:35:38)
> Running `make dtbs_check` yells:
>=20
>   arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml: interrupt-controller@17a00=
000: gic-its@17a40000: False schema
>=20
> From "arm,gic-v3.yaml" we can grok that this is explained by the
> comment "msi-controller is preferred".  Switch to the preferred name
> so that dtbs_check stops yelling.
>=20
> Fixes: 90db71e48070 ("arm64: dts: sc7180: Add minimal dts/dtsi files for =
SC7180 soc")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

This problem is also in sdm845 and probably others.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>


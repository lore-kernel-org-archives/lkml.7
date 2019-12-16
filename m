Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F356C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153C7206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fD2NoFnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfLPTfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:35:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43099 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfLPTfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:35:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id p27so4922495pli.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 11:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc:user-agent:date;
        bh=zyf5oqIBC4otO0TD/aAKD2B0cXiPBUfjLdMtf1EP18U=;
        b=fD2NoFnjxGFSTYc9JB2rdjm5W2cJCsvuN331lqeALXlrVqI9Kab6FoixmzhZsPnV4F
         0oLidyk97L8Y/gBuyeKt4h+/IdJbFP1Z8xAC8SFHRZsBViH+ShyzlVyS2hwIf/7YWFNM
         qIh1bQRzBxFIMFaEHGZcuHBFxjH4BjGrBSqTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc
         :user-agent:date;
        bh=zyf5oqIBC4otO0TD/aAKD2B0cXiPBUfjLdMtf1EP18U=;
        b=CHRHyMIK+7V7LV4czdFn4WVA1FlHgyf/vMHG9LQ/69W45WGCCux2KkjjyJlSjJkZsL
         Z1H31zqJwUxrcDBpXC600AKWisFfEXZd5kI2/LU/2wOuKGS+wNvS0nEgiYIvGaIScsHW
         1Xh4Wa8pmS5a1cARGefcintl8NhxtQmEhNYII0T9jf6dI26SjjGxWn+uKsu74P197CgW
         ibrzhZ4fgX9X4KW6oK+Qr5elbRrQWm3D4eJGJm9Iff6TtvEbiYOBa9qne0R4XaBZs1vH
         9b51V7BL2OTaDhDC3+WtqctuKp/J90iLZR+XXqLD2WZM1Y7fTHDFs9WtPht+CivcT4oa
         IICA==
X-Gm-Message-State: APjAAAVqo4OYmSWgBSutY52PDIv8MvYU8D9D7ZqzaplzLJa8lcAcAa9I
        A21Vf4ZYsfywe2KoDtYaLEeOqIMs8DcWbQ==
X-Google-Smtp-Source: APXvYqyviP4AYpq091Bvfn20j4LGQVIn39RgQpNuNLHQhQ9Q2u7Np+YFHk/5q8zyKt58XN+P7TaNAQ==
X-Received: by 2002:a17:902:7c13:: with SMTP id x19mr18277088pll.236.1576524920196;
        Mon, 16 Dec 2019 11:35:20 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i4sm260898pjw.28.2019.12.16.11.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 11:35:19 -0800 (PST)
Message-ID: <5df7dc77.1c69fb81.9e37f.16a5@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191216115531.17573-2-sibis@codeaurora.org>
References: <20191216115531.17573-1-sibis@codeaurora.org> <20191216115531.17573-2-sibis@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: rpmpd: Convert rpmpd bindings to yaml
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        rnayak@codeaurora.org, robh+dt@kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Mon, 16 Dec 2019 11:35:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2019-12-16 03:55:30)
> Convert RPM/RPMH power-domain bindings to yaml.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

One nitpick below!

> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Do=
cumentation/devicetree/bindings/power/qcom,rpmpd.yaml
> new file mode 100644
> index 0000000000000..4aebf024e4427
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/qcom,rpmpd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPM/RPMh Power domains
> +
> +maintainers:
> +  - Rajendra Nayak <rnayak@codeaurora.org>
> +
> +description:
> +  For RPM/RPMh Power domains, we communicate a performance state to RPM/=
RPMh
> +  which then translates it into a corresponding voltage on a rail

Add a full-stop here to make it a true sentence?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,msm8976-rpmpd
> +      - qcom,msm8996-rpmpd
> +      - qcom,msm8998-rpmpd
> +      - qcom,qcs404-rpmpd
> +      - qcom,sc7180-rpmhpd
> +      - qcom,sdm845-rpmhpd
> +      - qcom,sm8150-rpmhpd
> +

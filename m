Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F634C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177F82240A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ybxac2pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfKSSu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:50:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35683 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfKSSu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:50:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id k32so6082809pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 10:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=h3SuHWJ4z/KaTwFaWseZogIbcFeN0SoE6l1nIp4DGz8=;
        b=Ybxac2plgQ4VLa1bcLRooTRMs4gS/2rpYOUfte7cqw4WfXcLVlygbrLWZE4szcMrRY
         nupnHxN5/sf0hkxBdlRUnm7kMWfZnSSjmYkAX11/J2erMxPewefLZ4a+xxPAhK0yjLrf
         1UleWcAFqV2b5RCbgbIKLsa0g0OljDOJqjeQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=h3SuHWJ4z/KaTwFaWseZogIbcFeN0SoE6l1nIp4DGz8=;
        b=eIPbApATK+oTt+26Xd/evH+3ajz7wWHYJxhMWSKxh+quaAIf0oE6/U92nmTKtvWXER
         PfnyR9F8Dqw2Kyuj1FEO2/51veM1Lhr3QDbmwr7wX5B7EWBILokdKYHw3Uj/qcb5thqG
         6zWInPLQ2ZH5mbmBSoANKUwvlvqCtqfY+wMU7uVpvRS4GNWnU6NvIYpI2jRMQbkiQ2jo
         ipsiAMgFnU4Wi2A3IF1d44cDw3uoZ5ru1UcQ5/hCdJaoVwUUPxmgmP5Zvv6ZzuYYw4/D
         7bNW+PPlPBqdez4AC83BVN79uJdce8bbSnmqGlkc6dZCNOX9YUrjC6DPnbt998Vg6gzX
         DYRQ==
X-Gm-Message-State: APjAAAX/haaWZTwa3+hHQWvLGdoUKkUwDFh8KD+Sbn89q2QVhp2+163X
        bl6YtUy81uWMmt7i6j/XqkNQEQ==
X-Google-Smtp-Source: APXvYqyt4fFZBx9WmiKhI9FW3nECOBxo8vbsKkGfI9j6QIB1BmtDWvG7MajWu0meAk9l8J/+5x+1+A==
X-Received: by 2002:a63:4519:: with SMTP id s25mr7199212pga.240.1574189455042;
        Tue, 19 Nov 2019 10:50:55 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b18sm15722571pgh.60.2019.11.19.10.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 10:50:54 -0800 (PST)
Message-ID: <5dd4398e.1c69fb81.fb48b.b3bd@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0101016e7f99aa17-22b1062e-9922-40e4-ae7e-8b91210bb12c-000000@us-west-2.amazonses.com>
References: <20191118173944.27043-1-sibis@codeaurora.org> <0101016e7f99aa17-22b1062e-9922-40e4-ae7e-8b91210bb12c-000000@us-west-2.amazonses.com>
Subject: Re: [PATCH 2/6] dt-bindings: power: Add rpmh power-domain bindings for SM8150
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        rnayak@codeaurora.org, robh+dt@kernel.org, ulf.hansson@linaro.org
User-Agent: alot/0.8.1
Date:   Tue, 19 Nov 2019 10:50:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2019-11-18 09:40:07)
> Add RPMH power-domain bindings for the SM8150 family of SoCs.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>  .../devicetree/bindings/power/qcom,rpmpd.txt       |  1 +
>  include/dt-bindings/power/qcom-rpmpd.h             | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Doc=
umentation/devicetree/bindings/power/qcom,rpmpd.txt
> index bc75bf49cdaea..f3bbaa4aef297 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> @@ -10,6 +10,7 @@ Required Properties:
>         * qcom,msm8998-rpmpd: RPM Power domain for the msm8998 family of =
SoC
>         * qcom,qcs404-rpmpd: RPM Power domain for the qcs404 family of SoC
>         * qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of =
SoC
> +       * qcom,sm8150-rpmhpd: RPMh Power domain for the sm8150 family of =
SoC

Can you convert this binding to YAML? Would help us validate DTS files
in the future.

>   - #power-domain-cells: number of cells in Power domain specifier
>         must be 1.
>   - operating-points-v2: Phandle to the OPP table for the Power domain.

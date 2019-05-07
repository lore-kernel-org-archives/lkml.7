Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1888C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DE0204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ctTKjgV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfEGI6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:58:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43786 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfEGI6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:58:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id r3so8217462qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4j8vIu2wMMo6UT4+kjIlyoObNO3WTbPl4WCu+/nidM=;
        b=ctTKjgV+zvGS9Gu1Me48lcXJj5NqtLOU2qUZfsGcBDnwCUXDVEdjcq3QLVxixOlQSa
         xDxe0j3pLX2v9kUw9PZ+P910lyFYWbJbJkIgwu+caLtqZ49bbGbcdHpr8qyqbT9Oy5rV
         ZfEOk3QiUo7CLg9q/N5n5gysIRNWmEcCZxpLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4j8vIu2wMMo6UT4+kjIlyoObNO3WTbPl4WCu+/nidM=;
        b=mFqR7MDnMg//1shFsLxgcutmcJtWRaTjiso/w5k1YeSLmejOd/M812KiB5dlWcoapB
         y10ZdEjhvc6ZTTC8DGK4Gbq3OAT6QwE9boPIo4EHY9myzMQddzdooLlpJvNnY3kniJAm
         6VXHNQ8Xlp49jLsSJR3X1Nmc+81Meuln3gEz4jTSJZ7msHDcp1Jtgigzu6+/UzqWI41K
         1mJhiQDfuZRnEjTwbwhTxPpPoCNx7dc2BBIEajT2WEeHxdX1X7Apad0T2Os6oBHGwwtp
         bSXmB+/R2zSNz1XeXofZAPUJmcMufrds+x3z/7d4rhmi/hGS3go+LJYfmwMIo+gsKzNH
         Vcvg==
X-Gm-Message-State: APjAAAWijAxL0ITIorbJtkPujZm8qP0wCOBdhY9JHdf+QA3HI/5/edh/
        qdM5U78YQAVMGE0nKznUKqSnCYKhFLkwntm8UPq+bQ==
X-Google-Smtp-Source: APXvYqwh0Jp85DeTO2qBWgQsuEyExRB1yb+3NzYLBg178fUUMnHKuPVE2ZV5rt3C9hW9+lUMAdlXGFQiVeB/ea6x5qw=
X-Received: by 2002:ac8:3fe3:: with SMTP id v32mr24484207qtk.307.1557219524087;
 Tue, 07 May 2019 01:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com> <1556793795-25204-6-git-send-email-michael.kao@mediatek.com>
In-Reply-To: <1556793795-25204-6-git-send-email-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 7 May 2019 16:58:18 +0800
Message-ID: <CAJMQK-hKoK1hfK+XJuyExxp3rDWY9py6j3_jwEMfVeJcYYM7XA@mail.gmail.com>
Subject: Re: [PATCH 5/8] arm64: dts: mt8183: Increase polling frequency for
 CPU thermal zone
To:     "michael.kao" <michael.kao@mediatek.com>
Cc:     fan.chen@mediatek.com, jamesjj.liao@mediatek.com,
        dawei.chien@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrote:
>
> From: Matthias Kaehlcke <mka@chromium.org>
>
> Evaluate the thermal zone every 500ms while not cooling and every
> 100ms when passive cooling is performed.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 0b3294b..be879ac 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -370,8 +370,8 @@
>
>                 thermal-zones {
>                         cpu_thermal: cpu_thermal {
> -                               polling-delay-passive = <1000>;
> -                               polling-delay = <1000>;
> +                               polling-delay-passive = <100>;
> +                               polling-delay = <500>;
>
>                                 thermal-sensors = <&thermal 0>;
>                                 sustainable-power = <1500>;

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

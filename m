Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE901CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47AC2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bc/L5ksm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390572AbfJ2Ql0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:41:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43093 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390545AbfJ2QlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:41:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id l24so9945125pgh.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:subject:to:cc:user-agent:date;
        bh=LNxWM58ZrMRqhvJjmqyuwJjKcprn+LP2a5RPcX5BSTQ=;
        b=Bc/L5ksmmwMT+AV2TqfmTo8usjNX1/zYqzyxZaZ8rElettpFJdxKI9qyzPJ+qM+WN0
         IbohgiOJ2hj++SJH9te7RKZVz8DTuLaenbmG1sSDyeD/9tWJJkBoAxbJjK/+W0eZ8mMK
         StMHUCzc7rfK6ie/FdDKRDpgPUf7cyyF7NPso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:subject:to:cc
         :user-agent:date;
        bh=LNxWM58ZrMRqhvJjmqyuwJjKcprn+LP2a5RPcX5BSTQ=;
        b=Ot+UTCPAONtYVNe67uE0BqJZOfBjNDh7ud9iUmcnwK/3gHYWaXUmOlcahFhLI0xq59
         geVoCJr68GIlgd3SUXdxBpGfGuO7yvt4WVQYXf7jZAapEQ8MRFWZ82y98A2JjNXcP5xW
         ZOvUw4DtnimbbH6gl4N7Qn8jbRyOF2yDC7kPy77Eh+BXJb21QOk1DESF/BuRye/F5dIg
         RsyogqKgH+czyt9ANobQv8VChVGifHHByQZs+gxMVKay9PhHcAzkCT00B4h1Vs0jPQ26
         XgtTjkIYPZesViBC85rvBp8LbJDqOVaQoSoeuJzjaTbosufACxewUq1GG13MNbjD7djK
         Qv6g==
X-Gm-Message-State: APjAAAWN3ITPTZBOogfAO3oZnNV1EQ50oknmthkj96rWkCHMdDHkoXwS
        SeGvB4PLPhhsos2rKXpDTUBi3g==
X-Google-Smtp-Source: APXvYqy1MoKp6KuXydX7v5P5VKqYMVnerZ/CHnsraqUoZ+67iYNsXlmTCHa8d28nPUw+lzw6EGcJcQ==
X-Received: by 2002:a62:58c3:: with SMTP id m186mr28080725pfb.147.1572367282720;
        Tue, 29 Oct 2019 09:41:22 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y36sm13376512pgk.66.2019.10.29.09.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:41:21 -0700 (PDT)
Message-ID: <5db86bb1.1c69fb81.dc254.ec0b@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191023090219.15603-8-rnayak@codeaurora.org>
References: <20191023090219.15603-1-rnayak@codeaurora.org> <20191023090219.15603-8-rnayak@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v3 07/11] arm64: dts: qcom: sc7180: Add SPMI PMIC arbiter device
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Tue, 29 Oct 2019 09:41:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-10-23 02:02:15)
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/q=
com/sc7180.dtsi
> index 04808a07d7da..6584ac6e6c7b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -224,6 +224,25 @@
>                         };
>                 };
> =20
> +               spmi_bus: spmi@c440000 {
> +                       compatible =3D "qcom,spmi-pmic-arb";
> +                       reg =3D <0 0xc440000 0 0x1100>,

Please pad out the registers to 8 numbers. See sdm845.

> +                             <0 0xc600000 0 0x2000000>,
> +                             <0 0xe600000 0 0x100000>,
> +                             <0 0xe700000 0 0xa0000>,
> +                             <0 0xc40a000 0 0x26000>;
> +                       reg-names =3D "core", "chnls", "obsrvr", "intr", =
"cnfg";
> +                       interrupt-names =3D "periph_irq";
> +                       interrupts-extended =3D <&pdc 1 IRQ_TYPE_LEVEL_HI=
GH>;

This is different than sdm845. I guess pdc is working?

> +                       qcom,ee =3D <0>;
> +                       qcom,channel =3D <0>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <4>;
> +                       cell-index =3D <0>;
> +               };
> +

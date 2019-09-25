Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E2BC4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C153F21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TqcyhXTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437079AbfIYO3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:29:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38809 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407235AbfIYO3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:29:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id l11so7218619wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=01Kh5AUUblqFWi3ZNkHBI22OYBLpt/UY9FlNGz+JAZo=;
        b=TqcyhXTeBpjPbXHmATEWSbSMssHKlceadH9bNBK2rEENOV8S59lTjB19hASMn9u81X
         Uy53gHROuQETn6BSE3uKBX6Cc2RA0fAdrZx5yXDdezp2nLFGbasbMavfwf7uHfWF7j6G
         0cvSzxdT58fjITWfyWuC2b8+l6b0lt4N3OMerdFAbiWKZa+NjbD9T3kKONiLTpNnNIWl
         fLlOG5d9ez5gNmTciSj0ziVc3cr7T/pZh2Vv/fOd4E8DREYe7DDPddyw2hzLHKNWrafD
         nQva2H+kPP1F+lSYq5sQfjH+uHcxz0TfCRYNQH4UhPQ0AE81x2sJLZom1dCejyBfP0j/
         2yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=01Kh5AUUblqFWi3ZNkHBI22OYBLpt/UY9FlNGz+JAZo=;
        b=bcpsNh8d3M13DpaDN8gSmRwztWRs0H/AKLZ0NtBbjytoprQCm42nVR5ObvUo2cD/BD
         N0J0jA6KWd+A/ow5VtQKRXWIf0uts2JfkPk6e9pFh9jLJsEGSxml2PMhHdW3UP8xA4Gm
         HkBHG0ORd4P9rtnP/7r2PRadfW4cF1kY2+bXM37edkzf7hO4X9QSAFdCmDzW6SgsHPAc
         eBB6L3O0pCQ0qMudhCaVuGVSpkVnBjwf24pt3+AFGR5mLy3b5gi5kaaHdIeJ4W0wHKN/
         SRIFJ13opou2+r6H6TvpsJuI3u8NyQT7569q4pi+y9GpHBIhFDh1xLog5HD/AFACQ8Hp
         GbUw==
X-Gm-Message-State: APjAAAWkw1zhyf7n4ocR6pTMXQpVpyrrE71fPQWielIYPuXUqoeRYSHS
        q099qSg37DjFJrsqFcbUIFBrYA==
X-Google-Smtp-Source: APXvYqw6ta3lyXW5QXoDceAQYURMJqtEe8XE0Kee6BcYwayFrIM0iklE0ITqg8crPV7uy5OUMdOb5Q==
X-Received: by 2002:a5d:6812:: with SMTP id w18mr9321474wru.250.1569421784891;
        Wed, 25 Sep 2019 07:29:44 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i5sm3814592wmd.21.2019.09.25.07.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 07:29:44 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jian Hu <jian.hu@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: meson: add A1 clock controller bindings
In-Reply-To: <1569411888-98116-2-git-send-email-jian.hu@amlogic.com>
References: <1569411888-98116-1-git-send-email-jian.hu@amlogic.com> <1569411888-98116-2-git-send-email-jian.hu@amlogic.com>
Date:   Wed, 25 Sep 2019 16:29:43 +0200
Message-ID: <1j4l10motk.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25 Sep 2019 at 19:44, Jian Hu <jian.hu@amlogic.com> wrote:

In addition to the comment expressed by Stephen on patch 2

> Add the documentation to support Amlogic A1 clock driver,
> and add A1 clock controller bindings.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../devicetree/bindings/clock/amlogic,a1-clkc.yaml |  65 +++++++++++++
>  include/dt-bindings/clock/a1-clkc.h                | 102 +++++++++++++++++++++
>  2 files changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-clkc.h
>
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> new file mode 100644
> index 0000000..f012eb2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-clkc.yaml
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
> + */
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/amlogic,a1-clkc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson A1 Clock Control Unit Device Tree Bindings
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Jian Hu <jian.hu@jian.hu.com>
> +
> +properties:
> +  compatible:
> +    - enum:
> +        - amlogic,a1-clkc
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 3
> +    items:
> +      - description: peripheral registers
> +      - description: cpu registers
> +      - description: pll registers
> +
> +  reg-names:
> +    items:
> +      - const: peripheral
> +      - const: pll
> +      - const: cpu
> +
> +  clocks:
> +    maxItems: 1
> +    items:
> +      - description: Input Oscillator (usually at 24MHz)
> +
> +  clock-names:
> +    maxItems: 1
> +    items:
> +      - const: xtal
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - "#clock-cells"
> +
> +examples:
> +  - |
> +    clkc: clock-controller {
> +        compatible = "amlogic,a1-clkc";
> +        reg = <0x0 0xfe000800 0x0 0x100>,
> +              <0x0 0xfe007c00 0x0 0x21c>,
> +              <0x0 0xfd000080 0x0 0x20>;
> +        reg-names = "peripheral", "pll", "cpu";

I'm sorry but I don't agree with this. You are trying to regroup several
controllers into one with this, and it is not OK

By the looks of it there are 3 different controllers, including one you
did not implement in the driver.

> +        clocks = <&xtal;
> +        clock-names = "xtal";
> +        #clock-cells = <1>;

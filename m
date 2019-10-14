Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D05ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B31C21848
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571074744;
	bh=BeOfE2wVeIOi74vfC607tsEF/haJCUIZE3jwPOevmBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HhYSb8xD+DbbR9Q5jy3oe6S4yzDs2uNzsU9wK+NJXYevs8FmCgWC533MHuSQ/AcZ0
	 sMJQcs7jrRK+L7Hp08rvhYDJY4P1vKBbeMOnCEBGGvyXL/pD5BtxlTkrlRMxoZS/ux
	 A3Zhf1IkcEJQkuyGZbjmOxTLBv1mlgbkEsE4H7C0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbfJNRjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:39:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46475 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbfJNRjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:39:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id k25so14405212oiw.13;
        Mon, 14 Oct 2019 10:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WreGjKNejizDLrH2DJ0lAxbkyZ+jrNSgTeuzICqx9Z4=;
        b=Ps+BXYSncxtbGCQ/GHAeLojTLAhVtin33gIyD+TrRbs37kMSMo2NurG7cCWFw79dKM
         R4uIkUu+wSZofGcOljMq78mPQ0C15PEh6rK/0LJaXHxagVn+Paw9+5T0/ybMBcc6WhXM
         9ekXSjbiCNLoHLQUxvb7FsWMQ3h1jG4i7njjq1U3+V6ccixmwXjKRn+Bq/3kHrnvOdcn
         bsMVCQ6EPRndVRmW/PaBWjRWeJENPPU6NIAcOsYogRO5myerD0RSlWs01Mx11aLQ1Jws
         p5e86swtgGsFdNXfmfHhwg/zI4eUgzGOsdxv0nv00K6DIPpIzGEy6m5845COWIxhpbiu
         3Ghg==
X-Gm-Message-State: APjAAAURg4u9TZjnm+g91+opGlQ9xE84rw4vRTj1DS4c1ztlOmmnC+QP
        JZITTjVPtJDZ85xzdqjMPw==
X-Google-Smtp-Source: APXvYqwdJv5xXQGlATBAH3wK/IT/WCXKxGy8SwE92PGPwmCT2Qv3DTyiAPc8LtnULM3NF1dE3Xu3gQ==
X-Received: by 2002:aca:da41:: with SMTP id r62mr24442959oig.47.1571074742140;
        Mon, 14 Oct 2019 10:39:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u141sm5690928oie.40.2019.10.14.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:39:01 -0700 (PDT)
Date:   Mon, 14 Oct 2019 12:39:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH RESEND v2 1/4] dt-bindings: power: add Amlogic secure
 power domains bindings
Message-ID: <20191014173900.GA6886@bogus>
References: <1570695678-42623-1-git-send-email-jianxin.pan@amlogic.com>
 <1570695678-42623-2-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570695678-42623-2-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 04:21:15AM -0400, Jianxin Pan wrote:
> Add the bindings for the Amlogic Secure power domains, controlling the
> secure power domains.
> 
> The bindings targets the Amlogic A1 and C1 compatible SoCs, in which the
> power domain registers are in secure world.
> 
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     | 42 ++++++++++++++++++++++
>  include/dt-bindings/power/meson-a1-power.h         | 32 +++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>  create mode 100644 include/dt-bindings/power/meson-a1-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> new file mode 100644
> index 00000000..88d8261
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +# Copyright (c) 2019 Amlogic, Inc
> +# Author: Jianxin Pan <jianxin.pan@amlogic.com>
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/amlogic,meson-sec-pwrc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson Secure Power Domains
> +
> +maintainers:
> +  - Jianxin Pan <jianxin.pan@amlogic.com>
> +
> +description: |+
> +  Meson Secure Power Domains used in A1/C1 SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-a1-pwrc
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +  secure-monitor:
> +    description: phandle to the secure-monitor node
> +    $ref: /schemas/types.yaml#/definitions/phandle

Why not just a child node of this node?

Rob

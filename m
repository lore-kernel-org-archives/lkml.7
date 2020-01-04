Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B3BC00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC6221835
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578097475;
	bh=EGp+TvV6PwfbirwSPv1b1DDAEdNU47BRsj035pCBmZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BRAz/Q9mNfft49FZUjZzeAKr6uaL78Nv3ejKqy2hIzjYicU/4cDyVPMN+jfy6kRZH
	 HxNQkdZ3UHoNiJ6dS9J1rUDVk4/3bXoR8rLNiaRHvKC0X2QqLnpMFYxXEPUEOH1DIJ
	 /y11i7vJGh73qWrOThYYlWyPlS/NxJHaNc8dwa7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgADAYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:24:35 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33866 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgADAYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:24:34 -0500
Received: by mail-il1-f195.google.com with SMTP id s15so38053214iln.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RHzS3lmjvqBu923Z3jA1u6CAnoZKf0aTLGdAiWMkzuM=;
        b=sHbxVU0IMCR3Kayy+iHcqplEKSZmGNRmafhsWgDqEVu3wzERx090SM9yNS49vRaUTq
         XxNSjWFqyYgXUynF8JgHY5h/NyU24l/3sQyaP7aEXAKBEDv4b2mQNxIbr94PnnwNtrlq
         zyC9wyS+I9vhe8J22GZYBlkE6AEZz5YPWP7vdoJaKE1waB4besEWR4r0Fu5YxLb4YAyU
         qrbPJa45N3QyzNpltBSm4+zhAaX+568wsuTdcydb4vn0mVYdEqcwDfjE/Uc4iRpYtmQf
         cKWjU32LpYMZaNTmHzVvAJzg/HGmOLmwRffFsr4J/ucOoLDAnVAXvAz92yQr5kL4tYVG
         7XvQ==
X-Gm-Message-State: APjAAAVWy+1PL7K7WqDjVozTTRvWY6aRgOUh+tC4dlMZ4TTRQ2Ezb/OI
        dr9ynXYGe9+uzRIwulFEWvGOcRQ=
X-Google-Smtp-Source: APXvYqytabfNrgP2OC6g2XYgCeakE9mmE7gh7mLdAQa9dG9UFSgR1qcATAm4pXCY1Eq2VjdWuDcg+Q==
X-Received: by 2002:a92:d451:: with SMTP id r17mr77089065ilm.201.1578097473014;
        Fri, 03 Jan 2020 16:24:33 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id m18sm19526149ila.54.2020.01.03.16.24.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:24:31 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 17:24:29 -0700
Date:   Fri, 3 Jan 2020 17:24:29 -0700
From:   Rob Herring <robh@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/5] dt-bindings: Add AXG PCIE PHY bindings
Message-ID: <20200104002429.GA18966@bogus>
References: <20191224173942.18160-1-repk@triplefau.lt>
 <20191224173942.18160-6-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224173942.18160-6-repk@triplefau.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 06:39:42PM +0100, Remi Pommarel wrote:
> Add documentation for PCIE PHYs found in AXG SoCs.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  .../bindings/phy/amlogic,meson-axg-pcie.yaml  | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
> new file mode 100644
> index 000000000000..c622a1b38ffc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/amlogic,meson-axg-pcie.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic AXG PCIE PHY
> +
> +maintainers:
> +  - Remi Pommarel <repk@triplefau.lt>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,axg-pcie-phy

Do you expect another compatible? If not, use 'const' instead.

> +
> +  reg:
> +    maxItems: 1
> +
> +  aml,hhi-gpr:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: phy

You don't need *-names when there's only one entry.

> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - aml,hhi-gpr
> +  - resets
> +  - reset-names
> +  - "#phy-cells"
> +
> +examples:
> +  - |
> +    pcie_phy: pcie-phy@ff644000 {
> +          compatible = "amlogic,axg-pcie-phy";
> +          reg = <0x0 0xff644000 0x0 0x2000>;
> +          aml,hhi-gpr = <&sysctrl>;
> +          resets = <&reset RESET_PCIE_PHY>;
> +          reset-names = "phy";
> +          #phy-cells = <0>;
> +    };
> -- 
> 2.24.0
> 

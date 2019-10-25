Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2883CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7599E2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572038419;
	bh=zytSlQH5jQrbBTlr/9/7jTSApFqHNePVjFgB1UwzN3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d/tQZKJcmpgsxNj+1SH/vXQ+7gLqfKjyEMpKsJt43u2XyuSwOdJ8GCMwy2ihu+hc3
	 gffiiQJlUDAK14wLAPAI1YUm2o+MT8pw3fbm93bEH/zZGBaAafGX5erSpWm8IO1RCu
	 mf198cyYtRu8BSSRBkPz4TJRHD/eBdTxZiRG2C+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfJYVUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:20:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33296 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfJYVUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:20:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id a15so2556579oic.0;
        Fri, 25 Oct 2019 14:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JUXQFIqn/d86Rnbor0L71lToepY+28ApeXSzEW1WrrY=;
        b=Z9YZNCD0qdWPS5D6PmXn3t7lk1x2n5HB2cMpnqPK+AmjVa+HuZuFP7fDOzbRXJ0qsH
         HgGzMHO/uUpZrqCIxUBbG/CRaSofExMvULktaACAVl3hoxyqzcVYbCm/RgDPtpUUJTUx
         wqZQUHFxLHV51rhwd0OOR9oQ5Mxr+IiPuUnPIGa1xmP/E9OySsVPlBruWD/C67sbp7kC
         lQsknTUNgNbj75Q2B1qm/DgAQN8/Ad1j7bH1gC04SiiCfUmskhIN2xdNo/mpbdUgb2f0
         xaaEQgng3vcjlPs48gvtdy0cPrYaU++CqkJ71SvRER/ziXIisxHmZp/BWznX99OAom6g
         nJDw==
X-Gm-Message-State: APjAAAU+1Vo3UautgOV7Sul9kk7EcOCQ7LfyIq1CQQubx8ZlCLDx3ogy
        JjYAzsIB/Sjo8kkHia55BuZE51w=
X-Google-Smtp-Source: APXvYqz+woZytbel6lM3PcEJFze0yi42BfFRIteIU1+6GGt93bF3v+SwJ+tZUfL0epSsIXoR2YEYnA==
X-Received: by 2002:a05:6808:10:: with SMTP id u16mr4879719oic.16.1572038416910;
        Fri, 25 Oct 2019 14:20:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x80sm908528oia.37.2019.10.25.14.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 14:20:15 -0700 (PDT)
Date:   Fri, 25 Oct 2019 16:20:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: rtc: realtek: Convert RTD119x to
 schema
Message-ID: <20191025212015.GA29978@bogus>
References: <20191020040817.16882-1-afaerber@suse.de>
 <20191020040817.16882-3-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191020040817.16882-3-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 06:08:11AM +0200, Andreas Färber wrote:
> Convert the RTD119x binding to a YAML schema.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v2: New
>  
>  .../devicetree/bindings/rtc/realtek,rtd119x.txt    | 16 ---------
>  .../devicetree/bindings/rtc/realtek,rtd119x.yaml   | 38 ++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/realtek,rtd119x.yaml


> diff --git a/Documentation/devicetree/bindings/rtc/realtek,rtd119x.yaml b/Documentation/devicetree/bindings/rtc/realtek,rtd119x.yaml
> new file mode 100644
> index 000000000000..71b7396bd469
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/realtek,rtd119x.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause

Missing ()

Though I'm not sure it matters other than consistency.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/realtek,rtd119x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek RTD129x Real-Time Clock
> +
> +allOf:
> +  - $ref: "rtc.yaml#"
> +
> +maintainers:
> +  - Andreas Färber <afaerber@suse.de>
> +
> +properties:
> +  compatible:
> +    const: realtek,rtd1295-rtc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: Specifies the clock gate
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +examples:
> +  - |
> +	rtc@9801b600 {
> +		compatible = "realtek,rtd1295-clk";
> +		reg = <0x9801b600 0x100>;
> +		clocks = <&clkc RTD1295_CLK_EN_MISC_RTC>;

You need the include file here or the example won't build (run 'make 
dt_binding_check').

> +	};
> +...
> -- 
> 2.16.4
> 

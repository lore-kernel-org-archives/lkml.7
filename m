Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C63C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231702087E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573015569;
	bh=8oZt09c8tH/+LHkPmiNy6c9xvTNztGEAHbz98GwY858=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bJxyDv0QENHpnJ20/V5mQjhUROtBrZ/KAxo7p5kFP8cYnv9VvECm0s8GDi9dDQWdF
	 MVgTTuj/4oC2Q2j4q2mkBJumeMDT6zxcthBSr8GPIzk2BDrQVjssOQ3NDQ89COE+ai
	 NEtCr7VC8m7ZmupPt4xpw5oLQHYCKcAIAyvzc1Zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbfKFEqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 23:46:08 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44669 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbfKFEqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:46:07 -0500
Received: by mail-oi1-f196.google.com with SMTP id s71so19796395oih.11;
        Tue, 05 Nov 2019 20:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wGH4y8/QINgJibe6iZ9D+TwVEAiOc3D7dGreYmQ5/Jo=;
        b=PcPPcKtcb5RD+Sjz/zWztR6iG52z8wcUOi81skxd0tvQTrxS6NFbRqsUWAwSBR/TNl
         Awy3323AQMJH3eL+E5pVsL7/6tWek453OCU43QhsrLcB+uZmf+uV3wMSnRRWWgtIXWFo
         hnb0mrqevGQOiwDgp9+dNazt/hwrCliETYwQgHLx8MEGVEsSn7atOi5qEZpkJly4Xlyk
         rQc7aVPdxQnZ++RM42B8hxlRnbumi0Y9972P9cD9zA1hGIaT0Ebh1ldMJBdCmGMBK3l0
         66/QLwSNxArU6shG7h6rjxEvefUd+GJDl+FmSJ4BaLqIZQK98F3Jv9h00SBazVJgK2zZ
         x9FA==
X-Gm-Message-State: APjAAAU8HWkr7yGRz/7aiKE4FCc9iHYuUSoBBK3VzHYXFiZc0hMAxvcE
        hjO2j+1SFc+eNDhrfOX/0w==
X-Google-Smtp-Source: APXvYqxfLJ2h0dh0Tw9BSu30JLuugYqBhvX0Klb2+BzPFTk0XNj+BsaKeLMDjCxGYwt28bCZd9hang==
X-Received: by 2002:aca:ad52:: with SMTP id w79mr500353oie.149.1573015566353;
        Tue, 05 Nov 2019 20:46:06 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c15sm7156877otk.12.2019.11.05.20.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 20:46:05 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:46:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [RFC 05/11] dt-bindings: soc: realtek: rtd1195-chip: Extend reg
 property
Message-ID: <20191106044605.GA28959@bogus>
References: <20191103013645.9856-1-afaerber@suse.de>
 <20191103013645.9856-6-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191103013645.9856-6-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 02:36:39AM +0100, Andreas Färber wrote:
> Allow to optionally specify a second register to identify the chip.
> Whether needed and which register to specify depends on the family;
> RTD1295 family will want the CHIP_INFO1 register.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  A SoC specific binding would defeat the purpose of the generic Linux driver;

Why? You can map any number of compatibles to a generic driver.

>  is it possible to check the root node's compatible in an if: expression
>  to prohibit using more than one reg on "realtek,rtd1195"?

The "rule" is different programming model, different compatible string 
for the block. But this looks simple enough, I don't really care.

>  
>  .../devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml  | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
> index 565ad2419553..e431cf559b66 100644
> --- a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
> +++ b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
> @@ -11,13 +11,15 @@ maintainers:
>  
>  description: |
>    The Realtek SoCs have some registers to identify the chip and revision.
> +  To identify the exact model within a family, further registers are needed.
>  
>  properties:
>    compatible:
>      const: "realtek,rtd1195-chip"
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>  required:
>    - compatible
> @@ -29,4 +31,10 @@ examples:
>          compatible = "realtek,rtd1195-chip";
>          reg = <0x1801a200 0x8>;
>      };
> +  - |
> +    chip-info@9801a200 {
> +        compatible = "realtek,rtd1195-chip";
> +        reg = <0x9801a200 0x8>,
> +              <0x98007028 0x4>;
> +    };
>  ...
> -- 
> 2.16.4
> 

Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A83FC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A76820656
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556742477;
	bh=dNBEcOUjAql4+poEP40OGALiz2t2x1on+kex2xgn/UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q9bX2YoZQPDZYxw+08zSLNhxrV2C9R4llqfqfe83bJ1R8r7hmQAwWaR7BaJ4QIk4j
	 kL7PGYQzvOXFh3PrJ4MKsdFvdqnLa1H6A8W000ILT1SusiQ1UkFyhi7c/q1ekbXkDh
	 jTbwUwBCZvhs/J6IpoE27rxWnUd/9cybtbWnkLjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfEAU14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:27:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33778 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEAU1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:27:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id s11so152210otp.0;
        Wed, 01 May 2019 13:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KS4hKGNIVioMcRHyezKTJtPmApQ7+oYbfRHxucc7wGI=;
        b=qQowgEQa4pJtG31D+1wJXPwTge6IcqSfLcNCfS2BYQPPdvDj888fDUXE+CyC/HGQOI
         VMLdxAEUp6xodYsC4w0OTfV/xxXxaDU3FQEym6jhVHszZSbBNcmb3QYhj7VBNrEt4HcM
         nWtN0hkpr776HCuZwQpiVLE2RWcBuz31GOv7wHh+P/RA9KHqdOQGcrgMCdBbzA0qn7Fw
         ajJ2dwXeibTi0DH8ZEKdwyfz5Vxb9thYIDIERCLUKZRmc0omsSr0Fj4zAGjTn0lnYcqE
         ZR/04JypL/jTGHHlANGs2m43eUzQzG1oorzwmo5ZKSveqLQvvHeYiCKxLfapkwgwb/Yk
         yL5A==
X-Gm-Message-State: APjAAAVzUkN+3X71seXEpc7emW9nVgchgHL+Prjcu0HL0d8CrrHfuHoR
        mGMVWmGyQ8Szqr0LbtVhVA==
X-Google-Smtp-Source: APXvYqy2rYdK9ldoX9mWUXMnNnuvyEUUSkKlODoSZcJLLwSinumT9uIuGEHWyxrQzf0cIfbbiVfBAw==
X-Received: by 2002:a05:6830:c7:: with SMTP id x7mr335551oto.67.1556742474995;
        Wed, 01 May 2019 13:27:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b51sm18601731otc.8.2019.05.01.13.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:27:53 -0700 (PDT)
Date:   Wed, 1 May 2019 15:27:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 08/11] dt-bindings: interconnect: add MT8183
 interconnect dt-bindings
Message-ID: <20190501202753.GA2862@bogus>
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
 <1556614265-12745-9-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556614265-12745-9-git-send-email-henryc.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:51:02PM +0800, Henry Chen wrote:
> Add interconnect provider dt-bindings for MT8183.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../bindings/interconnect/mtk,mt8183.txt           | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/mtk,mt8183.txt
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/mtk,mt8183.txt b/Documentation/devicetree/bindings/interconnect/mtk,mt8183.txt
> new file mode 100644
> index 0000000..1cf1841
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/mtk,mt8183.txt
> @@ -0,0 +1,24 @@
> +Mediatek MT8183 interconnect binding

This should be part of the dvfsrc binding.

> +
> +MT8183 interconnect providers support dram bandwidth requirements. The provider
> +is able to communicate with the DVFSRC and send the dram bandwidth to it.
> +Provider nodes must reside within an DVFSRC device node.
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +			"mediatek,mt8183-emi-icc"
> +- #interconnect-cells : should contain 1
> +
> +Examples:
> +
> +dvfsrc@10012000 {
> +	compatible = "mediatek,mt8183-dvfsrc";
> +	reg = <0 0x10012000 0 0x1000>;
> +	clocks = <&infracfg CLK_INFRA_DVFSRC>;
> +	clock-names = "dvfsrc";
> +	ddr_emi: interconnect {
> +		compatible = "mediatek,mt8183-emi-icc";
> +		#interconnect-cells = <1>;

No need for a child node here. Just move #interconnect-cells to the 
parent.

Rob

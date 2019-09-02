Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE85C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FD921882
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567431532;
	bh=zKpfAKGBpK7c/RvmmhMqWqpylgVBWVGk/0PwIYEjKog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z4gS+hoDqT+BLIyNOO/yvqEU87iBsF0iv+C2QsV/uaKs2yHJFCMuBKwnP607G7o91
	 hhyq0F5/xFd7J68JwjsP6LlNz+ljGXPSllf20EQN2aZL4k7Lj2GAD2gBqIcJCQ0rxB
	 UxyWuIq0KdQFwbqQA5AX1D7qwf0KrKTKiLi4XaxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbfIBNiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:38:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34687 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbfIBNit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:38:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so9912368wmc.1;
        Mon, 02 Sep 2019 06:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lP+OoGEF7HmeKCtfc8mmDkbVMHD2nEU0wy8Yk5Uuck8=;
        b=qtyht2Knuc7WOEUVyWz7N7W2OyvHeJVMWelH0n0+VFYi+2ZODa3VjTWOjWgbxJu6G4
         rHaDs+CNydeoa66smHH31gJHMrvgN+CfrC9RL7kqmgLBzK37EnuthJAqS2Q3RwiBG+EU
         qIF+pgQoIo1QQKzXBTpqUYvISQEnw61VOjSh3yM7qmAoAFFSd8ZqVkz6dI3G/+W1vKIa
         7haO/h5/b8dX8bxk40193neUjz+VUJ0tIiPVZAjFx4ggxTMAq+t4G0yGWk5wWdK0E7qL
         ILA/uKqspyQ8pNmBE8QMMbSBsCdTf1HJbVKBzBHVNGZUesdIRkkYzSGYv5GvimsRiAIh
         fd3g==
X-Gm-Message-State: APjAAAXpPUgW2iufGvTixPKRfPtk7vXOdkz0gEq8Z3+94W387IHBno6D
        yvhqzC2ccltPP3laK3CyKA==
X-Google-Smtp-Source: APXvYqyDb7iutaz5y4Tc0LmVuWNVw/82y5Rin3xTusZ5wHyki1kqxmyfgqmGSIYLq5xNG/JShwZX8w==
X-Received: by 2002:a1c:a003:: with SMTP id j3mr35873401wme.42.1567431527091;
        Mon, 02 Sep 2019 06:38:47 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id t18sm11645053wrx.76.2019.09.02.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:38:46 -0700 (PDT)
Date:   Mon, 02 Sep 2019 14:38:46 +0100
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 08/10] dt-bindings: interconnect: add MT8183
 interconnect dt-bindings
Message-ID: <20190902033045.GA10734@bogus>
References: <1566995328-15158-1-git-send-email-henryc.chen@mediatek.com>
 <1566995328-15158-9-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566995328-15158-9-git-send-email-henryc.chen@mediatek.com>
X-Mutt-References: <1566995328-15158-9-git-send-email-henryc.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 08:28:46PM +0800, Henry Chen wrote:
> Add interconnect provider dt-bindings for MT8183.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/dvfsrc.txt        |  9 +++++++++
>  include/dt-bindings/interconnect/mtk,mt8183-emi.h      | 18 ++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/mtk,mt8183-emi.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> index 7f43499..da98ec9 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> @@ -12,6 +12,11 @@ Required Properties:
>  - clock-names: Must include the following entries:
>  	"dvfsrc": DVFSRC module clock
>  - clocks: Must contain an entry for each entry in clock-names.
> +- #interconnect-cells : should contain 1
> +- interconnect : interconnect providers support dram bandwidth requirements.
> +	The provider is able to communicate with the DVFSRC and send the dram
> +	bandwidth to it. shall contain only one of the following:
> +	"mediatek,mt8183-emi"
>  
>  Example:
>  
> @@ -20,4 +25,8 @@ Example:
>  		reg = <0 0x10012000 0 0x1000>;
>  		clocks = <&infracfg CLK_INFRA_DVFSRC>;
>  		clock-names = "dvfsrc";
> +		ddr_emi: interconnect {

The EMI is a sub-module in the DVFSRC? This is the DDR controller or 
something else?


> +			compatible = "mediatek,mt8183-emi";
> +			#interconnect-cells = <1>;
> +		};
>  	};


Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B11C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 14:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF83F20838
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 14:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="mfq2GQ/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfGMObG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 10:31:06 -0400
Received: from onstation.org ([52.200.56.107]:44382 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbfGMObG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 10:31:06 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 473DB3E838;
        Sat, 13 Jul 2019 14:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1563028265;
        bh=P3vNE5lNg+thFcJrJjk1r54W7S8rVsGTSQRhlpcn7lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfq2GQ/Uy1dSl+lMhqUTDuwoomzGMJmUBucRgJO9OrIqTDUkBCvvXswxW5Ra0EvSt
         5abCXCAuBQ0K0wB3LuuTfTSqNS8Qj5AGmeI6Aj40/sgUfn3BXgY9yIJyb7XmouZo/x
         p3DqIpjDUz12tdHr8ReQnBscfzdApA8Rml3AusO0=
Date:   Sat, 13 Jul 2019 10:31:04 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~martijnbraam/pmos-upstream@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: msm8974-FP2: add reboot-mode node
Message-ID: <20190713143104.GA11154@onstation.org>
References: <20190620225824.2845-1-luca@z3ntu.xyz>
 <4607058.UzJteFJyig@g550jk>
 <20190622014302.GA20947@onstation.org>
 <3733253.hEy9q5iLy3@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3733253.hEy9q5iLy3@g550jk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 01:26:45PM +0200, Luca Weiss wrote:
> Hi Brian,
> how about something like that (formatting is surely broken because I'm not 
> sending this with git-send-email^^)?
> 
> I'd says this should be work fine with all devices as all modes are defined in 
> the device-specific dts but the reg and offset values are in the board dts. 
> Should I also add a status = "disabled" to the reboot-mode node in the board 
> dts?
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts b/arch/arm/boot/
> dts/qcom-msm8974-fairphone-fp2.dts
> index 643c57f84818..ff4a3e0aa746 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
> @@ -338,6 +338,16 @@
>  			};
>  		};
>  	};
> +
> +	imem@fe805000 {
> +		status = "okay";
> +
> +		reboot-mode {
> +			mode-normal	= <0x77665501>;
> +			mode-bootloader	= <0x77665500>;
> +			mode-recovery	= <0x77665502>;
> +		};
> +	};
>  };
>  
>  &spmi_bus {
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-
> msm8974.dtsi
> index 45b5c8ef0374..1927430bded7 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -1085,6 +1085,17 @@
>  				};
>  			};
>  		};
> +
> +		imem@fe805000 {
> +			status = "disabled";
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0xfe805000 0x1000>;
> +
> +			reboot-mode {
> +				compatible = "syscon-reboot-mode";
> +				offset = <0x65c>;
> +			};
> +		};
>  	};
>  
>  	smd {

I think this sounds reasonable. 

Reviewed-by: Brian Masney <masneyb@onstation.org>

You should resend this out with git send-email and see what Bjorn says.

Brian

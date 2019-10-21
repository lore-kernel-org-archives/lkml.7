Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC67CA9EAE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B302F21D80
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3gY/UH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfJUCL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:11:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46285 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfJUCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:11:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so7376612pfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 19:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F4qHVfnQODELv7H/VIQXzK7KyvLwmXFYgs71Rh/FWg0=;
        b=U3gY/UH7n1wqSuzGgYuu5JkwQFH1pCsCSEljcjoseCr35KMcdlRjoipRGVUpQFHkEW
         PQEK52Wqkj8AzStD9au4n2hPtJp/uM3cvnfEQY/XeemzlRySDbpWSGLYhBPmMDxQJ8Uz
         r2qoIVc8sxvaLfA1ftl3sua/km8qGSTUsJEwTgGS5uUGIGk6dNgXqAB4ZXMR9YUK4y0Q
         KPuIazb0GlVN+v+zSsnAEy+QlR6kvTerNxE6ytvcoyoP+cxVgH3wZVFVgUD6vVc3bS1W
         03XMsNsNVrw7K7f5Jtl4Gz9hj+Of8wt96ac/E/WEbE8H2x18GKErauWRGKUngYKJFcoj
         NiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F4qHVfnQODELv7H/VIQXzK7KyvLwmXFYgs71Rh/FWg0=;
        b=q1LAjdko8BZa3cELz4UR4tDFIzHDWuKiqM1v6q8D8OrfkldtinFOrZA7hpGMOX1bLr
         dpiLaRrJySjoujxtc0Koo3eN18uYiIxmalEC3FU0JD9ng6h/NLTbTuUtJY3HCHDaWVq5
         WeQVvTRvI33OSQYZFCtOKMiTwh/Y4i1czjk3mxDwhzHsqXCmiK5ak8ILj5B+eLLKx673
         Xd32KFUpBx4Y4X0HHM+QgX3J+Wn/eafPhmfNHWx1bQ6jup1yc+JLw7YpGNOwWn+lzEX0
         GvXo0RuU3CD0USX5Ik1WZiWu7DZjn9zZt5urqvP+LYEHIuvkXKWSxC8mbbJLXJ25TLAN
         se3w==
X-Gm-Message-State: APjAAAXCu5sXke3YiovYJmUMk7sxy15ZwWnYg71Qd7QLffr94LEI4YcM
        iql05LLqLw4PTFB0gyZgXJ9Dbg==
X-Google-Smtp-Source: APXvYqz7/4IVhnW4AAy/RldJyNGvZmiY0N+5+GKQFV+bDo2piRiKUQxCyUhJTIszU6Z7/LnGAklMWQ==
X-Received: by 2002:a63:f40e:: with SMTP id g14mr11246293pgi.62.1571623886294;
        Sun, 20 Oct 2019 19:11:26 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m34sm11573538pgb.91.2019.10.20.19.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 19:11:25 -0700 (PDT)
Date:   Sun, 20 Oct 2019 19:11:23 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8998: Fixup uart3 gpio config for
 bluetooth
Message-ID: <20191021021123.GF4500@tuxbook-pro>
References: <20191019221217.1432-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019221217.1432-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 19 Oct 15:12 PDT 2019, Jeffrey Hugo wrote:

> It turns out that the wcn3990 can float the gpio lines during bootup, etc
> which will result in the uart core thinking there is incoming data.  This
> results in the bluetooth stack getting garbage.  By applying a bias to
> match what wcn3990 would drive, the issue is corrected.
> 
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  .../boot/dts/qcom/msm8998-clamshell.dtsi      | 31 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi     | 31 +++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
> index ab24d415acc0..7e02cb6c8e07 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
> @@ -74,6 +74,37 @@
>  	};
>  };
>  
> +&blsp1_uart3_on {
> +	/delete-node/ config;

So it would make much more sense then to split &blsp1_uart3_on in
sections defining its pins, than the "logical" config and mux split.


Please send a patch that changes msm8998-pins.dtsi to be:

blsp_uart3_on: blsp1-uart3-on {
	ctx {
	};

	rts {
	};

	rx [
	};

	tx {
	};
};


There's no need for the "pinconf" part and for pinctrl states with a
single pin/group we can simply omit the subnode (as this is now
possible).


Apart from that, I think this looks good!

Regards,
Bjorn

> +
> +	pinconf-cts {
> +		/*
> +		 * Configure a pull-down on 47 (CTS) to match the pull
> +		 * of the Bluetooth module.
> +		 */
> +		pins = "gpio47";
> +		bias-pull-down;
> +	};
> +
> +	pinconf-rts-tx {
> +		/* We'll drive 48 (RFR) and 45 (TX), so no pull */
> +		pins = "gpio45", "gpio48";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	pinconf-rx {
> +		/*
> +		 * Configure a pull-up on 45 (RX). This is needed to
> +		 * avoid garbage data when the TX pin of the Bluetooth
> +		 * module is in tri-state (module powered off or not
> +		 * driving the signal yet).
> +		 */
> +		pins = "gpio45";
> +		bias-pull-up;
> +	};
> +};
> +
>  &dsi0 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> index 1a1836ed1052..17f51af5e999 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -37,6 +37,37 @@
>  	};
>  };
>  
> +&blsp1_uart3_on {
> +	/delete-node/ config;
> +
> +	pinconf-cts {
> +		/*
> +		 * Configure a pull-down on 47 (CTS) to match the pull
> +		 * of the Bluetooth module.
> +		 */
> +		pins = "gpio47";
> +		bias-pull-down;
> +	};
> +
> +	pinconf-rts-tx {
> +		/* We'll drive 48 (RFR) and 45 (TX), so no pull */
> +		pins = "gpio45", "gpio48";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	pinconf-rx {
> +		/*
> +		 * Configure a pull-up on 45 (RX). This is needed to
> +		 * avoid garbage data when the TX pin of the Bluetooth
> +		 * module is in tri-state (module powered off or not
> +		 * driving the signal yet).
> +		 */
> +		pins = "gpio45";
> +		bias-pull-up;
> +	};
> +};
> +
>  &blsp2_uart1 {
>  	status = "okay";
>  };
> -- 
> 2.17.1
> 

Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A38C16A69
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7B3217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zBH+9e+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfEVDap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 23:30:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46744 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfEVDao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 23:30:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so530062pfm.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 20:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Du1Br0cmErddghQYkfGNqWduGZdP1qnPtvK0AlfzZMQ=;
        b=zBH+9e+oPLwAxt2JtsA9dx6xUT33mOnftRieb1rDok9y1s+4QuNYB4P5VVkTlaQF7+
         ETYvQRegJLTfVmBWv+dw3zG3HmmWhTUotA2HqPt/Abzgnsi9hKQJVKUv0WCbreywuKFr
         4eAQA3kXXw0f1NMwBgSVMZAoPTaMbCBLj5SKLa2jp/QVdjsyck27q3K18Nq3hmFtWoTs
         mTgLihzn2iXHGL6PW0A5CIErqKwHt9g2fLOClzkc1Pxh9NpgcKfd2Jc5lr6cIrCOUd4m
         sUcXkdZTeMdyXMTGUADmjvG/pKJN12sEGJgX7iqsimfqiS7R7WzSKEpk8ni8yk+mI1X/
         rBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Du1Br0cmErddghQYkfGNqWduGZdP1qnPtvK0AlfzZMQ=;
        b=Z8g0AYR4mvNxmsixa4eF/notr8r8DT2WKAziNLaAIHIW5syHDT2E9pFuOA+eaKePFY
         JmNByRLt1i0ZLUz6bosQZJzbnSSWsyB2hBj6r9HQxIlM48WlWVLQ0o9tjXbxqERilrwT
         MF5lPAMTvpz4avcelJSKJihGYIKP+OkdnPBl1uG48uyBa7wftuby7j1f8OYxhLolFrpw
         f9e7FEK88L2PaCRDhY7HhN1qoX5EvnWk1MXh1CQ8YB7bf1fwiJgeyF9eCz2BbiCbcXx8
         lm4oePcUo1oq2mHTzAsDYFeaEB4Y96iwMkcx/7tre0XmH8LUaUtn07bNRza8gF5NeaDr
         Pzmg==
X-Gm-Message-State: APjAAAWl9aX7QkosHEqjKekZG6d2zmgAwDvoZZdk+CGCI7XA3q+PMXVh
        /+vsL2XZi8VNH3UArB7Yy0lmqg==
X-Google-Smtp-Source: APXvYqxae4rVMiE6ukYJvShXDC88FepHsu9A4+YT044cewTqpM6UmU5wtJttPoq6ctid6Q7KviFvfQ==
X-Received: by 2002:a63:4c15:: with SMTP id z21mr43284759pga.395.1558495843573;
        Tue, 21 May 2019 20:30:43 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c127sm36802714pfb.107.2019.05.21.20.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 20:30:42 -0700 (PDT)
Date:   Tue, 21 May 2019 20:30:40 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, niklas.cassel@linaro.org,
        marc.w.gonzalez@free.fr, sibis@codeaurora.org,
        daniel.lezcano@linaro.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/9] arm64: dts: qcom: msm8916: Add entry-method
 property for the idle-states node
Message-ID: <20190522033040.GJ3137@builder>
References: <cover.1558430617.git.amit.kucheria@linaro.org>
 <0374669560d13bba30dfa33cd10a0ad8a65b604b.1558430617.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0374669560d13bba30dfa33cd10a0ad8a65b604b.1558430617.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 May 02:35 PDT 2019, Amit Kucheria wrote:

> The idle-states binding documentation[1] mentions that the
> 'entry-method' property is required on 64-bit platforms and must be set
> to "psci".
> 
> [1] Documentation/devicetree/bindings/arm/idle-states.txt (see
> idle-states node)
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Picked up

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 0803ca8c02da..82ea5b8b37a2 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -158,6 +158,8 @@
>  		};
>  
>  		idle-states {
> +			entry-method = "psci";
> +
>  			CPU_SPC: spc {
>  				compatible = "arm,idle-state";
>  				arm,psci-suspend-param = <0x40000002>;
> -- 
> 2.17.1
> 

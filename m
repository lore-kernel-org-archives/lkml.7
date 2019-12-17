Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D04C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D808206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVLsVcL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfLQATj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:19:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36761 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfLQATi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:19:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so4649067pgc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 16:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kSRMyRpGvN3O6oC2QK8ni8ozT+CBlR4DXsbN2O0RLUk=;
        b=jVLsVcL+tDd05VMnMqEWC/RH3jR0TeoTexR/4Jp2JrT+81wvxprdmBRSkjDT0WzRj0
         FzbLjkNZd3Rn4xsNLWoTL1V6hMYsyhe8B4EiSzpCNe15QVAkXANDcy9S92SWBOJJnf92
         vQsJn/wV4V4vE061RMljzuH4Nmq8rsIDc3HLVZwjKoEU+9tEivqbB4gPHd9iQXjsyZ/7
         XsRLQhIeddKOKft6IbM9eT1jU4E+WOBAOE0ATVQzW8TgBy6XqNzk2p8UIlgXi//DO6wb
         u3D9XdBLWkWpqS6xcgzVtZIvL0RVVVNdBlzeamMC/kzKBNxSDTJVLWQ6nXxCjR2VqJjA
         N/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kSRMyRpGvN3O6oC2QK8ni8ozT+CBlR4DXsbN2O0RLUk=;
        b=S5BoAVex0TZPKKfaXru60OTPTQTT6xI57jsLUcHPQiljnZd16u/okwpMGeflDAkZty
         eMYNQ81WN8yY1YgWtEUYJC9JRr9Ztm5xUbdjGMIToav6TMo5QHs9U44TF2N6QJ4XZXAC
         vgx1UuI4xdn38zw1X7PsiQgcl9hUHvdMMP6r79JiF2Te2sp6fQCXJuznijvPZ2qDwokT
         /iwzVKDTQT3tzfu7etwStMH9dFFKuI4qimH9T1zXWSqbm7g3V2r4aYYP122KglsIyg0c
         Ge3k9a7m40Hs3uJoRYLoKz0ibZ9KPBDDmk+U0hW8YgSORDvgjT2wAZYTfTw/rHgmJlsr
         OOhw==
X-Gm-Message-State: APjAAAVu9snscj6frcAbCT29swA2jezIQ/csiqqO5AMZSCS2bY/Y38lX
        2HrrL5mUuYnRU32W1YkiUV/NVw==
X-Google-Smtp-Source: APXvYqzGZHGPHjW1ue1HrbvnzOPYObbsplWRfg2TIsKHZ0VTBST/SlVCZt6iaZb64cWODmXhxvakmQ==
X-Received: by 2002:a62:2ad5:: with SMTP id q204mr7061373pfq.33.1576541977891;
        Mon, 16 Dec 2019 16:19:37 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d38sm21816480pgd.59.2019.12.16.16.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 16:19:36 -0800 (PST)
Date:   Mon, 16 Dec 2019 16:19:34 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     jhugo@codeaurora.org, robh+dt@kernel.org, jonathan@marek.ca,
        ohad@wizery.com, mark.rutland@arm.com, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org
Subject: Re: [PATCH 16/16] arm64: dts: qcom: sm8150: Add ADSP, CDSP, MPSS and
 SLPI remoteprocs
Message-ID: <20191217001934.GT3143381@builder>
References: <20191118214250.14002-1-sibis@codeaurora.org>
 <0101016e80794e1d-7c9ce825-6ba5-479e-bc98-f5d56ce6933f-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016e80794e1d-7c9ce825-6ba5-479e-bc98-f5d56ce6933f-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Nov 13:44 PST 2019, Sibi Sankar wrote:

> Add ADSP, CDSP, MPSS and SLPI device tree nodes for SM8150 SoC.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8150-mtp.dts |  12 +++
>  arch/arm64/boot/dts/qcom/sm8150.dtsi    | 135 ++++++++++++++++++++++++
>  2 files changed, 147 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> index aa5de42fcae45..4d9bb8145dbba 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
> @@ -348,6 +348,18 @@
>  	};
>  };
>  
> +&adsp_pas {
> +	status = "okay";
> +};
> +
> +&cdsp_pas {
> +	status = "okay";
> +};
> +
> +&slpi_pas {
> +	status = "okay";
> +};
> +
>  &qupv3_id_1 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 98a96fd1d6117..58f4ce95bd966 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -5,6 +5,8 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-sm8150.h>
> +#include <dt-bindings/power/qcom-aoss-qmp.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
> @@ -278,6 +280,139 @@
>  		};
>  	};
>  
> +	adsp_pas: remoteproc-adsp {

Please move this in under /soc, name it "remoteproc" and slap a reg = <>
on it. Even if qcom,*-pas doesn't use the information I find it look
better in the DT and it becomes more consistent between PAS and non-PAS
targets.

Regards,
Bjorn

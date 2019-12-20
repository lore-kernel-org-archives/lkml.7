Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02C9C2D0D1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977B9227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IiSA+8Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLTAk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:40:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44990 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfLTAk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:40:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id az3so3324271plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 16:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jRdtiusu+beWJmpVDOcRJ7adeaD2r8nAbkaw7dnEM3o=;
        b=IiSA+8Zu5xMGrVWMYcIurnZ+82iGEVaMNMAYiegms9yncV4Odo6L5M/TGQpyIezn8m
         tV4zwJ4ShOl3QB4MLIww8dJAE8GgAtN7bg0I0FblsIfNchewk13zr9OCsk24esyGcjqe
         CeGtVcnpDJB1UcX3MdrZrffNlHFR9DBIuVtsQScHTeosd/J4UpJWV4sVJUWxuiyyXFQU
         usb0+ndwgbW0KJE1z0Nad/3t/NOHqyRlRhrJe85j6rweybaBMTQABri1nG5ZdcejyZTZ
         Yyv5+xScQSwEnGQiQDlpr+SiYIO0C+ZYrWJ42h1joK3SUIkhf0UQcgqSZAIkbCqAZ3pP
         EReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jRdtiusu+beWJmpVDOcRJ7adeaD2r8nAbkaw7dnEM3o=;
        b=FmWnAvSKv64rNs4R64TXfizH2Ic//mkmTZP4OO6vAIfi2ysrLatvsPypacJMNIsQjl
         /FA6Clsz97Y0qTZFNq8sTw5rdLkzCqd5FjSfqnTNZ7KzbgiaZEzPmjSiiNawlcYavGbr
         4VZHAN+lrkOaXlXsfcOmUrGQx2zhTUHpvIW+M7Kf81rB/dMoa3ezGzXe4WCCCfwEkA+J
         2tgY8P/MHiym+x6XIOLbi/H7ljbJIl61PwwzcgVkVmwbpxW6ABjeOYrK8j7J/hfpQ7jh
         Or2RfNtztRKlfkqRaxwfC1HgoYU+nNa+yjjN84oEB8DJcDY1r2iEjOWo+rRnKMYtkNV8
         CfTw==
X-Gm-Message-State: APjAAAXFLD55L1EHO0g8pc5U/WphKiBmsIrE0oYTd4U2OuU2Odqa/uNT
        Jn4dMkDmnJJHhbRghMMDjwFXWg==
X-Google-Smtp-Source: APXvYqyXI07TRonse1dFs0JYqbSY6q5JMDHO4GTlLVXHf3CyrogLeSTQza7mciIV4JED48jdhYeetg==
X-Received: by 2002:a17:902:59c9:: with SMTP id d9mr11951312plj.184.1576802425465;
        Thu, 19 Dec 2019 16:40:25 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o16sm8713462pgl.58.2019.12.19.16.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 16:40:24 -0800 (PST)
Date:   Thu, 19 Dec 2019 16:40:22 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcs404: Update the compatible for
 watchdog timer
Message-ID: <20191220004022.GE3755841@builder>
References: <cover.1576211720.git.saiprakash.ranjan@codeaurora.org>
 <757995875cc12d3f5a8f5fd5659b04653950970a.1576211720.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757995875cc12d3f5a8f5fd5659b04653950970a.1576211720.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12 Dec 20:53 PST 2019, Sai Prakash Ranjan wrote:

> Update the compatible for QCS404 watchdog timer with proper
> SoC specific compatible.
> 

Applied

Thanks,
Bjorn

> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index f5f0c4c9cb16..c9e8e629045b 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -905,7 +905,7 @@
>  		};
>  
>  		watchdog@b017000 {
> -			compatible = "qcom,kpss-wdt";
> +			compatible = "qcom,apss-wdt-qcs404", "qcom,kpss-wdt";
>  			reg = <0x0b017000 0x1000>;
>  			clocks = <&sleep_clk>;
>  		};
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

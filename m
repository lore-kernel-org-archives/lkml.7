Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB947C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 05:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0E7218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 05:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZpIfA+yX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfCXFU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 01:20:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36047 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfCXFU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 01:20:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id p10so4166533pff.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 22:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WX+icl5fYdsRc6/xmAFTtVUxhryLFxvqmHy7/lFtcnE=;
        b=ZpIfA+yXkrtW+rZp8eN5GYf0bkIR1ySz8kLbdt6h9uWtJSOziBshZOqsZrHiMu/nYe
         CeBptU2O1Q9tg/JHy/yV3SCWJQSj7vx5PgChpuRtEZom5BYi0MCENLLI+H1qGxWDbt8c
         6w+DkWy1YiMeZWAPpy3axuFFdwew5GiautZOETS1oRMZSBpz5bzr7CqnDAKZUbVWsKYa
         WU7TIUExk8lBOz69c921zzYl7lOF6bgFW0iksotruW4Y+CJlDFdNXRyxgtLkiQS7xnr3
         zADmaS36kNiYElU6I6u3fuI++WorWjN7Y9jlp/M0n36zzpBOmOgF+JwGZq6mW8N5thjR
         XsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WX+icl5fYdsRc6/xmAFTtVUxhryLFxvqmHy7/lFtcnE=;
        b=Be4Doj19KvshEaS1qjskD9GJUb5ASKeSyJB/JQdexHtE4zAvejVxW5JSlduQUBSM92
         1zeHPZ7Isr0H1PV9fxhBRkE+U+RlZkgFDEQa/NXfxIC8xkqnHV87XliI6whIcbVAEoJ3
         Mo/ClTLrbyBgSPQ8rPiMAtd40i7vPx4Tn1BbAu8ME9kIsIxHVWV8WbRyasB6mseeNvGG
         rfFar1mG5AEvlJV9/Cx4d8owXTL5kuiVKFZ1qHJRYmUS+beY3e872KN+QP9O61kJrMpZ
         tgCNZNRGQJs9A6KFIN0Xh2FHFGSinKv4uBXrakpiLMyJrxOCfZ1Xy806ZeBMtjkj28Qu
         k0hQ==
X-Gm-Message-State: APjAAAX386bKWQg5IS2pT8Hy6rwGxDtwL2bIlpdISAYXis5wT3P1Cvpi
        gSQl9pOEf9r9Z+29JoCZhoyD7Q==
X-Google-Smtp-Source: APXvYqw0JGzHxh1enV05FiH1Ji6HEgtBhC1Qrh2FaHS2FHK0wRW6aBl3sEk9ILXu0t3lnIcfMctlIw==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr18529083plf.242.1553404827712;
        Sat, 23 Mar 2019 22:20:27 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p3sm20482466pfp.136.2019.03.23.22.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2019 22:20:26 -0700 (PDT)
Date:   Sat, 23 Mar 2019 22:20:23 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     andy.gross@linaro.org, daidavid1@codeaurora.org,
        evgreen@chromium.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sdm845: Include the interconnect resources
 DT header
Message-ID: <20190324052023.GG27005@builder>
References: <20190311140602.12160-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311140602.12160-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Mar 07:06 PDT 2019, Georgi Djakov wrote:

> Include the device tree header for the on-chip interconnect endpoint
> resources on sdm845 devices. This will allow using the "interconnects"
> property in DT nodes to describe the interconnect path resources they use.
> 
> The sdm845 interconnect provider DT node is already present, but the
> header file with the resources is not included, so let's fix this.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks Georgi, picked up for v5.2 with Evan's r-b.

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 5308f1671824..be4d4c5859c0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/clock/qcom,lpass-sdm845.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,videocc-sdm845.h>
> +#include <dt-bindings/interconnect/qcom,sdm845.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>

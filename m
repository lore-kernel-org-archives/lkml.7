Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34F3C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EB22332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldPZ7n1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfHUJHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:07:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34505 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfHUJHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:07:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id x18so1442421ljh.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l1PSwAxURmvRpKju1nSZAkhT1kqhpgoMPnKulqMvgaU=;
        b=ldPZ7n1YKnH6urIqEpjgNnB9Yz6A9hu7oUFsROK9+okfYJw31JxfVGrlYrO5EEIfCa
         UohvmNFqTTgOLenwL/KxMl7/Zkm/+uZ0ss3xAZ1mzFZ5idRlcs8PF1Qr6pzRg3CD9q4+
         l46lL0b/b1pbZ0jbxHflmKmNI0MMX0qMkfLrLMxBsk6M/7ofuixSCG/PFt7ypxfXC9nj
         FkTGzf2aPo1ZSbBa4MmUkRTkRRMQJHl0kTiF2QbKQJcNlzvxx2EqKkjBzJwz6oWRJAOt
         /yTUYrTgFGrn1tQ4+9dsq6A0UwFDdkHe97QTPZTdeyNhtrS4o+QWZqKZprCNEsOVodPd
         5Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l1PSwAxURmvRpKju1nSZAkhT1kqhpgoMPnKulqMvgaU=;
        b=Aox97wEzF7M62SKFgoImCx2Y+QvryM553Z5+Kejv1CuANUl5QV2y3gsuaXQ2bOuchS
         9jMUxn2U6wEOXayR4Zvyw91N8ehc3uSWPxxyyQ7h7Sz4cdsZ7l0JYr93Vk+75QtdZZ1O
         e/BY6CnAIH/LTN1Adxr0vR+hEyRM5sYq9uwUMYClhlzMFMPChcEBhPAss36TpQ6YRXdV
         Pzx8H/vBCDDmqFVexYz6w3isPLdW/47D/xExwgXTkX6ou9v67tyitNFLZ5yO4daXQ4v2
         FlcrouuLHqPxHwWgaZ/6Ap4qVLlAF3/0jQaZr9ZrY/Sh/hx3WvjX77xhS+n0d7DJLShj
         HMlQ==
X-Gm-Message-State: APjAAAXQt3N42CdfeCa2lReWO+p+0g5smoUjAKIQFkDKNOHOVIzL9K2V
        ta6/YHMR07enKU2ldGXNRyOGJA==
X-Google-Smtp-Source: APXvYqzG9CVLKmNl0LbqKy5+pIULi7I5nAFbvEiaeMSL2RErmaHBoXceiFNSGmwFYhOr2oazUpYPEA==
X-Received: by 2002:a2e:b00b:: with SMTP id y11mr18017045ljk.159.1566378419968;
        Wed, 21 Aug 2019 02:06:59 -0700 (PDT)
Received: from centauri (ua-84-219-138-247.bbcust.telenor.se. [84.219.138.247])
        by smtp.gmail.com with ESMTPSA id 202sm3182448ljf.102.2019.08.21.02.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 02:06:59 -0700 (PDT)
Date:   Wed, 21 Aug 2019 11:06:57 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] arm64: dts: qcom: sm8150: Add SM8150 DTS
Message-ID: <20190821090657.GA560@centauri>
References: <20190820172351.24145-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820172351.24145-1-vkoul@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:53:42PM +0530, Vinod Koul wrote:
> This series adds DTS for SM8150, PMIC PM8150, PM8150B, PM8150L and
> the MTP for SM8150.
> 
> Changes in v3:
>  - Fix copyright comment style to Linux kernel style
>  - Make property values all hex or decimal
>  - Fix patch titles and logs and make them consistent
>  - Fix line breaks
> 
> Changes in v2:
>  - Squash patches
>  - Fix comments given by Stephen namely, lowercase for hext numbers,
>    making rpmhcc have xo_board as parent, rename pon controller to
>    power-on controller, make pmic nodes as disabled etc.
>  - removed the dependency on clk defines and use raw numbers
> 
> 
> Vinod Koul (8):
>   arm64: dts: qcom: sm8150: Add base dts file
>   arm64: dts: qcom: pm8150: Add base dts file
>   arm64: dts: qcom: pm8150b: Add base dts file
>   arm64: dts: qcom: pm8150l: Add base dts file
>   arm64: dts: qcom: sm8150-mtp: Add base dts file
>   arm64: dts: qcom: sm8150-mtp: Add regulators
>   arm64: dts: qcom: sm8150: Add reserved-memory regions
>   arm64: dts: qcom: sm8150: Add apps shared nodes
> 
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/pm8150.dtsi    |  97 +++++
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi   |  86 +++++
>  arch/arm64/boot/dts/qcom/pm8150l.dtsi   |  80 ++++
>  arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 378 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8150.dtsi    | 481 ++++++++++++++++++++++++
>  6 files changed, 1123 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8150.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8150b.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8150l.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8150-mtp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sm8150.dtsi
> 
> -- 
> 2.20.1
> 

Whole series is:

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>

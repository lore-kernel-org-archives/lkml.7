Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D5AC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006C027032
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 23:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cMfP/lWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfEaXul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 19:50:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33092 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfEaXuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 19:50:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so4891831pgv.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c79H5rQZz0sMWOQ2Dkv18YmAHI94MxyIDoL9IyRKnFM=;
        b=cMfP/lWBiG8HDIKe1reMsz+A5J375yyopBUdiNuYccJ9PoMGVkT3Cq6ArQqQttOXkw
         KElbIOArfqCdwgWKvCi9FEEgVPfH6EUxfR40IDtO7J+V9Zuycnvk0m6cN3XO3ms+Sux1
         nSHivP7dABj6PsTFIBz4DsSF+3JvZdeS9VVPjg5/f3OZp3m8q8lRg2ZvsDl4lTTHfPVz
         3TOTsjUz18jwKPdj38ZdWE91k4XwPtKf3ouv1ucmJmVdA5eKX4NfLIV/MqENcvLD2olt
         R/DQD7pzR8PTjO56anLH84cHeqskxN10riQmO6Do7Tp7IRdULf5Fbs22rBAQIz1721Op
         yA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c79H5rQZz0sMWOQ2Dkv18YmAHI94MxyIDoL9IyRKnFM=;
        b=OYl0L8FlvSYECVi6Ct9Ms+pSPmJG+0F2ERJb9cRxaSMhrKx+GiI3zHyVS4QEHw50tl
         lHAH1E68ZaPpppipxKIzGIatBLgSqkctHmUTkm4wJshs+qkQbwWo40Gy4hYpShoMppaO
         PfpSR5V5uJnQn9800UFM21s9tfzMxtEnyp3Y2ocQCIln75VgCxn5XLay6X0miBv/MJ/0
         MEQdgmvQC5mJ+eB1b5WrGP2SWVj470ZSZq5RB73Qsz9uKbO3EH8+8mNVqbng4WcsYObR
         QKKLIOEH0bCvEMTgnj4JV17f2DxbcnqnH48LY2Za5Nk02IDCMm9ebi/jWBQOVqCCevrL
         WJPw==
X-Gm-Message-State: APjAAAWGWEqBEshji6q5MTNZLtF/zUMBkWxdEyATDcGihoHxVVC5G5Hh
        EQAc19kOvfdh8KJLdz7Ej17dtw==
X-Google-Smtp-Source: APXvYqwA2DJD2HY8jlTR3RoD8ReSjSWYM2qtbknvUUBN0/2NaV3wiCv0C3mqzB04u5cUNeZGnBVCnA==
X-Received: by 2002:a65:42ca:: with SMTP id l10mr12087312pgp.181.1559346640216;
        Fri, 31 May 2019 16:50:40 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a11sm8290710pff.128.2019.05.31.16.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 16:50:39 -0700 (PDT)
Date:   Fri, 31 May 2019 16:50:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC][PATCH 1/2] dt-bindings: power: reset: qcom: Add
 qcom,pm8998-pon compatability line
Message-ID: <20190531235037.GC25597@minitux>
References: <20190531234734.102842-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531234734.102842-1-john.stultz@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31 May 16:47 PDT 2019, John Stultz wrote:

> Update bindings to support for qcom,pm8998-pon which uses gen2 pon
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/reset/qcom,pon.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> index 5705f575862d..0c0dc3a1e693 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> @@ -9,6 +9,7 @@ Required Properties:
>  -compatible: Must be one of:
>  	"qcom,pm8916-pon"
>  	"qcom,pms405-pon"
> +	"qcom,pm8998-pon"
>  
>  -reg: Specifies the physical address of the pon register
>  
> -- 
> 2.17.1
> 

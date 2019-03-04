Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E31AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA46206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REJ0zfzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfCDTku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:40:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39428 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfCDTku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:40:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id g80so5379885ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 11:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JPOg+GSue9wrYWiMWrHItE1Mfe23cyDlrdIzF+BE7t4=;
        b=REJ0zfzPFDjYqAWlMSnOUdPeacdxkIhjygwqAQZe0f79UBXtMVvwqkOFrGL/ZjWRff
         n5tapeXNdcz3i6fFt6aP31hlP26nN0bH4co696abyYK9piIO2aoNfGBxi6esuLVDKeEk
         dt7tzqB3wnHXmaCNxG7LegFgl+qoPXuOh2v6QT1VX68aB16VqG+r+TO6WeddhdNDKd20
         uxjmIsECJ5qPoqs3J92shEVYbcnKgo9K5V+mPoVIjiEQQmMGAWIdEpiVrVQmX9qGU7HV
         Rlg15na0EsmNOS95qXLa41yjjiis/lk3mZofmq0yJ0GXZysa0d3UjlcNt5TERUJ4Jl1r
         +N4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JPOg+GSue9wrYWiMWrHItE1Mfe23cyDlrdIzF+BE7t4=;
        b=rdm1AZ9pZ8WEhipqVTdHEkfqJhL18LcRI+DhzJc6wDzP9Sxq7/9OwmEgLj4cJRW4F6
         rAmru0Z2goIt3spWXlpe50b7kMwGPE8fOYprHSTJJqTY1r3OPqbwNYN4bZoc1QyEphpK
         aBUeNuI/JHNABwo8/nU6ugo0MZj1XtB+MijbPRdPehOjsWeSfufzNfZWQOZw0HdAiG41
         Y+JclNSLzBdwUBPT+kKqgEq5R0v6AxHSg+sUYKFRYeNcDfGApodJDls4gV1xD58m7yHE
         WHnKn0ioQJ99RttlYFwzMRagvgNpfQiY1IO3DNY2FeVlUCm/Kmb+soHyd5jIXTHy24IZ
         9DRA==
X-Gm-Message-State: APjAAAVUxYynqvbCv6ivTDHRNCTIMVmcuNktgPyhtcp4KUytceBlA5bw
        fCJK5p4F0Yl2NHtzRxtB1ucr5w==
X-Google-Smtp-Source: APXvYqx6APH2ZJPnfptAh+ZW4pmzAvrWkVXzCReedH5z7OJuSoz0pvCJPGv7PfXM1vXTEt6u+zpQaQ==
X-Received: by 2002:a2e:5cc1:: with SMTP id q184mr11385180ljb.123.1551728447699;
        Mon, 04 Mar 2019 11:40:47 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id w17sm1745527lfk.18.2019.03.04.11.40.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 04 Mar 2019 11:40:47 -0800 (PST)
Date:   Mon, 4 Mar 2019 20:40:45 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcs404: evb: Fix voltage for l3
Message-ID: <20190304194045.GA14044@centauri.lan>
References: <20190219063222.15656-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219063222.15656-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 10:32:22PM -0800, Bjorn Andersson wrote:
> PMS405 L3 is outside the acceptable range, causing PCIe to fail. Fix
> this.
> 
> Fixes: 0b363f5b871c ("arm64: dts: qcom: qcs404: Add PMS405 RPM regulators")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Rebased upon https://lore.kernel.org/lkml/20181213183200.3204-1-bjorn.andersson@linaro.org/
> 
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index 3a7f0d42e35a..6146f3577961 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -87,7 +87,7 @@
>  		};
>  
>  		vreg_l3_1p05: l3 {
> -			regulator-min-microvolt = <976000>;
> +			regulator-min-microvolt = <1048000>;
>  			regulator-max-microvolt = <1160000>;
>  		};
>  
> -- 
> 2.18.0
> 

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>

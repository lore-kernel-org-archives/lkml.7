Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04513C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C1E2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="heFiNPFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfDLSBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:01:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40170 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfDLSBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:01:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so5505102pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 11:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cAyvts46CxUO1q3nqCN7N0KJfZy1nCVG+QnA5i5ndDM=;
        b=heFiNPFtUeF3lTAJAYN6IjSrct+LBCj3b+Ivt0LBrNKt6GfmQEUswMCL3pncGK5IX0
         qKv7P2GNawhvHDbtnDxFnPoBmTmUkDIctzuuZgW2BgQOIvhAhO3iQdCnxihEubk/G1F7
         CEsqHM4STpiDIU69IJDNPPy9rw8ntRYKDa7vfnMiGjLGCM5zE2eF19eyYUmLh0rujfCm
         hRVZAPlCLGTpQ5O8lBAFfeqkizN3TfBrAZi4giTAYWSq7n0cUrvQlXrSWNmMwYc0e+/Y
         4piNzteROzqhtX4NpngCZG8xzPlGclH6Z8Vs7mg5LC/Q9fVkCc6Vg3WyjypxRIBeFbMt
         7wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cAyvts46CxUO1q3nqCN7N0KJfZy1nCVG+QnA5i5ndDM=;
        b=hO0ReDEhasRc7M5XoRy3XX75rv/j9sJ1Rj3WWSy8aghvfMT0mxHvWGrOadagEoYbWJ
         xO5e/dX1Wftf52HgOji7qpbxujS0Fqm1YSecYRdQkcmTNRaWbc6p8+v8fZrUTitTYR37
         7OyRyHVnp0YiclC69CJ7/SpxQ6BFg2cyrbMvB091xjyjpCkkImNbDkmrokdgldQ5ObU+
         YZiLtEBk+OJoIJlCm2uBYlM2hB2hB2ihtkN7gni8Wg+ZcGkz95HKc5Nxbs7m7/EX1ZdT
         sh/bHv8JQntHp7rBC0t1Wfh+mtP+sSgEySufErtJTguO7Y3ciJy0cz2rPAyi9cwO2v9b
         0lRw==
X-Gm-Message-State: APjAAAXZYD5ZUXajcRqC3ezcT9yaeOtq86y1I7Ep2VlxLRYJyjsFi4dO
        Eba7Q/lCqTSiZbTjc4A/HOknhw==
X-Google-Smtp-Source: APXvYqwQ6orY+BpAnifdWUuUOGKlXUhljvz6gBnFGKCfATEll/Sog4Qcxl8RoovDhNa2/XaaBgRElg==
X-Received: by 2002:a62:6444:: with SMTP id y65mr58021628pfb.56.1555092105723;
        Fri, 12 Apr 2019 11:01:45 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z21sm59982048pfn.139.2019.04.12.11.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 11:01:44 -0700 (PDT)
Date:   Fri, 12 Apr 2019 11:01:42 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     agross@kernel.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: Add Lenovo Miix 630
Message-ID: <20190412180142.GZ1843@tuxbook-pro>
References: <20190411205144.43557-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411205144.43557-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11 Apr 13:51 PDT 2019, Jeffrey Hugo wrote:
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-clam.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clam.dtsi
[..]
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <81 4>;

Did you double check that you actually need these? (Iirc boot testing is
enough)

> +
> +	touchpad: touchpad {
> +		config {
> +			pins = "gpio123";
> +			bias-pull-up;           /* pull up */
> +		};
> +	};
> +};
[..]
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
[..]
> +/ {
> +	model = "Lenovo Miix 630";
> +	compatible = "qcom,msm8998-clam";

compatible = "lenovo,miix-630", "qcom,msm8998";

> +
> +	/* bootloader doesn't understand DT, so no qcom,board-id */

You can omit this comment, as I don't think people will miss these
non-standard properties.

Regards,
Bjorn

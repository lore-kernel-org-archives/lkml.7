Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEEFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7EA206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UdaFI7DJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbfDEOdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:33:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35714 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEOdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:33:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so3148710plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ex/VBjEd/JvWsygdRpVbzxGn6ImSWZQZBntpxZBqwxQ=;
        b=UdaFI7DJIorSFpdBunamjGRpmB+du56HY3Md0GuFiPbz5T4Dwas8+1xnKMI+c8E8W6
         fYLb2H5Gx+FuvVGPgDBy1tDik0jToY5GUYODxpDTlWX4tjCmEj8ioE0H5ZtM62ZuBv7P
         NvkPm+ztRS1XAz7+zPsAKlQcJWMQ00Y2qW5L7KN/GCHvypkvZ0lT2NoqCmtCQ/EamD4G
         rvYUS400BNXilLuCoKGjy5dFejV8YCopPSnDy2dbjHsSJIMiBd1xNLNFcV2ywwyf/j24
         9dQlghKWVTV4ohYUUtBvrLJXuEjrgv1B605BRUhNAXdnkRkbK5GEl6j79rDvYL9Vku71
         xOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ex/VBjEd/JvWsygdRpVbzxGn6ImSWZQZBntpxZBqwxQ=;
        b=tYdLNaO0sX1H69GKqPaQQPMmi01gMAkKsvDFKuo9uBaA9FOP0soUCtq8pX5PCc+nLW
         zUUN5q264Rg2YoZyN8qRvCGhsFuvVIWyeYFOAn9TPF7ZME8ClsS1F3OKQbX0YCdBQyD/
         DsCJCJ6SFL7KI6gPQrzMrDtD+79fP8+yD9K/H5T4QlbdvM0dCVdQG5x6ITaMvf7V++Y2
         yZOjRhcXe1ej2Ij0apDcENzxSPF1UTyNm+Ajj6dKJXIf/oyXdOqd8xcwqC2+ooIgtg8R
         gY7FyIqgci6k/wZ8eU1yGnQcCL1bBpukUq6v0xz97+q+mRaqWFCj5mIkFnrA1tAP4Qot
         c5+g==
X-Gm-Message-State: APjAAAVqoCBu2oXbrsFcZCcwcRIrj0PicajToKGsz/ncQLIZ7c/oensj
        3XJlFbq08+/EsLjYpifEWTn42Q==
X-Google-Smtp-Source: APXvYqxJxCTwHD3HvYHzJdYRu7YORbLq2Ss/yc5737cwFsHDRN1JVnX1csBB9Pa/Qkzfpd8vqmgeWg==
X-Received: by 2002:a17:902:2ba7:: with SMTP id l36mr12887641plb.237.1554474783313;
        Fri, 05 Apr 2019 07:33:03 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y12sm62498782pgq.64.2019.04.05.07.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 07:33:02 -0700 (PDT)
Date:   Fri, 5 Apr 2019 21:32:54 +0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm QCS404 DT
 bindings
Message-ID: <20190405143254.GM1843@tuxbook-pro>
References: <20190405035446.31886-1-georgi.djakov@linaro.org>
 <20190405035446.31886-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405035446.31886-2-georgi.djakov@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05 Apr 10:54 +07 2019, Georgi Djakov wrote:

> The Qualcomm QCS404 platform has several buses that could be controlled
> and tuned according to the bandwidth demand.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom,qcs404.txt     | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> new file mode 100644
> index 000000000000..2ea63ea827d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> @@ -0,0 +1,45 @@
> +Qualcomm QCS404 Network-On-Chip interconnect driver binding
> +-----------------------------------------------------------
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +			"qcom,qcs404-bimc"

As this is a hardware block available in mmio register space I think you
better represent this on the mmio (soc) bus - and then represent the
link to rpm as a child node of the rpm.

Apart from that this looks good.

Regards,
Bjorn

> +			"qcom,qcs404-pcnoc"
> +			"qcom,qcs404-snoc"
> +- #interconnect-cells : should contain 1
> +
> +Optional properties :
> +clocks : list of phandles and specifiers to all interconnect bus clocks
> +clock-names : clock names should include both "bus_clk" and "bus_a_clk"
> +
> +Example:
> +
> +rpm-glink {
> +	...
> +	rpm_requests: glink-channel {
> +		...
> +		bimc: interconnect@0 {
> +			compatible = "qcom,qcs404-bimc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +				<&rpmcc RPM_SMD_BIMC_A_CLK>;
> +		};
> +
> +		pnoc: interconnect@1 {
> +			compatible = "qcom,qcs404-pcnoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> +				<&rpmcc RPM_SMD_PNOC_A_CLK>;
> +		};
> +
> +		snoc: interconnect@2 {
> +			compatible = "qcom,qcs404-snoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +				<&rpmcc RPM_SMD_SNOC_A_CLK>;
> +		};
> +	};
> +};

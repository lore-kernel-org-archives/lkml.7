Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66312C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB0920872
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YN/UgLNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407941AbfFKXIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:08:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35788 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404669AbfFKXIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:08:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so8383879pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vjl9Ns8qTRMKP0J+iO0hKqMC3min1EiwS3qQ6sVNS1c=;
        b=YN/UgLNkyeTM1qoFucU0AJFUxeziYWrhUCibHWCA/qlMUN6spFPO8C0Kvv+zJFiWDC
         zXLmuybO9JFifvUo0mmqfj9igpjzb8fqlzcAz4+Yx47Sy3EhpPa2HK9x8iDXoDHBOzRw
         wBVo3r4//Gkv25xlprDkXizA7UxjgB+dzDQWPxtn0DwKTAGgkmLq2+RiOvUfT6vva2B1
         WjN23HAl91P5GutP+gJ9ynAWNtTOWJm11MBQHdpYh4QY6CW5KrXtCKBLV1zqh2z6R21S
         ++xN7LRProkA12fmgeIpexQ9SL27ncDFGksdFy/T+a3GvZ8I33Ej4FpjvxShMCxflUdd
         7GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vjl9Ns8qTRMKP0J+iO0hKqMC3min1EiwS3qQ6sVNS1c=;
        b=Fn0msEfxLzJgjE0CcJF1Xyv8ux6I+r1JlGwp071ARc2Ji3rmk9WowvKeGTnd1VtbeX
         joulbCBOi8iOxMl11bVnw3yhtwAvNjjYnz/PaunvEPy6mw97QVC/7/9Uw0KBobKdC9uB
         K43kkamadYunK7zyW2NwDFxhuoNwQBVJpOxV2702rVnzbRpFL6uxy5W4cd8KIhx05CMT
         f+PoL3vD+bii0Pc1v/BAj8HuC7+fmXhvV+GgyRUqCkBGBwUla8/1zVQKlc2RSvu5Vkbo
         qQgznniKKVsXC/VdBBiXFCRQfUJUYUodjBhyDJeyzy6yShh+1DkxphMo6wWzDJZcVDQ6
         8m+Q==
X-Gm-Message-State: APjAAAU2v3/IVVOV/YhTaVytGOLgrYXCaL9dIv7GjygnvnaHl7aC8zSh
        Ou32mXJGL9v7RzHwFHUoHvpbwA==
X-Google-Smtp-Source: APXvYqynsWTp0wdQaNa3lyxkx2tbF0tlUWrRe3v1z2Eum8yVKB/bjwEiZ8XB8FqYlwWcOT8gSLV1Jg==
X-Received: by 2002:a17:90a:25e6:: with SMTP id k93mr8367124pje.100.1560294501786;
        Tue, 11 Jun 2019 16:08:21 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c129sm29717844pfa.106.2019.06.11.16.08.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 16:08:20 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:08:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, vkoul@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: interconnect: Add Qualcomm QCS404 DT
 bindings
Message-ID: <20190611230818.GT4814@minitux>
References: <20190611164157.24656-1-georgi.djakov@linaro.org>
 <20190611164157.24656-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611164157.24656-2-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11 Jun 09:41 PDT 2019, Georgi Djakov wrote:

> The Qualcomm QCS404 platform has several buses that could be controlled
> and tuned according to the bandwidth demand.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v3:
> - Add a reg property and move the interconnect nodes under the "soc" node.
> 
> v2:
> - No changes.
> 
>  .../bindings/interconnect/qcom,qcs404.txt     | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> new file mode 100644
> index 000000000000..14a827268dda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> @@ -0,0 +1,46 @@
> +Qualcomm QCS404 Network-On-Chip interconnect driver binding
> +-----------------------------------------------------------
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +			"qcom,qcs404-bimc"
> +			"qcom,qcs404-pcnoc"
> +			"qcom,qcs404-snoc"
> +- #interconnect-cells : should contain 1
> +
> +Optional properties :
> +reg : specifies the physical base address and size of registers
> +clocks : list of phandles and specifiers to all interconnect bus clocks
> +clock-names : clock names should include both "bus_clk" and "bus_a_clk"
> +
> +Example:
> +
> +soc {
> +	...
> +	bimc: interconnect@400000 {
> +		reg = <0x00400000 0x80000>;
> +		compatible = "qcom,qcs404-bimc";
> +		#interconnect-cells = <1>;
> +		clock-names = "bus_clk", "bus_a_clk";
> +		clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +			<&rpmcc RPM_SMD_BIMC_A_CLK>;
> +	};
> +
> +	pnoc: interconnect@500000 {
> +		reg = <0x00500000 0x15080>;
> +		compatible = "qcom,qcs404-pcnoc";
> +		#interconnect-cells = <1>;
> +		clock-names = "bus_clk", "bus_a_clk";
> +		clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> +			<&rpmcc RPM_SMD_PNOC_A_CLK>;
> +	};
> +
> +	snoc: interconnect@580000 {
> +		reg = <0x00580000 0x23080>;
> +		compatible = "qcom,qcs404-snoc";
> +		#interconnect-cells = <1>;
> +		clock-names = "bus_clk", "bus_a_clk";
> +		clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +			<&rpmcc RPM_SMD_SNOC_A_CLK>;
> +	};
> +};

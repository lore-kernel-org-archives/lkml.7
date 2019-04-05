Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34FDC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DDD21855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFnv+2F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbfDEPqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:46:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43543 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:46:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id g7so4702720lfh.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ehJt99eJpY8nkQ0hoktuTKxGJ3XNJVUyU/PWnVd8elw=;
        b=UFnv+2F1/maoQV9Rb60WyQR2Oy2ItCHpG9hQRWV5iW6adeq0p1+bvPAYbKU+H4FPHJ
         6ePD9/AOMZDkGJsVMFxKJRvkS/NATIz48JxMO5/7vtrlhT7ohzKEdbu7mkn+1d3kZ3l5
         +QTyDY6X2RgBGqNK8RSspbE3+rDozr/YWeM8sejWbA+TETDDlDIwGBBDrWuiNDVNuH0t
         OdHFERWR7FVtjMC8ZzyXwSvNLnojllu+JYdzHWQyLMwC3Kj5NjNng+isTQ4z3F+ZCL0s
         3pLRaUlqmt//Zl/vsFpiyz3iDFO42rHPTx2lR+6yvdlqzOamqwG72e8z4JyevsF1uYkH
         ylIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ehJt99eJpY8nkQ0hoktuTKxGJ3XNJVUyU/PWnVd8elw=;
        b=gfjO3GDvUVD1lB+Jd4rsquyywhiD0g1ZUlrY7CRuiiAoYU7a5g94nt8aLzRQHEycbT
         qsy8YQREa5bZ6X4PxW6BpCdnIaooGsUBuSCoLA/NZhhUOs2BPdAtiCC/eGqBgszLrLei
         eYpvZMp2G3HuNPMXjVN9DIh7kLEoV5U6TFx6ggQN5mC9nRu0zR/S50T6RSMZECZw3QMg
         8+VfsCwr/RyhTMdGtzsij9hlB+na5KMHbNnyvigI+A+2+okhyIA9qX1gHq7lrKQKpSgG
         gc0xPXAucWF2jaWQB7ILUEetu4H2BK5RiKFdgjz6RnDUIDU6czfwshSMgwjBIJRvcpNm
         rZXQ==
X-Gm-Message-State: APjAAAWzyraQMqSrRzcjkpJ+Qic/4hA06bju+FBhodpyy9B9SZdyCuAj
        HxeMZUm+JDqIi2Xfsy8Ckc8TxA==
X-Google-Smtp-Source: APXvYqy/XsBNDoIRiNq579TnfOQMVn1EVYwck0Tv2sSU/ceOp8w89YE2rsvCU7e3jJnd0ef51i9+Wg==
X-Received: by 2002:a19:7916:: with SMTP id u22mr7344861lfc.144.1554479212547;
        Fri, 05 Apr 2019 08:46:52 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id f4sm4875609ljg.37.2019.04.05.08.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 08:46:51 -0700 (PDT)
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm QCS404 DT
 bindings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190405035446.31886-1-georgi.djakov@linaro.org>
 <20190405035446.31886-2-georgi.djakov@linaro.org>
 <20190405143254.GM1843@tuxbook-pro>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <9ee2c9b2-f201-abfb-be60-180befa9dc6d@linaro.org>
Date:   Fri, 5 Apr 2019 22:46:39 +0700
MIME-Version: 1.0
In-Reply-To: <20190405143254.GM1843@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 4/5/19 21:32, Bjorn Andersson wrote:
> On Fri 05 Apr 10:54 +07 2019, Georgi Djakov wrote:
> 
>> The Qualcomm QCS404 platform has several buses that could be controlled
>> and tuned according to the bandwidth demand.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  .../bindings/interconnect/qcom,qcs404.txt     | 45 +++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
>> new file mode 100644
>> index 000000000000..2ea63ea827d7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
>> @@ -0,0 +1,45 @@
>> +Qualcomm QCS404 Network-On-Chip interconnect driver binding
>> +-----------------------------------------------------------
>> +
>> +Required properties :
>> +- compatible : shall contain only one of the following:
>> +			"qcom,qcs404-bimc"
> 
> As this is a hardware block available in mmio register space I think you
> better represent this on the mmio (soc) bus - and then represent the
> link to rpm as a child node of the rpm.

The mmio register space is not used for expressing bandwidth needs, but
contains mostly QoS related stuff. We do not support QoS for now and
that's why i haven't included it. When we decide to support QoS, we can
add the nodes for the QoS registers and then reference them with some DT
property like qcom,qos = <&bimc_qos>;

Thanks,
Georgi

> 
> Apart from that this looks good.
> 
> Regards,
> Bjorn
> 
>> +			"qcom,qcs404-pcnoc"
>> +			"qcom,qcs404-snoc"
>> +- #interconnect-cells : should contain 1
>> +
>> +Optional properties :
>> +clocks : list of phandles and specifiers to all interconnect bus clocks
>> +clock-names : clock names should include both "bus_clk" and "bus_a_clk"
>> +
>> +Example:
>> +
>> +rpm-glink {
>> +	...
>> +	rpm_requests: glink-channel {
>> +		...
>> +		bimc: interconnect@0 {
>> +			compatible = "qcom,qcs404-bimc";
>> +			#interconnect-cells = <1>;
>> +			clock-names = "bus_clk", "bus_a_clk";
>> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
>> +				<&rpmcc RPM_SMD_BIMC_A_CLK>;
>> +		};
>> +
>> +		pnoc: interconnect@1 {
>> +			compatible = "qcom,qcs404-pcnoc";
>> +			#interconnect-cells = <1>;
>> +			clock-names = "bus_clk", "bus_a_clk";
>> +			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
>> +				<&rpmcc RPM_SMD_PNOC_A_CLK>;
>> +		};
>> +
>> +		snoc: interconnect@2 {
>> +			compatible = "qcom,qcs404-snoc";
>> +			#interconnect-cells = <1>;
>> +			clock-names = "bus_clk", "bus_a_clk";
>> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
>> +				<&rpmcc RPM_SMD_SNOC_A_CLK>;
>> +		};
>> +	};
>> +};

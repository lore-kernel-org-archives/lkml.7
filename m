Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABA6C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E7E2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1zuOTNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfLJJIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:08:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36494 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfLJJIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:08:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id j17so15308593edp.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AtN3Q3W1bdf9VARMb6C2iXiiZG+VLqz+9X40+TK0cJI=;
        b=i1zuOTNupXiKlWynk217tYSihTBbG46uf17LLX13BEdS44JTXmYrBDR9J8wcx7guRO
         wgNTPGd3onOaq7p+838Q9LeINfaqbihuo/WMX4jVEKNJeCkc2ZF0UB5w2mdPuZoC57aO
         jTIgy1wBREjUpHJIWdehS0K8HxNTc2uIQEcz6QohaINpCMk1n6bakccFzd/vrFUIsIdK
         EOVnsx25XiS4em6p7M6F/3ogJOHcNO0EEMJHBgP3ZEXReEN5tWa4HThzhHZ3MjnJG3y3
         Ykf8oTOoHc4Z2rnFKAJZgQvIUmxFzH3Lcgt7T99EcJDWsNCTjxmTndEWCWMM1ZdpYJUV
         7CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AtN3Q3W1bdf9VARMb6C2iXiiZG+VLqz+9X40+TK0cJI=;
        b=CbvsHr1H8z8fysjAdjeeGNuqqje8jDx/ycYam+CBaCM+gNLjhWkReo/L0lVisXgblw
         qxXQOVIdHQoGeWE7SZJ1v3IsJAWkB1s8Ve8s/zgLwdk/ObP6eTkjAUrOP5iEl1NOsa5B
         a7CZ6qvAtzqYoE1hQgp6sIxe5Wic3OfbScTpij6Rj0L+mHrI4mgKC9sr15ekq5SLi0qW
         uEdlEE8tSrLr1Y6zaBIhmY9wkCd/dMncwtQsGbfJSBXDQ4k2DseDVc07Y0yUeuB+5DME
         rKYE8yWmb4byfojkAegofMxHMEyXqQjvMM8UtJzTLydrX0bqIbo8DJ3Wz7Lm9qgq+Sa1
         Mi2Q==
X-Gm-Message-State: APjAAAXldEcqe6Tz5uXLPepAX/JmCaMjEAz0G99BKLu5sjO4Qo1IKq3E
        J7a98GLj44kjhO0Je5pLbsv2Rw==
X-Google-Smtp-Source: APXvYqxrwIVuqeKmvw7IUojlrOQ+phD5fflfDOgKrnwolC/Ge+ZJlFNHMjmWp+R4gKTxRyV6RwmEZg==
X-Received: by 2002:aa7:da84:: with SMTP id q4mr37653095eds.152.1575968912531;
        Tue, 10 Dec 2019 01:08:32 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id cb20sm56832edb.1.2019.12.10.01.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 01:08:31 -0800 (PST)
Subject: Re: [PATCH 4/6] dt-bindings: media: venus: describe sdm845 with
 optional pmdomains
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20191209083824.806-1-stanimir.varbanov@linaro.org>
 <20191209083824.806-5-stanimir.varbanov@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <cc6b409f-b562-2034-1f31-e38db267bcd7@linaro.org>
Date:   Tue, 10 Dec 2019 11:08:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209083824.806-5-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please ignore this patch for now. I forgot to add description for
power-domain-names property for sdm845. Will fix that in next version.

On 12/9/19 10:38 AM, Stanimir Varbanov wrote:
> Describe an optional DT binding for sdm845 with power-domain-names
> and clocks in Venus DT node. After that the binding for sdm845 will
> have two options, the first will be to describe vcodec clocks and
> pmdomains in (encoder and decoder) subnodes and the second will be
> to describe vcodec clocks and pmdomains in the Venus DT node
> (the parent). Both option will be handled in driver, and the second
> one will give an opportunity to the driver to dynamically assign
> vcodec pipelines for every given instance depending on its load.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,venus.txt  | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,venus.txt b/Documentation/devicetree/bindings/media/qcom,venus.txt
> index b602c4c025e7..69a104fcb8eb 100644
> --- a/Documentation/devicetree/bindings/media/qcom,venus.txt
> +++ b/Documentation/devicetree/bindings/media/qcom,venus.txt
> @@ -35,6 +35,21 @@
>  		- "iface"	Video accelerator AHB clock
>  		- "bus"		Video accelerator AXI clock
>  		- "mbus"	Video MAXI clock
> +- clock-names:
> +	Usage: required for sdm845
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries:
> +		- "core"	Core video accelerator clock
> +		- "iface"	Video accelerator AHB clock
> +		- "bus"		Video accelerator AXI clock
> +- clock-names:
> +	Usage: optional for sdm845
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries:
> +		- "vcodec0_core"	Codec0 core clock
> +		- "vcodec0_bus"		Codec0 AXI clock
> +		- "vcodec1_core"	Codec1 core clock
> +		- "vcoded1_bus"		Codec1 AXI clock
>  - power-domains:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> @@ -72,7 +87,12 @@ Every of video-encoder or video-decoder subnode should have:
>  	Value type: <stringlist>
>  	Definition: Should contain the following entries:
>  		- "core"	Subcore video accelerator clock
> -
> +- clock-names:
> +	Usage: required for sdm845
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries:
> +		- "core"	Video codec accelerator clock
> +		- "bus"		Video codec AXI clock
>  - power-domains:
>  	Usage: required for msm8996
>  	Value type: <prop-encoded-array>
> 

-- 
regards,
Stan

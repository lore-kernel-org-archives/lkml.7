Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E1BC33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883E420673
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mubr9Yrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgAHKcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:32:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42679 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgAHKcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:32:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id p9so952647plk.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 02:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JRSseHLewK0ltHlOf6IIEMSjngjyOxSD/KfPZ4IpVLI=;
        b=mubr9YrxsOv2C7hQ34JdHTW+nIwSF2+agoCwwGIe38uqhRdL/w+coigyFZAX/abKN4
         53EXMRyLW1XlzXdjaYINHxBYivMQ71jxTtaj/3m8fTTW7uZn2QIMDC/RvBC2RX5GZGPj
         IBcFRr22CvB2+x/Aylp6ue8NFLAW14HcKIalz5FP+DWrW3dxQvQ3TgOJOPaK8R/UwYdc
         biITeYn18Tard2Om0MBmQyDsgP3WEQ9gqj55g4K2XjkzQKhBS7RkBn+FtnOEmmuVAsuN
         rGzBh4icbFZFEcGCVFYu0z7HvX6DwNHGTPx29tI9i+nmvt7TnlbRX29hCZVWp0QuPdgo
         Gc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JRSseHLewK0ltHlOf6IIEMSjngjyOxSD/KfPZ4IpVLI=;
        b=gG8ue22AEw9JsvZ40Xa1XOruIVKKWjios1RqCO4xWcXaFZc7yBbWHrg9dE+RV/g4Of
         9XlaVBsZ+e7TSffhLzqT3ioU0klnolyFj+bV1ZQ5+mJnqk5ZHxVJEsHF/yqqb1uT2oz+
         EMZ9kWgoFsePXgPo6domP0Hn+CWw8+l0NveKoSvAbuOTjaq5q2eE1DE5mqEPRV8y10As
         OYP6OfRLkrbEhpz/bs/7PMv29yIGPWLRsvwrTGsu+bQdK+T+ayWZ9wiCHvrMoZvbibGN
         Y1z6XiVMvpW/iqLW2HVqL38s70tAb0QQ6wYwptc6mV20IkFaOH1eseqsUgtQw5AIGYJB
         6VmA==
X-Gm-Message-State: APjAAAUo3CsC7/ANRxJMnRPH3hli09CqQQ7YWXKrM0uR7VXRyH4UBjhr
        vptvKxu8Flgg9fdaZyTgXDVVAw==
X-Google-Smtp-Source: APXvYqzl2pKlCO2kMLeHPiwC65RgF/2o1TWeA38eJFNgsrc5MhPHh89c3t41AVilMN+OeoXZstB+vw==
X-Received: by 2002:a17:90a:cb16:: with SMTP id z22mr3550255pjt.122.1578479535942;
        Wed, 08 Jan 2020 02:32:15 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id d24sm3082639pfq.75.2020.01.08.02.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 02:32:15 -0800 (PST)
Date:   Wed, 8 Jan 2020 16:02:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: opp: Introduce opp-peak-kBps and
 opp-avg-kBps bindings
Message-ID: <20200108103210.oyrqxlybrdbelkne@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207002424.201796-2-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-12-19, 16:24, Saravana Kannan wrote:
> Interconnects often quantify their performance points in terms of
> bandwidth. So, add opp-peak-kBps (required) and opp-avg-kBps (optional) to
> allow specifying Bandwidth OPP tables in DT.
> 
> opp-peak-kBps is a required property that replaces opp-hz for Bandwidth OPP
> tables.
> 
> opp-avg-kBps is an optional property that can be used in Bandwidth OPP
> tables.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt     | 15 ++++++++++++---
>  .../devicetree/bindings/property-units.txt        |  4 ++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 68592271461f..dbad8eb6c746 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -83,9 +83,14 @@ properties.
>  
>  Required properties:
>  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> -  required property for all device nodes but devices like power domains. The
> -  power domain nodes must have another (implementation dependent) property which
> -  uniquely identifies the OPP nodes.
> +  required property for all device nodes except for devices like power domains
> +  or bandwidth opp tables.

Fine until here.

> The power domain nodes must have another
> +  (implementation dependent) property which uniquely identifies the OPP nodes.
> +  The interconnect opps are required to have the opp-peak-kBps property.

Maybe rewrite it as:

The devices which don't have this property must have another
(implementation dependent) property which uniquely identifies the OPP
nodes.

So we won't be required to update this again for another property.

> +
> +- opp-peak-kBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
> +  big-endian integer.

> This is a required property for all devices that don't
> +  have opp-hz.

This statement is surely incorrect, isn't it ? What about power-domain
tables ?

Suggest rewriting it as:

This is a required property for bandwidth OPP tables.

> For example, bandwidth OPP tables for interconnect paths.
>  
>  Optional properties:
>  - opp-microvolt: voltage in micro Volts.
> @@ -132,6 +137,10 @@ Optional properties:
>  - opp-level: A value representing the performance level of the device,
>    expressed as a 32-bit integer.
>  
> +- opp-avg-kBps: Average bandwidth in kilobytes per second, expressed as a
> +  32-bit big-endian integer. This property is only meaningful in OPP tables
> +  where opp-peak-kBps is present.
> +
>  - clock-latency-ns: Specifies the maximum possible transition latency (in
>    nanoseconds) for switching to this OPP from any other OPP.
>  
> diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
> index e9b8360b3288..c80a110c1e26 100644
> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -41,3 +41,7 @@ Temperature
>  Pressure
>  ----------------------------------------
>  -kpascal	: kilopascal
> +
> +Throughput
> +----------------------------------------
> +-kBps		: kilobytes per second
> -- 
> 2.24.0.393.g34dc348eaf-goog

-- 
viresh

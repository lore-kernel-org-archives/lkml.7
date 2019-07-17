Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB3EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740722077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X91hHiq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfGQHyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:54:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35468 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfGQHyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:54:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so4442910pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7CDBem+N4Y8GonyneakgYW4yRRjV6CTTMSRhiie6FvM=;
        b=X91hHiq+XMv6rYqH0C1L60r5PFIPz0ALpX0L4rrxy3R0L7yIB7LB1wt2GigVavcOlw
         6oNDhqTXYbkwuqZn8UJsLbssFwcot9lLbvTZCgauXQHyKkA3hbliqn/Pln2C0fQfx8x5
         yx3XJh+N84gqLV5iCqeUMA5IGPCBhOJsd5+DRpIv8Kbgo3yq9BSgMAlkIy/j9JAqR/tD
         3s8BLrcNBgsG36XBmNVIcnSSPm8aUnDU06iVjLVYRaV+9zQy5rcenYGaEiCbEompeLfl
         HtejdgkFeaAnQYV7SuoOXrGEj355XnPS6yNbRH3RUNcCJ+cEEfsWiezir5dGcPT0xRLZ
         DsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7CDBem+N4Y8GonyneakgYW4yRRjV6CTTMSRhiie6FvM=;
        b=XSszZdtV9A0VABC5Qn7WW4ZeiqaedPazLOzGzFSfRhGGk6/EsKZi6VF6Z6GUvbsBFA
         2dJFXnGYSB+MfKlynVlYQ8t3umDpGa6emgZ4hXPplbtAiFuiDpYxOFvMUrC+9Q1ccXje
         Ul6SbtDP5mbWzu11uV7QAOEpTCtMrR6e1UuPvwUGnSvi0KrV49wc4vfaQVBZRXUtXFxJ
         FXua3p29f1ih71Q1XgMq/jyhVmaMITsjvOT1NxS2g3W+KduooNR9hwZV2Z43k9lVpMjX
         9Y1DCn+OsGy441nPveHFC6HPb/eDUwSfUKtPPEfYQcJUlGSyDxi0nx59omM1CjK6zugg
         bUyQ==
X-Gm-Message-State: APjAAAVGME7K8oq6HReiiltV1xZT4TQkD7eshL8Char1JQzEt1CXBFNl
        0ngq0OjifMUSQiXExXdwS/ZB1A==
X-Google-Smtp-Source: APXvYqwS793ra2K/Q8y9DiNBlQJ9AqGzBCIEAGcfR20+btRcZICeer3TBgT1cpHsLKOv5k3Z4wKZjQ==
X-Received: by 2002:a17:90a:c391:: with SMTP id h17mr42645811pjt.131.1563350093035;
        Wed, 17 Jul 2019 00:54:53 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id z20sm37644233pfk.72.2019.07.17.00.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 00:54:50 -0700 (PDT)
Date:   Wed, 17 Jul 2019 13:24:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        sibis@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
Message-ID: <20190717075448.xlyg2ddewlci3abg@vireshk-i7>
References: <20190703011020.151615-1-saravanak@google.com>
 <20190703011020.151615-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703011020.151615-2-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-07-19, 18:10, Saravana Kannan wrote:
> Interconnects often quantify their performance points in terms of
> bandwidth. So, add opp-peak-KBps (required) and opp-avg-KBps (optional) to
> allow specifying Bandwidth OPP tables in DT.
> 
> opp-peak-KBps is a required property that replace opp-hz for Bandwidth OPP
> tables.
> 
> opp-avg-KBps is an optional property that can be used in Bandwidth OPP
> tables.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 76b6c79604a5..c869e87caa2a 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -83,9 +83,14 @@ properties.
>  
>  Required properties:
>  - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
> -  required property for all device nodes but devices like power domains. The
> -  power domain nodes must have another (implementation dependent) property which
> -  uniquely identifies the OPP nodes.
> +  required property for all device nodes but for devices like power domains or
> +  bandwidth opp tables. The power domain nodes must have another (implementation
> +  dependent) property which uniquely identifies the OPP nodes. The interconnect
> +  opps are required to have the opp-peak-bw property.

                                   ??

> +
> +- opp-peak-KBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
> +  big-endian integer. This is a required property for all devices that don't
> +  have opp-hz. For example, bandwidth OPP tables for interconnect paths.
>  
>  Optional properties:
>  - opp-microvolt: voltage in micro Volts.
> @@ -132,6 +137,10 @@ Optional properties:
>  - opp-level: A value representing the performance level of the device,
>    expressed as a 32-bit integer.
>  
> +- opp-avg-KBps: Average bandwidth in kilobytes per second, expressed as a
> +  32-bit big-endian integer. This property is only meaningful in OPP tables
> +  where opp-peak-KBps is present.
> +
>  - clock-latency-ns: Specifies the maximum possible transition latency (in
>    nanoseconds) for switching to this OPP from any other OPP.
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog

-- 
viresh

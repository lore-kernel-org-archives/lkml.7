Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B67C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2899920818
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adsbfCT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDIJX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:23:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44958 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDIJX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:23:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so8947832pgj.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dGg6zXTAqaKqlRNjVEtRm8795L22UXOKCVFnrQMVtoM=;
        b=adsbfCT8mF/1HNyWwO1137Gx3wjDO0lGjxLhCPRXNTQabijxKBUp3zdBJr2lTIGtNf
         3Q3g5oD1Kf1PT+Z+zUWYDT2rKi5LEP50E7c9aHLpQCLkvvh0DGSwctcEakrr2aSp1JWp
         HRIfWQMkhraTFjw6RvKAdjSDEV6iNBkm5Fr8PoBRHRTOkNq1IrzZmNhplFdtQj9+7HmM
         22Fi8OngpV7LlSHmVJxy+Bi+/oAuTbsOqd0xn1Dwl+MlthhUFMrt1BIC5n8pq3YdGlvf
         AjV22bQOx/fk9Y2amc6zg7s5K6qB1ZxhZIckengWn6M4wl2bK0WkK0ynaEPFcCQJx1cF
         fD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dGg6zXTAqaKqlRNjVEtRm8795L22UXOKCVFnrQMVtoM=;
        b=gFuEtgZyJgCI30YMoF7VpWWYcOH/idboeq4Unyo4CFbKQu3lfGPiY3w4c5GxoNJXjO
         Z5yYx3Zpq7OOWvfHBhQz0MsLHE9yZ2SW2Y3aYrPOD3kKVZfna5X6InjpYZjh/mQJ+KBB
         I5tZvY+dNxu76APNZsf4J+GkgPwWDQNUZDPbZv3MhU/mSGvfrlZ6UrnwDkbqJl4hsbLV
         79bxEPuwf2EGA1GotLWxFi91m/FhrPZPvbTybLlPGFhJhY6FQ5BTLFS1Qc6vhBgxY48G
         H1U5MSPRjpdT1uji3v8dHNEhLm4Tnq+rbEl2sLWOJR8hNL/0yxNwn4YNAVzEwrtxgVXK
         lWhw==
X-Gm-Message-State: APjAAAUJABcneNptbifAaypxwD1KTyAa1oYYhOToIIjYpkF9rBvPZZL+
        M61kkTHy5mgn2qM1TTnIRpDGDA==
X-Google-Smtp-Source: APXvYqwQQ2LNuyfR9ooUoJo8phCYXgwEQMiHuPF3Kv2tbzkvPwD794iU52kmY8OWu54NBWApSrcRtA==
X-Received: by 2002:a63:403:: with SMTP id 3mr29437003pge.335.1554801836073;
        Tue, 09 Apr 2019 02:23:56 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id u5sm32458231pfm.121.2019.04.09.02.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:23:54 -0700 (PDT)
Date:   Tue, 9 Apr 2019 14:53:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/9] dt-bindings: opp: Add qcom-opp bindings with
 properties needed for CPR
Message-ID: <20190409092352.joayvxyo77e6lehl@vireshk-i7>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-7-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404050931.9812-7-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-04-19, 07:09, Niklas Cassel wrote:
> Add qcom-opp bindings with properties needed for Core Power Reduction (CPR).
> 
> CPR is included in a great variety of Qualcomm SoC, e.g. msm8916 and msm8996,
> and was first introduced in msm8974.
> 
> Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  .../devicetree/bindings/opp/qcom-opp.txt      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
> 
> diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> new file mode 100644
> index 000000000000..d24280467db7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> @@ -0,0 +1,24 @@
> +Qualcomm OPP bindings to describe OPP nodes
> +
> +The bindings are based on top of the operating-points-v2 bindings
> +described in Documentation/devicetree/bindings/opp/opp.txt
> +Additional properties are described below.
> +
> +* OPP Table Node
> +
> +Required properties:
> +- compatible: Allow OPPs to express their compatibility. It should be:
> +  "operating-points-v2-qcom-level"
> +
> +* OPP Node
> +
> +Optional properties:
> +- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. Even
> +  though a power domain doesn't need a opp-hz, there can be devices in the
> +  power domain that need to know the highest supported frequency for each
> +  corner/level (e.g. CPR), in order to properly initialize the hardware.
> +
> +- qcom,opp-fuse-level: A positive value representing the fuse corner/level
> +  associated with this OPP node. Sometimes several corners/levels shares
> +  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
> +  min uV, and max uV.

I know we discussed this sometime back and so you implemented it this way.

Looking at the implementation of the CPR driver, I now wonder if that was a good
choice. Technically a single domain can manage many devices, a big and a little
CPU for example and then we will have different highest frequencies for both of
them. How will we configure the CPR hardware in such a case ? Isn't the
programming per-device ?

-- 
viresh

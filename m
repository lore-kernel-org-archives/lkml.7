Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7918CC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F48B2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgThgCgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfDJD0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 23:26:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39034 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfDJD0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 23:26:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so634633pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 20:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sjLTw+m2ZEwqD7IRnenJTwcO08Oa8viTpb2e9ccyS4U=;
        b=LgThgCgOgkN7pRj4T2GtyzrHmfduHws5+SQcF+2AIjGl7LmENhPJB8jlNW5djJbR8H
         6FmJM/guN/c9YODnuQ3+CAG209rwzEYljgCvJVHJrAAbTeuFqr2a/QcqLRGAIi8OFzwE
         o7sGMo7fXEl+x5AhPK1OiMlhvjAcib4pixHo4b0BehcZa+KFDk6b3LzjH9uGFK0tFGEN
         NIvWjYhirgM4M6uILdsIUOhmq3zaqBLLhxNmZQAMqFdF4HMOiO0bDmtrfAeMmRKB5QaK
         seLKOuJ8AmjpSTqDdHvi+dJXj7SOKx1ycjqjMu8eyF7J09N4BbeEKYyoRJenr0V+N/c1
         eT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sjLTw+m2ZEwqD7IRnenJTwcO08Oa8viTpb2e9ccyS4U=;
        b=TfMTL2nqamfgPpr0hjsiv593BQYEq5FqpR29bg7eWhbJaDjEgzxZDW93nwsY/pgsRi
         hShID2DVZlHfN5ZanmA1zwDfgV0NI56/BghrorKf0EEmI4jo2E0mJWweDizbWhufc+GQ
         imghEtUZDESClT0E2SqaVY7W9PoXq2MmAqDAm1EiXY1yCzfALnYfsywh79ungTMXtkvu
         AxQD2yAQeveKFaiI+lhgCu9dKNxZuAzexU7deoAFL5Kxkycz6l7hqRrhaSorx6rGu+yN
         Z1eol4+yEm3scdIQP7MUNh8ZmxVyjf/DLUjf8nEwfiPUMsVbo5f0DP5CCJW83GVdQxZm
         srFQ==
X-Gm-Message-State: APjAAAX5iLh8eKfY4ui42JD8Q42NrvG/87Q7NbdHHQIVRjch9q22699D
        R5cZ3kK2qvBlL9Easj7QFguYVg==
X-Google-Smtp-Source: APXvYqwZerODFzooN1BoAnAvg6g1i9NOJ4zDlf5w0jfGkfzixlOMaLzkxMFtkfQa4oe1517myGS1dA==
X-Received: by 2002:aa7:9088:: with SMTP id i8mr41168740pfa.118.1554866771683;
        Tue, 09 Apr 2019 20:26:11 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id w23sm39848156pgj.72.2019.04.09.20.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 20:26:10 -0700 (PDT)
Date:   Wed, 10 Apr 2019 08:56:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: cpufreq: Document
 operating-points-v2-sunxi-cpu
Message-ID: <20190410032608.fqxahvys6rysvayy@vireshk-i7>
References: <20190409172558.18778-1-tiny.windzz@gmail.com>
 <20190409172558.18778-3-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409172558.18778-3-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-04-19, 13:25, Yangtao Li wrote:
> Allwinner Process Voltage Scaling Tables defines the voltage and
> frequency value  based on the speedbin blown in the efuse combination.
> The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each
> OPP of operating-points-v2 table when it is parsed by the OPP framework.
> 
> The "operating-points-v2-sunxi-cpu" DT extends the "operating-points-v2"
> with following parameters:
> - nvmem-cells (NVMEM area containig the speedbin information)
> - opp-microvolt-<name>: voltage in micro Volts.
>   At runtime, the platform can pick a <name> and matching
>   opp-microvolt-<name> property
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt

LGTM.

-- 
viresh

Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A684C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4D420872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPV2Tcxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfDQCJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:09:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42130 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfDQCJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:09:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so11259597plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 19:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UtPgie9W+jVjs6lTZwzj46q4btHZghcKfvIvGVTcL0E=;
        b=PPV2TcxoKH3c6hoWGwTGaVo+AI9e2Vu02t1eXRXiex/1RzRycPOvi9bAI8X+6Gr8DP
         XDv9Dsl0j63LPcyVb+X6Lpb+Xy2rJwSUIp9e5QlUf0oBE8GxBkVLTZGYHdqzaU0Q+2hS
         DSjmKaN2R3SjmjXa6iBnFNnMg5qGclszJZFhfPqPqrNmk7l5KazRJQHwM5o33K4KP4CQ
         f+OLKJGHwKmOIMchCWPv/7HGvxSv9uTRFUK/QykPLS2Nq657zL7t9qjtv035x4PLXGfV
         3B5Qz2Ik1rj3rCLgHQMuGiymUo06Oe8B8FuQJ4Ihjq0TLuPKM0Q8vm2IGLvNqDkFZpNR
         MtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UtPgie9W+jVjs6lTZwzj46q4btHZghcKfvIvGVTcL0E=;
        b=Y7cJz8WDP52n1GX1djTuW9a0QoYa5nZ2Ra9RRYsx9yVHy5lyrXMGH2D9n6GN2SmydF
         QeL40hQHOxSYRCXzDTgA9aRL3mF8PqWWykiKfgc17N82kWz/+fhz4/MVrZziWWUCL6pQ
         QkzJ0g7cjD3Wqot6NYWD6yVNUt2O3O+NKAsq0baxii7gTO7rOD4/oE6ZrbuFGXhL3AxS
         s+R+FNzDir3W6tuQ4erNrwr9Knc7LPR+vKP+KVlMLAjQKGbsIEWM+6u0w9g1j15d9xjt
         RlP8pWu1nxM8we/QOyOAKReXCjDS8FIvp8+W6NYSLDfb9fGZE9FzTdzr/iYnHm/W+Lcr
         ay6Q==
X-Gm-Message-State: APjAAAXLU43ZxXf4sKhFbKNFHrO7fBcaHz3WpFUcCB8J9Unmf8UnhLz6
        W89/xblVWTgpsHz1RIV17m1GKA==
X-Google-Smtp-Source: APXvYqynuNGuoJx+xyBcaGnrTay1xtJXqj5Gxox58vQ8nMJdRMdz3zxGlto8glHkw2IHlimAMda71w==
X-Received: by 2002:a17:902:bb0d:: with SMTP id l13mr83300207pls.141.1555466971906;
        Tue, 16 Apr 2019 19:09:31 -0700 (PDT)
Received: from localhost ([43.229.100.82])
        by smtp.gmail.com with ESMTPSA id l1sm67750147pgo.13.2019.04.16.19.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 19:09:31 -0700 (PDT)
Date:   Wed, 17 Apr 2019 07:39:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: cpufreq: Document
 allwinner,sun50i-h6-operating-points
Message-ID: <20190417020927.cl4b6wadpjcxn4om@vireshk-mac-ubuntu>
References: <20190416155209.24216-1-tiny.windzz@gmail.com>
 <20190416155209.24216-3-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416155209.24216-3-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-04-19, 11:52, Yangtao Li wrote:
> Allwinner Process Voltage Scaling Tables defines the voltage and
> frequency value based on the speedbin blown in the efuse combination.
> The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each
> OPP of operating-points-v2 table when it is parsed by the OPP framework.
> 
> The "allwinner,sun50i-h6-operating-points" DT extends the
> "operating-points-v2"
> with following parameters:
> - nvmem-cells (NVMEM area containig the speedbin information)
> - opp-microvolt-<name>: voltage in micro Volts.
>   At runtime, the platform can pick a <name> and matching
>   opp-microvolt-<name> property.
> 			HW:		<name>:
> 			sun50iw-h6      speed0 speed1 speed2
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt

I would need an Ack from Rob before applying this.

-- 
viresh

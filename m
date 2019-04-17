Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CBCC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3A220872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GoVQcyJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfDQCIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:08:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44609 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfDQCIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:08:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id i2so11226437pgj.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=geRlmDcTul9VB73FjWPElo/UilrGz0nFvp9dtLpPLeY=;
        b=GoVQcyJZRwhl7wZkGWzqM+RAg3Pi3z+6Sq9Oy9pJr0a+SOCroSCMVYG5rcm0SDcjOo
         SoABpNURyNVfOG4KK1BIF6zIRed/JOGVY7MZSJl+yQvg0F9Nr+EK42yThVVZHQmo20dE
         YmOYmGC8/CutvGtJQBsKdbzbzAfoqr+1TBYwhFCKu+UnisZrbU2Q8uivkPYOlu+FKHw2
         D9cNI5yOqDGJj7hjPXfXfNO8BEHewkRgNo5sgoDtOXY++W1RSfUxn/uBFQNQxraux1wn
         z2mVPAPopjU6KMZqebrFbj5T91Ld38O+zwhhWrS0fF+Xxd1WqkHEYtYM1mziRyDsxM6V
         s2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=geRlmDcTul9VB73FjWPElo/UilrGz0nFvp9dtLpPLeY=;
        b=rkGQDn0rt+vQacrU+U8ZrEYjpvLc37vf8NPGpl/0b6vBhHK0pZKb+nPY05rTLxHI5N
         lZK2+L12IIHSdXTrcwvAQ4ww3qptumaW7MG6K6Ajzt6bgqLi+cGQBou3ppcdeltykqVj
         7LprQif8V97EzaB8m4d3SLBRYsdNCXBqKaS3ADejbS2qpPuBV6+X7igZNgVDwohC/L1S
         4JB8w0f9UvVvjpUtQlKhGZr6+ZtPW7OhfPrwfd0YCkeJlXil0mmqkOe/nGcWSD1TGNHZ
         uLrqqLEXlFwCW9mYs6Ii3gccavw36oTzoMkatXnxWl8tZ72oTWzNXdeH2+AF5bpx/WUM
         oI6A==
X-Gm-Message-State: APjAAAW3JwcTgR4tSG33Tkg5Lwp8pAfLXemQhL2bagVfkNMnvjxDnF+3
        7s+Of/sa/rU3vmTRHGks+QiB3A==
X-Google-Smtp-Source: APXvYqw94x+tjDFSROug4pcVZ/D3RA9QE6a7pcNPphmcuoi4litVxhyc5iKI71m0nn7Em4vRTGPU0A==
X-Received: by 2002:a63:e70c:: with SMTP id b12mr77162721pgi.399.1555466916574;
        Tue, 16 Apr 2019 19:08:36 -0700 (PDT)
Received: from localhost ([43.229.100.82])
        by smtp.gmail.com with ESMTPSA id v19sm96511015pfa.138.2019.04.16.19.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 19:08:34 -0700 (PDT)
Date:   Wed, 17 Apr 2019 07:38:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Message-ID: <20190417020830.f5empr3rr3ifbstl@vireshk-mac-ubuntu>
References: <20190416155209.24216-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416155209.24216-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-04-19, 11:52, Yangtao Li wrote:
> Add sunxi nvmem based CPU scaling driver, refers to qcom-cpufreq-kryo.
> 
> Yangtao Li (2):
>   cpufreq: Add sunxi nvmem based CPU scaling driver
>   dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points
> 
>  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 +++++++++++++
>  MAINTAINERS                                   |   7 +
>  drivers/cpufreq/Kconfig.arm                   |  12 +
>  drivers/cpufreq/Makefile                      |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c        | 226 ++++++++++++++++++
>  6 files changed, 415 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
>  create mode 100644 drivers/cpufreq/sun50i-cpufreq-nvmem.c
> 
> ---
> v4:
> -I removed this sunxi_cpufreq_soc_data structure for now.

Why this change ?

> -Convert to less generic name.
> -Update soc_bin xlate.
> v3:
> -update changelog and title
> -convert compatibles to allwinner,cpu-operating-points-v2
> -document the valid names for opp-microvolt-<name>
> v2:
> -update changelog
> -convert to dev_pm_opp_set_prop_name instead of
>  dev_pm_opp_set_supported_hw
> -some change in OPP Node  
> ---
> 2.17.0

-- 
viresh

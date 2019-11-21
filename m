Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67831C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4065620872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qodeJAUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKUFda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:33:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37448 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfKUFd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:33:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id bb5so1034810plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 21:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qKAo4Cdbl5qk57EbVutaV8+esKv4OGYytS6E1Z1Hoxg=;
        b=qodeJAUR+rZeMgjzPXZiFahJ3Avgxa76msvsNtTUEln3ZNxt+mNP+kCJM07Z2PG0jX
         Kon5ZObszQAEu89WoRs85QNPHUlhv1hY7HRgrc2sDZY9Ltuyt9PjNAjl2OhAQ9rKenj8
         i2lZ6BjVjJcXVyg0f3ciwc7Fd5YhAeCuQvutbo43WsAMXm+MFVJBj+Hqk5UlfW2WaEwH
         ErIUfV42I3y60+UUbmsJHeKmwyPIwJeHURXBciRkCweGFW0JGy9GR0+l8/evwbSYWgaZ
         Z+/1VZnn/ar0ASwilIL7pt7do2/pH+RU4fsxzpwgUCLhgzMSl5gsqNF4otnmKf/J4gGd
         U2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qKAo4Cdbl5qk57EbVutaV8+esKv4OGYytS6E1Z1Hoxg=;
        b=aiud1YEBSRyNhxR+dPi1I91VoqWV1uczI37aRIF7j3nyQO3slcAbhU/tnBsUHK1Hk4
         fCIuAh/5DrGcidn2aBWZvxu7R2+xuPa41RgDg5kxa53CCO16S1b/tPqFtwQPOIyfE95C
         NsqRo3Pxb58IkHVFYdk6amEGtvrF3QM27eijket30bWV951J2f0x1iBb9ugmo/+gcdUN
         IvTfzYZmr+ahcpCQfpjM4p6ky2TbnErE6FseqQBSf7njuRBlGmqnouu/ge9s/V3Frvyn
         bBdhVF+gPe1+vSH2mozLWnEZjRJhk/gqd9HD9l8Y/WKaCp2SbWKjk0aBzC0y+UfZ0eJ2
         plog==
X-Gm-Message-State: APjAAAVa+vwffItNwhJc3+rGwbk0kuK+NJp0KXCQSai99eO7Wiqw9zs8
        cpQe0CcZvLPLDtaXT/Rt6UiB2Q==
X-Google-Smtp-Source: APXvYqzsTLcuU0XxK0Ryor0wos8+N5G+mRJhTd5+IqLed83rC9VEmWuT+iwfe8mMkokktF0xfFwRnQ==
X-Received: by 2002:a17:90a:7188:: with SMTP id i8mr8701309pjk.6.1574314408174;
        Wed, 20 Nov 2019 21:33:28 -0800 (PST)
Received: from localhost ([223.226.74.76])
        by smtp.gmail.com with ESMTPSA id s2sm1094335pgv.48.2019.11.20.21.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 21:33:27 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:03:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: Fix Kconfig indentation
Message-ID: <20191121053322.2vy3vbnkgxomegop@vireshk-i7>
References: <1574306355-29316-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574306355-29316-1-git-send-email-krzk@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-19, 04:19, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Fix also 7-space and tab+1 space indentation issues.
> ---
>  drivers/cpufreq/Kconfig.powerpc |  8 ++++----
>  drivers/cpufreq/Kconfig.x86     | 16 ++++++++--------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
> index 35b4f700f054..58151ca56695 100644
> --- a/drivers/cpufreq/Kconfig.powerpc
> +++ b/drivers/cpufreq/Kconfig.powerpc
> @@ -48,9 +48,9 @@ config PPC_PASEMI_CPUFREQ
>  	  PWRficient processors.
>  
>  config POWERNV_CPUFREQ
> -       tristate "CPU frequency scaling for IBM POWERNV platform"
> -       depends on PPC_POWERNV
> -       default y
> -       help
> +	tristate "CPU frequency scaling for IBM POWERNV platform"
> +	depends on PPC_POWERNV
> +	default y
> +	help
>  	 This adds support for CPU frequency switching on IBM POWERNV
>  	 platform
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index dfa6457deaf6..a6528388952e 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -4,17 +4,17 @@
>  #
>  
>  config X86_INTEL_PSTATE
> -       bool "Intel P state control"
> -       depends on X86
> -       select ACPI_PROCESSOR if ACPI
> -       select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
> -       help
> -          This driver provides a P state for Intel core processors.
> +	bool "Intel P state control"
> +	depends on X86
> +	select ACPI_PROCESSOR if ACPI
> +	select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
> +	help
> +	  This driver provides a P state for Intel core processors.
>  	  The driver implements an internal governor and will become
> -          the scaling driver and governor for Sandy bridge processors.
> +	  the scaling driver and governor for Sandy bridge processors.
>  
>  	  When this driver is enabled it will become the preferred
> -          scaling driver for Sandy bridge processors.
> +	  scaling driver for Sandy bridge processors.
>  
>  	  If in doubt, say N.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

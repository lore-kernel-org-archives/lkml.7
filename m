Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0AAC4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC8320830
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOYsGPAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfINPZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 11:25:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44513 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfINPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 11:25:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so16852753pgl.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h+ybOgPBdbmgnuqXjRrYZvQSWICvx+jC8gaIu6wXEOA=;
        b=vOYsGPAyZpkVOY+nRiXzF96qBLgnTZ28L+QyZ4t5Q1tK2Old+HBi4/qPnWyAZ3vPMX
         8oaBj4muk9qQGCj8nzyHnIMV4au+ieHO9lXEUdpgrqWk5GLkBzi9UEaHrrDRO2MkZAwV
         qkJI/2kMb8kL4ISkWfcaDcRM2wMytHsycvt7dzjj2ULlvKAPcBoKRsY/OhlVw5eSdYG6
         KF5hgSFFJ2n9V2R3HiyzZwU8NZEAH+tUtasmjkGvmEtnfyyXYf3ckoPwA6ns2fzhEdrz
         6Q9yQK5WGb76E4d3R3RdPbsgPXBfzJLopPTc5O25EulQpJOmO9rFWCQ6TnwWghBbRoDV
         CZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=h+ybOgPBdbmgnuqXjRrYZvQSWICvx+jC8gaIu6wXEOA=;
        b=X5eEw/oLZmhsfNyWDWpumS/X6uThqH79LtgbzepviEvwQxGAxa1wQYSTbk1qWv6ALk
         TdMoPaEoGkpGFTZ8i2uv6J+UdShA26P4Y7HGCqo/i3J+waOoLD83CXAXV5ZoVSjkdc5R
         P1GBC/Qhz9cirCJNeWbdOwMUdxQA3eTk4YNJp/ix7xiKcj167XbyIW6OxjRBfg+nrAUT
         otrDy9gUS/vJqX0RKLD1EOnPuEFd1bAjJSVCJFz7/ptf7WGmT63sc9AdQrN6CX2cKQsV
         zFp1yinhs+7iq1JLmYUfEkr8POB8MSpMl5nKU+3hIxGtoppxZxXVkLOh5fpU8Q1MCUpQ
         pPCQ==
X-Gm-Message-State: APjAAAXWt/NoQhfFTBYEKcoFLykWt/Iy9M0ZZRdGPMkir8S3eFUgen8/
        54VB1KEVON2FW3bY6iAjkqc=
X-Google-Smtp-Source: APXvYqymogWDolBNczo2kKGqCE0LvOI9iMDUyqNgRBjbZKJeFny0oVpcdX0aY8yvQrvFNUwH4BROGQ==
X-Received: by 2002:a63:89c8:: with SMTP id v191mr349331pgd.395.1568474747250;
        Sat, 14 Sep 2019 08:25:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a18sm26574996pgl.44.2019.09.14.08.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2019 08:25:46 -0700 (PDT)
Date:   Sat, 14 Sep 2019 08:25:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] ARM, arm64: Remove arm_pm_restart()
Message-ID: <20190914152544.GA17499@roeck-us.net>
References: <20170130110512.6943-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170130110512.6943-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2017 at 12:05:06PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Hi everyone,
> 
> This small series is preparatory work for a series that I'm working on
> which attempts to establish a formal framework for system restart and
> power off.
> 
> Guenter has done a lot of good work in this area, but it never got
> merged. I think this set is a valuable addition to the kernel because
> it converts all odd providers to the established mechanism for restart.
> 
> Since this is stretched across both 32-bit and 64-bit ARM, as well as
> PSCI, and given the SoC/board level of functionality, I think it might
> make sense to take this through the ARM SoC tree in order to simplify
> the interdependencies. But it should also be possible to take patches
> 1-4 via their respective trees this cycle and patches 5-6 through the
> ARM and arm64 trees for the next cycle, if that's preferred.
> 

We tried this twice now, and it seems to go nowhere. What does it take
to get it applied ?

Guenter

> Thanks,
> Thierry
> 
> Guenter Roeck (6):
>   ARM: prima2: Register with kernel restart handler
>   ARM: xen: Register with kernel restart handler
>   drivers: firmware: psci: Register with kernel restart handler
>   ARM: Register with kernel restart handler
>   ARM64: Remove arm_pm_restart()
>   ARM: Remove arm_pm_restart()
> 
>  arch/arm/include/asm/system_misc.h   |  1 -
>  arch/arm/kernel/reboot.c             |  6 +-----
>  arch/arm/kernel/setup.c              | 20 ++++++++++++++++++--
>  arch/arm/mach-prima2/rstc.c          | 11 +++++++++--
>  arch/arm/xen/enlighten.c             | 13 +++++++++++--
>  arch/arm64/include/asm/system_misc.h |  2 --
>  arch/arm64/kernel/process.c          |  7 +------
>  drivers/firmware/psci.c              | 11 +++++++++--
>  8 files changed, 49 insertions(+), 22 deletions(-)
> 
> -- 
> 2.11.0

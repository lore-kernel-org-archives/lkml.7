Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B22C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230FD2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0HE4YTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgABJlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:41:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35352 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgABJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:41:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so5123008wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 01:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YYk4RrqRiHeXeFHSCs0JC3WBbVYcdJO0K+vRjr20Yqs=;
        b=k0HE4YTKVkQUa+xBDwoWEQBzlyTB7JaRFUy6T9nsBzdlb3Xpd8PcnP+qxFaauI8o4J
         xtI+vEvHUIVhKFWH0bkoNXrv3SJwS9/uxlW1riHDQptF6IXI8aumjuG4kKHW1HIjii5G
         HzKiIJ1kxR8kE2TnqeDvGi12v4i/iPQvCucj+Z9W/4rHN8zGtUVDJDxq7Af6DqOn7CXW
         ieghe5Op++kFiXBMrb6I7WYfwCG+SG6j+GTkAQbNR6VChT0jqjcQndU+utyQo4RNNJ9T
         BGagzR2kDfcP3DmBHwG7DqArOu3bU65dC49sTAV49nn04GT0QXV2z0CVjyo5tNnd3Mer
         vzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YYk4RrqRiHeXeFHSCs0JC3WBbVYcdJO0K+vRjr20Yqs=;
        b=tBp2FqURmOuawVMh1gKUKrtflUkBpiUcOgXOWylMgWSlxgSE3/sW90k1kzrvZbMoRa
         KenZxuDzY5IrTvfiSAtydLkUVkD/eHr0bFF5xhjdO4BP9B9gdFtXydTCDHV1Mn18ue4a
         YeaTN+tp/Oh/ZIK1e+SyWIYpJC/LQdmuTcBa1cDqt29g1xFDKx9VW8LbN2KYC++IEPoJ
         JyqVDQtxQWTAfn84lEFo62IVjx6rGnG6RZYaSVI1qolq/vD3vQhF9imkBPqfOeYsvvyj
         Yn9qSLWwCFPI6fgLm53xyRLxKjFvAVXbgWHBApt+UteAuaq8N+BHHUMZMNVPEAFhDIM2
         ppxA==
X-Gm-Message-State: APjAAAVpjGgvKEVE7mKYop6iq71Q5hJ5uTk+Cioqfchji2pLyaVH0xIN
        thkfelWc9RbKrdXSO/WLHDj/Aw==
X-Google-Smtp-Source: APXvYqwDF9sbmfRnF0Oz9U/vaygIh98Mwxqw1Ir/2oy8I03ejwfX5WPa/DoHdrFYc7LoZ8c+k4ViJA==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr14168952wmo.147.1577958074638;
        Thu, 02 Jan 2020 01:41:14 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id t190sm7950580wmt.44.2020.01.02.01.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 01:41:14 -0800 (PST)
Date:   Thu, 2 Jan 2020 09:41:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/37] platform/x86: intel_pmc_ipc: Move under MFD
Message-ID: <20200102094126.GG22390@dell>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
 <20191223141716.13727-34-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191223141716.13727-34-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019, Mika Westerberg wrote:

> This driver only creates a bunch of platform devices sharing resources
> belonging to the PMC device. This is pretty much what MFD subsystem is
> for so move the driver there, renaming it to intel_pmc_bxt.c which
> should be more clear what it is. We convert the driver to call MFD APIs
> in subsequent patches.

Nope.  Not happening.

It's not appropriate to dump a 1000+ line source file into MFD without
a thorough review.  For starters, the 100's of lines of code which
support the bespoke IPC APIs should remain within the 'platform'
domain.

It's okay to move the subordinate device registration into MFD, but it
will need to be converted *whilst* transferring it, rather than the
dump/edit method currently implemented.

> While there update Kconfig entry to be more descriptive.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/mfd/Kconfig                           |  13 +-
>  drivers/mfd/Makefile                          |   1 +
>  .../intel_pmc_ipc.c => mfd/intel_pmc_bxt.c}   | 214 +++++++++---------
>  drivers/platform/x86/Kconfig                  |  16 +-
>  drivers/platform/x86/Makefile                 |   1 -
>  .../platform/x86/intel_telemetry_debugfs.c    |   2 +-
>  drivers/usb/typec/tcpm/Kconfig                |   2 +-
>  .../linux/mfd/intel_pmc_bxt.h                 |  11 +-
>  8 files changed, 132 insertions(+), 128 deletions(-)
>  rename drivers/{platform/x86/intel_pmc_ipc.c => mfd/intel_pmc_bxt.c} (72%)
>  rename arch/x86/include/asm/intel_pmc_ipc.h => include/linux/mfd/intel_pmc_bxt.h (83%)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

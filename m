Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E453EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA780215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSJnFgvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfICGUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:20:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36433 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfICGUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:20:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so16051832wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 23:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YKY88mE2T1JIVhonH4BKsN4In+EOCkLewu/cYwg0NFI=;
        b=oSJnFgvpy0N/Nmx5iIH3UkDpNMrRdPCgW0b4jddqpLvi4/d1Rkz0iH9x6JROMRweXs
         XdX7jguoInFB7gtTaGYBrXzI6qz0J0da8yO+VYo7yCy4565Z/40NDO3pHW7vWgx5Vf0o
         Vxlbis9eTsOPTASQ0Oky9OzE/ET2cNCAJ4t62ZXj4YjOhG+UraKA6e0MvanYzVQ8NR1K
         o9Y685UaF4FtTl+zcgsEUNhEVPOcbPUi24DqfjU46CfvhOizKa8OuRggtVCAjBunUn/s
         klakPSif8jugFhmBXjktCEhCN3hZu5YWuyvSxMGJof5mdhJTcriZLh8wDRDbg/PKbQNP
         jIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YKY88mE2T1JIVhonH4BKsN4In+EOCkLewu/cYwg0NFI=;
        b=DtTXqBzZqCCeQuPuOh9RzAABzc/sLns5eX7q0STfGJjkEJ3dE0xYXLDfCmHqyj2ecY
         iKUNoISMhn4idF+P0MH4PCRX2wO4ONxg8YPx4bj/Tv1+eWocfTvTP3mbCbug14hHBPWD
         711UehN5FsdN1Wg3+c2QT2CER1HkA2ZCpJxweVdJ5P/XdWr5eExXo2/yPUdsDjkHFOYx
         AMwfJxh2aVplNVUt4VXq5C6sGuAfIXQeyw9MHjHl+YQGD1g+K8WXnHdRLwYIAyUMZ8xE
         K2bcb1/38j41ULMBwW7WhsiazL12JEGn/dG3chrQlriJj53/GBO7DRxBzL3cDcTjQMVD
         0a3w==
X-Gm-Message-State: APjAAAWYuKvtCiDGwEoB+MuY7r+sJARuTO+98+PLNo7NdIjzZMy/fvAf
        8vxl+JXLYlmcl+tZDefxNZ44kw==
X-Google-Smtp-Source: APXvYqzxTP9Izgjyqm7VZnX7b5HaQgM+sZAiS2X6RszH2QLjrimvK7wmFA+TGBzFrnlM0Gq6VvNosA==
X-Received: by 2002:adf:e912:: with SMTP id f18mr38483436wrm.46.1567491642530;
        Mon, 02 Sep 2019 23:20:42 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id o193sm19866846wme.39.2019.09.02.23.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 23:20:41 -0700 (PDT)
Date:   Tue, 3 Sep 2019 07:20:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: qcom: Add Lenovo Yoga C630
Message-ID: <20190903062040.GC26880@dell>
References: <20190902132400.14084-1-lee.jones@linaro.org>
 <20190903054451.GV6167@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903054451.GV6167@minitux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Sep 2019, Bjorn Andersson wrote:

> On Mon 02 Sep 06:24 PDT 2019, Lee Jones wrote:
> 
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > The Lenovo Yoga C630 is built on the SDM850 from Qualcomm, but this seem
> > to be similar enough to the SDM845 that we can reuse the sdm845.dtsi.
> > 
> > Supported by this patch is: keyboard, battery monitoring, UFS storage,
> > USB host and Bluetooth.
> 
> Applied this to next-20190829 and booted it, got a little bit of EFI FB,
> then the screen goes blank and after a while I'm back in GRUB.
> 
> I've not been able to figure out what's causing this though.

Probably DMA.  There is still an issue in the COM GENI Serial Engine
Driver which reboots the system when a DMA transaction is initiated.

However, with a workaround patch applied to the Serial Engine driver
(drivers/soc/qcom/qcom-geni-se.c) this DTS has no issue booting the
system.

We have ~12 weeks to either fix or elegantly work around the Serial
Engine issue.  IMHO is makes no sense to hold back this enablement
patch (which cannot go in via the -rcs) for something which is likely
to be fixed and applied during v3.4-rcX.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

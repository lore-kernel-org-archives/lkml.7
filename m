Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B11C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC01F20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ou3ERKZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfCSKBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:01:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34214 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfCSKBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:01:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so2021434wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=opIwr+LSOxebZuop6rJKZi2dDlWJbe9q7JQeFwl12vc=;
        b=ou3ERKZXc13ZIO3uMV1dAKJiph09MzUn2Iz/+74xW8AKAEf54On4+B6xfd9cW9crA+
         IPW4FRIpBusWJ+Uevhn4HeKecEAeV6h1zl4nqFIxhFaM94ZxPxczDTSe5JPa/CwwlvGV
         Ne50AC1aUhavUvQNmm2NtwdVMzjmPc+PPbL2T4YHYbBCIaQHGyhiX4P2Sh2X4RPsemPi
         CH8R2HEQdvBZ0/PaoamK+ii6s07BWMlXHzwIGgSg6zQYNkQHkKm2r213Xz4atLQaYr9N
         D7ua91avN0vkyNyCp5VKteCrh8wf77UNwC5XcZxRbtV5P6ljrpssJkTO6L+NY2rscYBd
         Zb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=opIwr+LSOxebZuop6rJKZi2dDlWJbe9q7JQeFwl12vc=;
        b=FJMaGGwRLo1ogRbqVe5qJW8Rqn9zss22Q6H+LLJz3Yh66TqJgXPvpX/RWHzYlSqmDP
         fHd6OBSdAg7SMB4I990HIzO/Mhm4c17WoITna/Kpv6cvZzAFLDjuTetL2Qpwpxl8Lwka
         56f8TDqSLVnHP28D9MYcacSzN+tz2bTFEgRBLpGEVl7KXbrJYl0deTZRGpYbVlVKvIBy
         J3csPJLh8SQOStLPg0j7mXTCA/riKUqrZpu1yN6AhvkBUMiBqsS09pROlVf3FyZMZQLP
         fynPT58Y7BauW4mTt9E4A+SgUS/KTOhP2Fd1B83W30WZHF1iL0tDV757pnlXL69vAZ9l
         7Vtw==
X-Gm-Message-State: APjAAAUjZoZ9Qf0yKeQl6UpbjN7k22o78Etum+SuvPXGe3N0EqYNPJjH
        KtbvG375hOmKKZRiUR9lPP1JOg==
X-Google-Smtp-Source: APXvYqwe2UkmD1q/qMxlum03VsVtWDwnc35WofKXjVdJhq+R7iQJgEUzK9bUOvpnnUG36+XwmOCxew==
X-Received: by 2002:adf:fe83:: with SMTP id l3mr15321368wrr.229.1552989697023;
        Tue, 19 Mar 2019 03:01:37 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id b3sm17596163wrx.57.2019.03.19.03.01.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 19 Mar 2019 03:01:36 -0700 (PDT)
Message-ID: <2f8d217befcc4fdec36e5a31947cccfe74ccd49f.camel@baylibre.com>
Subject: Re: [PATCH 0/3] clk: meson: add support for PCIE PLL
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 11:01:34 +0100
In-Reply-To: <20190307141455.23879-1-narmstrong@baylibre.com>
References: <20190307141455.23879-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 15:14 +0100, Neil Armstrong wrote:
> The Amlogic G12A SoCs embeds a dedicated PLL to feed the USB3+PCIE
> Combo PHY. This PLL needs a very specific and strict register sequence
> in order to correcly enable it and deliver the 100MHz reference clock
> to the Analog PHY.
> 
> After lot of trials and errors, and since this PLL will ever feed 100MHz
> with a static configuration, it is simpler to setup a dedicated ops
> structure with a custom _enable() op applying the init register sequence.
> 
> The rate calculation ops are kept in order to keep the nominal read
> ops as-in, but set_rate is removed.
> 
> With this setup, the PLL can be enabled and disable safely and always have
> the recommended PLL setup to feed the USB3+PCIE Combo PHY.
> 
> Neil Armstrong (3):
>   clk: meson-pll: add reduced specific clk_ops for G12A PCIe PLL
>   dt-bindings: clk: g12a-clkc: add PCIE PLL clock ID
>   clk: meson-g12a: add PCIE PLL clocks
> 
>  drivers/clk/meson/clk-pll.c           |  26 ++++++
>  drivers/clk/meson/clk-pll.h           |   1 +
>  drivers/clk/meson/g12a.c              | 118 ++++++++++++++++++++++++++
>  drivers/clk/meson/g12a.h              |   5 +-
>  include/dt-bindings/clock/g12a-clkc.h |   1 +
>  5 files changed, 150 insertions(+), 1 deletion(-)

Well this PLL is indeed a nasty one ;)

Acked-by: Jerome Brunet <jbrunet@baylibre.com>


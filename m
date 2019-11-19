Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A772EC33C9D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD1522312
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XgvgsAl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKSBFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:05:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41166 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSBFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:05:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id 207so3117152pge.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 17:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uZSX0gXZEyWbpeDATXICIzoasiY9Eo2qw3XPlac1tGg=;
        b=XgvgsAl0bL1TY6fkGEmf81K8dDZO6A5M8XuF2XkY0OIUWUqI9/uZGfJW+9rUg/41ds
         lDYdDNBuqlsQN+5710fIOI+S/ka9f/2JZM4Aa2tsKClSNyyzd06PFu+kiwawhCcuNosA
         gZtw8MORRi4kOQw0u8lbvq4eR0bqPox7K8R+WJ8sm/1lFtL4Ixo6nVQVoWQeWfKRliXm
         LUrCMIvKpQi9QWFHahsHd/kiWHKPLlABjI6AwtSIRQsNK967Aq21agg+Oqn4v24Qp7gZ
         wmReq/HsIzrkFzUargGPWl7CUDBHOXY4gSw3PqWL5z1CZZ2K13kYazYyjPXGi4bUNeL+
         /sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uZSX0gXZEyWbpeDATXICIzoasiY9Eo2qw3XPlac1tGg=;
        b=BikDFUaO00Zuf3dcjUkmClbkoYU8xQ94kguBoshtMvQDHMUt0HtRULIPXuCzpM9sNR
         l0LAa6BtKV+sUw4469iq3Y0ZcABIC/nYO1PcPtbtC5poBJv+/rOUCLGbUX6Ej6rflzdC
         ORSIvvkv+5d5IXVk2AVX4AUpq5jtFNkt0MhIZkXyA9SXvgvHQzYmBUZZk1d9YNTJ1ouj
         Hnn/5Qb+3YxLY3iFXeK9yRM0EeaTfSwO76GSBeLeUgLtqCM9RoytEN3tfGdfVhvErOAE
         e3o/ZiSp4PQCPUKhT9KgLPNkqaaABl1urqCRgq7n3zdblOmc5MYABh9sbxOQa/j6nC0w
         fA6g==
X-Gm-Message-State: APjAAAWC1iKgEXrgE7ZKC/RRb3nHLNbALdy+O3sZCU7zzmSNE6/bEp60
        dDgtdIyzIDwqpOQ/MAYVf/RuZw==
X-Google-Smtp-Source: APXvYqw3NIZ6s/qg3ByJQpoS8wsFMhRGesqeKBTUjrMpriPYIyzvHa2rujTOL1ezqVrBTdyxxojgRw==
X-Received: by 2002:a62:8c:: with SMTP id 134mr2550973pfa.31.1574125550804;
        Mon, 18 Nov 2019 17:05:50 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h23sm20982195pgg.58.2019.11.18.17.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 17:05:50 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:05:47 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     swboyd@chromium.org, maz@kernel.org, linus.walleij@linaro.org,
        evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org
Subject: Re: [PATCH v2 00/12] Support wakeup capable GPIOs
Message-ID: <20191119010547.GN36595@minitux>
References: <1573855915-9841-1-git-send-email-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573855915-9841-1-git-send-email-ilina@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15 Nov 14:11 PST 2019, Lina Iyer wrote:

> Hi,
> 
> Here is the spin of the series with the review comments addressed and
> Reviewed-by tags added. Thanks all for your reviews.
> 
> Andy/Bjorn, would you pull patches 10-12 in your tree? Marc would be
> pulling the patches 1-9 into the irqchip tree.
> 

Patches 10-12 picked up for v5.6

Regards,
Bjorn

> Thanks.
> 
> --Lina
> 
> ---
> Changes in v2:
> 	- Address review comments
> 	- Added Reviewed-by tags
> 
> Changes in v1[7]:
> 	- Address review comments
> 	- Add Reviewed-by tags
> 	- Drop SPI config patches
> 	- Rebase on top of Rajendra's PDC changes [6]
> 
> Changes in RFC v2[5]:
>         - Address review comments #3, #4, #6, #7, #8, #9, #10
>         - Rebased on top of linux-next GPIO latest patches [1],[3],[4]
>         - Increase PDC max irqs in #2 (avoid merge conflicts with
>           downstream)
>         - Add Reviewed-by #5
> 
> 
> [1].
> https://lore.kernel.org/linux-gpio/20190808123242.5359-1-linus.walleij@linaro.org/
> [2].
> https://lkml.org/lkml/2019/5/7/1173
> [3].
> https://lore.kernel.org/r/20190819084904.30027-1-linus.walleij@linaro.org
> [4].
> https://lore.kernel.org/r/20190724083828.7496-1-linus.walleij@linaro.org
> [5].
> https://lore.kernel.org/linux-gpio/5da6b849.1c69fb81.a9b04.1b9f@mx.google.com/t/
> [6].
> https://lore.kernel.org/linux-arm-msm/d622482d92059533f03b65af26c69b9b@www.loen.fr/
> [7].
> https://lore.kernel.org/linux-gpio/5dcefdfd.1c69fb81.c5332.fbe0@mx.google.com/T/#t
> 
> Lina Iyer (10):
>   irqdomain: add bus token DOMAIN_BUS_WAKEUP
>   drivers: irqchip: qcom-pdc: update max PDC interrupts
>   drivers: irqchip: pdc: Do not toggle IRQ_ENABLE during mask/unmask
>   drivers: irqchip: add PDC irqdomain for wakeup capable GPIOs
>   of: irq: document properties for wakeup interrupt parent
>   drivers: pinctrl: msm: setup GPIO chip in hierarchy
>   drivers: pinctrl: sdm845: add PDC wakeup interrupt map for GPIOs
>   arm64: dts: qcom: add PDC interrupt controller for SDM845
>   arm64: dts: qcom: setup PDC as the wakeup parent for TLMM on SDM845
>   arm64: defconfig: enable PDC interrupt controller for Qualcomm SDM845
> 
> Maulik Shah (2):
>   genirq: Introduce irq_chip_get/set_parent_state calls
>   drivers: irqchip: pdc: Add irqchip set/get state calls
> 
>  .../bindings/interrupt-controller/interrupts.txt   |  12 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               |  10 ++
>  arch/arm64/configs/defconfig                       |   1 +
>  drivers/irqchip/qcom-pdc.c                         | 147 +++++++++++++++++++--
>  drivers/pinctrl/qcom/pinctrl-msm.c                 | 112 +++++++++++++++-
>  drivers/pinctrl/qcom/pinctrl-msm.h                 |  14 ++
>  drivers/pinctrl/qcom/pinctrl-sdm845.c              |  23 +++-
>  include/linux/irq.h                                |   6 +
>  include/linux/irqdomain.h                          |   1 +
>  include/linux/soc/qcom/irq.h                       |  34 +++++
>  kernel/irq/chip.c                                  |  44 ++++++
>  11 files changed, 388 insertions(+), 16 deletions(-)
>  create mode 100644 include/linux/soc/qcom/irq.h
> 
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

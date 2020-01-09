Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F8C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 03:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718C8206F0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 03:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jWLAJLZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgAIDdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 22:33:53 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37259 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgAIDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 22:33:53 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so512823pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 19:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UEKrA4j5xg849HgxG4ZgJ3CHls4ZaTF+OB+u2nBy33w=;
        b=jWLAJLZge6mjoh1B+Y+exKkX3xhYHt+O6tdsCcpbh8x45x/doL4BEYVF5JzTD65rh0
         kZzfZVBlcTWckd+6njdzCCC2QQe+eyMk0FbyNASLAZ0Rsgvj8LQ+Z7vQfJO1OHetV4fg
         Q3Ez3EgGL4mFqtojk2UnwqJM/KthIVG59SZ/7ORSUI8oGRJ1D2KXd9e4AJkY2f6ymYur
         ssnptz8InuRmPaKuppPx8J1X+hoEX4Z31wDuetK+BwVdMPrn5oz8vHd7D9D1ySQt8bx3
         iErcFc6+eppa5JicBfKErKsOinntQOstqc5Wu1agatr0LlLIjKIusMHeDLko5U4AeCnr
         6uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UEKrA4j5xg849HgxG4ZgJ3CHls4ZaTF+OB+u2nBy33w=;
        b=GXnqhn2Qkms4W4EGtNpP1I/0m0K/PvJ7RhXgPLBIpY787JSQm0V3o4HF2eHBhxs8jh
         DTdy9IkqZGuqOWuCV7LHhGpYLuZgIBIvSk9XNYJx5GtuKFoikVGg7Ko7ySxSbh0YyOQ/
         NMCyTFsmsqnNre7VUBwRQH3SEB57H7khTdVN6I+tOERcZqy1IOFWlnUoC+I2gHqSCS7e
         5TKGcQDpH9I8ShSTm6Y+xcEAoA5gQOJvQmYuVtj6CAtA8pCI9oCAaDwTAEfWVu9BF/3f
         cpO7JbdwkepzZj7DxjBF9skDp5W4KWZ0/zoF8mcA235YBuzJ+NJeIGJ3ZaHUE5ZO+OwM
         cQKw==
X-Gm-Message-State: APjAAAVAm+aYkDC4rN+SP8h8Kd/6ClvLTzkD9l4n3dLLvJHS6FJfFXR2
        e4SyIqOOQqXcyadyAXW9S0hC
X-Google-Smtp-Source: APXvYqyFA9CYznyRkR2hqVgK4ysMEuFUTXN+FNbeSuaIQzFbysYpCBVZUkL6I/LUt8KQkOVuDS6NTg==
X-Received: by 2002:a17:902:b709:: with SMTP id d9mr9348044pls.235.1578540831432;
        Wed, 08 Jan 2020 19:33:51 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:795:afda:19cb:953c:6ae:6158])
        by smtp.gmail.com with ESMTPSA id z6sm5261493pfa.155.2020.01.08.19.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 19:33:50 -0800 (PST)
Date:   Thu, 9 Jan 2020 09:03:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add support for Thor96 board
Message-ID: <20200109033342.GA3281@Mani-XPS-13-9360>
References: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Wed, Oct 30, 2019 at 02:31:20PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This patchset adds support for Thor96 board from Einfochips. This board is
> one of the 96Boards Consumer Edition platform powered by the NXP i.MX8MQ
> SoC.
> 
> Following are the features supported currently:
> 
> 1. uSD
> 2. WiFi/BT
> 3. Ethernet
> 4. EEPROM (M24256)
> 5. NOR Flash (W25Q256JW)
> 6. 2xUSB3.0 ports and 1xUSB2.0 port at HS expansion
> 
> More information about this board can be found in Arrow website:
> https://www.arrow.com/en/products/i.imx8-thor96/arrow-development-tools
> 
> Link to 96Boards CE Specification: https://linaro.co/ce-specification
> 
> Expecting patch 1 to go through LED/Rob's tree, 4 through MTD tree
> and 2,3 through Freescale tree.
> 

Any update here? Patch 4 is already merged.

Thanks,
Mani

> Thanks,
> Mani
> 
> Changes in v2:
> 
> * Added patch for documenting commonly used LED triggers
> * Added Reviewed-by tags for bindings patch
> * Changed, fsl,uart-has-rtscts to uart-has-rtscts in dts
> * Modified the commit message of MTD patch
> 
> Manivannan Sadhasivam (4):
>   dt-bindings: leds: Document commonly used LED triggers
>   dt-bindings: arm: Add devicetree binding for Thor96 Board
>   arm64: dts: freescale: Add devicetree support for Thor96 board
>   mtd: spi-nor: Add support for w25q256jw
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  .../devicetree/bindings/leds/common.txt       |  17 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx8mq-thor96.dts      | 581 ++++++++++++++++++
>  drivers/mtd/spi-nor/spi-nor.c                 |   2 +
>  5 files changed, 602 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-thor96.dts
> 
> -- 
> 2.17.1
> 

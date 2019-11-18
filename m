Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEB8C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3486120692
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GUqxG6CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfKRJzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:55:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51685 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfKRJzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:55:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id q70so16614416wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 01:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=PgGBXNN0Jirm20pqBP2alAmny4JZsXPFHK67g56bQ0w=;
        b=GUqxG6CLejc6KGV040NaZ4pursegloLrR/ifPEW5TMnYTJN40jTwfTDcoPyHl++AYH
         7hDIjGeJs7/35Jcr3FMbYzv8jczm/IjAVdmFufSTHr+KbQDxIlzz1fFOP9rEPt9H0fYi
         C/0COGPKR46Q/kAu9c2Db+OGR2LoRA5af1KdmcLpaA18ymFFLoneezHQbBk0iF3z6Z+2
         V5qu0n5zE8uOBPZCrOuSW6lF3GziCSS0CJiebQ/UorvBuSDkTyaVQsSs9ob5+HFgGA8O
         YdLUl+AuVNp/TpadiKD69zNPJfoxDGwOW1K6v535KB67jnYfaN70laGOpM+pbhCWGWT3
         Rp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=PgGBXNN0Jirm20pqBP2alAmny4JZsXPFHK67g56bQ0w=;
        b=KCQ2a2D3PlNcy9mSL1MQnU2XF6T94yOZ4zYRpUhC4KleIK6I9pXCABIjxkDPP0wvEl
         ez8RluBUP0DthJCwPOpo14KU+AmzvGhUeZM+ekq0FjHbGc8OMQ5quJYhnZTd1mxmmaRn
         /t0P102USKsUcjPS1oTCtWvO06jJm6fDo27e7oQx5Rn52/IRG3i3T02VK+E2DekqZnfo
         TVwAk28q3UPlyfsRCstL2zXhoi/zwsiXVvJfllgu6toboqg2Q3VkISjyVUpUjLXO6A+s
         Bj/f1Na5p9OfRz0uz++WwEOzCWWR1EL57Pg6znxaMdIa9t9YFz9/xkJa6PZzY2dKFG0a
         PHdQ==
X-Gm-Message-State: APjAAAWqh771mmB+xavyD2VNzGNO/vVm7TnCe/EBIKolKPUbB/4cuJVp
        0mmmvzB3dFgfDZeLwKbtlOA3nw==
X-Google-Smtp-Source: APXvYqyHTu9Hx3fhpKYkJTLr1HNLDFQ01pm20kXFjw2y/6FC4VNE3s2de/14tyIsevI46o9k72VsZg==
X-Received: by 2002:a1c:39c2:: with SMTP id g185mr27162171wma.88.1574070928635;
        Mon, 18 Nov 2019 01:55:28 -0800 (PST)
Received: from localhost ([2a01:e34:eeb6:4690:ecfa:1144:aa53:4a82])
        by smtp.gmail.com with ESMTPSA id a11sm20052731wmh.40.2019.11.18.01.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 01:55:27 -0800 (PST)
References: <20191117140731.137378-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        narmstrong@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org
Subject: Re: [PATCH v3 0/2] add the DDR clock controller on Meson8 and Meson8b
In-reply-to: <20191117140731.137378-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Nov 2019 10:55:26 +0100
Message-ID: <1j7e3xpkz5.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 17 Nov 2019 at 15:07, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Meson8 and Meson8b SoCs embed a DDR clock controller in their MMCBUS
> registers. This series:
> - adds support for this DDR clock controller (patches 0 and 1)
> - wires up the DDR PLL as input for two audio clocks (patches 2 and 3)
> - adds the DDR clock controller to meson8.dtsi and meson8b.dtsi
>
> Special thanks go out to Alexandre Mergnat for switching the Amlogic
> clock drivers over to parent_hws and parent_data. That made this series
> a lot easier for me!
>
> This series depends on v3 my other series from [0]:
> "provide the XTAL clock via OF on Meson8/8b/8m2"
>
>
> Changes since v2 at [2]:
> - add #include <linux/clk-provider.h> as suggested by Stephen Boyd
> - drop unused includes
> - use devm_platform_ioremap_resource instead of open-coding it as
>   suggested by Stephen Boyd
> - drop trailing comma after sentinel element as suggested by Stephen
>   Boyd
> - dropped patch #3 "clk: meson: meson8b: use of_clk_hw_register to
>   register the clocks" because it's now moved to my other series at
>   [0]
> - dropped dts changes so this series exclusively targets clk-meson
>
> Changes since v1 at [1]:
> - fixed the license of the .yaml binding and added Rob's Reviewed-by
> - drop unused syscon.h include (spotted by Jerome - thanks)
> - drop fast_io from regmap_config and add max_register as suggested
>   by Jerome
> - dropped original patch #4 "clk: meson: meson8b: add the ddr_pll
>   input for the audio clocks" because I could not test that yet (that
>   patch was a forward-port from Amlogic's 3.10 BSP kernel)
>
>
> [0] https://patchwork.kernel.org/cover/11248377/
> [1] https://patchwork.kernel.org/cover/11155553/
> [2] https://patchwork.kernel.org/cover/11214227/
>
>
> Martin Blumenstingl (2):
>   dt-bindings: clock: add the Amlogic Meson8 DDR clock controller
>     binding
>   clk: meson: add a driver for the Meson8/8b/8m2 DDR clock controller
>
>  .../clock/amlogic,meson8-ddr-clkc.yaml        |  50 ++++++
>  drivers/clk/meson/Makefile                    |   2 +-
>  drivers/clk/meson/meson8-ddr.c                | 149 ++++++++++++++++++
>  include/dt-bindings/clock/meson8-ddr-clkc.h   |   4 +
>  4 files changed, 204 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
>  create mode 100644 drivers/clk/meson/meson8-ddr.c
>  create mode 100644 include/dt-bindings/clock/meson8-ddr-clkc.h

Applied for v5.6
Please note this will get rebased once v5.5-rc1 is out


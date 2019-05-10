Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13DDC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77279216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9mrqU4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfEJPQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:16:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39274 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfEJPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:16:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so7855233wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HNTqfGPCwHotSSFB/bs3NRxKL+FaiL/rv+Medyfbh88=;
        b=P9mrqU4+sESJPNllGdbaccCTv5uBF42euzxH8O6o8zHSGzXapBATU/ejvkoDYJd8pX
         6AJBVyP+RdkRIdNRvSa4EzWUeFPzAQShL4KAOw0t3O2xYe5xHu7M3H3ylRZTfAkpdvf2
         ue+dkzSeHV7jn0J84ADyxcL0PbUaXMbV8FwFURUkTQ4K2TFgvKyXk4HsgXm5u4/HZqJI
         HbpDbjtOV/p/ZxxNEI9efJL4OUiW5dqVY6gxO3PbOtSMc4BYqRlShapCRdVTHpknfn+c
         8h6L57V14ODLHHpOGw7A3c0Aj8/IMBuJZqjVBLF3NZ2/ROIyz8U83oRLNQ68NkPE71GJ
         8k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HNTqfGPCwHotSSFB/bs3NRxKL+FaiL/rv+Medyfbh88=;
        b=gNIhPp/1PY0lVE9epveZ10huua4vuZvIFvdmdVyq5vEiYEo/2AtnTSSXY1vN1N58zG
         AXhPZ280v/EE08sUwhVEP78O/HL4/MbHqSg6DAauUIP9eHxBqVLv2SAJgYeFJIGBHopZ
         7FW/o6T4BGXe5xtqKJ/VxTnRedzW47GBuUUKA7M5i1f2R3GXZqxmHvy0KNHrWnxIAwtU
         5ovP62jrtBKhDtW4/9gTTh4sW6NVFt64Sk04fKzGYcxqXpb2OWGpYqkMfB9IJTIyntuK
         pb41II376tz9RAj+mcQrekQO1dlpXrAnbz7mwyjIGs2VxHnEg7rKZXZ5gn536iMStcHH
         yhqw==
X-Gm-Message-State: APjAAAVVhTmvyDSEswqZz66o5Nm0abB1iDcNKPpo1r4nZj51b3s8XvYw
        NXd7Y+R8NRoa99hVVU8BFqgCOQ==
X-Google-Smtp-Source: APXvYqwNcxQ+wZMQA6guBn6Potmx/LFX1w8O7OL3E3EWuj53qYCOqeHNdMVEJUOrPTEFTAuf9pvusQ==
X-Received: by 2002:a1c:14:: with SMTP id 20mr7907578wma.66.1557501360717;
        Fri, 10 May 2019 08:16:00 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id v189sm8817961wma.3.2019.05.10.08.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 08:15:59 -0700 (PDT)
Date:   Fri, 10 May 2019 16:15:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [GIT PULL] Immutable branch between MFD and Pinctrl due for the
 v5.2 merge window
Message-ID: <20190510151556.GA4319@dell>
References: <1557392336-28239-1-git-send-email-amelie.delaunay@st.com>
 <20190510072314.GC7321@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190510072314.GC7321@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

** Contains fix for i386 build breakage **

Enjoy!

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-pinctrl-v5.2-1

for you to fetch changes up to 9af2de7657f5a52f9e15aebb6f9348f9b8f250a6:

  pinctrl: Kconfig: Fix STMFX GPIO expander Pinctrl/GPIO driver dependencies (2019-05-10 16:09:56 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Pinctrl due for the v5.2 merge window

Contains fix for i386 build breakage

----------------------------------------------------------------
Amelie Delaunay (5):
      dt-bindings: mfd: Add ST Multi-Function eXpander (STMFX) core bindings
      mfd: Add ST Multi-Function eXpander (STMFX) core driver
      dt-bindings: pinctrl: document the STMFX pinctrl bindings
      pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
      pinctrl: Kconfig: Fix STMFX GPIO expander Pinctrl/GPIO driver dependencies

 Documentation/devicetree/bindings/mfd/stmfx.txt    |  28 +
 .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   2 +-
 drivers/mfd/stmfx.c                                | 545 ++++++++++++++
 drivers/pinctrl/Kconfig                            |  14 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-stmfx.c                    | 820 +++++++++++++++++++++
 include/linux/mfd/stmfx.h                          | 123 ++++
 9 files changed, 1661 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
 create mode 100644 drivers/mfd/stmfx.c
 create mode 100644 drivers/pinctrl/pinctrl-stmfx.c
 create mode 100644 include/linux/mfd/stmfx.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2826FC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99FB217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MLfJXEMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfEJHXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:23:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32995 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfEJHXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:23:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so652028wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6IJvqYq4JZWD5aTcjw2ROgUsvIuulKVOwmPtVdRwUBw=;
        b=MLfJXEMdZmKpvWHQlqIzfyImp6Wy+KcsU0p5YvE1otyh3zIOF+I1vvQ/PJnC4diJpY
         sh7j6UBJ/0TsdJxDPFx15teFeEEP0QzxEIQEcUOhHwljvJCS2Tjkf/2mrXiP9/ZgNwHe
         CH4EkBxMqLQgUUoLVvHev0mv2XVIeQZeRZWtqthsJGrx+ZQjGkna1+4trW4eI+KMpWg/
         NqQgmANFTSZNHuEBAXzpXICTBex/HmPLIEN8E0Q2umUFYZfV9vf8qRqgiXOYJdB/lK+T
         nasc2eF4kXFxaiNB/WjJeNwU3qb9R9VMtLpc1FhwexCo5vE8Uqiyx1kEp0G2RSSP1FIm
         NJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6IJvqYq4JZWD5aTcjw2ROgUsvIuulKVOwmPtVdRwUBw=;
        b=CdRqsKee7HaJmn6I6wiIO1JOSvWXygcp3AV3TzMyioQg+uHugc/ZP8DSmJjnpe9kNm
         4LTEjvYZJMLTNV8yc45wBdoTSuCc1Izbe2+kZUlXf9SShc9W7QlvPHg3GzVDkWpemCUh
         hQJiyRvJB6DwdMK2IIz+XFYoLAq5nFhuU2TTpwfU11y3TNXq4gcfL2SZJ1ZZd91ySHjj
         RtEaJc/WcHnBhrGodatMivnXGjD4xhQoeSiah3vpxEmALM0HOpZi8lqyI7u+0WKYVpxV
         oM2UMEhyOWygt0vOyJDmgDiMjeiWAGgHTXUeDyVd83iTvJLyP858GTpjLrG8LlYFlIjb
         bFiQ==
X-Gm-Message-State: APjAAAUwtSk04J1Sog13RQ6oTPLZqfnZAmWCktXsrhUYy3MUOnEPbeJQ
        6lt8ZE+CAim42D2rveZ+ckstvg==
X-Google-Smtp-Source: APXvYqwFI/XoRqh3l4hbVHQYN4vuu2sgvGQIfc1CDZPFb5/hfW20fNRJaFM/GapMBIrdKush+zwVEw==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr5638463wmc.49.1557472996594;
        Fri, 10 May 2019 00:23:16 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id n14sm1748514wrt.79.2019.05.10.00.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 00:23:16 -0700 (PDT)
Date:   Fri, 10 May 2019 08:23:14 +0100
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
Subject: [GIT PULL] Immutable branch between MFD and Pinctrl due for the v5.2
 merge window
Message-ID: <20190510072314.GC7321@dell>
References: <1557392336-28239-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1557392336-28239-1-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-pinctrl-v5.2

for you to fetch changes up to 1490d9f841b186664f9d3ca213dcfa4464a60680:

  pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver (2019-05-10 08:21:31 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Pinctrl due for the v5.2 merge window

----------------------------------------------------------------
Amelie Delaunay (4):
      dt-bindings: mfd: Add ST Multi-Function eXpander (STMFX) core bindings
      mfd: Add ST Multi-Function eXpander (STMFX) core driver
      dt-bindings: pinctrl: document the STMFX pinctrl bindings
      pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver

 Documentation/devicetree/bindings/mfd/stmfx.txt    |  28 +
 .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   2 +-
 drivers/mfd/stmfx.c                                | 545 ++++++++++++++
 drivers/pinctrl/Kconfig                            |  12 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-stmfx.c                    | 820 +++++++++++++++++++++
 include/linux/mfd/stmfx.h                          | 123 ++++
 9 files changed, 1659 insertions(+), 1 deletion(-)
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

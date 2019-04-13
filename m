Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFE9C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D382082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfNY7SQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDMKdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54513 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfDMKdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so14195314wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1D/vpZhkpnrNC5vrHmbmlzGbahsmNnMzAgArQrryVSk=;
        b=YfNY7SQ6Zq+eYTr38wXqWsMz8zPfa9svoIKcauzdOdMYf1d0ne6rtbGTmkOVSYx9g9
         M6CfAkkuft7sKLjDCuXSLrsA+cReq1OExiRiM8uhHoY4EBUYlheObTtZzU86DkLWP9/a
         4TkciSkYxI0GPZa5nopOqabkXecVYM2ZxQ1x2v4XhExCxLuEORWMONA1iQx9jZBjudxH
         UUQFb3WjqsmyE5UJOK+VFmAdDMblUDcyFBy9Bay3hJH/T0psSH44RhnqqDvY+IvgYZT5
         SPpLTl+RdiezdBSPPrwsuJVfbxlB2TyqrVxxOMd1rY6dXv4PJmf/Y6PRHCBu2b5anyr+
         Yxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1D/vpZhkpnrNC5vrHmbmlzGbahsmNnMzAgArQrryVSk=;
        b=o9LaC7454JBamRAsptRr7JscGf+7koxVYV6S6EBr0h4DOhW5F95eWGd0wtYye8p9Zu
         43JxzWTv07qn4JD5dCgsm2Qb7/5/E3VWnnKpaiPDOXVwCuvQtQRpxvi31ANkhe14cnAy
         yGkNalInkfyKBJmTdyOQ01bIILEv+tDXfVXloQi15icOK/r85dqArDyRjWPMQRNkYmrL
         JJA7at6kkq1Nzl/qpv8VfWZuUvdXlGrkwg16OR1uObdSt0MtCKE5uHo2WOdqc5uO44bA
         h5ucouN1hMMZxZyHgiWNjp+tQPwGxp8QpvOLcUoBEcWW7+JBEWw8zplynqr5UBZLkJKI
         MjDQ==
X-Gm-Message-State: APjAAAXO5fJs7uXHsXofqku6I76A92KNjns70VPAbYxgio3dReKpjWT/
        OEhU8jX+REUCzy2XXy00WyolEQ==
X-Google-Smtp-Source: APXvYqz/Bh8vyIu/+fLzaR76U7hL6dN/yWLvWd4u2s50YW4M54efrU5bbMr9MwgDkv41djF3FBWPTw==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr14175302wmi.20.1555151586710;
        Sat, 13 Apr 2019 03:33:06 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 00/20] nvmem: patches(set 1) for 5.2
Date:   Sat, 13 Apr 2019 11:32:45 +0100
Message-Id: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending this with cc to linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.2 which includes:
- adding support to new stm32, sunix and imx providers
- few general cleanups
- fix for in place buffer reads.

Can you please pick these for 5.2.

thanks,
srini

Anson Huang (3):
  nvmem: imx-ocotp: use devm_platform_ioremap_resource() to simplify
    code
  nvmem: mxs-ocotp: use devm_platform_ioremap_resource() to simplify
    code
  nvmem: imx-iim: use devm_platform_ioremap_resource() to simplify code

Chen-Yu Tsai (5):
  nvmem: sunxi_sid: Read out SID for randomness without looping
  nvmem: sunxi_sid: Optimize register read-out method
  nvmem: sunxi_sid: Dynamically allocate nvmem_config structure
  nvmem: sunxi_sid: Read out data in native format
  nvmem: sunxi_sid: Support SID on A83T and H5

Fabrice Gasnier (4):
  dt-bindings: nvmem: Add STM32 factory-programmed romem
  nvmem: Add driver for STM32 factory-programmed read only mem
  nvmem: stm32: add support for STM32MP15 BSEC to control OTP data
  nvmem: core: add nvmem_cell_read_u16

Jorge Ramirez-Ortiz (1):
  nvmem: core: fix read buffer in place

Lucas Stach (3):
  dt-bindings: imx-ocotp: Add i.MX8MQ compatible
  nvmem: imx-ocotp: add support for imx8mq
  nvmem: imx-ocotp: broaden Kconfig dependency

Yangtao Li (4):
  nvmem: sunxi-sid: fix wrong description in kernel doc
  nvmem: sunxi-sid: add binding for H6's SID controller
  nvmem: sunxi-sid: convert to SPDX license tags
  nvmem: sunxi_sid: Support SID on H6

 .../bindings/nvmem/allwinner,sunxi-sid.txt    |   3 +-
 .../devicetree/bindings/nvmem/imx-ocotp.txt   |   4 +-
 .../bindings/nvmem/st,stm32-romem.txt         |  31 +++
 drivers/nvmem/Kconfig                         |  14 +-
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/core.c                          |  52 ++++-
 drivers/nvmem/imx-iim.c                       |   4 +-
 drivers/nvmem/imx-ocotp.c                     |  11 +-
 drivers/nvmem/mxs-ocotp.c                     |   4 +-
 drivers/nvmem/stm32-romem.c                   | 202 ++++++++++++++++++
 drivers/nvmem/sunxi_sid.c                     | 115 ++++------
 include/linux/nvmem-consumer.h                |   7 +
 12 files changed, 362 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
 create mode 100644 drivers/nvmem/stm32-romem.c

-- 
2.21.0


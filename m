Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E377C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 11:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6472E207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uhxJhoaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfJMLkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 07:40:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39275 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfJMLkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 07:40:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so8768123pff.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 04:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JJesClvZPI57LiKAGH+mfL4LvGX/K6XZEsgwxovyzfw=;
        b=uhxJhoaSSS5T1/0ebEMzWzw7K6b7OXDjdOgSIcbOIkJTJ0I81TmRPxdNTiOG0AQe7o
         lyjnfkJkE4PAOv5uaLWlBGxOZpdnxbKuRWc1Yw/LNOHo5P6zYTue7Lmu60CvUG0Ihzwf
         Aol58rW3yf+M7+tDeNidJ5FFuGM3hQ1iV7C+lziFhbIUs3iTzjmGegkZnOVt9d6tlY/b
         k+3eJAroNZ3EPIbDVHt05eCeNLhSJ75acTNxMLeBhMa5/KqctdGSZkYzyPCPy+DD6A0s
         xn1cBT/dZ9lEl9j46KsBLRBZXoaQbbFrXQ12/0IX+asRKYpzRI/Eac3F0Ug3g8DBKPtN
         m3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JJesClvZPI57LiKAGH+mfL4LvGX/K6XZEsgwxovyzfw=;
        b=PTwcI4aJKpVHH7bM38I1uNpvnV2tceoKdluqGjt4dIF4sbalhwn2J5d6Gm9jhcm7w/
         FwsS0zOgEEc0HO61OtktiOZgrbPHJPmdHxbKuWSc9m49A3WVBlYRy65Ztp8bq3dT2tdy
         2dejhFAcBxJzwVcC7xw2raZldDFsImq3hiIT6g1q8LQWqnKqdr5WxkS8RxEXdAhQb96F
         fZquYE6ZYqJRxoIKQWu3VNsEx1bltDKDCED0p7XDarxm8r+8q5p1qy85lSQs/zY9k0r7
         MAsWYWz1PILX5UOj6RZGJu93q1kd1jkjD/DA/3BP4Tgq0EaDWt17roISLNZqSKFt4KER
         SpMQ==
X-Gm-Message-State: APjAAAV7U+jYB7UeEw/f/srPhm1XlwpYD/TeCRpRPQO4YEGU6fIuprrD
        JT/hmijo+y0T0LfznFD7IJ/Z
X-Google-Smtp-Source: APXvYqxIeS2C0iQ5M1sifVwuU36Fj7ZdRpllo3pk4Sj4fF4++WdHr5Vc/z9REKwAGjsy3h12qGMzNA==
X-Received: by 2002:a63:d246:: with SMTP id t6mr27729211pgi.5.1570966849575;
        Sun, 13 Oct 2019 04:40:49 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:8e:4f53:b957:652b:7622:f311])
        by smtp.gmail.com with ESMTPSA id g12sm23165736pfb.97.2019.10.13.04.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 04:40:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/4] Add GPIO support for RDA8810PL SoC
Date:   Sun, 13 Oct 2019 17:10:33 +0530
Message-Id: <20191013114037.9845-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds GPIO controller support for RDA Micro RDA8810PL
SoC. This SoC has 4 GPIO controllers and each handles 32 GPIOs. Except
GPIOC, all controllers are capable of generating edge/level interrupts
from first 8 GPIO lines. The pinctrl part for this SoC will be added
later.

This driver has been validated on 96Boards OrangePi i96 board from
Shenzhen Xunlong Software Co.,Limited with libgpiod.

Thanks,
Mani

Manivannan Sadhasivam (4):
  dt-bindings: gpio: Add devicetree binding for RDA Micro GPIO
    controller
  gpio: Add RDA Micro GPIO controller support
  ARM: dts: Add RDA8810PL GPIO controllers
  MAINTAINERS: Add entry for RDA Micro GPIO driver and binding

 .../devicetree/bindings/gpio/gpio-rda.yaml    |  50 +++
 MAINTAINERS                                   |   2 +
 arch/arm/boot/dts/rda8810pl.dtsi              |  48 +++
 drivers/gpio/Kconfig                          |   8 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-rda.c                       | 334 ++++++++++++++++++
 6 files changed, 443 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-rda.yaml
 create mode 100644 drivers/gpio/gpio-rda.c

-- 
2.17.1


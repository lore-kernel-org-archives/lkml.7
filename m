Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEB4C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B19221707
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eIjUllel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfFHTEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:04:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42267 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFHTET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:04:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so5269341wrl.9;
        Sat, 08 Jun 2019 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jXFcak2cBpexQk8XYN9VwrCjw1WZmHd35NHcnWvlUM=;
        b=eIjUllelamnWeZcriXf4pecRr643goyySvVh2oJM0Dhb5G7lrmEbCequZfHbZbaCmN
         g/qHrO6fzfqlK0ycFPOnUio+yrz8dc0qLpiCnfuXN7M6474V4gNYjCk3aJ+QH4uU++P5
         FrZ92j96kXDKox9o6FBdjE3XYWlEJB/hELgeaW+vykoT3GVOA7Od8zmFN1LBaUoVyBuW
         8+mBMqYndQxBlqJfVE8dgEcuXDIeqqMRcmPZc7WnYlQo/ch83e8I7DUQPQyigBLHu/WU
         9Y2cAe1hPF3l0f5elho+4et2FsznVRtBCpcnT9Y9b/OLWllASSjSaJA7lwm7tQB7KyIq
         VnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9jXFcak2cBpexQk8XYN9VwrCjw1WZmHd35NHcnWvlUM=;
        b=fS5Zp5vZxqCVMq+5bs8jY6YZFQYjNk3V4ByzUQozpWdv1NbcjTWUzmzg2+9KTO4vLF
         BJs5C/AOcYThZ79Fsqb28HmTz0dlnoDSUUBFnlUDXKKf30Gqtc0fzVcRS5AUInH6JugO
         5ZTTjPLGGBux5m/HBUXTKxZW1pgaJVbmnzjfFNSDqt31c6gdCQIPIyNpGMvW6lmQ5DoY
         NRMk2hyouRAZyNjK6OIBWGD5vM0453J/6LozAFKi9NXQeiAMNQWTfkdJLbd7gAegy05L
         WfJLHU0M3ene4aEipr3HAJOPx4vMXTdU6EhT9lTtceOgHhghK04UppN6I60yDu/dOb5K
         WPRg==
X-Gm-Message-State: APjAAAWRbtNLYJl+5LiNWHJ8z9eSVv52IYqtqnyENGTTwIi4enahexgg
        FmnVvXLDhNFCYePUAqDGgOYNxRUL
X-Google-Smtp-Source: APXvYqwG28JNmUgm1CsQro+958rHZ/hNNfAHUq1Xkkz1MmrE6sJADMNYtPLldhD5c8SSB7LZxxUWJA==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr36679469wrr.252.1560020657104;
        Sat, 08 Jun 2019 12:04:17 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id t6sm5655062wmb.29.2019.06.08.12.04.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 12:04:16 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/3] meson-gpio-irqc: Add support for the Meson-G12A SoC
Date:   Sat,  8 Jun 2019 21:04:08 +0200
Message-Id: <20190608190411.14018-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds GPIO interrupt controller support for Meson-G12A SoCs.
Although the total number of pins is the same as the Meson-AXG SoC, the
GPIO banks and IRQ numbers are different. Add a new compatible string
to avoid confusion when using it.

I am re-sending this update because v2 looked good in my opinion (Xingyu
Chen did good work here) but it never made it into mainline.


Changes since v1 at [1]:
- share the device data with Meson-AXG

Changes since v2 at [2]:
- dropped "Change-Id" from patch #2
- added .dts patch #3 - this should go through Kevin's linux-amlogic
  tree. if required I can re-send it in a separate series


[1] https://lore.kernel.org/lkml/20181203061324.36248-1-xingyu.chen@amlogic.com
[2] https://lore.kernel.org/patchwork/cover/1021232/


Martin Blumenstingl (1):
  arm64: dts: meson: g12a: add the GPIO interrupt controller

Xingyu Chen (2):
  dt-bindings: interrupt-controller: New binding for Meson-G12A SoC
  irqchip/meson-gpio: Add support for Meson-G12A SoC

 .../interrupt-controller/amlogic,meson-gpio-intc.txt     | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi              | 9 +++++++++
 drivers/irqchip/irq-meson-gpio.c                         | 1 +
 3 files changed, 11 insertions(+)

-- 
2.21.0


Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F46C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425562080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMuYTPIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407964AbfFLHzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:55:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37350 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbfFLHzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:55:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so8324732pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t/zZQ82E/N4gFFsCTmRZdYbvd54D5nSgY4uOp2BfUg4=;
        b=JMuYTPILm5oCrO9h51xNSn+tS6CagMc0yZFGqpOBe60q4o0BGqiouryTqq5e1OMzHD
         rPPNZ6vtqqgXRNsjRVtnkphRfkUPh+ageRVwawW3Zb9/JzbfLx2+gbG/Q05yndF8bg80
         fdkSyEiFKeDP8Zg8eMMFLl4Xygesmch6UQi95PqTzgRYLLjzZCkfdxLcdEBzGvaufIuM
         mcjHpczgaPIKv5/CQL1z9f3shXhEdLul5A9x2m0C5DeWaO8pItHJXx2sKOUZ/3wzfyQz
         tO9WxRv1cwUSO9K7qfKf6uCA5ogtyUUpa4CaHtiviKvqDF28bKJZ/M9N7zW914ZOfNaF
         a9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t/zZQ82E/N4gFFsCTmRZdYbvd54D5nSgY4uOp2BfUg4=;
        b=bEXegrlXvX2XGHLVMGWIBm041Ls+bYrHJJ/ZF8/2j0/74xyCFhkhWzzdW4+mUq+QUE
         GIWhRVU74rYhgqheMtB19rgMZ7UDSCrvVnZ7RJK4dBcF/cJHGEDEiiLkc/l7LGCwvj/f
         SYs3nKPq86SFMSuIU5VSuC2FCclZiR11ipVF1QXls6mTROOb3Bw4fb23vidM6Q1isVIG
         1MVCTNUSKuYq7oiZ4/YmSI08dN1ltBx9o3vAzix8KWYHdzjurreAMlFm1c7Voz2Ro+3V
         krx+ptb4gkALz/19kf/Qu37c3U5tb41OgxZIRG0E2fHuwM0i3a6TqLPu7mqy8ZOx/Cos
         +DsQ==
X-Gm-Message-State: APjAAAWrScmIE83eFVT/OSKxWnfJ4MWKx1UZs1erpGnEgUX9i7xnbtvh
        dMKm5oFt2OzwuqqTiajN+Hxzm8D0dfD2
X-Google-Smtp-Source: APXvYqyhsNDJVnEra02+JvmqkHRHXuSl223Vx4mOQwGbwFeFfO1wG9ZHDU3uBEIjt7IKjmaKTRH8Uw==
X-Received: by 2002:a17:90b:8d6:: with SMTP id ds22mr31537248pjb.143.1560326103017;
        Wed, 12 Jun 2019 00:55:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:894:d456:15b5:9ca9:e3ec:c06a])
        by smtp.gmail.com with ESMTPSA id b15sm16846399pfi.141.2019.06.12.00.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 00:55:02 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robh+dt@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/4] Add Avenger96 board support
Date:   Wed, 12 Jun 2019 13:24:47 +0530
Message-Id: <20190612075451.8643-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds Avenger96 board support. This board is one of the
Consumer Edition boards of the 96Boards family from Arrow Electronics
featuring STM32MP157A MPU and has the following features:

SoC: STM32MP157AAC
PMIC: STPMIC1A
RAM: 1024 Mbyte @ 533MHz
Storage: eMMC v4.51: 8 Gbyte
         microSD Socket: UHS-1 v3.01
Ethernet Port: 10/100/1000 Mbit/s, IEEE 802.3 Compliant
Wireless: WiFi 5 GHz & 2.4GHz IEEE 802.11a/b/g/n/ac
          Bluetooth®v4.2 (BR/EDR/BLE)
USB: 2x Type A (USB 2.0) Host and 1x Micro B (USB 2.0) OTG
Display: HDMI: WXGA (1366x768)@ 60 fps, HDMI 1.4
LED: 4x User LED, 1x WiFi LED, 1x BT LED

More information about this board can be found in 96Boards website:
https://www.96boards.org/product/avenger96/

Thanks,
Mani

Changes in v4

* Deleted the old stm32.txt binding
* Added Rob's Reviewed-by tag

Changes in v3:

* Converted STM32 platform bindings to DT schema

Changes in v2:

As per Alex's review:

* Fixed I2C2 pinctrl node
* Sorted the avenger96 dtb in alphabetical order
* Added device-type property to memory node

Manivannan Sadhasivam (4):
  ARM: dts: stm32mp157: Add missing pinctrl definitions
  dt-bindings: arm: stm32: Convert STM32 SoC bindings to DT schema
  dt-bindings: arm: stm32: Document Avenger96 devicetree binding
  ARM: dts: Add Avenger96 devicetree support based on STM32MP157A

 .../devicetree/bindings/arm/stm32/stm32.txt   |  10 -
 .../devicetree/bindings/arm/stm32/stm32.yaml  |  31 ++
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi     |  75 ++++
 arch/arm/boot/dts/stm32mp157a-avenger96.dts   | 321 ++++++++++++++++++
 5 files changed, 428 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.txt
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.yaml
 create mode 100644 arch/arm/boot/dts/stm32mp157a-avenger96.dts

-- 
2.17.1


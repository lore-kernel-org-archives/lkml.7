Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D5C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271FD2494A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPebLeDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfEaGjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:39:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34710 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfEaGjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:39:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id h2so233308pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXBhhNmLSZ7SfSIDocpcP+tG+VZK/npThfwPX+RXL68=;
        b=DPebLeDbFNVD5P67tqP0E6NbXfo0GqBg57A5cpk0ASEU2EHf6awCPba6G4D+1PwlRj
         YhsRX/gA0mlYVXED8lkdcJV8bWS2fB9I4CqPcbawD/e2P+1RPta6Kb/8y4DQXjWw9gm0
         +H3zmCDCa3KW537AnnuScG0NEae48ULqRfGYODDp2u4Pv7GdHb+4t17s+Dqj77brlAs5
         JDJRlvf4tsykSLgQU84EyPwqQ6OgsG4flhnrJVBbMlBoDARGLJqIHwj5DbmUPcpAYjKg
         AVCnE0ukyuWLUZelupQ7fL261pnfoDdFWrj6/KLqGfTT8PkZjxmKb5c9viU0i+Qn/TMl
         O4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SXBhhNmLSZ7SfSIDocpcP+tG+VZK/npThfwPX+RXL68=;
        b=oNYM23xNaiWDMTwBNeK9YEcJYjwid8IP10Y6cl0QQupKHDzDY7jeR2ICoFYSsXv2wQ
         ecW4hChC5iJZnDW6B8uT4XLF30DvKJrnEtAG0EZ+W2ZIF+fXFP2onTboee9n+Fw289bB
         axq4wrwtI/eZk+gsWKpt7eSxfUukQKgwcDrodU3P/2puZjKjXGJGuvMu5dUqCOhq4zy1
         ZcB7kNfqig5jypcMQTviR6Ikz0wgdnIOVQ6DuXqquttahfsp8jtjH6YKPORdc2acO1ru
         Yge/ZO/nBGf9eIl1kDdI1ZjdTpPPCD34NuBMJL1GjUQH8eSmBdE2Esg9hMIDIykI+hYw
         vlrQ==
X-Gm-Message-State: APjAAAXlIiFM2pWbin2bTrUpSsCSmhdEpuEJmsuWTGZRSu5XklGUoI6s
        aEFWqmJBVrVPSKxOZXopFcDP
X-Google-Smtp-Source: APXvYqxSXSKcfJHZzFiDp9JVK/XspKz74WHAtcBbnHiEhOKXCoHZ3JHNNC2pEpI0Wj0IJGDLpMcR/g==
X-Received: by 2002:a63:ff52:: with SMTP id s18mr3535804pgk.187.1559284753339;
        Thu, 30 May 2019 23:39:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:72cb:ebf2:a51d:3877:feab:5634])
        by smtp.gmail.com with ESMTPSA id y12sm4644158pgp.63.2019.05.30.23.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:39:12 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robh+dt@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/4] Add Avenger96 board support
Date:   Fri, 31 May 2019 12:08:45 +0530
Message-Id: <20190531063849.26142-1-manivannan.sadhasivam@linaro.org>
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

 .../devicetree/bindings/arm/stm32/stm32.yaml  |  31 ++
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi     |  75 ++++
 arch/arm/boot/dts/stm32mp157a-avenger96.dts   | 321 ++++++++++++++++++
 4 files changed, 428 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32.yaml
 create mode 100644 arch/arm/boot/dts/stm32mp157a-avenger96.dts

-- 
2.17.1


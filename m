Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01079C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45DF2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lnij2FPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfECFbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:31:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39428 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECFbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:31:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so858304pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbA+h1SWOeC+A9lxbgQ9nyiTDR7RZSnCD5SEiXc6Chc=;
        b=Lnij2FPqvmSvFcPoNxUkNY/JS83WNPIYA/lZMituG08241YitIDNyfyYAsIOyD2Vh7
         mPJcAWqwUWvDcuiJDnes/xhUyrREUUDjtGk72y8FQISb0WqkF/rLk2Y5TsKzoEM1vnpc
         t78JV1qjKZGg6Bg4HyO2Q+i76zrgSDWvXioq5M5V33GczeXpvgZQjQFnqx3Mlct7t1Tn
         CpexQ+3yESDh8pR647ZS71i1ozQR7ZdPGPXXXGF6WoreVf5pNozrPzsHYgBwzR9Vd17M
         e4+0EOPKodzzCLmTEltxUcckAVPtISrrtbLDxDNUCw3BTjZTOFiqLj7nJUFHyOeL/Ezt
         xztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbA+h1SWOeC+A9lxbgQ9nyiTDR7RZSnCD5SEiXc6Chc=;
        b=c4/+9qSKmnlHoPlsbjanbNveU7dKU35Ez2amzAd9Lx9hvgM/dllPA8tFhmPngHUKoF
         TQ8FtwtbN+3ep+xwxlZQNSi4AAa+KThdJy7oa7Byqj4u9Y5E9XdZckP4GuKUO0kQcQus
         1aMYd0wPx9y3LQeRvHvnOI7KTLzKLpO7aMnx+QO6TwMumz8XxtPR63hVeqUsDnSvV8fK
         XSiUBa7+HVi5NSFLU5/skiz0kr4QFTETNxC3jHcyFKe/0DaCFRpif1zyQw5ibSDb5Hte
         3l6KazL68hSBxoknebmH762GxkqaBc+m7A8ZntmzJ1T6X4Ih+8ypVk1/XFpMk0vknW0w
         EkDg==
X-Gm-Message-State: APjAAAXT8oy8cfS8LSGdGwIhr7dem5ZeVTidRDl20o2OXCqVCKnf5RK/
        aDRbGNuCm/KZLtGwj057dubP
X-Google-Smtp-Source: APXvYqwdnJ1wGysGVAJNxsji+b4A9Fu8qkeqQd4DxFfJGQBIFlAwwOQZoni5fRsBgxCIpFPuLIDZLg==
X-Received: by 2002:a65:5246:: with SMTP id q6mr8137656pgp.296.1556861496796;
        Thu, 02 May 2019 22:31:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:72c7:3835:31df:f367:f70b:ed86])
        by smtp.gmail.com with ESMTPSA id l15sm1152226pgb.71.2019.05.02.22.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 22:31:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robh+dt@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Add Avenger96 board support
Date:   Fri,  3 May 2019 11:01:20 +0530
Message-Id: <20190503053123.6828-1-manivannan.sadhasivam@linaro.org>
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

Manivannan Sadhasivam (3):
  dt-bindings: arm: stm32: Document Avenger96 devicetree binding
  ARM: dts: stm32mp157: Add missing pinctrl definitions
  ARM: dts: Add Avenger96 devicetree support based on STM32MP157A

 .../devicetree/bindings/arm/stm32/stm32.txt   |   6 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi     |  62 ++++
 arch/arm/boot/dts/stm32mp157a-avenger96.dts   | 320 ++++++++++++++++++
 4 files changed, 389 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-avenger96.dts

-- 
2.17.1


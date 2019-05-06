Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990D0C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABB9206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NL1GyKgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfEFKFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:05:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39777 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFKFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:05:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so6495836pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzJC2cGnv4guPyK0TH8rxdCNy91Y2MqZHMVt0Hj1UZg=;
        b=NL1GyKgbriLVakxOq1jPwdxkfiGtpgzEVVNcaaGHD2TRfHVkTxbpCyNV/1ywD9Jw5w
         yfbKzH10+nSa4f1w868NzXQMhVjbjmb9hcWAJs2OIuuLBlApd7pU5kTD2U/5l0YSzSBm
         T2si2DEKppfFDmics//fwthVrvWKMnT78xAG1Wvz/uAfRWN9q7+0TPNvG6ZTgCFIVNae
         Iwc+ttvFGJj/N6XC7LZdcgBXrXblJ+kJdiJ4ZQo3uxX+qz7h956lAdwSK8YtWglHxHVs
         eRA9iqWc8ouN3gnGRhDk9I0VAD/2YnJbslPtEv+zv0seh2Oryf5aakf1VOhaRLdQp6Bf
         /BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzJC2cGnv4guPyK0TH8rxdCNy91Y2MqZHMVt0Hj1UZg=;
        b=O7DZNqt9/XA9nURjZnYnynvpVPHCzH76nzKv6X84QuDrmn8gFGnbQjfvx3DuSRxxiN
         snUI0O2sqIYsG6d0K0VaD5DmW/5b3Lhrb5UnPi02lQGOGsyz27A17XvMR6nwaNUXlo38
         MSaQWtlh5xeRkOMAWkoAOVq+0+B5TcjNO2IYajmeOccLEbGqVGF/qXclLYKOo/rBbzmY
         F2yAHKHWhtle3MPFJFe8n95hrr3VMq7L00X0frbSb8He33Li5VDY3K0l/IgKE+Z6vYbV
         6CZ4GLpo5pnPJA982S4KQutXI/df3InHeIB7SnS85/33+L0K95KwWvtM4TNU6gEgaqN/
         5nzQ==
X-Gm-Message-State: APjAAAUtM82OQP5mBtvHuQ6GF37pjOxVpo552iAbYNo2O9QuEcxx07Fr
        DtqgwfSRlfRg7E0n/xyvFbow
X-Google-Smtp-Source: APXvYqz0D0CtKqL3bIVtaE3Zyo+/xiVoozF07VaHqELDfSxUqbd9yW66ihVnrA16JSi02lR98iLN2Q==
X-Received: by 2002:a62:3684:: with SMTP id d126mr31872502pfa.70.1557137146052;
        Mon, 06 May 2019 03:05:46 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:611b:55a4:e119:3b84:2d86:5b07])
        by smtp.gmail.com with ESMTPSA id c137sm16229653pfb.154.2019.05.06.03.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 03:05:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robh+dt@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/3] Add Avenger96 board support
Date:   Mon,  6 May 2019 15:35:31 +0530
Message-Id: <20190506100534.24145-1-manivannan.sadhasivam@linaro.org>
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

Changes in v2:

As per Alex's review:

* Fixed I2C2 pinctrl node
* Sorted the avenger96 dtb in alphabetical order
* Added device-type property to memory node

Manivannan Sadhasivam (3):
  dt-bindings: arm: stm32: Document Avenger96 devicetree binding
  ARM: dts: stm32mp157: Add missing pinctrl definitions
  ARM: dts: Add Avenger96 devicetree support based on STM32MP157A

 .../devicetree/bindings/arm/stm32/stm32.txt   |   6 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi     |  75 ++++
 arch/arm/boot/dts/stm32mp157a-avenger96.dts   | 321 ++++++++++++++++++
 4 files changed, 403 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157a-avenger96.dts

-- 
2.17.1


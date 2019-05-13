Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEAFC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE8221473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aY5uMZeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbfEMQKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:10:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33493 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731482AbfEMQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:10:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so7582611wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBIWbSPpc7j2EgIiZbpjBgwSCzEoaoZA6IHHGeyqm0k=;
        b=aY5uMZeISGZkbAL4GnQfuBHulOyUat3bMlveTgkJEg6ZBvpZ46nBDnlLqd/Jc79Ck2
         8wJtwXrFpWPlcwX3JBvKFk61E77dPYAb0o4ZS6QivcLAxxymoy+SIWueXSvhsWe+Cui0
         5M5/40WeQcT5p+w3fM/dlxqUl/nd2uCkqI1Ch1LT780M9ui4QcYyvBLFwwvG/HkUGw/2
         ius4Ma6d9Ba2ztYKa4i/bA7eWNdcpXplomqgDocIwJ8mhjHxvSOs2EkEPg8k6mP1e5eX
         ivr+bf+9dFvo7pyIFXxda2BQshTin5d1OCk7NFTzfkF9LebTtfxVv5dpxLe/SRxyKnXx
         raDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBIWbSPpc7j2EgIiZbpjBgwSCzEoaoZA6IHHGeyqm0k=;
        b=nrXooFr8H9w/C0aL3rbCi4/NULlb+/+3U/WpPAulID2RzcQgKRMePFp8r52gLbAm+h
         ZnllYXcX4f4hp1h7cks/hJLO2OS0C86Zhj0z1vhC0M1M71FdXju1uFhRfV9XSSBg1hOu
         GWqluYmvzveqCa01u+w/yRDUK6BJ4wn8GsaB7RO5CeXjLnPiAhJtiirh7/1Bh7z4P3rw
         H0J/+FqHKtQCEmE1+v7srqrKS/pdE+ZEUY5yXs7/XRbg3BCeO+uVOPItZOogq3MqefT7
         35Nd/MBBOZlPwqjRbHJxRyr4TSkqaLi8AvFNuwq7wX7cqil1hyikLnbl0c1G/TqT/Wef
         Ydfw==
X-Gm-Message-State: APjAAAV+HZnn6D5eljUxPdmYjqn+KscB/X4tu/pp0H0I+Iv8acXt81pR
        U3WcnR1VIOCyAReop3pxbUxH/A==
X-Google-Smtp-Source: APXvYqwl0U7CzCVOL/tmw6kz1N59Lc9fpRVWsN1Me+FPaSVsbwduVRxDq8hd2gYZT9TE28T+W6qLNQ==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr3219226wrn.241.1557763830904;
        Mon, 13 May 2019 09:10:30 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-11-31.w90-86.abo.wanadoo.fr. [90.86.214.31])
        by smtp.gmail.com with ESMTPSA id n2sm24439089wra.89.2019.05.13.09.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 09:10:30 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 0/5] mt6392: Add support for MediaTek MT6392 PMIC
Date:   Mon, 13 May 2019 18:10:21 +0200
Message-Id: <20190513161026.31308-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims at bringing support for the MediaTek MT6392 PMIC. This
PMIC is used on the MT8516 Pumpkin board.

This patch series adds support for the following features:
 * PMIC keys
 * regulator
 * RTC

Fabien Parent (5):
  dt-bindings: regulator: add support for MT6392
  regulator: mt6392: Add support for MT6392 regulator
  dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
  mfd: mt6397: Add support for MT6392 pmic
  arm64: dts: mt6392: Add PMIC mt6392 dtsi

 .../devicetree/bindings/mfd/mt6397.txt        |  12 +-
 .../bindings/regulator/mt6392-regulator.txt   | 220 ++++++++
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 208 ++++++++
 drivers/mfd/mt6397-core.c                     |  55 ++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6392-regulator.c          | 490 ++++++++++++++++++
 include/linux/mfd/mt6392/core.h               |  42 ++
 include/linux/mfd/mt6392/registers.h          | 487 +++++++++++++++++
 include/linux/regulator/mt6392-regulator.h    |  40 ++
 10 files changed, 1562 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6392-regulator.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h
 create mode 100644 include/linux/regulator/mt6392-regulator.h

-- 
2.20.1


Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C10C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80B1218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLmr/IYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfC3Fun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 01:50:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45389 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfC3Fun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 01:50:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so5059156wra.12;
        Fri, 29 Mar 2019 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BmXvWkyxo0c8a4qSu48xg6QsEYyfhThwmxiqL36nycg=;
        b=BLmr/IYPUMLESgfe9D6xXJGcon+tfp/WEkK54RaNBeXULqDdmGbULhRpYlTBHZv39n
         VAv8pHTXnQhiS7ziRT/a/hOIz+LILsdRGCBsg99ZI2bzgpMQZ6CWWzDlg4wAc60J+4if
         HqsP8rKa4fLmCzUcAzovGMXjtP4ySnoF/Ia9UKyCMobxt2+4k9xzG2y7COzbgbcZ5pPq
         c6D0tx7m9goDCb2HjEdmA3ulBgdIfMddD/rx5aC0MlJz2DQdoBxKxiOyb/EP+kMl7wHa
         ocmTLEjqIgeqHeCSTYDssFDATbDhyHqiDL7o3BtQWckGzWdSkiL228554It/yxTXFFv4
         CqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BmXvWkyxo0c8a4qSu48xg6QsEYyfhThwmxiqL36nycg=;
        b=sh0FF+rXeaayThJNmFEelWQeBeMTyE+Df1D/epnCPxGMZCUwcCg+bCalyVO3T5Mf1R
         0CI+8yz7tvShoMR4GVVqkod0Q1RbIFkIPotVwuJy5N5qhkNAGP26iSAGK3tvFDGqML21
         z7l0UkZvmtHynGjdJfmxImEl/PtMvsUrXzkrUxam8/C8mYrW8OTrpOYmEuAJtYs8MBNx
         Km467GNuJDmM2OIYhxJ+0q8UPlTOhMnkLsJy1jh7Egn2TpDjR6dsFS7HrWVwbLkoaGNo
         1pGH9wYuRXI/7r62W9rGlzjH8GmZ4yv7VMDAYsy9uruSNR6DT/h2qlnswiZ6DlzExEjk
         chMg==
X-Gm-Message-State: APjAAAWsh3oq8chwtMGXwsyu4mx/CX3pGSEk6QfqGwuLpXhJlGCrCfJe
        JwXTlucJrd1R9iE1z4r8dDY=
X-Google-Smtp-Source: APXvYqzTaqhp6GoI+uprofX7t5yl2CXQbTl3tHPIkZjaRr3LCxTF56Di12TXVDrxsKLBL9HeLKCJMg==
X-Received: by 2002:a5d:698b:: with SMTP id g11mr30329506wru.65.1553925041203;
        Fri, 29 Mar 2019 22:50:41 -0700 (PDT)
Received: from localhost.localdomain (79.red-83-47-240.dynamicip.rima-tde.net. [83.47.240.79])
        by smtp.gmail.com with ESMTPSA id l8sm4089610wrv.45.2019.03.29.22.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 22:50:40 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, devicetree@vger.kernel.org,
        john@phrozen.org, linux-mips@vger.kernel.org, robh+dt@kernel.org,
        neil@brown.name
Subject: [PATCH v2 0/2] MT7621 PCIe PHY
Date:   Sat, 30 Mar 2019 06:50:36 +0100
Message-Id: <20190330055038.18958-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the PCIe PHY found in the Mediatek
MT7621 SoC.

This is the first attempt to get feedback of what is missing in
this driver to be promoted from staging.

There is also a 'mt7621-pci' driver which is the controller part
which is still in staging and is a client of this phy.

Both drivers have been tested together in a gnubee1 board.

Changes in v2:
    - Reorder patches to get bindings first in the series.
    - Don't use child nodes in the device tree. Use #phy-cells=1 instead.
    - Update driver code with new 'xlate' function for the new device tree.
    - Minor changes in driver's macros changing some spaces to tabs.

Thanks in advance for your time.

Best regards,
     Sergio Paracuellos

Sergio Paracuellos (2):
  dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY
  phy: ralink: Add PHY driver for MT7621 PCIe PHY

 .../bindings/phy/mediatek,mt7621-pci-phy.txt  |  28 ++
 drivers/phy/ralink/Kconfig                    |   7 +
 drivers/phy/ralink/Makefile                   |   1 +
 drivers/phy/ralink/phy-mt7621-pci.c           | 401 ++++++++++++++++++
 4 files changed, 437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
 create mode 100644 drivers/phy/ralink/phy-mt7621-pci.c

-- 
2.19.1


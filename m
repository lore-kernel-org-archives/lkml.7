Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D553C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4004204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPEWhYQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCNNWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:22:15 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45661 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfCNNWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:22:15 -0400
Received: by mail-wr1-f53.google.com with SMTP id h99so5816575wrh.12;
        Thu, 14 Mar 2019 06:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g38Tf2KlGC3MsI7rD6vgAvY53tZNBCthHbygknXlwU8=;
        b=hPEWhYQ8rWVyS5yNROyfgEzmUFptAp6qaICkQnhrmI3q+/5ZZlD+xU1FPOL+Bp3O7+
         43Jn78QcQoLGWwx9qZ/VT0yrD7iW0mQInHMNUiXkEf8/sPWn6nuU8/g6b5ZLmfu4wWCu
         lXO7QbbiKS26pKC4CY4FKuQm3Louwipxk/6gdgseU7nQcnXcIwRlmuYZxfDIPT+hcIZ4
         aUbnMBd1ATWAd18HOs43emFwUCwfq3Chx//mGFUEEGeWDnLk5MTz/mxat0vCaLKc9yHp
         5MFMTDkwfkVGK+da2ECKEcSxSHMPvYol9iQGQyPleDu9VOwpE2eUD9LidX5irHcYLr+k
         gRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g38Tf2KlGC3MsI7rD6vgAvY53tZNBCthHbygknXlwU8=;
        b=KNVLAiMsuQslLIPtylGXdQokgqGUrFhBbYsuBOhr207DldE7OJjJ9chrVhhyLpZQc7
         lv4I9w/s4+IhaLetApR/gdVsthl3Gtvc3LTokhcwPSXjxFU2ws4dA9exk1zDufOQ3Nbl
         XaKgwwoameXacee/RKO5XNgisua0ufNnWrPnrahfboLDddCBtxKqwljpE/fYC+wDzPO1
         hXCCvCODOs2Q8F5nlewdpL6W588hDhFr8Ni9pctYZ0nqDCuyOCwaQZzl1JA+LeA8JEvX
         1SY3kX2upUB4LiUgDnDxfSL4BczlA6zw/WXVg4QuCLOq+1V357jmWCcuIHwEU+x/4SOc
         K2lQ==
X-Gm-Message-State: APjAAAWiC6HYrWXoY9i6l3ljaH3lRQ+Z8g0Ab3qvoSPjq6eyRwKmGeSS
        zvNWeHBbHlnUXblQwtp6B5I=
X-Google-Smtp-Source: APXvYqzfMJL4MwWiuBpfM+uz6bMOqkDJWxG9WwIFXKaIa3EQ5UeyFTN2r5ENwdBkwWoQTahByD/Dsw==
X-Received: by 2002:adf:ce91:: with SMTP id r17mr30121304wrn.80.1552569733179;
        Thu, 14 Mar 2019 06:22:13 -0700 (PDT)
Received: from localhost.localdomain (79.red-83-47-240.dynamicip.rima-tde.net. [83.47.240.79])
        by smtp.gmail.com with ESMTPSA id y66sm2979820wmd.37.2019.03.14.06.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Mar 2019 06:22:12 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, devicetree@vger.kernel.org,
        john@phrozen.org, linux-mips@vger.kernel.org, robh+dt@kernel.org,
        neil@brown.name
Subject: MT7621 PCIe PHY
Date:   Thu, 14 Mar 2019 14:22:08 +0100
Message-Id: <20190314132210.654-1-sergio.paracuellos@gmail.com>
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

Thanks in advance for your time.

Best regards,
     Sergio Paracuellos

Sergio Paracuellos (2):
  phy: ralink: Add PHY driver for MT7621 PCIe PHY
  dt-bindings: phy: Add binding for Mediatek MT7621 PCIe PHY

 .../bindings/phy/mediatek,mt7621-pci-phy.txt  |  54 +++
 drivers/phy/ralink/Kconfig                    |   7 +
 drivers/phy/ralink/Makefile                   |   1 +
 drivers/phy/ralink/phy-mt7621-pci.c           | 387 ++++++++++++++++++
 4 files changed, 449 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
 create mode 100644 drivers/phy/ralink/phy-mt7621-pci.c

-- 
2.19.1


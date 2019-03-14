Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCB0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF1E21852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zBFdJD6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfCNOB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:01:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55204 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfCNOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:01:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so3163935wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fjwsjwlHMsEm45LUtcBnXKn7bhdbIvWwPtmw07Gq+o=;
        b=zBFdJD6U1S/1wQSSjtxcxoMgff9/XaRbHJpkR0cpR11MMON5HlXDtQsHQJ/XgyUAXJ
         27JdlLZEA0r1GHJmhsP/C8C1lV84QhoOcQ9fTurPltKj+JXIs4crqJ38SBpAGQWLi4X9
         NynLUJsNRv6BEcV+Y8aw0LepVjdqkwwJVJO32betyXJBEeNTRv/yDGDftz8cyPqU9NiB
         31JtPMOOexeJKGC1QKGDTlPHLi6DVgy0AJuRX1dntLuRltCl8nQfpL2BXDnDyCerEqqf
         TLDBsQCJ6+wrs7UITo/jtfkxABmFZ7x5QPVC+eYC+O46e2UxZB/U8RKPbKXUKOn+eRy3
         NAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fjwsjwlHMsEm45LUtcBnXKn7bhdbIvWwPtmw07Gq+o=;
        b=WfotlJVa5gJBmzFD8awYi3mYb5okOyrm4D42FjHFJ9kgrlvW7b6lQX9lgz15r/K/JD
         p6z6hUmUQ6RTyIxqxb8ZGEqFvTWuhGkFv+P8OSRbYCycdB/bVNZHw2ll2uT8XTT/VCh4
         NGFr8IzUqWI1kMqeCyh4EyHZluESG2SBnleygU41A0/dPZ0EJskTcQDbHvBA65P4pE4z
         Aln2r9UjSfCLk4A5J4xcLknSXLScE+o+98/uAKsHE1DglFEowy7/rjmLCCnsXTi4cv3l
         UZFRocikz1x6cfXkApRtrLQfxKt37sGWTsdKYXWg8p5cL52JRt3dtVkQ2FAbGeh/SX9r
         vpow==
X-Gm-Message-State: APjAAAXSxUAi/YsdkjJNFAW6En6Ft36Qzd+mW7d1J8oYZz8Vrjk+YW6F
        jJFdMmzgWx9XuCLyFs+B77Ye6g==
X-Google-Smtp-Source: APXvYqx1rU5GXR97ju2BKBGDGkyugpcPMuy47xNmPlDB4DMFiw/eR9pGvI7gbkdn5flBQND+gOW5TA==
X-Received: by 2002:a1c:9ed5:: with SMTP id h204mr2795123wme.35.1552572113197;
        Thu, 14 Mar 2019 07:01:53 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y7sm2661051wmi.34.2019.03.14.07.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 07:01:52 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH net-next 0/3] net: phy: add Amlogic g12a support
Date:   Thu, 14 Mar 2019 15:01:32 +0100
Message-Id: <20190314140135.19184-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the necessary bits to support network on the Amlogic
g12a SoC family.

Only the internal PHY and related MDIO mux needed to addressed. The GMAC
remains compatible with axg SoC family

This series has been tested on the u200 (S905D2) with both the internal
and external (Realtek) PHYs.

Jerome Brunet (3):
  dt-bindings: net: phy: add g12a mdio mux documentation
  net: phy: add amlogic g12a mdio mux support
  net: phy: meson-gxl: add g12a support

 .../bindings/net/mdio-mux-meson-g12a.txt      |  48 +++
 drivers/net/phy/Kconfig                       |  10 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/mdio-mux-meson-g12a.c         | 371 ++++++++++++++++++
 drivers/net/phy/meson-gxl.c                   |  14 +
 5 files changed, 444 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt
 create mode 100644 drivers/net/phy/mdio-mux-meson-g12a.c

-- 
2.20.1


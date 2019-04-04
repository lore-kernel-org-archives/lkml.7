Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48798C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E14206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nvNerVUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfDDNL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:11:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41862 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbfDDNL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:11:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so3728342wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zne7rL8o2Uhetbx8eDzdGegTuzVC77WKOG0iaHnJIq8=;
        b=nvNerVUQk6qAziZ0+scnbRC6OEhk9WP597+AozOM+ROTKSDR7u7MpLdKgt5EvID+2Z
         lmgFy0qShO6OKuCJJolP7cuWRaWzv5PZyJS46Z+yS/5uAyknWF0dy6j1pHqnSdpcn6ca
         uu7VptMH5W0JUtW/2phaiCLTKce/qERAzO8Xvdt0Ty0U3K29i87mZ8OszKRNq0TvcBju
         WuePUCXTskOqFG3vyDX02w3C0z+NHvI3vcGm39Q7sxavIHJE+DNUL4vnwVn6CCxMRskQ
         vlfkc7ob8oB2iNHsaanrLZTm6YPyTyngAfr+y/m49pQrQSAX947ENAyvRgakPAuH6EZC
         VVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zne7rL8o2Uhetbx8eDzdGegTuzVC77WKOG0iaHnJIq8=;
        b=a4A2HUZW7HYH14jY92WF2+KHW15j+9Huh40tec30mPfYbr7QAACcq+deBi3brHZtP9
         LbxBr/GPDi0WlqEi1JhJYbxeLLHoMJH1q1e3nvkSKWz5hsYmUoQvpiJrj2Gh+yjgyBUD
         QHTh+hFAOUZtoAtZhAIxVwN8LeuZ5heFQwhvHlsWg76FHEPymxH0GXfd8ZHcmCcabcv2
         88+sxz7ponCYsuigpEsP86TTeH9pZvHOsyJLLpDKjlHMX1l04f7KCg/dO8jtTKjc8tbv
         2N2M5rzcvL4Gf46YC9n885edtVMc+gggjStUBn+t7SeYm55O+2evS90B/AJ5rSLbN6jy
         3/mA==
X-Gm-Message-State: APjAAAUYPxRiPePsc/cRkVVBmIv9D40jwpCv8APvs+PnI34OjlSOY8Hd
        TQJ+8zDWlPm1+4L35IjTSG5/nw==
X-Google-Smtp-Source: APXvYqypwdXWJe5AkkYqY+DHm1GPpZPJOHhhVcQYDZOVACiPzLus4L85LxAgzq7fAFI7fvo0013deQ==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr4207420wro.189.1554383515894;
        Thu, 04 Apr 2019 06:11:55 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y133sm21984923wmd.2.2019.04.04.06.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 06:11:55 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH net-next v3 0/4] net: phy: add Amlogic g12a support
Date:   Thu,  4 Apr 2019 15:11:43 +0200
Message-Id: <20190404131147.31156-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the necessary bits to support network on the Amlogic
g12a SoC family.

Only the internal PHY and related MDIO mux needed to be addressed.
The GMAC remains compatible with axg SoC family

This series has been tested on the u200 (S905D2) with both the internal
and external (Realtek) PHYs.

Change since v2 [1]:
* Change 'clk part' Reviewed-by as suggested
* Remove default callback from phy drivers
* Use exact match PHY macros
* Default MDIO g12a as module if ARCH_MESON is enabled
* Don't print error on probe defer in the g12a mdio mux

Change since v1 [0]:
* drop '_' from function name unrelated to locking
* fix peripheral clock disable on error
* fix variable declaration reverse Xmas trees
* fix Kconfig dependency on CCF
  (Actually needed for 'struct clk_hw', Thx Andrew !)
* Minor fix in the DT exemple as reported by Rob

[0] https://lkml.kernel.org/r/20190314140135.19184-1-jbrunet@baylibre.com
[1] https://lkml.kernel.org/r/20190329141512.29867-1-jbrunet@baylibre.com

Jerome Brunet (4):
  dt-bindings: net: phy: add g12a mdio mux documentation
  net: phy: add amlogic g12a mdio mux support
  net: phy: meson-gxl: add g12a support
  net: phy: meson-gxl: clean-up gxl variant driver

 .../bindings/net/mdio-mux-meson-g12a.txt      |  48 +++
 drivers/net/phy/Kconfig                       |  11 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/mdio-mux-meson-g12a.c         | 380 ++++++++++++++++++
 drivers/net/phy/meson-gxl.c                   |  17 +-
 5 files changed, 453 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt
 create mode 100644 drivers/net/phy/mdio-mux-meson-g12a.c

-- 
2.20.1


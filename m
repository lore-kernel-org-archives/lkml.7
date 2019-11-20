Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E6C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DE322419
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GtZuKo/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfKTLkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:40:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44773 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfKTLkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:40:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so14080841pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPJkuGz+JSjzJ50nZ26ldWX3k6k/FLUFZmlBSMSkXIM=;
        b=GtZuKo/YXhZDfFx2Fg6eTUxxwhtdrqfhNSiftIvxAboMj7Abz8xhbA6gApZCbFjKhx
         6++Cl8pLFZDZ+HgBc2POt6G2l1ZCWOYmPlqQwsubN7RSEa7EtG3XmIAtld4tulVCrEBP
         oSBFwZNYGG/AP89b5q2JMQOwDl/CE1NVR36xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPJkuGz+JSjzJ50nZ26ldWX3k6k/FLUFZmlBSMSkXIM=;
        b=l2P1E3VJoaOnpDgJKHx44pCIGUaDxA8926A2Aid8ippNvj3MmRuN1QwmdV1kXw+sWM
         CTqCqGpSqAF7IPcsJmfQb/bulVfP/94em3pVw2E1VwBRziFKWvX1rO5+nTjNJqZ0PZ6e
         Jddnf0gJ4VvXwrSPILRdb+9ktGzXdTt+cG0dB7WqfNnHhsMS882BHXEGG9LMqk5grTgO
         icoFMd1Hrf9/FoEsdF3JPiNs8FjlTYbS3R6CUDYnPIzHUtLUduAvV9ioJZejWnaUjyQi
         WPxcpOiKSWBg+GoXLEy1c6F7Jg79Wbak0XJtCMCt7aoauFt/AvuKG7ft3QalDb55Ktic
         MFdQ==
X-Gm-Message-State: APjAAAXfNNBXpTLh9aIHikiX0wUfyNw2UycNfxNNkvpYNnKsWrqWuyia
        7kqHJpvju8VNtT9vNouLGwwWJQ==
X-Google-Smtp-Source: APXvYqwEZ56JDZTPJcrZRd6NoxeRu3wg9RK57Xc3CqoGcBA0SsoP47nnmr5ufV5AVYg+p5xqSb8IRg==
X-Received: by 2002:a62:e818:: with SMTP id c24mr3459856pfi.125.1574250051807;
        Wed, 20 Nov 2019 03:40:51 -0800 (PST)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id h185sm13492850pgc.87.2019.11.20.03.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 03:40:50 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 0/5] arm64: dts: rockchip: Add Rock Pi N10 support
Date:   Wed, 20 Nov 2019 17:09:18 +0530
Message-Id: <20191120113923.11685-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike, other Rock PI boards from radxa, Rock Pi N10 SBC is based
on SOM + Carrier board combination.

Rock Pi N10 is a Rockchip RK3399Pro based SBC, which has
- VMARC RK3399Pro SOM (as per SMARC standard) from Vamrs.
- Compatible carrier board from Radxa.

This series add initial support for Rock Pi N10.

patch 0001: dt-bindings for VMARC RK3399Pro SOM

patch 0002: VMARC RK3399Pro SOM dtsi support

patch 0003: dt-bindings for Rock Pi N10

patch 0004: Radxa carrier board dtsi support

patch 0005: Rock Pi N10 dts support

Tested basic peripherals and will all more in future patches.

Any inputs?
Jagan.

Jagan Teki (5):
  dt-bindings: arm: rockchip: Add VMARC RK3399Pro SOM binding
  arm64: dts: rockchip: Add VMARC RK3399Pro SOM initial support
  dt-bindings: arm: rockchip: Add Rock Pi N10 binding
  ARM: dts: rockchip: Add Radxa Carrier board
  arm64: dts: rockchip: Add Radxa Rock Pi N10 initial support

 .../devicetree/bindings/arm/rockchip.yaml     |  10 +
 .../boot/dts/rockchip-radxa-carrierboard.dtsi |  81 +++++
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399pro-rock-pi-n10.dts    |  17 +
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 339 ++++++++++++++++++
 5 files changed, 448 insertions(+)
 create mode 100644 arch/arm/boot/dts/rockchip-radxa-carrierboard.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi

-- 
2.18.0.321.gffc6fa0e3


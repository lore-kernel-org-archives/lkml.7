Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5367C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A83B2068E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Dn06DFYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKUOPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:15:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36474 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUOPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:15:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so1757312pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0lg7xoqCU9griTX07bOPborDv4xC+ndaqpkFXe9TjLg=;
        b=Dn06DFYADguxXrNrHFoCiFbFd1uG/ryAw8ky8mYHCn9oUzVz9hB2yMDAu5ULjtXAI0
         hqC4JRrQZa8CXukoaP5Y2URVyXUjUpoKO7Lgzizd9Bp5vGOLa8HrAUeWBKmfT0wOmT1z
         p43ut5Cy5wBhePmkmrvHQVgasIXEG9iPq+vVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0lg7xoqCU9griTX07bOPborDv4xC+ndaqpkFXe9TjLg=;
        b=TgQfGbeD0zRpxp6FLmws8rJdR5r0Em/NsJyt0jw69mldxxumOkBIPolP6Veh4KrD44
         Kp1GtBCShCC0EZgqXqGe1xFd9kx8DHJw9g9/LJliyvfnctSjBYh2gGruWNlErVhewLRf
         5Fptay8Wws0XnJZRhxfC7gGQmc9slEjdsRaU6E+nI05Jl/R3rtNrr0ELSM/QEu1olY7Q
         ii57bnQZxmiecY8F0VvSOUGbQ/w5qi006HF/qtZFRLIDU4WurO0NsKRShSwIfdGmsthU
         v/1WS4QEeA1ity0kxpqtFadko/AHiz//dO2Cp4StD4IDKTYUmaEZomUbDe6YVIHwTKxy
         zZpw==
X-Gm-Message-State: APjAAAVQX1eDc/FrTy8RlYJmUAcuwf19yEYsiTvy6Nxjw53c6KaQcTz5
        ziTbT0KiL0V2SiULvl0n9xj/kQ==
X-Google-Smtp-Source: APXvYqwuTjhpD/waPmGZkM+fuBj2AUAa0JiWceYv23FKWcp+RSP3vrbjA1wVoDSX04kNhqg5Ck74hQ==
X-Received: by 2002:a63:1303:: with SMTP id i3mr9710113pgl.430.1574345702647;
        Thu, 21 Nov 2019 06:15:02 -0800 (PST)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id w138sm4072304pfc.68.2019.11.21.06.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:15:01 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 0/5] arm64: dts: rockchip: Add Rock Pi N10 support
Date:   Thu, 21 Nov 2019 19:44:40 +0530
Message-Id: <20191121141445.28712-1-jagan@amarulasolutions.com>
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
- Dalang carrier board from Radxa.

This series add initial support for Rock Pi N10 and fixes comments 
from Heiko from v1[1].

patch 0001: dt-bindings for VMARC RK3399Pro SOM

patch 0002: VMARC RK3399Pro SOM dtsi support

patch 0003: dt-bindings for Rock Pi N10

patch 0004: Radxa Dalang carrier board dtsi support

patch 0005: Rock Pi N10 dts support

Tested basic peripherals and will all more in future patches.

[1] https://patchwork.kernel.org/cover/11253649/

Any inputs?
Jagan.

Jagan Teki (5):
  dt-bindings: arm: rockchip: Add VMARC RK3399Pro SOM binding
  arm64: dts: rockchip: Add VMARC RK3399Pro SOM initial support
  dt-bindings: arm: rockchip: Add Rock Pi N10 binding
  ARM: dts: rockchip: Add Radxa Dalang Carrier board
  arm64: dts: rockchip: Add Radxa Rock Pi N10 initial support

 .../devicetree/bindings/arm/rockchip.yaml     |  10 +
 .../dts/rockchip-radxa-dalang-carrier.dtsi    |  81 +++++
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399pro-rock-pi-n10.dts    |  17 +
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 333 ++++++++++++++++++
 5 files changed, 442 insertions(+)
 create mode 100644 arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi

-- 
2.18.0.321.gffc6fa0e3


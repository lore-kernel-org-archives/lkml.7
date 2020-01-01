Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD940C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 16:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1912073D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 16:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HWdlEBR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgAAQbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 11:31:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38233 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgAAQbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 11:31:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so3811025wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 08:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iN3ER8YBL77cDQ+F7+peYqBn5NYdW4aIpShdgc/0S5s=;
        b=HWdlEBR3JniTqw/OkazjCGEkoQHRuIWTuBNfMBi7WDC8TversAkpXSvCpZgoGVkh5Y
         gk9v/VSKQ5z4o6ZUWJDW1R5hsLbNlFsEDhg6bxMBFocVxprC2d3T2uhP1VjMp7g9u+RE
         S1akPddbRjKMeyIIqdhWOLR6OBdwUt6CTZuXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iN3ER8YBL77cDQ+F7+peYqBn5NYdW4aIpShdgc/0S5s=;
        b=Y3paHpihRBRg7DxwmQoDWNPzb7Ip+5N/AruuQLKoB7v49dfSuAud1Ifj9UywLvBz2S
         ZnZxYdyIilIEp1c0phD65GC93eG32lWSUEcDEDGQK19kGtXong5L28HWTPtN/i5ABfFk
         LH3o8qBR6WmF953Xl12CApTp/RPM6Adxc1n4cYg2qczCYE4RKeFitJ9Dz+YF6QQ68cSC
         39sa7ZtuDyOL2jjXOZSn03KdSDCIlAvqyHLQxC5XZl5ZyezvN5hfX8xaLLa9HOWHIiJt
         +StOfS5/O5QY4TzCRmVHdt/g+OaS720agDh9ftOp6IIjmN0KJTc+KbIsZ/CIESHpwsDV
         +q5w==
X-Gm-Message-State: APjAAAXKd1nzgIuiKatcCW5D1FO8m+XPmUHHGhaAffR3Kj4RVDctnZCU
        QbAmPrnq3YS02IH231M3x+JDQQ==
X-Google-Smtp-Source: APXvYqyghfuMJFR6V3A8pWQdPhOIC3GGm41k/h7MWdufo7KjaCPPTc0Pw+IdDBc6OVBOulRnsXNLNA==
X-Received: by 2002:a1c:5945:: with SMTP id n66mr9505080wmb.98.1577896298391;
        Wed, 01 Jan 2020 08:31:38 -0800 (PST)
Received: from panicking.lan (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id u13sm6108580wmd.36.2020.01.01.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 08:31:37 -0800 (PST)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com
Subject: [PATCH 0/3] Add initial support for iMX8MM power domain
Date:   Wed,  1 Jan 2020 17:31:33 +0100
Message-Id: <20200101163136.1586-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some minimal support for imx8mm power domain. This let my usb otg2
to properly work in host mode. The patches and the description are
quite similar to iMX8MQ. I follow the same logic.

Michael Trimarchi (3):
  soc: imx: gpcv2: add support for i.MX8MM SoC
  irqchip/irq-imx-gpcv2: Add IRQCHIP_DECLARE for i.MX8MM compatible
  arm64: dts: imx8mm: properly describe IRQ hierarchy

 .../bindings/power/fsl,imx-gpcv2.txt          |   4 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  31 ++++-
 drivers/irqchip/irq-imx-gpcv2.c               |   2 +
 drivers/soc/imx/gpcv2.c                       | 110 ++++++++++++++++++
 4 files changed, 145 insertions(+), 2 deletions(-)

-- 
2.17.1


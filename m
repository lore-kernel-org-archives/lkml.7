Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B001C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C7D2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="NzBNdntB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbgAINjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:39:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53709 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731266AbgAINjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:39:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so2959589wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3uTRVYc3CwuaK7vmscKhsuq+TjWl2SbzmcNvk0jneyE=;
        b=NzBNdntB5n+8cI1SL4hqMv75gF5qlYVZoch0u5XZUNN4uJshZpMC51TbpQMMmZfbz4
         /2T+YoXIspoZOzWP7ZZp2UN/RCcGF882X7PoCZ86N8BWE6MXAmqVVqSbBKbeYE0XmQZM
         tESlcMvjCBE24H8bTMS5E1AGelx5r61vXOojuK8GbCRdchRQ7lVB++1TT7gVfM0usSD/
         iS2T3WgMxXxWXF8QWlfW6xUiRoJsABW+Z/uoss5qUGF9PvrlI5gZR64dLhTr351ioKeX
         mZoxh4DBVAjdM3a6aLJzGN/bXBq4dBjShu18PMl/Dt1UcljrSlVPQpSfzbDbBmJc7DPu
         FEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3uTRVYc3CwuaK7vmscKhsuq+TjWl2SbzmcNvk0jneyE=;
        b=sZkd08fzbmtFjeyk35jaEeFk06Lk7MkgmKvruQpIOeB/fj8bEBYzTCS0MWySVhHlwO
         Oc7rNST9iSx4CEPoTynX9/V2Tf8DCbieTcEvWHAHkrJBJx+rOjujP+WY6KzEszj2A3it
         fyRLhZYUvUnYlpFQN5tnG74ZJZjGXJ6RK9hit93nkw7XIMIkyypsOJjmK3d95QRjR3wQ
         fRjvpZvXLAx4ONz8s1s2XoquqcE28pByluXCAyKxquBJkn8RBnOidBm4shl89oHnjHvU
         Esdbt4F4Mcu7DgCd29nN5t5d8XDofqZKlZllBu+Jz7+fKAAEfSmNrIaJ2g4oYDJXKa3r
         i6mA==
X-Gm-Message-State: APjAAAVq5A7Y/7+5yVM0hRK2Ru2xVk47kBQvGiPMaZIzCW5HulYDiI/e
        rgfW9zdwLlDOAWC2pvM6/Dhw5A==
X-Google-Smtp-Source: APXvYqxf0QTNnxUA/HlCe/Xc2QU9JGp9/9H2D79UhXJ9ShL1knOd6pTuDj94GA14KOuiRGe/kR1Lvw==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr4856590wmc.74.1578577168009;
        Thu, 09 Jan 2020 05:39:28 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id s8sm7846492wrt.57.2020.01.09.05.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 05:39:27 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: zynqmp: Setup default number of chipselects for zcu100
Date:   Thu,  9 Jan 2020 14:39:15 +0100
Message-Id: <0565b9a88830f0d995d666a9c4bf346641a2b040.1578577147.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578577147.git.michal.simek@xilinx.com>
References: <cover.1578577147.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one chipselect on each connector.
Define it directly in board dts file.
There should be an option to use more chipselects via gpios.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 2b3757dd74cc..a109e82982ae 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -250,11 +250,13 @@ wlcore: wifi@2 {
 &spi0 { /* Low Speed connector */
 	status = "okay";
 	label = "LS-SPI0";
+	num-cs = <1>;
 };
 
 &spi1 { /* High Speed connector */
 	status = "okay";
 	label = "HS-SPI1";
+	num-cs = <1>;
 };
 
 &uart0 {
-- 
2.24.0


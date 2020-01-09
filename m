Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858B2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0FC206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="WBiZ04BG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbgAINwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:52:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33476 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731375AbgAINwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:52:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so7547009wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCu2jl/XHfUALT1gSW/oUJuMvhaIfk+GEmxRnskvRww=;
        b=WBiZ04BGf0FD0e3HDXi2zqqJES7l8wIRo5kwT1O3LHGWVo0iDVBf5TA5HzIEFbutg7
         kpUTzFJjPnmXM0h7ETEg8JmgFtf9UqRhqAwlpTTalIxffO2dLm3XPZqNfKopczBXC7Ui
         ZKKE1w56+xR9VK3Caa08qsUnp5SyN/JD2wztdynHE9OsL0DSLgZvIJXQcZDWKWUKe+6o
         4M4CPAxrnDG28z7o53mVHI+9oaaB/qPWXgX4HRF0NniezhiF1ffsTNCtNwaOOei7ovM6
         KZlLbV8Y6Tj6OZw7zDmN/ZsoQdWmTJDRQqwIUCIASQ2Tc+Jk0C/AiaZvY4NVyl2kDn6c
         vYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NCu2jl/XHfUALT1gSW/oUJuMvhaIfk+GEmxRnskvRww=;
        b=o/1wL1ESlKf+LBNNrBqkXET9laW+aYTwNiSQZ0luO30v0q7gBRRbHl4osC5EzHq8LU
         Zfem2OphmnRDPMWX3TjPcJpdrX1LhrU+w0KXPZbTyWDOBiwpUDuuy7u5ZdaULCTAXqf3
         SudhCGQ8RnoRPKzbxirIjAtArqvBlBlASsE8rCvk9InqqaWs8IcAc3axeveMeWrE82ea
         bnuTA32kNKCeJUerxN5FFH9B93kXvcqKEJhBJ2qsf9EAboYkLSao3Wz3W4SToW67cQ4r
         Zh/vw4yBRcVB1DoPs0zxTgqZt6mnHBVBBfoeFycF6ONx6kpja90M6OrjXbOuHoCwg5Ke
         ZmBg==
X-Gm-Message-State: APjAAAVZ8eeoyJqnzDJaOM8Le6uhdlV8AgzRKcq9nJM+rwM8PxeVot4A
        /BPTb3hX09EyaWpqPFEHz2CERA==
X-Google-Smtp-Source: APXvYqzlZUNpCtgZo0eIHsRriyQS9df0EhD997mMpVJO2gscTH1ejvVUUg0WzAxElifJzEkjuAAYQQ==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr10940641wrm.210.1578577957079;
        Thu, 09 Jan 2020 05:52:37 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id l7sm8332605wrq.61.2020.01.09.05.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 05:52:36 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] arm64: zynqmp: Setup default number of chipselects for zcu100
Date:   Thu,  9 Jan 2020 14:52:22 +0100
Message-Id: <227c68a635b031ce20ba2a48a950bf4407c01359.1578577931.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578577931.git.michal.simek@xilinx.com>
References: <cover.1578577931.git.michal.simek@xilinx.com>
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

Changes in v2: None

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


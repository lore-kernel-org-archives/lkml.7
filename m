Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4738EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E43F206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="ZmSrs3gf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbgAINwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:52:33 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:55761 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbgAINwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:52:30 -0500
Received: by mail-wm1-f54.google.com with SMTP id q9so2991651wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Dls9W9bj1Gd/Lpqv5BPHUUP2RvMef3FCTEyB1xcyHE=;
        b=ZmSrs3gfZlGX9yRHbls/OTOQJMinpbZpam24OqN4vYR9asSrgRGCPLZpt0NhLiuQpb
         wzZ5XSKUTJDyRkmIWZwv1k8GW++vcg36BoxACbhfOj7wKKVrvbWDcc/W8gmp+lKivacg
         JIB4lQwlXP4prJWeTZ0YTg/Y68sYDKVuKZyw+9WjU7vdXRXB5KUTw42Muyk/Rjv/tZkr
         cP/8jjSpE7H1Dsr6NtQ9j23PVU2yF0P//wNubjtDiL/s/Q7TKk90DdUGyWpGeBCQpv38
         KJnHpdATT/CUuFXt3P/CUcv+VH/LtGVavzS3Z/qFQcWMMakOkTfbV49mIPfR+4KNDcKf
         gF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5Dls9W9bj1Gd/Lpqv5BPHUUP2RvMef3FCTEyB1xcyHE=;
        b=hNRdm/tzTIg3WaIgH5o0lRZdHS/FzhM1xLwklkv8nopOMFTZLnPErmXLMgzSkk4R5O
         0d9Ua4I0Wm+fNjt+SeX/5iZ0ubf2t1H/dBhu7ZW0AE9dTuzZwWr570JDpk3VIePmWcqt
         I8yfdQn5W5GyFU8vBKl9unD7EgLacGv6OIwkYchtMkbDvT6FBJcV0l+OFucUDXnPeNp4
         gmIe7yeAO/EmL/l2th2gOgQFbkC2Ry3p0yEwDmNeV8aOlib1keK0TPCWn75sQTvl3qw5
         n4uc8UBJ9hMSPyq76Z03CgCiwY1AiLIQctCIEKSuP+yZuHPywTfuHvAnLZpskp6KTA6L
         YS1g==
X-Gm-Message-State: APjAAAXcWe9ZFwK1a8qQVzU+IUZRxs2xjFT3kge+yaLuUXIQRmBrHmKp
        6RWMan3rVqCoMgyI0kMWbdcETQ==
X-Google-Smtp-Source: APXvYqx0+sXU9Xa6uVSv3/rkJoMDUEUGho9XMFd9d3+XzkDYUqX5o+JlJlKdL+1KOfK8+bnYRZVCOQ==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr4957307wmi.45.1578577948805;
        Thu, 09 Jan 2020 05:52:28 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q68sm3178254wme.14.2020.01.09.05.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 05:52:28 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] arm64: zynqmp: Fix address for tca6416_u97 chip on zcu104
Date:   Thu,  9 Jan 2020 14:52:17 +0100
Message-Id: <100294ed4d902923527de042cc87eb59648ce91f.1578577931.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578577931.git.michal.simek@xilinx.com>
References: <cover.1578577931.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2c address is not 0x21 but 0x20.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 2d71b4431cce..7a4614e3f5fa 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -118,9 +118,9 @@ i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
-			tca6416_u97: gpio@21 {
+			tca6416_u97: gpio@20 {
 				compatible = "ti,tca6416";
-				reg = <0x21>;
+				reg = <0x20>;
 				gpio-controller;
 				#gpio-cells = <2>;
 				/*
-- 
2.24.0


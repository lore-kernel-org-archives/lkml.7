Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B23C33CA3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB962067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="QJIiAeT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgAINjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:39:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35763 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731159AbgAINjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:39:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2894329wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSLBbyZMom5Gh2asx6vSf9spPxO1dtGNpvUOI6kKFOE=;
        b=QJIiAeT3487JndkFw1jxkB1fCvzWWv1O/7PNOPDhXs5owXnctuTcuHcb1znb8OtuO9
         Yu4bJeEkL3whooM4CuY9LnTpi+PR2IOFXUY1iqV0UG2KmRoaITgkSSog+eyBrDp1yh9N
         Va/CFMOSakJqAkXehUGqRdpGniZFLlTrYVtGhWmq7YHBBMcsrEJHkXfK0PzXXtY4mEr/
         iQk1hg9dVrsTPRwOAKBoBUQGre82zVyKrNN3a0xplz322eKPr+GuXIlXUUoyFDInhKQI
         5MVkN5kYQJrZC0Z86vsy6hfZC48nhM5DP0DPS0kRcBxmqWUURi0P0ocbfA0N0ZaN4hZ8
         kyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iSLBbyZMom5Gh2asx6vSf9spPxO1dtGNpvUOI6kKFOE=;
        b=r3bI31QBQZCHg1vEtLjUA2sJEwDUVxoAZcsgt/cpzGigYs2+bvhtaxfcOHKxr4OLIR
         W65MatbWTWH135meAqb5JFuEP2kawZSGxEjwBsykF2YoLEzHk2yqbN21W3cNn7iah1Ym
         mEK88qDe9d2k6tMPB7Yjfmy8h/ZwNg7nRG7iihK6ARnKvznyLi3I1xP1WlrzGqcVihVB
         Wqx35XxbTAFMLBWEkr8EsHefTD9a6/4tx/uDIf+YR9bc+oIKutCyhTwkPGPQSNphkZLf
         WheY/yjYyvWBp9uv8gUMT2JVJZea6RN7jBPi05D1/aOsMxTsq/xJ+v0THHvRrjXWYJ1M
         k2aw==
X-Gm-Message-State: APjAAAVVV7w2J1q6LmEYh/5NaJa4GMooxluCmhFI7Y6l0dOaaLJ5WKq2
        tE5dxj+JFwSQK1Ot3LaX6N9bK6b5ESSmgg==
X-Google-Smtp-Source: APXvYqwGbw1JXeoKM7gwrs21nIc0OoNINaE7UVW4HZCYixEZBd/0C48GvM2p3JS33LvusyNKo9Tkag==
X-Received: by 2002:a1c:81ce:: with SMTP id c197mr5072174wmd.96.1578577159200;
        Thu, 09 Jan 2020 05:39:19 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q68sm3136809wme.14.2020.01.09.05.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 05:39:18 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] arm64: zynqmp: Fix address for tca6416_u97 chip on zcu104
Date:   Thu,  9 Jan 2020 14:39:10 +0100
Message-Id: <c542d6e305010dd08ff1d434de6f9d1996a6b0d6.1578577147.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578577147.git.michal.simek@xilinx.com>
References: <cover.1578577147.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2c address is not 0x21 but 0x20.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

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


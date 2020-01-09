Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5152C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0292077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="eo1zaEGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbgAINj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:39:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35471 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbgAINj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:39:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so7449578wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8iGe/BokIqYVIferI0k5q9JOZCEsfURHQgz30AC5VkQ=;
        b=eo1zaEGlu59ZCciIZUQL5j6ovn7/ex11pNjDfx0qLWOl11Bjtz0XMgKZy0TWPgZTh1
         13VxWDNHZ5MnvvZ5TI3NfsAxE6TMzyKuL8+N70jJW/ulwEj36FLWTemAxVlXlG6ZMssx
         2ygvegR3HhcUGPYnLUtsv5ffMHjn78iXXaXArFzYMD5QUXUB75JfgPJmvfwEP6h9CM7B
         DO3CxXA/jTy12gQ6hZSsuv0O7P6GF9VWR5hEK4psHT9gJqXtvBOArVITlIzmzT2eN1Eo
         sUVwPFQoMPzuLeB3+KMVzuurypWqjTH+kr6Nj9yrdBoegpn/xO4gefFJsW/qIoumAJE9
         fxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8iGe/BokIqYVIferI0k5q9JOZCEsfURHQgz30AC5VkQ=;
        b=E34+gMMWBGhiafB8z9OSfqFbOFzLSSFYTOBFFF8wxN27J5d4cPjQT6FR5ane5eX//m
         UZnYENuKqxJuKCrkFDZW/2xNLEtUXR9QVCf611h7SoS18FnLSru32Jju0i0oz2R3aL/y
         fI7ZKdAPUYhgzrCNrQJENYigiEexfxwQNOo5Qm8g5+1aCjUtc4/ZLzq92s4P5J40qFXG
         MLzF7oziX7PdFcNdbAyyg7DIYlqet4kKcMMlKLPgILcO6FN3rq6XECfwYH/QNDZBHszS
         mlmtYZ0txqf9Qn8C2Abu9QKCYoOLkeb2wljJG5ePTYcBJYL4qEgCZbqMShvhXdmWttTf
         hbRA==
X-Gm-Message-State: APjAAAXQBf/gc6EZVXhIC9XMdYdWMbD5M+Sm37b/IBAG8/7nXdpXUvbg
        fwnsrb8iTy0dM3M4lNy6KtP+SBMXzuSeLQ==
X-Google-Smtp-Source: APXvYqxHNk75iP2xMF1ahG95r2ei7cIYSOulT5oG4ZmfepYBGl7fgDQ4d6VHHMHAzCG3BfSnypjb0g==
X-Received: by 2002:a5d:4cc9:: with SMTP id c9mr10782702wrt.70.1578577164608;
        Thu, 09 Jan 2020 05:39:24 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d10sm8455126wrw.64.2020.01.09.05.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 05:39:24 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64: zynqmp: Fix the si570 clock frequency on zcu111
Date:   Thu,  9 Jan 2020 14:39:13 +0100
Message-Id: <f16ade8e75ef9f9eeb133145d510b142c13121e8.1578577147.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1578577147.git.michal.simek@xilinx.com>
References: <cover.1578577147.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>

The si570 clock frequency should be 156.25MHz as per datasheet.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 022c732005ee..cb2e46833a7b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -317,7 +317,7 @@ si570_2: clock-generator@5d { /* USER MGT SI570 - u49 */
 				reg = <0x5d>;
 				temperature-stability = <50>;
 				factory-fout = <156250000>;
-				clock-frequency = <148500000>;
+				clock-frequency = <156250000>;
 				clock-output-names = "si570_mgt";
 			};
 		};
-- 
2.24.0


Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD7EC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A126217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNZl8wHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbfDQRbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:31:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36901 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733034AbfDQRaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:30:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so4566831wmf.2;
        Wed, 17 Apr 2019 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+YiUM75De4BFeN5CqwNUI+YVTIngpiY3A0fybpC1XI=;
        b=PNZl8wHyxbSAmvbzf4KiobddapYSMCxVKmxwk9lrMRnkVoGOtP+PKtfakTyBvpxJok
         AS8kfvF4EL7oM/w6sjWrEnSr+isSbCJjCB1UnUhrRTY2hnUtUehSaWSuofVL6gmL1Kba
         wYdufqWdWg1vts73uwTNWzymieHs1p7bpbti0Rt/2wbqBIc0bMkQIORYO1Nwygz7HlPw
         w3ujKcBqjrtn0m62RGKJacL/8Jd8VsIoKSUezoowq9zhS95+Cu22iwWv77G1YlNpHj1i
         GLHu0ySt8AEBSfOGmiUwMh9iraL9Ap13YHA1UPP7DO2G7m7sN5ZtTPzlvg5R5cjJWmBr
         nc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+YiUM75De4BFeN5CqwNUI+YVTIngpiY3A0fybpC1XI=;
        b=EL2V2Qn7w9cZ6q770Ta6qQt/bem1wvWYVWGcwyIigF2wag9JT7pTgAhu4va25apFPY
         zCpx5M0/WF8RvxLzzwsZ694fXOE1vcpvWx8yUIcpIno9bXHPsLWc93metNljUSmfBZ6k
         bEyYSn7vsXRMm/rPZD60hvJOiUPsUbVT4Pc8RPMEfVEpDpNn441u5AWi1I2kGuax6hZ/
         q7VHxcY2hL+MHWYFZR1CD7nh7Xgk1zxikcHM017q2OKTQr/i5nD02unAYV6NBBNxBGEn
         4indloUSOQwHlVKJsqsbhCSDI6idaYcRuTTt6AY7XVoJi9V7qWvGq0hY+6a9cofqZo5R
         ivJA==
X-Gm-Message-State: APjAAAXrnShSq+Gx8GMyQ/4rnwginhjyJUdqEtiBVKa2x0tCDnNSZEdL
        QTsxyw4/fx4MOC+Epla037E=
X-Google-Smtp-Source: APXvYqyCy70GDJ7gaJUnHBS5DgBh6IpUzbzie+xsxjtCGtR2KujMDcMaVi0NFQi7i/It4O55Ud+8KA==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr33040526wmg.14.1555522221471;
        Wed, 17 Apr 2019 10:30:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id c6sm2669306wmb.21.2019.04.17.10.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:30:20 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 2/8] dt-bindings: gpu: mali-midgard: Add bus clock bindings
Date:   Wed, 17 Apr 2019 19:30:25 +0200
Message-Id: <20190417173031.9920-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417173031.9920-1-peron.clem@gmail.com>
References: <20190417173031.9920-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Some SoCs adds a bus clock gate to the Mali Midgard GPU.

Add the binding for the bus clock.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 1b1a74129141..2e8bbce35695 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -31,6 +31,12 @@ Optional properties:
 
 - clocks : Phandle to clock for the Mali Midgard device.
 
+- clock-names : Specify the names of the clocks specified in clocks
+  when multiple clocks are present.
+    * core: clock driving the GPU itself (When only one clock is present,
+      assume it's this clock.)
+    * bus: bus clock for the GPU
+
 - mali-supply : Phandle to regulator for the Mali device. Refer to
   Documentation/devicetree/bindings/regulator/regulator.txt for details.
 
-- 
2.17.1


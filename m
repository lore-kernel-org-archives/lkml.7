Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC059C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 03:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99926218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 03:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDn481rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfI2DWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 23:22:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45625 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfI2DWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 23:22:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id c21so12398133qtj.12;
        Sat, 28 Sep 2019 20:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cmgjUEReW2xgJs09ruxsgF5mBs1jh3iGvI+ApLc1M98=;
        b=DDn481rcaHW2wEdm6rTXaOSklaJ3ldJqF4LS4udfLf2riCgFkUp71wRYXePgR0SaR1
         U7keGNoAqVdPPLmLH8rQNF3Zq6rt5gMXUYUobgqyJL6zcHp6+J6ZsowVaWChCCH3Ijb/
         VRSuLKluiRv8egd0xKZ2Drl2ljt8G8a7B7oNb1cgebYyCivO5JLoCljr7lFWZWBzG9gb
         D1b9cMw3+bcmzolCe10vmTGQAeqF+2k4C2bp7DBskRSl9gX5MXJixAOi2J9fcqnIDAmq
         8cZU0tPHAgP/jQGKlp7ckdZOTz+srH47d13OAqL2huJOEXiyBrO4cbRCqOC2TQ+rI+nP
         90XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cmgjUEReW2xgJs09ruxsgF5mBs1jh3iGvI+ApLc1M98=;
        b=FlbkIDNSVTWkFPP4YYGwdlfPoOGLJ1tFYxkXsZvjB8OZhrWiCddItIxgDQJtPKrBCj
         WCpZbqIwVlTvU4UZdMKBx14WOJGCq72vQo0hUqujpSsx8y1OA58vRVFeMx/kJRQAl6dJ
         HaPFdZ/oDAiqHzyYAziquoxi3duaBHwF3i7ZwgQZVPxri3qAs12YkPQ1vJEmtAY93yfV
         kgsY7eiEMNQWP4Xo7pufM9tmh0uwbl8kvn9flur0Yy59ntQ6hS+tvbpeXFpdWDF18lm5
         7O+C9i9lszRYO4KvORFHvg7P70EtYLOBN10UTGvNmUBvz0DxDVSuQuQC/ZXzeYnVsvu1
         bLjQ==
X-Gm-Message-State: APjAAAWQqd6YZtf5B0lFVsG5hQJYvf8NZftQS3/fiO46swfkwjdap7/z
        VIMkNdIEBVJz+WEdFkP2bcw=
X-Google-Smtp-Source: APXvYqxUMzBmTKXxdHnKbBW/2lvalxXZXzJo0LqFLfXYxRG7wIaRk/3MJ4PaeHYHDvAc01DDxBLC5w==
X-Received: by 2002:ac8:6982:: with SMTP id o2mr18722488qtq.143.1569727356636;
        Sat, 28 Sep 2019 20:22:36 -0700 (PDT)
Received: from localhost.localdomain (ool-457857f8.dyn.optonline.net. [69.120.87.248])
        by smtp.googlemail.com with ESMTPSA id y58sm5086733qta.1.2019.09.28.20.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 20:22:36 -0700 (PDT)
From:   Vivek Unune <npcomplete13@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        ezequiel@collabora.com, vicencb@gmail.com, akash@openedev.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vivek Unune <npcomplete13@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Fix usb-c on Hugsun X99 TV Box
Date:   Sat, 28 Sep 2019 23:22:30 -0400
Message-Id: <20190929032230.24628-1-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix usb-c on X99 TV Box. Tested with armbian w/ kernel 5.3

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index 0d1f5f9a0de9..c133e8d64b2a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -644,7 +644,7 @@
 	status = "okay";
 
 	u2phy0_host: host-port {
-		phy-supply = <&vcc5v0_host>;
+		phy-supply = <&vcc5v0_typec>;
 		status = "okay";
 	};
 
@@ -712,7 +712,7 @@
 
 &usbdrd_dwc3_0 {
 	status = "okay";
-	dr_mode = "otg";
+	dr_mode = "host";
 };
 
 &usbdrd3_1 {
-- 
2.17.1


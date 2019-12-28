Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDE3C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 07:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1836721582
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 07:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcVDWAGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfL1HsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 02:48:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45818 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfL1HsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 02:48:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so28000611wrj.12;
        Fri, 27 Dec 2019 23:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hxfnZMBs1EEg7q0rSJrZ/QwgArDGkn1GU7trZB2ysxo=;
        b=IcVDWAGvv3NwbPgy6alH+NmPo2MqsIxTURvGL/WI5jN6mTyp3nhN4Gka3bC97hItnI
         o3in/nW7Tja1ASm47AYQ9t36ddYobpfx+mFpH9JWOFFeELlGLsFyO+IXwNa+oEc5vsVt
         3HjI6rwdFK18YGHlgNIoVFdZoE+vRTOAt1doILPt7GrLgp4BnhNZZNa/12TcaqQvguGR
         qB07U74euKi0+VpI2smpmU/5oSL/fQipvYOD4rUXMwaDeD4c50oBLTgop0OQSXi+s4o1
         oZ7dWW0xAVZGHOYk49k8cg2mPfO7rkL+9aYlwughmFJQ2ha09o/duP+vfyTKwhQs0RIN
         hqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hxfnZMBs1EEg7q0rSJrZ/QwgArDGkn1GU7trZB2ysxo=;
        b=gnvcD43SYZIMc6eHxAjMV/ofCFRAN/EtS/qi8JQQmIcCu9jhg7ubWftfHX1dWX9jua
         MYr1gQlghLFcP+2nLES/zccL9rCmSGR3MPC+WU7yZsB6x3NQX/eb6H1fLxSRhhUnx3dK
         DRUd349LwlJVH3LNX5L0UOh+U86AmCdrVPsX4pMj4pQdLoNPV0iZcCQMXvhPgUuG+Jam
         O9BGgdiFNDetsLDzQE7mwbMclSK3Z3Bos3Mk7TR3OjJimLSfHo+T9rnyKJWt232QD1C1
         dyi7sNj+5cVtcH3W/1vlp1C7+2oYLZQ0JNQVKPV1JLzW8uKDtFnSG0Ocqnbjm7JK4NKU
         XpZw==
X-Gm-Message-State: APjAAAXvmfGi0WxDN9GkWLqB0daKKmHAkjkW8U4P6jUL7KUzA9FlH6TD
        0r2YXI/TU/aoZ+UXdxUhFFI=
X-Google-Smtp-Source: APXvYqzbeDGPi6mv9YGx0XuuDAd8x/X+KAyCAU9avVfvpQmcfji8fwkI4Qi+dD3S4rYyS2qlcAlAUQ==
X-Received: by 2002:adf:e591:: with SMTP id l17mr50523032wrm.139.1577519284705;
        Fri, 27 Dec 2019 23:48:04 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s19sm13553258wmj.33.2019.12.27.23.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 23:48:04 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     robh+dt@kernel.org
Cc:     mark.rutland@arm.com, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: rk3368-lion-haikou: remove identical &uart0 node
Date:   Sat, 28 Dec 2019 08:47:57 +0100
Message-Id: <20191228074757.2075-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191220125520.29871-1-jbx6244@gmail.com>
References: <20191220125520.29871-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two identical &uart0 nodes in this dts file,
so remove one of them.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
index 8251f3c0d..cbde279ae 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
@@ -83,12 +83,6 @@
 	status = "okay";
 };
 
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
-	status = "okay";
-};
-
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.11.0


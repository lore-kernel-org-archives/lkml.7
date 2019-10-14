Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE7AC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC73621835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qw+2kp/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbfJNOR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:17:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52695 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732506AbfJNOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:17:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so17475536wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WhPSwUwjAsJRbhdmE0cVGRUouZ5x8oaruQHda5jd55I=;
        b=qw+2kp/+fl6kXsLl22YjrO0TyQy+b2qOG96cAr18nh3mIUcQO2wxOniKBJRga3bv6p
         9gVO175nSljYfUAcAjw9jxTI1QDAAsmlRxihaiHD0ltMTQcWkjfZASaKg7Zrg0rKzyc5
         kFWR35CpMP10S6rBiE0sZlidqw2c81x70/pVS9YXFWxXbQfXDv3Z/TWitlohxBSSLH0I
         P34TlcmfOwb0nOjj/iyY8JJLUbbJhcr7bPt+yGE4VFH0VxHjbSW13cTO9VLCyNOU4x1F
         GyW1IX/y5/Gt5n10NogGoISQkc3ykn+ouY3KCXlxf+UvVSWFnjKjQKKwexoQVmbk7g8u
         mwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WhPSwUwjAsJRbhdmE0cVGRUouZ5x8oaruQHda5jd55I=;
        b=KDDRu5s1ZSgFKxdaW8d8b4ZqrxuzaaeKGmwE6sfRkY+iZ1I+FqTXi8DKQAMPt+UJMl
         1vJm9yHVWjBT84/az7oiTq/xLGRbU3hlHhNzUsi4Na8FVzCF1xa9OsDOS9NRO5/m2BP2
         up6XSHf3LbCNDuD0aU6fx1MCoMsX0lS6obLKu5mnvr+5MFW8AXVpYLBrIEquc4wCTRSA
         CuVTLD5hoIlAXJNLe34zSP3lkOISpi0pYlIPfthLQUOZZyvSnlDY38u4eddUUZ8br4lA
         vixAPFEI0wy2d2Nk1ac4kYltTS87L2r/3bGY55Evd1m1A8ucpRUIjwng/EuCQ6x46F/S
         m+Hg==
X-Gm-Message-State: APjAAAXfjAJ2zZizZwbdOk4tVVm/j0q0G9o7k1qo3JkF9ysgBlS7PrUL
        s/FjCr5xqgwfL2meNMIBFWDYig==
X-Google-Smtp-Source: APXvYqwyLKkJs7kEVRKHW2iMVF8t8Y3SI49VubmuzAmVzLaKXolT83XHyMDU/m35t26Bb9WZbO3Sjg==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr15817487wmb.125.1571062643202;
        Mon, 14 Oct 2019 07:17:23 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t83sm42708624wmt.18.2019.10.14.07.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:17:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, Tim <elatllat@gmail.com>
Subject: [PATCH 3/3] arm64: dts: g12-common: add parkmode_disable_ss_quirk on DWC3 controller
Date:   Mon, 14 Oct 2019 16:17:18 +0200
Message-Id: <20191014141718.22603-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191014141718.22603-1-narmstrong@baylibre.com>
References: <20191014141718.22603-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When high load on the DWC3 SuperSpee port, the controller crashed as:
[  221.141621] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
[  221.157631] xhci-hcd xhci-hcd.0.auto: Host halt failed, -110
[  221.157635] xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume dead
[  221.159901] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
[  221.159961] hub 2-1.1:1.0: hub_ext_port_status failed (err = -22)
[  221.160076] xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
[  221.165946] usb 2-1.1-port1: cannot reset (err = -22)

Setting the parkmode_disable_ss_quirk quirk fixes the issue.

CC: Dongjin Kim <tobetter@gmail.com>
Cc: Jianxin Pan <jianxin.pan@amlogic.com>
Reported-by: Tim <elatllat@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 3f39e020f74e..4b002e799e5c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2381,6 +2381,7 @@
 				dr_mode = "host";
 				snps,dis_u2_susphy_quirk;
 				snps,quirk-frame-length-adjustment;
+				snps,parkmode-disable-ss-quirk;
 			};
 		};
 
-- 
2.22.0


Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB5AC17442
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F152080F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuUZTZU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfKKAwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 19:52:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43413 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfKKAwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 19:52:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so8296097pgh.10;
        Sun, 10 Nov 2019 16:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=7JBZMDJ/jQpvGVhkPi30utKHejoieOrOST93jaHrfvk=;
        b=uuUZTZU4ugdpCAeFHhqDRbg8HA2vYG1ELckLdXzZrkOa3J9YX3rpx3TUbe8gn8j/AR
         cW5MPpJLNwnQ2F6EOJLzuA8WXQ3RIAbH8AJyX4vZzXgLuTOkCVTyYDA6k2a1JZ80GdMd
         Kwh3FoIyH3SpQBLtdPaOnPCpLIOEZHFcm+CLf2vR2PyuuwtltWXVipmyjbIubmZGRDgO
         KToeWqkbgRtYlXi0Thd2U3BuG2RX6WQjpmMrUvY/LlAGzY8g59ZK80J3c3IrGz5VdRyV
         Yxs5nqzGGqk+axRolveimuomUZoMc8EPNzCZiqwvjYhvsXjykpQnV6m5OhkFP7f2wcYA
         lFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=7JBZMDJ/jQpvGVhkPi30utKHejoieOrOST93jaHrfvk=;
        b=fdyNjjikuH0ogNMG82eOYhoaJhaQMzUWAibm1h73mbKB9M89xhodtDu2U7lji/pqRZ
         G0qiNvAgOfCopNGEh9r0msCWL2H6cRx9inLSpU+dMLWdidzK21WlKA1N9rFqf3bbQ+Bi
         ZMtUWx8vZDCxCwLrPcEKkeJORNNCBWyK2Go57kUnkpSlLXeBPnAyAHiz24ec8DEuO5ry
         pXSdr6/1jVPaphYbIhHHQsp4mAvsQHOwtZNS8xLP2bbr/7fhlnWFqrotUFv3LEAcBdZE
         U8aEIiS/zkKj86+aLAKCjDdxm6OvzBAmrxQF+7f6qZdzoICnCsiSAO9cL4VLkqg3eTyk
         me0g==
X-Gm-Message-State: APjAAAV0fT+e7CAM3ed3qcl3IMTgMq8FITuy+AIxuhRXTcXAnFb3Jr4w
        IoNiEC/zlvY9wHbP/9d1iJ8=
X-Google-Smtp-Source: APXvYqwDRChvidhBwhHK5/pGQamQPfZb8pb7/YDluV+1KaXPBs9O8AoWBZkEJTB4TUYKdk4p9DdhvA==
X-Received: by 2002:a63:f94e:: with SMTP id q14mr21190084pgk.411.1573433538888;
        Sun, 10 Nov 2019 16:52:18 -0800 (PST)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id e8sm12449215pga.17.2019.11.10.16.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 16:52:18 -0800 (PST)
From:   Kever Yang <kever.yang@rock-chips.com>
To:     heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org,
        Kever Yang <kever.yang@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: rockchip: Fix min voltage for rk3399-firefly vdd_log
Date:   Mon, 11 Nov 2019 08:51:56 +0800
Message-Id: <20191111005158.25070-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The min/max value of vdd_log is decide by pwm IO voltage and its
resistors, the rk3399-firefly board's pwm regulator circuit is designed
for IO voltage at 1.8V, while the board actually use 3.0V for IO, which
at last lead to the min-microvolt to '430mV' instead of '800mV'.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index c706db0ee9ec..92de83dd4dbc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -206,7 +206,7 @@
 		regulator-name = "vdd_log";
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <800000>;
+		regulator-min-microvolt = <430000>;
 		regulator-max-microvolt = <1400000>;
 		vin-supply = <&vcc_sys>;
 	};
-- 
2.17.1


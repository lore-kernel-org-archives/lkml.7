Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF501C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884CA20870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VTRPpUxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfCYKPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:15:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32797 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbfCYKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:15:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so9416868wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yEQc6Wg8CZcOFKxbK8s1T4WXh2s7N0+F2je28egpEkM=;
        b=VTRPpUxsdWXbvv7s+emAjTBvA/MqASJ8uvpD//UsmZrVF4PxfkW/Flq3+RtLo6M4Q5
         mA+18RfAY4Wq0AZW/5NQuAQjVSqpGenpGOwhByGggapCMKigQua+t+dE5G1J18yLbih4
         qEgO7KH00eq9d7xjbxqeU5oLR7YnByL2UqgWZ38CprGg+DIsBoWHzZf4di/GYI5wseku
         VDeaX6iRVxu+0Kf4mAuAVOkjzKEWgWyHNy305nrnJNsjDet4L1LYsKDQ7ImBmVOjdCLM
         Wt1VZnnjz/uNmbkD7VGZj/6ozwKiLiIR7LQFaZX7iUjPIBtt7YkvSxDY5ZYliu8ekvnZ
         apAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yEQc6Wg8CZcOFKxbK8s1T4WXh2s7N0+F2je28egpEkM=;
        b=lE0QClINefEPQ0XiXYEQ3bj6f0OBwglinlo/1D5/AXWcsNrrZHuEniZDdwRIB2PHFF
         gXB2RnZHH7ymyTYaclmShMgRAU2wAnS3YQCr3eL4hAIXqQSjA3foaL1MjMOUeRfbVfbb
         hwMfbMCCeiKlDqOQkXv+HMQj8Rh4bGi/LJetraZvpewfU+22BNqUqgOx/PVNW7NZG075
         1sxNMY18g2kZTWTelC6beQttqqup520eB6vhAl4ih3T1BE9SZlhsCmPCxSIGI/6C32ya
         m5sDXtLYn2YxXhrj/rBVGTf8ZfRS97XaujAj0Y3wugfv5CyVe2/Yg3zFKxNU85VIY5BZ
         lGcQ==
X-Gm-Message-State: APjAAAXGJoW9wQKM9PNQdq7lQ1JMHwgf0r1PqTTGMTQs7RDkAVwoS2g9
        oJEiARvu6WOKxtxjFBQEDhjY9g==
X-Google-Smtp-Source: APXvYqw+efCxqUDAf3UmoXIoYX8pvXaCy+7DXnJZURVRZ797iHI/qbzdgU+ufRqjODLA/Ddjc/AsOw==
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr10621233wrq.306.1553508901246;
        Mon, 25 Mar 2019 03:15:01 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v14sm20049484wrr.20.2019.03.25.03.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:15:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 5/6] arm64: dts: meson-g12a-u200: Enable USB
Date:   Mon, 25 Mar 2019 11:14:52 +0100
Message-Id: <20190325101453.3009-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325101453.3009-1-narmstrong@baylibre.com>
References: <20190325101453.3009-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB2 OTG and USB3 Host ports on the S905D2 Reference Design.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index c69328d16333..2240e365af27 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -108,3 +108,15 @@
 	pinctrl-names = "default";
 };
 
+&usb {
+	status = "okay";
+	vbus-supply = <&usb_pwr_en>;
+};
+
+&usb2_phy0 {
+	phy-supply = <&vcc_5v>;
+};
+
+&usb2_phy1 {
+	phy-supply = <&vcc_5v>;
+};
-- 
2.21.0


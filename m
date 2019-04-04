Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F276C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE31D206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pro6Qmwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfDDQ5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:57:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32962 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfDDQ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:57:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so1474171plo.0;
        Thu, 04 Apr 2019 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nN+9+tvHnXI0jG1JTz3yCZcoQzjtz9zADSIXD+s5sGk=;
        b=pro6QmwgP+rwFtaYgYKoLYsUXNXHrtCtQyLgnNU154LiK0IT7dgwyMI3MUI3zVpO2f
         M6kxR+cjW/+9ICx31RlM5YU0HTEv/nRAot9UzH4bnhgoBjJIY3N5pOLxh++gutwjv+yP
         ddvfygijSWvn3FenJ7GIApRPqt834xx2wbMJiFDSAkanzZvyaloSsRoRYfm6NWLVcyGC
         IapzbamDV6suHjh8wVxp4wIGHEwRO3OIBanBd1wcx7gvJzYbZkjXBDLOA4PZNjuHNx9N
         eUgMMfG9EXNiZeL9HO2EwVPLgSRZemPnVOA3PNCGq8YzpeDSUH26OSgC6kjKICnWWZgK
         C8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nN+9+tvHnXI0jG1JTz3yCZcoQzjtz9zADSIXD+s5sGk=;
        b=FkO9xULW7BveuSBOVvxG2OY/eig666GGttnQGgAocX9vhXLkf610WEBy6lUDSM6/rg
         YuU/nJh30leZX3U7f/WvuZeqGsPJpbS6EUCzl8/OD5rUJq2wKjRMzhbs4ORcO1YJlHvt
         yV1ixkylmaf8zVFusHq1tDy8QWwTCPhMC+k+uDmvM5RnyO85gtFSaF3+CzOliPEicE69
         VlRb5Aw0iGTtmdE3izWwnmSQd2Q3yBMKWJd3TRkTwJLvbVnGrENiIUKSajE7ojRNLLAk
         usggxdnPfBtXr1EOw+zYccvX1vj7A9HdQTKe8Y+jJYTWTQU1wvrUW1IruSj0BoVs9B1+
         +UiQ==
X-Gm-Message-State: APjAAAURF30DKTg0hViU2lqDoNL8LPnKN3jOZSRwjLaUhit10eWffCTL
        ICSJrvozxjfBTvbB1/GJ3lE=
X-Google-Smtp-Source: APXvYqys2T1Yqbjee26mJ7ydNa5a7rQcEhvw8oyk7aDPi1GXhVmRyPW6KUprRBXBUqF1zRtND+LGuA==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr7639948plz.216.1554397057854;
        Thu, 04 Apr 2019 09:57:37 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v19sm27320826pfn.62.2019.04.04.09.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 09:57:37 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND 2/2] arm64: dts: sunxi: h6: Add device node for SID
Date:   Thu,  4 Apr 2019 12:57:26 -0400
Message-Id: <20190404165726.13149-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190404165726.13149-1-tiny.windzz@gmail.com>
References: <20190404165726.13149-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree binding already lists compatible strings for H6
SoCs, so add a device node for iy.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index c9e861a50a63..cbeb587d2eed 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -192,6 +192,11 @@
 			#reset-cells = <1>;
 		};
 
+		sid: sid@3006000 {
+			compatible = "allwinner,sun50i-h6-sid";
+			reg = <0x3006000 0x400>;
+		};
+
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
-- 
2.17.0


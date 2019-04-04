Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A052C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA48F206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoOz8Xth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfDDRBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:01:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39789 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDRBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:01:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so1668534pfo.6;
        Thu, 04 Apr 2019 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OfXhZNv2ycLMx0GX7xE4EaK5RbDMQkGbXHxvNLOvufQ=;
        b=QoOz8XthIX7nZEKURrrsNSyVtHkS6GWOXi8k/6nNZIyilfRkKpqC8x4Iec2AW0MZXH
         9s1nCKBzXLdkcGyjgaHAM5vG5zrhfAVlV3N9BIV3EZlEApCxejNwlf7RvGsy/MUS5LLK
         l6CYQtT5pn6LgKvCuT0zvTodVXM/AG/zC0oQpTtM8L9U0S5WzI7ZPnkqtCNTUbeihHPh
         N+jPLya6yqNoNmD15k19M8ISGBM92jJJmwXKoilw8XLWKhbm3sbr3pB1P/ht0YxqNNPb
         ricOt0ljO7p11vIMcgpJuNZ+1a2yqyIHz4EsRTcX6F7NtUO1ppdt8R3IZmd52dYrBSk1
         df/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OfXhZNv2ycLMx0GX7xE4EaK5RbDMQkGbXHxvNLOvufQ=;
        b=ZqYGyjjHlVA7Daiz/dYbaM7Ex+I3s29FyF8rBg8mJHNcJp4+JObI/aToPG+RFaAatg
         vPjOg8GGQU5lGWi1ivfI3N7yfYtVcW9fz9Uw7w5cFKZ4q60OzYGQjC+ZT1n6mjzh0qy4
         2PxVPia53z22FBAa1Nb2eLtTzoyWfL2myKT2sJB/j6ebjJUhkTy7j3zCgqYu6bPKiZbj
         ql2VCV0F8YXLVsiye28d47nqh4kkP14ZOvl4fJzDAULPKQmnICYeqpvLoOTpDrtULAWZ
         xeUQ6xND2l+y6uc/q5LZA4sAEmf22bYPtw5WhEQjTvjHnaaIigypu+R1yWmzeI2nbzr6
         7VKQ==
X-Gm-Message-State: APjAAAVL7VX/gjgIARp5YMVLFwIDoaSwoRjQRT0fhs4EWbteuIsF/9kR
        QSYn+jdGmdTl0E6ODwOe3SU=
X-Google-Smtp-Source: APXvYqxXGNT3+iJdlt10GvWLbF/nf2BZtynaZq/cpAMaH/cz2FbieGxx9Vqz6EU1wcQolDhDbfhIVg==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr6969895pgp.197.1554397309262;
        Thu, 04 Apr 2019 10:01:49 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h64sm29892287pfj.40.2019.04.04.10.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 10:01:48 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND 2/2] arm64: dts: sunxi: h6: Add device node for SID
Date:   Thu,  4 Apr 2019 13:01:46 -0400
Message-Id: <20190404170146.13204-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree binding already lists compatible strings for H6
SoC, so add a device node for it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
fix typo:
iy->it
0x3006000->0x03006000
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
+			reg = <0x03006000 0x400>;
+		};
+
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
-- 
2.17.0


Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA211C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7583F21855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 09:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="D+98tgcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfDTJdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 05:33:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41318 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 05:33:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id c12so3452516wrt.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idwqWI24RRMujosXdp72Gc2bSSwiwXLwDzY0CFc9vDM=;
        b=D+98tgcfLHHn/09OlcyMyPqRyvAkI0RjyRjnng55f1q0Ha+YD2lTxHIZuhaGvY2gdP
         m2Q1y+7ZkoNNtON3+XSNpkIxTDysbaAgvfWGt3SiYjaJw6rlRmCIr3OyB/c9fr5H/lqz
         eSEJi2lqkIeVZvz0bFtF5EwMM9srM+UdbIrAiDrbfHMzK0JIUF9pcvC6xnkttRNnjZX1
         BuqwVdmXfNxJooIAxgaZjcnUqZ1WLhGFWfOEJbeOEpKTzCgH3ZydkaSx9Bxwnj6Kh9P7
         Irt5ZGLFgHPxmdDXtNyhHu/LM5rn2zfQ/NA5NREcp06Vde31PcdjIcwND1tZf6700CSk
         kgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idwqWI24RRMujosXdp72Gc2bSSwiwXLwDzY0CFc9vDM=;
        b=Dcbu+OTn0TO/T3PBjp5vm8V+C5LfXrK8jcwbM268hZRtfT8aRCDR1xuulCwOGQyMFu
         KHzLQ6bbspHRX3W0ztjbfO6awu3XajG9SKA6zt6fn5gf2rfJ9cv925lIU10a8XXBGnxW
         T6CD9Qkt5BKDRMxNwMUx+ParNJ/WakEELPaVx/sCpX7gMMdfJBDhS7lLFEd59C7zehWb
         aYvdRKusMy5Ijs4hLyl2BOiMGGIsBTlVyoQZ9BWXhrDfSN6Gic4pm1g7nvOVgA5xwLNQ
         34jDrfPHyQAEKWiLvY6thfG8Ux0iIIr66nEOZDeEwp7mcaxZ3dCrFkCm96xi5u/kMtUM
         S39w==
X-Gm-Message-State: APjAAAXpgsr1SXk5z4DMOwrKLqQJl0Tm9TbJaExp3mTY/LK+lhPRUwOK
        DEL4lvNSa8LOigUHjV0RxFo=
X-Google-Smtp-Source: APXvYqyYB2zv3rPKR/iSExi8uLlrZXfzKr72r31aYA603zBukH4UFcppZL9Jev1aaIKTeUmJm0E6gw==
X-Received: by 2002:adf:ee82:: with SMTP id b2mr1592773wro.233.1555752795276;
        Sat, 20 Apr 2019 02:33:15 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD0028C4739A57449001.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:28c4:739a:5744:9001])
        by smtp.googlemail.com with ESMTPSA id w11sm12858244wre.15.2019.04.20.02.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 02:33:14 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] ARM: dts: meson8b: drop undocumented property from the Mali GPU node
Date:   Sat, 20 Apr 2019 11:32:58 +0200
Message-Id: <20190420093258.2012-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190420093258.2012-1-martin.blumenstingl@googlemail.com>
References: <20190420093258.2012-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the undocumented "switch-delay" which is a left-over from my
experiments with an early lima kernel driver when it was still
out-of-tree and required this property on Amlogic SoCs.

Fixes: c3ea80b6138cae ("ARM: dts: meson8b: add the Mali-450 MP2 GPU")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 800cd65fc50a..4b919590dae5 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -229,7 +229,6 @@
 			clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
 			clock-names = "bus", "core";
 			operating-points-v2 = <&gpu_opp_table>;
-			switch-delay = <0xffff>;
 		};
 	};
 }; /* end of / */
-- 
2.21.0

